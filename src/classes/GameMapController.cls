public with sharing class GameMapController {
	public String 						id 					{get; set;}
	public Game__c 						game 				{get; set;}
	public Map__c 						m 					{get; set;}
	public transient string       		sectorJSON 			{get; set;}
	public list<Race__c>				races				{get; set;}

	public GameMapController() {
        id = apexpages.currentpage().getparameters().get('id');
        game = [SELECT Id, Name, Map__c FROM Game__c WHERE ID = :id];
    	//m = [SELECT Id, Name, Height__c, Width__c, Area__c FROM Map__c WHERE ID =:game.Map__c];
    	races = [SELECT Id, Name, Mood__c FROM Race__c WHERE Game__c = :game.Id];
    	string constructQuery = 'SELECT '+
    		'Id, '+
    		'Name, '+
    		'Type__c, '+
            'X__c,'+
            'Y__c,'+
    		'Class__c, '+
    		'Game_Sector__c, '+
            'Game_Sector__r.Terrain__c, '+
    		'Fleet_Size__c, '+
    		'Player__c, '+
    		'Potential_Resource_Points__c, '+
    		'Resource_Points__c, '+
            'Race__c '+
    		'FROM Constructs__r limit 10';
    	string sectorQuery = 'SELECT '+
    		'Id, '+
    		'Name, '+
    		'Order__c, '+
    		'X__c, '+
    		'Y__c, '+
    		'Terrain__c, '+
    		'Beacon_Star__c, '+
    		'Beacon_Star_Name__c, '+
    		'Base_GPot__c, '+
    		'Base_RPot__c, '+
    		'Resource_Value__c, '+
    		'Fleet_Size__c, '+
    		'Explorer_Log__c, '+
    		'Has_Starbase__c, '+
    		'('+constructQuery+') '+
    		'FROM Game_Sector__c WHERE Game__c =:id ORDER BY Order__c';
    	sectorJSON = JSON.serialize(database.query(sectorQuery));
	}
}