public class TerritoryCardsController {
    public list<String> Coordinates {get; set;}
    public list<territory__c> Territories {get; set;}
    public Congregation__c Congregation {get; set;}
    
    public void init() {
        coordinates = new list<string>();
        territories = new list<territory__c>();
        string id = apexpages.currentpage().getparameters().get('id');
        congregation = [select id, name, (select id, name, coordinates__c from territories__r order by name) from congregation__c where id = : id];
        for(territory__c t : congregation.territories__r){
            if(t.coordinates__c != null){
                t.coordinates__c = t.coordinates__c.replace(';','|');
                t.coordinates__c = t.coordinates__c + '|' + t.coordinates__c.substring(0,t.coordinates__c.indexof('|'));
                territories.add(t);
            }
        }
    } 
}