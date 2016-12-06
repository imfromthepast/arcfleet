public abstract class territorytemplatecontroller {
    public String                 deviceType           {get; set;}
    public String                 userAgent            {get; set;}
    public boolean                IsMobile             {get; set;}
    public boolean                IsAdmin              {get; set;}
    public string                 username             {get; set;}
    public string 				  ks 				   {get; set;}
    public string 				  id 				   {get; set;}
    public string                 kid                  {get; set;}
    public string                 cid                  {get; set;}
    public string                 tid                  {get; set;}
    public kingdom_hall__c        kingdomhall          {get; set;}
    public congregation__c        congregation         {get; set;}
    public territory__c           territory            {get; set;}
    public list<kingdom_hall__c>  kingdomhalls         {get; set;}
    public list<congregation__c>  congregations        {get; set;}
    public list<territory__c>     territories          {get; set;}
    public string                 territoriesCoords    {get; set;}
    public string                 amountofterritories  {get; set;}
    public string                 mode                 {get; set;}
    public kingdom_hall__c        newkingdomhall       {get; set;}
    public list<householder__c>   householders         {get; set;}
    
    public territorytemplatecontroller() {
        ks = getParam('ks');
        id = getParam('id');
        if(id != null){
            if(id.startswith('a08')) kid = id;
            if(id.startswith('a09')) cid = id;
            if(id.startswith('a0A')) tid = id;
        }
        if(kid == null){
            kingdomhall = new kingdom_hall__c();
        }else{
            kingdomhall = [select id, name, address__c, street__c, city__c, state__c, zip_code__c, country__c, (select id, name, Territories__c, public_Talk_Time__c, public_Talk_Day__c, TMS_Service_Meeting_Time__c, TMS_Service_Meeting_Day__c from congregations__r order by name) from kingdom_hall__c where id =:kid];
            congregations = new list<congregation__c>(); 
            congregations.addall(kingdomhall.congregations__r);
        }
        if(cid == null){
            congregation = new congregation__c();
        }else{
            congregation = [select id, name, public_Talk_Time__c, campaign_start__c, campaign_end__c, unassigned_territories__c, assigned_territories__c, percentage_covered__c, public_Talk_Day__c, TMS_Service_Meeting_Time__c, TMS_Service_Meeting_Day__c, kingdom_hall__c, (select id, name, covered_in_campaign__c, checked_out__c, Marker_Coords__c, coordinates__c  from territories__r order by name) from congregation__c where id = :cid];
            kingdomhall = [select id, name, address__c, street__c, city__c, state__c, zip_code__c, country__c from kingdom_hall__c where id = :congregation.kingdom_hall__c];
            if(ks != null){
            	territory = [select id, name,(select id, name, telephone__c, street__c, city__c, state__c, zip_code__c, type__c, note__c from householders__r order by street__c), notes__c, checked_out__c, publisher__r.name, Marker_Coords__c, covered_in_campaign__c, square_footage__c, kingdom_hall_id__c, coordinates__c, congregation__c  from territory__c where congregation__c = :cid and name = :ks];
            }else{
            	territories = new list<territory__c>();
            	territories.addall(congregation.territories__r); 
            	parseTerritoryCoordinates();
            }
        }
        if(tid == null){ 
			if(ks == null){
            	mode = 'new';
            	territory = new territory__c();
			}
        }else{
            mode = getParam('mode');
            territory = [select id, name,(select id, name, telephone__c, street__c, city__c, state__c, zip_code__c, type__c, note__c from householders__r order by street__c), notes__c, checked_out__c, publisher__r.name, Marker_Coords__c, covered_in_campaign__c, square_footage__c, kingdom_hall_id__c, coordinates__c, congregation__c from territory__c where id = :tid];
            if(territory.coordinates__c == null) mode = 'new';
            congregation = [select id, name, campaign_start__c, Percentage_Covered__c, Assigned_Territories__c, unassigned_territories__c, campaign_end__c, (select id, name, coordinates__c, covered_in_campaign__c, marker_coords__c, checked_out__c, congregation__c from territories__r where id <> :tid order by name) from congregation__c where id = :territory.congregation__c];
            kingdomhall = [select id, name, address__c, street__c, city__c, state__c, zip_code__c, country__c from kingdom_hall__c where id = : territory.kingdom_hall_id__c];
            territories = new list<territory__c>();
            territories.addall(congregation.territories__r);
            householders = new list<householder__c>();
            householders.addall(territory.householders__r);
            parseTerritoryCoordinates();
        }    
        
        kingdomhalls = [select id, name, street__c, city__c, state__c, zip_code__c, country__c, address__c from kingdom_hall__c order by name];
        newKingdomHall = new Kingdom_Hall__c();
        
        userAgent = ApexPages.currentPage().getHeaders().get('USER-AGENT');
        isAdmin = userinfo.getprofileid() == '00eA00000013dqbIAA';
        IsMobile = userAgent.contains('Mobile');
        if(userAgent.contains('iPhone')){
            deviceType = 'iPhone';
        }else if(userAgent.contains('BlackBerry')){
            deviceType = 'BlackBerry';
        }
        username = Userinfo.getName();
    }
    
    public boolean getIsAdmin(){
        return userinfo.getprofileid() == '00eA00000013dqbIAA';
    }
    
    public void parseTerritoryCoordinates(){
        integer i = 1;
        territoriesCoords = '';
        boolean inWindow = getIsInWindow();
        for(territory__c t : territories){
            string mc = '';
            if(t.marker_coords__c == null){
                mc = 'none';
            }else{
                mc = t.marker_coords__c;
            }
            boolean covered = false;
            if(inWindow){
                covered = t.covered_in_campaign__c;
            }
            if(t.coordinates__c != null){
                territoriesCoords += t.id + ':' + t.name + ':' + covered + ':' + t.checked_out__c + ':' + mc + '/' + t.coordinates__c + '|';
                i++;
            }
        }
        if(territoriesCoords.endswith('|'))territoriesCoords = territoriesCoords.substring(0,territoriesCoords.lastindexof('|')-1);
    }
    public boolean getIsInWindow(){
        return isinwindow(congregation.campaign_start__c,congregation.campaign_end__c);
    }
    public boolean isInWindow(date ws, date we){
        date t = system.today();
        boolean tIsAfterWs = t > ws;
        boolean tIsBeforeWe = t < we;
        return tIsAfterWs && tIsBeforeWe;
    }
    public string getParam(string p){
        return apexpages.currentpage().getparameters().get(p);
    }
}