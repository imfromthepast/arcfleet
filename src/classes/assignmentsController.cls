public class assignmentsController extends territorytemplatecontroller{
    public publisher__c Publisher = new publisher__c();
    public congregation__c congregation {get; set;}
    list<publisher__c> publishers;
    public string PublisherName {get; set;}
    list<territory__c> territories;
    list<string> assignedTerritoryIds;
    list<territory_assignment__c> unassignedTerritories;
    public string id {get; set;}
    public string pid {get; set;}
    public string territoriesCoords {get; set;}
    public kingdom_hall__c KingdomHall {get; set;}
    
    public void init(){
        id = apexpages.currentpage().getParameters().get('id');
        pid = apexpages.currentpage().getParameters().get('pid');
        if(pid == null) pid = 'none';
        congregation = [select id, name, kingdom_hall__c from congregation__c where id = :id];
        if(pid != 'none') publisher = [select id, name, first_name__c, last_name__c, email__c, phone__c from publisher__c where id = : pid];
        kingdomhall = [select id, name, address__c, street__c, city__c, state__c, zip_code__c, country__c from kingdom_hall__c where id = :congregation.kingdom_hall__c];
        territories = [select id, name, covered_in_campaign__c, checked_out__c, publisher__c, coordinates__c from territory__c where congregation__c = :congregation.id order by name];
        integer i = 1;
        territoriesCoords = '';
        for(territory__c t : territories){
            if(t.coordinates__c != null){
                boolean isthispubsterr = false;
                if(pid != 'none')isthispubsterr = (t.publisher__c == pid) ;
                
                territoriesCoords += t.name + ':' + t.id + '-' + isthispubsterr + ':' + t.checked_out__c + '/' + t.coordinates__c + '|';
                //if(i < congregation.territories__r.size()) otherterritories += '|';
                i++;
            }
        }
        if(territoriesCoords.endswith('|'))territoriesCoords = territoriesCoords.substring(0,territoriesCoords.lastindexof('|')-1);
        if(pid != 'none'){
            PublisherName = publisher.name;
        }else{
            PublisherName = 'Territory Assignments';
        }
        
    }
    
    public PageReference savepublisher() {
        if(publisher.id == null){
            publisher.congregation__c = id;
        }
        publisher.name = publisher.first_name__c + ' ' + publisher.last_name__c;
        upsert publisher;
        //publishers = null;
        //publisher = new publisher__c();
        return null;
    }
    public pagereference newpublisher(){
        
        publishers = null;
        publisher = new publisher__c();
        pagereference pr = page.assignments;
        pr.getparameters().put('id',id);
        pr.getparameters().put('pid',null);
        
        pr.setredirect(true);
        
        return pr;
    }
    
    public publisher__c getPublisher() {
        return publisher;
    }
    public list<publisher__c> getPublishers(){
        if(publishers == null){
            publishers = new list<publisher__c>();
            list<territory_assignment__c> assignedTerritories = new list<territory_assignment__c>();
            for(publisher__c p : [select id, name, (select id, name, checkout__c, check_in__c, due_date__c, territory__r.name, territory__c from territory_assignments__r where check_in__c < :system.now() order by territory__r.name) from publisher__c where congregation__c = :id order by last_name__c]){
                publishers.add(p);
                assignedTerritories.addall(p.territory_assignments__r);
            }
            assignedTerritoryIds = new list<string>();
            for(territory_assignment__c ta : assignedterritories){
                assignedTerritoryIds.add(ta.territory__c);
            }
        }
        return publishers;
    }
    
    public list<territory__c> getTerritories(){
        //if(territories == null){
            //territories = [select id, name, covered_in_campaign__c, checked_out__c, coordinates__c from territory__c where congregation__c = :id];
            
        //}
        return territories;
    }
    public list<territory_assignment__c> getUnassignedTerritories(){
        if(unassignedTerritories == null){
           unassignedterritories = new list<territory_assignment__c>();
           for(territory__c t : [select id, name from territory__c where congregation__c = :id and id not in :assignedTerritoryIds order by name]){
               territory_assignment__c ta = new territory_assignment__c();
               ta.territory__c = t.id;
               ta.name = t.name;
               unassignedterritories.add(ta);
           }
        }
        return unassignedTerritories;
    }
    public pagereference checkout(){
        string territoryId = apexpages.currentpage().getParameters().get('territoryId');
        string territoryName = apexpages.currentpage().getParameters().get('territoryName');
        territory__c t = [select id, name, checked_out__c, publisher__c from territory__c where id=:territoryID];
        
        territory_assignment__c ta = new territory_assignment__c();
        ta.publisher__c = pid;
        ta.name = territoryName;
        ta.territory__c = territoryId;
        ta.checkout__c = system.today();
        insert ta;
        t.checked_out__c = true;
        t.publisher__c = pid;
        update t;
        pagereference pr = page.assignments;
        pr.getparameters().put('id',id);
        pr.getparameters().put('pid',pid);
        pr.setredirect(true);
        return pr;
    }
    public pagereference checkin(){
        string territoryId = apexpages.currentpage().getParameters().get('territoryId');
        territory__c t = [select id, name, checked_out__c, publisher__c from territory__c where id=:territoryID];
        territory_assignment__c ta = [select id, name, check_in__c, checkout__c from territory_assignment__c where territory__c =: territoryId and check_in__c = null order by checkout__c limit 1];
        ta.check_in__c = system.now();
        update ta;
        t.checked_out__c = false;
        t.publisher__c = null;
        update t;
        date checkin = ta.check_in__c.date();
        if(ta.checkout__c == checkin){
            delete ta;
                
        }
        pagereference pr = page.assignments;
        pr.getparameters().put('id',id);
        pr.getparameters().put('pid',pid);
        pr.setredirect(true);
        return pr;
    }
}