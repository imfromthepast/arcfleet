trigger PreventShortAssignments on Territory_Assignment__c (before update) {
    list<string> TAIds = new list<string>();
    list<territory_assignment__c> deleteThese = new list<territory_assignment__c>();
    list<territory_assignment__c> TAs = new list<territory_assignment__c>();
    
    for(territory_assignment__c ta : trigger.old){
        TAIds.add(ta.id);
        //if(ta.checkout__c == ta.check_in__c.date()) deleteThese.add(ta);
    }
    
    TAs = [select id,checkout__c,check_in__c from territory_assignment__c where id in :TAIds];
    
    for(territory_assignment__c ta : TAs){
        if(ta.checkout__c == ta.check_in__c.date()) deleteThese.add(ta);
    }
    
    delete deletethese;
}