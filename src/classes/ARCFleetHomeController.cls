public with sharing class ARCFleetHomeController {
	public string                	    id           	  	{get; set;}
	public list<Release_Note__c> 	    releaseNotes 	  	{get; set;}
	public Player__c                    Player              {get; set;}
    public String                       playerFirstName     {get; set;}
    public String                       playerLastName      {get; set;}
    public Player__c                    newPlayer           {get; set;}
	public string               	    email	     	  	{get; set;}
	public string               	    password     	  	{get; set;}
	public string               	    newemail	     	{get; set;}
	public string               	    newpassword     	{get; set;}
    public list<Game__c>                Games               {get; set;}
    public list<selectoption>           Maps                {get; set;}
    public Game__c                      newGame             {get; set;}
    public Game__c                      game                {get; set;}
    public string                       version             {get; set;}
    public list<screenshot__c>          screenshots         {get; set;}
    public transient Cookie             playerId            {get; set;}
    public Boolean                      rememberme          {get; set;}
    
    public void init() {            
        playerId = ApexPages.currentPage().getCookies().get('playerId');
        if(playerId != null){
            id = playerId.getValue();
        }else{
            id = apexpages.currentpage().getparameters().get('id'); 
        }
        newPlayer = new Player__c();

        games = new list<Game__c>();
        if(String.isNotBlank(id)){
            player = [SELECT id, Name, email__c FROM Player__c WHERE Id =:id];
            try{
                game = [SELECT id, Name FROM Game__c WHERE Player__c =:id limit 1];
            }catch(exception e){
                game = new game__c();
                game.Player__c = id;
                game.Public__c = true;
                insert game;
                //newGame();
            }
            games = [SELECT Id, Name, Public__c, Production_Value__c, Resource_Value__c, Regular_Fleets__c, Explorer_Fleets__c, Destroyer_Fleets__c, ARCBases__c, Mood__c, Mood_Label__c, Map_Name__c, Percent_explored__c, Civilization_Level__c, Turns__c, Civilization_Name__c FROM Game__c WHERE Player__c =:id ORDER BY Public__c desc];
            //Maps = new list<selectoption>();            
            //newGame = new game__c();
            //for(Map__c m:[SELECT Id,Name FROM Map__c]){
            //    Maps.add(new selectoption(m.id,m.name));
            //}
            //newGame.Map__c = Maps[0].getvalue();
            //newGame.Player__c = id;
            //newGame.Public__c = true;
        }
    	releaseNotes = [SELECT Id, Name, Title__c, Version_Number__c, Notes__c, CreatedDate FROM Release_Note__c WHERE Title__c != '' Order By Major_Release__c desc, Minor_Release__c desc LIMIT 10];
        version = releaseNotes[0].Version_Number__c;
        screenshots = [SELECT Id, Name, Description__c, Order__c, (Select Id From Attachments order by createddate desc limit 1) FROM screenshot__c WHERE Active__c = true Order By Order__c];        
	}	
    public PageReference newGame(){
        insert newGame;
        //id batchinstanceid = database.executeBatch(new CreateGameSectors(newGame.Id,newGame.Map__c));   
        //AsyncApexJob j = [select Id, Status, NumberOfErrors from AsyncApexJob where id =: batchinstanceid];

        pagereference pr = Page.Game;
        pr.getParameters().clear();
        pr.getparameters().put('id',newGame.id);
        pr.setRedirect(true);
        return pr;
    }
    public PageReference login(){        
        pagereference pr = Page.ARCFleetHome;  
        try{
            Player = [select Id From Player__c WHERE Password__c =:password AND Email__c =:email];            
            if(rememberme){
                playerId = new Cookie('playerId',player.Id,null,-1,false);
                ApexPages.currentPage().setCookies(new Cookie[]{playerId});
            }else{
                pr.getParameters().clear();
                pr.getparameters().put('id',Player.id);
            }               
            pr.setRedirect(true);
            return pr;
        }catch(exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Unable to authenticate the supplied login info because reasons.'));
            return null;
        }  
    }
    public PageReference logout(){
        playerId = new Cookie('playerId',null,null,0,false);
        ApexPages.currentPage().setCookies(new Cookie[]{playerId});
        pagereference pr = Page.ARCFleetHome;  
        pr.getParameters().clear();      
        pr.setRedirect(true);
        return pr;
    }
    public PageReference register(){
        newPlayer.Name = playerFirstName+' '+playerLastName;
        newPlayer.Email__c = newEmail;
        newPlayer.Password__c = newPassword;
        try{
            insert newPlayer;
        }catch(exception ex){
            ApexPages.addMessages(ex);
        }
        System.debug(newPlayer);
        pagereference pr = Page.ARCFleetHome;
        pr.getParameters().clear();
        pr.getparameters().put('id',newPlayer.id);
        pr.setRedirect(true);
        return pr;
    }
}