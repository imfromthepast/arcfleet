public with sharing class ARCBugTrackerController {
	public string rid {get; set;}
	public Bug__c bug {get; set;}
	public list<Bug__c> bugs {get; set;}
	public attachment a {get; set;}

	public ARCBugTrackerController() {
        rid = apexpages.currentpage().getparameters().get('r');
		bug = new Bug__c();
		a = new attachment(ContentType = 'image/jpg');
		bug.Reporter__c = rid;
		bug.Browser__c = ApexPages.currentPage().getHeaders().get('USER-AGENT');
		bugs = [SELECT Id, Name, Browser__c, Description__c, Priority__c, Reporter__c, Reporter__r.Name, Status__c, (SELECT Id, Name, ContentType FROM Attachments WHERE Name ='Screenshot' LIMIT 1) FROM Bug__c ORDER By NAME Desc];
	}
	public PageReference submitBug(){
		insert bug;
		if(a.body != null){
			a.Name = 'Screenshot';
			a.parentId = bug.Id;
			insert a;
		}
		pagereference pr = apexpages.currentPage();
		pr.getParameters().clear();
		pr.getparameters().put('r',rid);
		pr.setRedirect(true);
		return pr;
	}
}