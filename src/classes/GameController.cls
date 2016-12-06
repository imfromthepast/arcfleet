public with sharing class GameController {
	public String                		status                  {get; set;}
	private String                	    id           	  	    {get; set;}
	public Map__c                	    m            	  	    {get; set;}
	public Game__c               	    game            	  	{get; set;}
	public transient string       		sectorJSON 			    {get; set;}
    //public transient string             constructJSON           {get; set;}
    public transient string             contactARCBasesJSON     {get; set;}
    public transient string             relationshipsJSON       {get; set;}
	public boolean               	    inProgress   	  	    {get; set;}
	public Integer                    	startX          	    {get; set;}
	public Integer                    	startY          	    {get; set;}
    public Decimal                      turn                    {get; set;}
    public Map<string,list<string>>     eventMatrix             {get; set;}
    public Event__c                     currentEvent            {get; set;}
    public Integer                      autonomousForces        {get; set;}
    public String                       eventTag                {get; set;}
    public String                       version                 {get; set;}
    public Boolean                      isDebug                 {get; set;}

    public list<game_sector__c> orphans {get; set;}
    public integer getHash(){
        string s = 'test';
        return s.hashCode(); //Crypto.generateDigest('SHA-512', b).toString();
    }
    public GameController(){
        turn=0;        
    }
    public void markExplored(){
        game.explored_last_turn__c = true;
    }
    public void init() {   
        version = [SELECT Version_Number__c FROM Release_Note__c WHERE Title__c != '' Order By Major_Release__c desc, Minor_Release__c desc LIMIT 1].Version_Number__c;
        eventTag = '0';
        id = apexpages.currentpage().getparameters().get('id');
        string debug = apexpages.currentpage().getparameters().get('d');
        isDebug = debug == 'Mellon';
        currentEvent = new Event__c();
        eventMatrix = new map<string,list<string>>();
        list<string> l0 = new list<string>();
        l0.add('0');
        l0.add('0');
        l0.add('0');
        l0.add('0');
        l0.add('0');
        l0.add('0');
        l0.add('0');
        l0.add('0');
        eventMatrix.put('0',l0);
        list<string> l1 = new list<string>();
        l1.add('0');
        l1.add('0');
        l1.add('0');
        l1.add('0');
        l1.add('0');
        l1.add('0');
        l1.add('H');
        l1.add('G');
        eventMatrix.put('1',l1);
        list<string> l2 = new list<string>();
        l2.add('A');
        l2.add('0');
        l2.add('0');
        l2.add('0');
        l2.add('G');
        l2.add('H');
        l2.add('J');
        l2.add('I');
        eventMatrix.put('2',l2);
        list<string> l3 = new list<string>();
        l3.add('C');
        l3.add('A');
        l3.add('0');
        l3.add('G');
        l3.add('H');
        l3.add('J');
        l3.add('I');
        l3.add('K');
        eventMatrix.put('3',l3);
        list<string> l4 = new list<string>();
        l4.add('E');
        l4.add('C');
        l4.add('A');
        l4.add('H');
        l4.add('J');
        l4.add('I');
        l4.add('G');
        l4.add('K');
        eventMatrix.put('4',l4);
        list<string> l5 = new list<string>();
        l5.add('B');
        l5.add('E');
        l5.add('C');
        l5.add('A');
        l5.add('I');
        l5.add('G');
        l5.add('J');
        l5.add('K');
        eventMatrix.put('5',l5);
        list<string> l6 = new list<string>();
        l6.add('D');
        l6.add('B');
        l6.add('E');
        l6.add('C');
        l6.add('A');
        l6.add('J');
        l6.add('L');
        l6.add('K');
        eventMatrix.put('6',l6);
        list<string> l7 = new list<string>();
        l7.add('F');
        l7.add('D');
        l7.add('B');
        l7.add('E');
        l7.add('C');
        l7.add('A');
        l7.add('L');
        l7.add('K');
        eventMatrix.put('7',l7);
        list<string> l8 = new list<string>();
        l8.add('A');
        l8.add('F');
        l8.add('D');
        l8.add('B');
        l8.add('E');
        l8.add('C');
        l8.add('L');
        l8.add('K');
        eventMatrix.put('8',l8);
        list<string> l9 = new list<string>();
        l9.add('C');
        l9.add('A');
        l9.add('F');
        l9.add('D');
        l9.add('B');
        l9.add('E');
        l9.add('L');
        l9.add('K');
        eventMatrix.put('9',l9);
        list<string> l10 = new list<string>();
        l10.add('E');
        l10.add('C');
        l10.add('A');
        l10.add('F');
        l10.add('D');
        l10.add('L');
        l10.add('L');
        l10.add('K');
        eventMatrix.put('10',l10);
        inProgress = id != '' && id != null;
        if(inProgress){
            game = [SELECT Id, Name, Player__c, Map__c, Galaxy_Name__c, CreatedDate, RelationShips__c, Sector_JSON_1__c, Sector_JSON_2__c, Sector_JSON_3__c, Sector_JSON_4__c, Sector_JSON_5__c, Sector_JSON_6__c, Sector_JSON_7__c, Sector_JSON_8__c, Sector_JSON_9__c, Sector_JSON_10__c, SFX_On__c, Start_X__c, Start_Y__c, Civilization_Level__c, Explored_Last_Turn__c, Mood__c, Mood_Label__c, Turns__c, Production_Value__c, Resource_Value__c, Map_Name__c, Civilization_Name__c FROM Game__c WHERE ID = :id];
            if(game.explored_last_turn__c == null){
                game.explored_last_turn__c = false;
            }
            if(game.Turns__c == null) game.Turns__c = 0;
            turn = game.Turns__c;
            if(turn == 0){
                game.Sector_JSON_1__c = '';
            }
            //handleEvent();
            game.turns__c++;
            turn = game.turns__c;
            sectorJSON = game.Sector_JSON_1__c; //+game.Sector_JSON_2__c+game.Sector_JSON_3__c+game.Sector_JSON_4__c+game.Sector_JSON_5__c+game.Sector_JSON_6__c+game.Sector_JSON_7__c+game.Sector_JSON_8__c+game.Sector_JSON_9__c+game.Sector_JSON_10__c;
            //sectorJSON = '[';
            //for(Integer i = 0; i < 10000; i++) {
            //   sectorJSON += '{"attributes":{"type":"ARCFleet__Game_Sector__c","url":"/services/data/v34.0/sobjects/ARCFleet__Game_Sector__c/a0FA000000F4Zr2MAF"},"Id":"a0FA000000F4Zr2MAF","ARCFleet__Order__c":'+i+',"ARCFleet__Terrain__c":"Axis","ARCFleet__X__c":1,"ARCFleet__Y__c":1,"ARCFleet__Beacon_Star__c":0,"ARCFleet__Base_GPot__c":4,"ARCFleet__Base_RPot__c":0,"ARCFleet__Dark_Matter__c":false,"ARCFleet__Has_ARCBase__c":false,"ARCFleet__Home_Sector__c":false,"ARCFleet__Constructs__c":"0;0;0;0;0;0;0;0"}';
            //   if(i<9999) sectorJSON +=',';
            //}
            //sectorJSON +=']';
            
            update game;      
        }
    }	
    public void handleEvent(){
        autonomousForces = 0;
        if(turn == 0){
            eventTag = '-1';
        }else{
            integer roll = randomIntFromInterval(0,7);
            decimal asp = Math.floor(game.Production_Value__c / 10);
            eventTag = eventMatrix.get(string.valueof(asp))[roll];
        }
        if(!string.isBlank(apexpages.currentpage().getparameters().get('et'))) eventTag = apexpages.currentpage().getparameters().get('et');
        boolean explored = !string.isBlank(apexpages.currentpage().getparameters().get('ex'))?apexpages.currentpage().getparameters().get('ex') == 'true':game.explored_last_turn__c;
        system.debug('Explored Last Turn: '+explored);
        system.debug('eventTag: '+eventTag);
        
        if(eventTag == 'G') eventTag = explored?'G':'0'; //autonomousForces = explored?1:-1;
        if(eventTag == 'H') eventTag = explored?'H':'0'; //autonomousForces = explored?2:-1;
        if(eventTag == 'I') eventTag = explored?'I':'0'; //autonomousForces = explored?3:-1;
        if(eventTag == 'J') eventTag = explored?'J':'0'; //autonomousForces = explored?4:-1;
        //if(autonomousForces < 0) eventTag = '0';
        //system.debug('autonomousForces: '+autonomousForces);
        explored = false;
        game.explored_last_turn__c = explored;
        list<Game_Sector__c> sectorsWithARCBase = [Select Id, Name FROM Game_Sector__c WHERE ARCBase_Points__c > 0 AND Game__c =:Id];
        currentEvent = [SELECT Id, Name, Tag__c, Description__c, Icon__c, Dissolution__c, Civilization_Level_Increase__c, Color__c, ARCBase_Count__c, Regular_Fleet_Count__c, Explorer_Fleet_Count__c, Destroyer_Fleet_Count__c FROM Event__c WHERE Tag__c = :eventTag];
        integer dissolutionCount = integer.valueof(Math.floor(currentEvent.Dissolution__c * sectorsWithARCBase.size()));
        for(Integer i = 0; i < dissolutionCount; i++) {
           sectorsWithARCBase[i].ARCBase_Points__c = 0;
        }
        update sectorsWithARCBase;

        system.debug('## dissolutionCount: '+dissolutionCount);
        //List<Game_Sector__c> alienSectors = new List<Game_Sector__c>();
        //for(Integer i = 0; i < currentEvent.ARCBase_Count__c; i++) {
        //   Game_Sector__c af = placeAutonomousForce();
        //   if(af.Id != null) alienSectors.add(af);
        //}
        //if(alienSectors.size()>0) update alienSectors;
    }
    //public Game_Sector__c placeAutonomousForce(){       
    //    integer i = 0;
    //    list<Game_Sector__c> exploredSectors = [SELECT Id, Alien_ARCBase__c, Alien_Regular_Count__c, Alien_Explorer_Count__c, Alien_Destroyer_Count__c FROM Game_Sector__c WHERE Game__c =:id AND Resource_Value__c > 0 AND Alien_ARCBase__c < 1 AND Has_ARCBase__c = false AND Has_Explorers__c = true];
    //    integer randomIndex = randomIntFromInterval(0,exploredSectors.size()-1);
    //    Game_Sector__c alienSector = new Game_Sector__c();
    //    for(Game_Sector__c es: exploredSectors) {
    //        i++;
    //        if(randomIndex == i){
    //            es.Alien_ARCBase__c = 10;
    //            es.Alien_Regular_Count__c = currentEvent.Regular_Fleet_Count__c;
    //            es.Alien_Explorer_Count__c = currentEvent.Explorer_Fleet_Count__c;
    //            es.Alien_Destroyer_Count__c = currentEvent.Destroyer_Fleet_Count__c;
    //            alienSector = es;
    //        }
    //    }
    //    return alienSector;
    //}
    public integer getsectorjsonsize(){
        return sectorJSON.length();
    }
    public integer randomIntFromInterval(integer min,integer max){
        return integer.valueof(Math.floor(Math.random()*(max-min+1)+min));
    }
    public PageReference EndTurn(){
        update game;
        pagereference pr = apexpages.currentpage();
        //pr.getParameters().clear();
        pr.getparameters().put('id',id);
        pr.setRedirect(false);
        return pr;
    }
    public PageReference selfDestruct(){
        delete game;
        pagereference pr = Page.ARCFleetHome;
        pr.setRedirect(false);
        return pr;
    }
    public PageReference startOver(){
        Game__c newGame = new Game__c();
        newGame.Player__c = game.Player__c;
        delete game;
        insert newGame;
        pagereference pr = Page.ARCFleetHome;
        pr.setRedirect(false);
        return pr; 
    }
}