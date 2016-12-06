public class TerritoryCardController extends territorytemplatecontroller{
    public string coordinates {get; set;}
    public void init(){
        coordinates = territory.coordinates__c.replace(';','|');
        coordinates = coordinates + '|' + coordinates.substring(0,coordinates.indexof('|'));
    }
}