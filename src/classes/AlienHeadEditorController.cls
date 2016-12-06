public with sharing class AlienHeadEditorController {
	public Shape__c neck {get; set;}
	public Shape__c part {get; set;}
	public Head_Layout__c head {get; set;}
	public list<Head_Layout__c> heads {get; set;}
	public AlienHeadEditorController() {
		
	}
	public void init(){
		string n = apexpages.currentPage().getParameters().get('n');
		string p = apexpages.currentPage().getParameters().get('p');
		string h = apexpages.currentPage().getParameters().get('h');
		if(n != null && n != ''){
			neck = [SELECT Id, JSON__c, Type__c FROM Shape__c WHERE Id=:n];
		}else{
			neck = new shape__c();
		}
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
		heads = new list<head_layout__c>();
		heads = [SELECT Id, Symmetry__c, Shape__c, Anchors__c FROM Head_Layout__c ORDER BY Name];
	}
	public pageReference saveNeck(){
		neck.Type__c = 'Neck';
		upsert neck;
		pagereference pr = apexpages.currentpage();
		return pr;
	}
	public pageReference savePart(){
		neck.Type__c = 'Part';
		upsert part;
		pagereference pr = apexpages.currentpage();
		return pr;
	}
	public pageReference saveHead(){
		head.Symmetry__c = 'Horizontal';
		upsert head;
		pagereference pr = apexpages.currentpage();
		return pr;
	}
}