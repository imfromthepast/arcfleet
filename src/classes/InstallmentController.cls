public class InstallmentController {
    string id = apexpages.currentpage().getparameters().get('id');
    public installment__c i = new installment__c();
    public installment__c getInstallment() {
        i = [select id, name,chapter__r.name, chapter__r.order__c, chapter__c, story__c, order__c, story__r.date__c, story__r.quote__c, story__r.quoted__c, story__r.body__c from installment__c where id = :id];
        return i;
    }
    public attachment getimage(){
        return [select id, body from attachment where parentid = :i.story__c];
    }
}