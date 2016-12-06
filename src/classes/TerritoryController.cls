public class TerritoryController extends territorytemplatecontroller{
    public pagereference Save(){
        if(territory.marker_coords__c.contains(';'))territory.marker_coords__c = '';
        update territory;
        pagereference pr = page.territory;
        pr.getparameters().put('id',tid);
        pr.setredirect(true);
        return pr;
    }
    public pagereference Reset(){
        territory.coordinates__c = '';
        update territory;
        pagereference pr = page.territory;
        pr.getparameters().put('id',tid);
        return pr;
    }
    public pagereference del(){
        pagereference pr = page.congregation;
        pr.getparameters().put('id',territory.congregation__c);
        delete territory;
        return pr;
    }
}