public class TaleController {
    public boolean noimage {get; set;}
    public string tid = apexpages.currentpage().getparameters().get('id');
    public string cid {get; set;}
    public string i {get; set;}
    public chapter__c chapter {get; set;} 
    public list<chapter__c> chapters = [select id, name, order__c, (select id, name, story__r.id, story__r.name, story__r.date__c, story__r.quote__c, story__r.quoted__c, story__r.body__c from installments__r order by order__c) from chapter__c where tale__c = :tid order by order__c];
    public list<chapter__c> getChapters(){
        return chapters;
    }
    public list<string> installments {get; set;}
    public String getTid() {
        return tid;
    }
    public integer totalstories {get; set;}
    public storywrapper sw = new storywrapper();
    public map<integer,storywrapper> stories = new map<integer,storywrapper>();
    
    public attachment getimage(){
        attachment a = new attachment();
        try{
            a = [select id, body from attachment where parentid = :sw.storyid];
            
        }catch(exception e){
            a = [select id, body from attachment where parentid = 'a03A0000005hUN4'];
            noimage = true;
        }
        return a;
    }
    public storywrapper getStory(){
        
        return sw;
    }
    public void init(){
        noimage = false;
        integer o = 1;
        cid = apexpages.currentpage().getparameters().get('c');
        installments = new list<string>();
        if(cid != null){
            Chapter = [select id, name, order__c, (select id, name, story__r.id, story__r.name, story__r.date__c, story__r.quote__c, story__r.quoted__c, story__r.body__c, Order__c from installments__r order by order__c) from chapter__c where id = :cid];
            for(installment__c i : chapter.installments__r){
                storywrapper sw = new storywrapper();
                story__c s = new story__c();
                s.name = i.story__r.name;
                s.date__c = i.story__r.date__c;
                s.quote__c = i.story__r.quote__c;
                s.quoted__c = i.story__r.quoted__c;
                s.body__c = i.story__r.body__c;
                sw.story = s;
                sw.order = o;
                //sw.chapter = c;
                sw.chaptername = chapter.name;
                sw.chapternumber = string.valueof(chapter.order__c);
                sw.storyid = i.story__r.id;
                stories.put(o,sw);
                installments.add(string.valueof(o));
                o++;
            }
        }else{
            for(chapter__c c : chapters){
                for(installment__c i : c.installments__r){
                    storywrapper sw = new storywrapper();
                    story__c s = new story__c();
                    s.name = i.story__r.name;
                    s.date__c = i.story__r.date__c;
                    s.quote__c = i.story__r.quote__c;
                    s.quoted__c = i.story__r.quoted__c;
                    s.body__c = i.story__r.body__c;
                    sw.story = s;
                    sw.order = o;
                    //sw.chapter = c;
                    sw.chaptername = c.name;
                    sw.chapternumber = string.valueof(c.order__c);
                    sw.storyid = i.story__r.id;
                    stories.put(o,sw);
                    o++;
                }
            }
        }
        totalstories = stories.size();
        i = apexpages.currentpage().getParameters().get('i');
        sw = stories.get(integer.valueof(i));
        chapters.clear();
        stories.clear();
    }
    public pagereference next(){
        pagereference pr = page.tale;
        pr.getParameters().put('i',string.valueof(sw.order + 1));
        return pr;
    }
    public pagereference prev(){
        pagereference pr = page.tale;
        pr.getParameters().put('i',string.valueof(sw.order - 1));
        return pr;
    }
    public class storywrapper{
        public integer order {get; set;}
        public string StoryID {get; set;}
        public story__c story {get; set;}
        //public chapter__c chapter {get; set;}
        public string chaptername {get; set;}
        public string chapternumber {get; set;}
        public storywrapper(){
        }
        public storywrapper(integer i, story__c s){
            this.order = i;
            this.story = s;
        }
    }
}