public class AssignmentController extends territorytemplatecontroller{
    public publisher__c            Publisher = new publisher__c();
    public congregation__c         congregation           {get; set;}
    list<publisher__c>             publishers;
    list<territory__c>             territories;
    list<string>                   assignedTerritoryIds;
    list<territory_assignment__c>  unassignedTerritories;
    public string                  id                     {get; set;}
    
    public void init(){
        id = apexpages.currentpage().getParameters().get('id');
        congregation = [select id, name from congregation__c where id = :id];
    }
    public PageReference addPublisher() {
        publisher.congregation__c = id;
        publisher.name = publisher.first_name__c + ' ' + publisher.last_name__c;
        insert publisher;
        publishers = null;
        publisher = new publisher__c();
        return null;
    }
    public publisher__c getPublisher() {
        return publisher;
    }

    public list<publisher__c> getPublishers(){
        if(publishers == null){
            publishers = new list<publisher__c>();
            list<territory_assignment__c> assignedTerritories = new list<territory_assignment__c>();
            for(publisher__c p : [select id, name, (select id, name, checkout__c, check_in__c, due_date__c, territory__r.name, territory__c from territory_assignments__r where check_in__c = null or check_in__c > :system.now() order by territory__r.name) from publisher__c where congregation__c = :id order by last_name__c]){
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
        if(territories == null){
            territories = [select id, name from territory__c where congregation__c = :id];
        }
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
    public PageReference updateTerritory() {
        string territoryId = apexpages.currentpage().getParameters().get('territoryId');
        string territoryName = apexpages.currentpage().getParameters().get('territoryName');
        string publisherId = apexpages.currentpage().getParameters().get('publisherId');
        string terrAssId = apexpages.currentpage().getParameters().get('terrAssId');
        territory__c t = [select id, name, checked_out__c, publisher__c from territory__c where id=:territoryID];
        if(publisherId != '0'){
            //dropped on the Publishers List
            if(terrAssId == ''){
                //taken from Available Territories
                territory_Assignment__c ta = new territory_Assignment__c(Name = territoryName, publisher__c = publisherID, checkout__c = system.today(), territory__c = territoryId);
                insert ta;
                t.checked_out__c = true;
                t.publisher__c = publisherID;
                update t;
            }else{
                //taken from Publisher
                territory_assignment__c ta = [select id, name,checkout__c, check_in__c from territory_assignment__c where id = :terrAssId];
                ta.check_in__c = system.now();
                update ta;
                
                //t.checked_out__c = false;
                //t.publisher__c = '';
                //update t;
                
                date checkin = ta.check_in__c.date();
                territory_Assignment__c nta = new territory_Assignment__c(Name = territoryName, publisher__c = publisherID, checkout__c = system.today(), territory__c = territoryId);
                insert nta;
                
                t.checked_out__c = true;
                t.publisher__c = publisherID;
                update t;
                
                if(ta.checkout__c == checkin){
                    delete ta;
                    
                    t.checked_out__c = false;
                    t.publisher__c = '';
                    update t;
                }
            }
        }else{
            //dropped on the Available Territories
            if(terrAssId == ''){
                //taken from Available Territories
            }else{
                //taken from publisher list
                territory_assignment__c ta = [select id, name, check_in__c, checkout__c from territory_assignment__c where id =: terrAssId];
                ta.check_in__c = system.now();
                update ta;
                t.checked_out__c = false;
                t.publisher__c = null;
                update t;
                date checkin = ta.check_in__c.date();
                if(ta.checkout__c == checkin){
                    delete ta;
                        
                }
            }  
        }
        publishers = null;
        unassignedTerritories = null;
        pagereference pr = page.assignment;
        pr.getparameters().put('id',id);
        pr.setredirect(true);
        return null;
    }

}