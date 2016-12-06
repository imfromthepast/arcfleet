public class ChapterController {
    string id = apexpages.currentpage().getparameters().get('id');
    
    public chapter__c getChapter(){
        return [select name, tale__c, tale__r.name from chapter__c where id = :id];
    }
    public list<installment__c> getInstallments(){
        return [select id, name, story__c, order__c, story__r.date__c, story__r.quote__c, story__r.quoted__c, story__r.body__c from installment__c where chapter__c = :id order by order__c];
    }
    
}