public with sharing class CanvasController {
	public list<Shape__c> partShapes {get; set;}
	public list<Shape__c> neckShapes {get; set;}
	public list<Color_Scheme__c> colorSchemes {get; set;}
	public list<Head_Layout__c> headLayouts {get; set;}
	public Alien_Species__c alienSpecies {get; set;}

	public CanvasController() {
		
	}
	public void init(){
		partShapes = new list<Shape__c>();
		neckShapes = new list<Shape__c>();
		colorSchemes = new list<Color_Scheme__c>();
		headLayouts = new list<Head_Layout__c>();

		for(Shape__c s : database.query('SELECT Id, Name, JSON__C, Type__c FROM Shape__c ORDER BY CreatedDate')){
			if(s.Type__c == 'Part') partShapes.add(s);
			if(s.Type__c == 'Neck') neckShapes.add(s);
		}
		try{
			alienSpecies = database.query('SELECT Id, Name, Seeds__c FROM Alien_Species__c');
		}catch(exception e){
			alienSpecies = new Alien_Species__c();
			insert alienSpecies;
		}
		
		colorSchemes = database.query('SELECT Id, Name, Primary_Color__c, Secondary_Color__c, Tertiary_Color__c, Primary_Accent__c, Secondary_Accent__c, Tertiary_Accent__c FROM Color_Scheme__c ORDER BY Name');
		headLayouts = database.query('SELECT Id, Name, Symmetry__c, Anchors__c, Shape__c FROM Head_Layout__c ORDER BY Name');
	}
	public PageReference save(){
		upsert alienSpecies;
		pagereference pr = ApexPages.currentPage();
		return pr;
	}
}