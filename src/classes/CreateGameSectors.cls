global class CreateGameSectors implements Database.Batchable<sObject> {
	
	String query;
	String GID;
	
	global CreateGameSectors(string g, string mid) {
		GID = g;
		query = 'SELECT Id, Map__c, Terrain__c, X__c, Y__c, Home_Sector__c, Beacon_Star__c, Beacon_Star_Name__c, Order__c, Base_Gpot__c, Base_RPot__c FROM Sector__c WHERE Map__c =\''+mid+'\'';
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		integer i = 0;
        integer randomIndex = Integer.valueof(Math.floor(Math.random()*10));
		list<Game_Sector__c> gameSectors = new list<Game_Sector__c>();
		for(Sobject s : scope){
			Sector__c sector = (Sector__c)s;
			Game_Sector__c gs = new Game_Sector__c();
            gs.Sector__c = sector.Id;
            gs.Game__c = GID;
            if(sector.Home_Sector__c){
                i++;
                if(randomIndex == i){
                    gs.Home_Sector__c = true;
                    gs.Resource_Value__c = 10;
                }
            }
            gameSectors.add(gs);
		}
		insert gameSectors;
	}
	
	global void finish(Database.BatchableContext BC) {
		Game__c g = [SELECT Id, Public__c FROM Game__c WHERE Id =: GID];
		g.Public__c = true;
		update g;
	}
	
}