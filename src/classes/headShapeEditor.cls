public with sharing class headShapeEditor {	
	public Shape__c neck {get; set;}
	public Shape__c part {get; set;}
	public Head_Layout__c head {get; set;}
	public list<Shape__c> partShapes {get; set;}
	//public list<Shape__c> neckShapes {get; set;}
	public list<Color_Scheme__c> colorSchemes {get; set;}
	public list<Head_Layout__c> headLayouts {get; set;}
	public list<Head_Layout__c> heads {get; set;}
	public string headid {get; set;}
	public headShapeEditor() {
		
	}
	public void init(){		
		//string n = apexpages.currentPage().getParameters().get('n');
		string p = apexpages.currentPage().getParameters().get('p');
		string h = apexpages.currentPage().getParameters().get('h');
		//if(n != null && n != ''){
		//	neck = [SELECT Id, JSON__c, Type__c FROM Shape__c WHERE Id=:n];
		//}else{
		//	neck = new shape__c();
		//}
		if(p != null && p != ''){
			part = [SELECT Id, JSON__c, Type__c FROM Shape__c WHERE Id=:p];
		}else{
			part = new shape__c();
		}
		if(h != null && h != ''){
			head = [SELECT Id, Symmetry__c, Shape__c, Anchors__c FROM Head_Layout__c WHERE Id=:h];
		}else{
			head = new Head_Layout__c();
		}
		partShapes = new list<Shape__c>();
		//neckShapes = new list<Shape__c>();
		colorSchemes = new list<Color_Scheme__c>();
		headLayouts = new list<Head_Layout__c>();

		for(Shape__c s : database.query('SELECT Id, Name, JSON__C, Type__c FROM Shape__c ORDER BY CreatedDate')){
			//if(s.Type__c == 'Part') 
			partShapes.add(s);
			//if(s.Type__c == 'Neck') neckShapes.add(s);
		}

		colorSchemes = database.query('SELECT Id, Name, Primary_Color__c, Secondary_Color__c, Tertiary_Color__c, Primary_Accent__c, Secondary_Accent__c, Tertiary_Accent__c FROM Color_Scheme__c ORDER BY Name');
		headLayouts = database.query('SELECT Id, Name, Symmetry__c, Anchors__c, Shape__c FROM Head_Layout__c ORDER BY Name');
		
		heads = new list<head_layout__c>();
		heads = [SELECT Id, Symmetry__c, Shape__c, Anchors__c FROM Head_Layout__c]; // WHERE Id=:id];
	}
	//public pageReference saveNeck(){
	//	neck.Type__c = 'Neck';
	//	upsert neck;
	//	pagereference pr = apexpages.currentpage();
	//	return pr;
	//}
	public pageReference savePart(){
		part.Type__c = 'Part';
		upsert part;
		pagereference pr = apexpages.currentpage();
		pr.getParameters().put('m','p');
		return pr;
	}
	public pageReference saveHead(){
		if(headid != ''){
			head_Layout__c editedHead = [select id, name, shape__c, anchors__c, symmetry__c from head_layout__c where id = :headid];
			editedHead.shape__c = head.shape__c;
			editedHead.anchors__c = head.anchors__c;
			update editedHead;
		}else{
			//head.id = headid;
			head.Symmetry__c = 'Horizontal';
			upsert head;
		}
		pagereference pr = apexpages.currentpage();
		pr.getParameters().put('m','h');
		return pr;
	}
}