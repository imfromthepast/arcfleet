public class KingdomHallController extends territorytemplatecontroller{
    public string cName {get; set;}
    
    public pagereference save(){
        upsert kingdomhall;
        pagereference pr = page.kingdomhall;
        pr.getparameters().put('id',kingdomhall.id);
        pr.setredirect(true);
        return pr;
    }
    
    public pagereference newCongregation(){
        congregation__c c = new congregation__c(name = cName,kingdom_hall__c = kid);
        insert c;
        pagereference pr = page.kingdomhall;
        pr.getparameters().put('id',kingdomhall.id);
        pr.setredirect(true);
        return pr;
    }
    
    public pagereference deleteKH(){
        delete kingdomhall;
        pagereference pr = page.kingdomhalls;
        pr.setredirect(true);
        return pr;
    }
}