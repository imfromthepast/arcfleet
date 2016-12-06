public class homecontroller {
    public list<tale__c> tales {get; set;}
    public list<Chapter__c> chapters {get; set;}
    public list<Installment__c> installments {get; set;}
    public string tid {get; set;}
    public string cid {get; set;}
    public void init(){
    	tid = apexpages.currentpage().getparameters().get('tid');
    	cid = apexpages.currentpage().getparameters().get('cid');
    	chapters = new list<Chapter__c>();
    	installments = new list<Installment__c>();
        tales = [select id, name, active__c, description__c, (Select Id, Name From Attachments Where Name = 'logo') from tale__c where active__c = true order by order__c];
        if(tid != null && tid != '') chapters = [select id, name, order__c, Tale__c from chapter__c where tale__c = :tid order by order__c];
        if(cid !=null && cid != '') installments = [SELECT Id, Story__r.Name FROM Installment__c WHERE Chapter__c =:cid Order By Order__c];
    }
}