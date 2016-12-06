public class territoryassignmentrecordcontroller {
    public string id = apexpages.currentpage().getparameters().get('id');
    public list<integer> territoryincrementer {get; set;}
    public integer total {get; set;}
    public list<territory> Territories {get; set;}
    public list<territory_assignment__c> TerritoryAssignments {get; private set;}
    public list<territory[]> pageBrokenTerritories {get; set;}
    
    public void init(){
        territories = new list<territory>();
        //territoryincrementer = new list<integer>();
        //TerritoryAssignments = new list<Territory_Assignment__c>();
        //integer i = 0;
        //territories = [select id, name, (select id, name, publisher__r.name, checkout__c, check_in__c from territory_assignments__r order by checkout__c asc limit 20) from territory__c where congregation__c = : id order by name];
        //total = territories.size();
        for(territory__c terr : [select id, name, (select id, name, publisher__r.name, checkout__c, check_in__c from territory_assignments__r order by checkout__c asc limit 20) from territory__c where congregation__c = : id order by name]){
            territory t = new territory();
            t.t = terr;
            t.rows = terr.territory_assignments__r.size();
            //TerritoryAssignments.addall(terr.territory_assignments__r);
            territories.add(t);
            //territoryincrementer.add(i);
            //i++;
        }
        //total = math.round(territories.size()/5);
        //for(integer i = 0; i<=total; i++){
        //    territoryincrementer.add(i);
        //}
        //territoryincrementer.add(total);
        //total = territoryincrementer.size()*5;
        //return territories;
        
        prepareTerritoriesForPrinting();
    }
    
    public void prepareTerritoriesForPrinting(){
        pageBrokenTerritories = new List<list<territory>>();
        list<territory> pageOfTerritories = new list<territory>();
        Integer counter = 0;
        boolean firstBreakFound = false;
        boolean setSubSeqBreak = false;        
        Integer breakPoint = 5;

        for(territory t : territories){
            if(counter < breakPoint){
                pageOfTerritories.add(t);
                counter++; 
            }
            if(counter == breakPoint){
                if(!firstBreakFound){
                    firstBreakFound = true;
                    setSubSeqBreak  = true;
                }
                counter = 0;
                pageBrokenTerritories.add(pageOfTerritories);
                pageOfTerritories = new list<territory>();
            }
             if(setSubSeqBreak){
                 breakPoint = 5;
                 setSubSeqBreak = false;
             }
         }
         //if we have finished looping and have some quotes left let's assign them
         if(!pageOfTerritories.isEmpty()) pageBrokenTerritories.add(pageOfTerritories);
    }
    
    public list<integer> getRows(){
        list<integer> rows = new list<integer>();
        for(integer i=0; i<20; i++){
            rows.add(i);
        }
        return rows;
    }
    public class territory{
        public territory__c t {get; set;}
        public integer rows {get; set;}
        public list<territory_assignment__c> tas {get; set;}
        
        public territory(){
        }
    }
    
}