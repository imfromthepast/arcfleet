public class ChapterEditController {

    public chapter__c chapter {get; set;}
    public story__c newstory {get; set;}
    public installment__c ni {get; set;}
    public list<installment__c> installments {get; set;}
    public list<story__c> stories {get; set;}
    public string id {get; set;}
    public string sid {get; set;}
    public list<installmentwrapper> iws {get; set;}
    
    
    public void init(){
        id = apexpages.currentpage().getParameters().get('id');
        sid = apexpages.currentpage().getParameters().get('sid');
        installments = new list<installment__c>();
        iws = new list<installmentwrapper>();
        stories = new list<story__c>();
        chapter = [select id, name, order__c, quote__c, quoted__c, tale__c, tale__r.name, (select id, name, order__c, story__c from installments__r order by order__c) from chapter__c where id = :id];
        installments.addAll(chapter.installments__r);
        list<string> storyids = new list<string>();
        newstory = new story__c();
        ni = new installment__c();
        for(installment__c i : installments){
            installmentwrapper iw = new installmentwrapper();
            storyids.add(i.story__c);
            if(i.story__c == null){
                story__c s = new Story__c();
                s.name = 'New Installment';
                insert s;
                i.story__c = s.id;
            }
            iw.i = i;
            iw.s = [select id, name, date__c, quote__c, quoted__c, body__c from story__c where id = :i.story__c];
            iws.add(iw);
            stories.add(iw.s);
        }
        //stories = [select id, name, date__c, quote__c, quoted__c, body__c from story__c where id in :storyids];
    }
    public PageReference saveInstallments() {
        
        update Installments;
        pagereference pr = page.chapteredit;
        return pr;
    }
    public PageReference saveStories() {
        update Stories;
        pagereference pr = page.chapteredit;
        return pr;
    }
    public PageReference addInstallment() {
        
        string innum = '';
        if(stories.size()<10){
            innum='.0';
        }else{
            innum='.';
        }
        ni.chapter__c = chapter.id;
        ni.order__c = stories.size()+1;
        if(ni.story__c == null){
            insert newstory;
            ni.story__c = newstory.id;
        }
        ni.name = chapter.tale__r.name + ' ' + chapter.order__c + innum + (stories.size()+1);
        insert ni;
        pagereference pr = page.chapteredit;
        return pr;
    }
    public PageReference saveChapter() {
        update chapter;
        pagereference pr = page.chapteredit;
        return pr;
    }
    public class InstallmentWrapper{
        public installment__c i {get; set;}
        public story__c s {get; set;}
        
        public InstallmentWrapper(){
        }
    }
    
}