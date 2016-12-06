public with sharing class WikiController {
	public String 					EntryName 				{get; set;}
	public String 					SearchTerm 				{get; set;}
	public Wiki_Entry__c 			Entry 					{get; set;}
	public Boolean 					IsEdit 					{get; set;}
	public Boolean 					IsError					{get; set;}
	public Boolean 					IsHome 					{get; set;}
	public String 					PageCount   			{get; set;}
	public String  					RedirectedFrom 			{get; set;}	
	public list<Wiki_Entry__c> 		Entries 				{get; set;}
	public list<Category__c> 		Categories 				{get; set;}
	public List<SelectOption>		CategorySelectOptions 	{get; set;}
	public List<SelectOption>		EntrySelectOptions 		{get; set;}
	public WikiController() {
		EntryName = apexpages.currentpage().getparameters().get('p');
		IsEdit = apexpages.currentpage().getparameters().get('m') == 'e';
		IsHome = false;
		IsError = false;
		SearchTerm = '';
		RedirectedFrom = '';
		PageCount = [SELECT Order__c FROM Wiki_Entry__c ORDER BY Order__c DESC LIMIT 1].Order__c;
		Categories = new List<Category__c>();
		CategorySelectOptions = new List<SelectOption>();
		EntrySelectOptions = new List<SelectOption>();
		CategorySelectOptions.add(new SelectOption('','-- None --'));
		EntrySelectOptions.add(new SelectOption('','-- None --'));
		for(Category__c c:[SELECT Id, Name, (SELECT Id,Name FROM Wiki_Entries__r ORDER BY Name) FROM Category__c ORDER BY Order__c]){
			CategorySelectOptions.add(new selectoption(c.id,c.name));
			Categories.add(c);
		}
		
		for(Wiki_Entry__c e:[SELECT Name FROM Wiki_Entry__c ORDER BY Name]){
			EntrySelectOptions.add(new selectoption(e.name,e.name));
		}

		if(String.isNotBlank(EntryName)){
			try{
				Entry = [SELECT Id, Name, Rich_Content__c, Redirect_Page__c, Category__r.Name, lastModifiedDate FROM Wiki_Entry__c WHERE Name =: EntryName LIMIT 1];
				if(String.IsNotBlank(Entry.Redirect_Page__c)){
					RedirectedFrom = Entry.Name;
					string newEntry = Entry.Redirect_Page__c;
					Entry = [SELECT Id, Name, Rich_Content__c, Redirect_Page__c, Category__r.Name, lastModifiedDate FROM Wiki_Entry__c WHERE Name =: newEntry LIMIT 1];
				}
			}catch(exception e){
				Entry = new Wiki_Entry__c();
				Entry.Name = EntryName;
				Entry.Rich_Content__c = 'New Page';
				
				IsEdit = true;
				IsError = true;
			}
		}else{
			EntryName = 'Introduction';
			Entry = [SELECT Id, Name, Rich_Content__c, Category__r.Name, lastModifiedDate FROM Wiki_Entry__c WHERE Name =:EntryName LIMIT 1];
			IsHome = true;
		}		
	}
	public pagereference save(){
		upsert entry;
		pagereference pr = apexpages.currentpage();
		pr.getParameters().clear();
		pr.getparameters().put('p',Entry.Name);
        pr.setRedirect(true);
		return pr;
	}
	public pagereference search(){
		pagereference pr = apexpages.currentpage();
		pr.getParameters().clear();
		pr.getparameters().put('p',SearchTerm);
        pr.setRedirect(true);
		return pr;
	}
	public pagereference random(){
		string random = string.valueof(randomIntFromInterval(1,integer.valueof(PageCount)));
		EntryName = [SELECT Name FROM Wiki_Entry__c WHERE Order__c =:random LIMIT 1].Name;

		pagereference pr = apexpages.currentpage();
		pr.getParameters().clear();
		pr.getparameters().put('p',EntryName);
        pr.setRedirect(true);
		return pr;
	}	
    public integer randomIntFromInterval(integer min,integer max){
        return integer.valueof(Math.floor(Math.random()*(max-min+1)+min));
    }
}