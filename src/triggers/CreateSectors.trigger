trigger CreateSectors on Map__c (after insert) {

    transient list<sector__c> sectors = new list<sector__c>();
    for(map__c newmap : trigger.new){
        integer x = 1;
        integer y = 1;
        for(integer i = 1; i <= newmap.area__c; i++){
            integer gPot = Math.floor(Math.random() * 10).intValue();
            integer beacon = Math.floor(Math.random() * 100).intValue();
            if(beacon == 50){
                beacon = Math.floor(Math.random() * 10).intValue()/2;
            }else{
                beacon = 0;
            }

            Sector__c sector = new Sector__c(Map__c = newmap.id, Base_Rpot__c = 0, Base_Gpot__c = gPot, Order__c = i, Beacon_Star__c = beacon);
            if(x<=newmap.width__c){
                sector.x__c = x;
                sector.y__c = y;
            }else{
                x = 1;
                y++;
                sector.x__c = x;
                sector.y__c = y;
            }
            x++;
            sectors.add(sector);
        }
    }
    insert sectors;
}