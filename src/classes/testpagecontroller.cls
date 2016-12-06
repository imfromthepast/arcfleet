public class testpagecontroller {

    public list<householder__c> householders {get; set;}
    
    public void init(){
        householders = [select id, name from householder__c where territory__c = :apexpages.currentpage().getParameters().get('id')];
    }
}