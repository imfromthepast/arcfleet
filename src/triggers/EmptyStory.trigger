trigger EmptyStory on Installment__c (Before Update) {
    for(installment__c i : Trigger.old){
        try{
            story__c s = [select id from story__c where id = :i.story__c];
        }catch(exception e){
            story__c s = new story__c();
            s.name = 'New Installment';
            insert s;
            i.story__c = s.id;
        }
    }
}