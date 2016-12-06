global class mapcontroller {
    public string               id = apexpages.currentpage().getparameters().get('id');
    public list<sector__c>      sectors         {get; set;}
    public map__c               m               {get; set;}
    public list<map__c>         maps            {get; set;}
    public transient string     sectorJSON      {get; set;}
    public string               sectorIds       {get; set;}
    public string               terrainType     {get; set;}
    public integer              beacon          {get; set;}
    public boolean              isHome          {get; set;}
    public attachment           a               {get; set;}
    public boolean              darkMatter      {get; set;}

    public void init(){
        
        m = [SELECT Id, Name, Height__c, Width__c, Area__c FROM Map__c WHERE ID =:id];
        try{a = [SELECT Id FROM Attachment WHERE ParentId = :m.Id LIMIT 1];}catch(exception e){}
        maps = [SELECT Id, Name FROM Map__c];
        //for(sector__c sec :[SELECT Id, Name, Order__c, X__c, Y__c, Base_GPot__c, Base_Rpot__C, Terrain__c, Beacon_Star__c, Beacon_Star_Name__c FROM Sector__c WHERE Map__c =:id ORDER BY Order__c]){
            //sectors.add(sec);
        //}
        sectorIds = '';
        sectorJSON = JSON.serialize(database.query('SELECT Id, Name, Order__c, X__c, Y__c, Dark_Matter__c, Base_GPot__c, Base_Rpot__C, Terrain__c, Beacon_Star__c, Beacon_Star_Name__c, Home_Sector__c FROM Sector__c WHERE Map__c =:id ORDER BY Order__c'));
    
    }
    public pagereference saveSectors(){
        sectors = new list<sector__c>();
        list<string> sids = sectorIds.split(';');
        system.debug('## SectorIds: '+sectorIds);
        system.debug('## Sids: '+sids);
        system.debug('Terrain: '+terrainType);
        system.debug('IsHome: '+isHome);
        for(Sector__c s : [SELECT Id, Terrain__c, Dark_Matter__c, Beacon_Star__c, Home_Sector__c FROM Sector__c WHERE Id IN:sids]){
            s.Terrain__c = terrainType;
            s.Beacon_Star__c = beacon;
            s.Home_Sector__c = isHome;
            s.Dark_Matter__c = darkMatter;
            sectors.add(s);
        }
        update sectors;
        sectors = new list<sector__c>();
        //return null;

        pagereference pr = apexpages.currentpage();
        pr.getParameters().clear();
        pr.getparameters().put('id',id);
        pr.setRedirect(true);
        return null;
    }
    public pagereference clearBeaconStars(){
        sectors = new list<sector__c>();
        for(Sector__c s : [SELECT Id, Terrain__c, Beacon_Star__c FROM Sector__c WHERE Map__c =:id AND Beacon_Star__c > 0]){
            s.Beacon_Star__c = 0;
            sectors.add(s);
        }
        update sectors;
        pagereference pr = apexpages.currentpage();
        pr.getParameters().clear();
        pr.getparameters().put('id',id);
        pr.setRedirect(true);
        return pr;
    }
    public pagereference expungeOrphanSectors(){
        list<Game_Sector__c> DeleteSectors = new list<Game_Sector__c>();
        for(Game_Sector__c s : [SELECT Id FROM Game_Sector__c WHERE Game__c = '' limit 1000]){
            
            //if(DeleteSectors.size()>999){
                //delete DeleteSectors;
                ////DeleteSectors.clear();
            //}else{
                DeleteSectors.add(s);
            //}
        }
        delete DeleteSectors;
        pagereference pr = apexpages.currentpage();
        pr.getParameters().clear();
        pr.getparameters().put('id',id);
        pr.setRedirect(true);
        return pr;
    }
}