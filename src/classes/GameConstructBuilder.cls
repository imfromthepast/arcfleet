public class GameConstructBuilder {
	public static list<Construct__c> cs = new list<Construct__c>();
	public GameConstructBuilder(list<Construct__c> constructs){
		cs = constructs;
	}
	@future 
	public static void insertConstructs(){
		insert cs;
	}
}