public with sharing class kingdomhallscontroller extends territorytemplatecontroller{ 
    public pagereference addKingdomHall(){
        insert newKingdomHall;
        pagereference pr = page.kingdomhall;
        pr.getparameters().put('id', newkingdomhall.id);
        //pr.setredirect(true);
        return pr;
    }
}