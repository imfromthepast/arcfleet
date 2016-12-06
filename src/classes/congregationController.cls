public class congregationController extends territorytemplatecontroller{
    public PageReference save() {
        upsert congregation;
        pagereference pr = page.congregation;
        pr.getparameters().put('id',congregation.id);
        pr.setredirect(true);
        return pr;
    }
    public PageReference deleteCong() {
        pagereference pr = page.kingdomhall;
        pr.getparameters().put('id',congregation.kingdom_hall__c);
        delete congregation;
        return pr;
    }
    public pagereference AddTerritories(){
        integer amount = integer.valueof(amountofterritories);
        list<territory__c> newterritories = new list<territory__c>();
        for(integer i = 0; i < amount; i++){
            territory__c t = new territory__c();
            t.name = string.valueof((territories.size()+1)+i);
            if(t.name.length() == 1) t.name = '0'+t.name;
            t.congregation__c = cid;
            newterritories.add(t);
        }
        insert newterritories;
        pagereference pr = page.congregation;
        pr.getparameters().put('id',cid);
        return pr;
    }
}