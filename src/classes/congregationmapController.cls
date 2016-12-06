public class congregationmapController extends territorytemplatecontroller{
    public void init(){
    	congregations = [select id, name from congregation__c where kingdom_hall__c = :kingdomhall.id];
    	kingdomHalls = [select id, name, (select id, name from congregations__r limit 1) from kingdom_hall__c order by name];
    }
}