public with sharing class DropDownMenuController {
    public string preArrayString {get; set;}
    public DropDownMenuController() {
        
    }
    public list<String> getBits(){
        return preArrayString.split(';');
    }
    public integer getNoOfBits(){
        return preArrayString.split(';').size();
    }
}