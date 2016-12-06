public with sharing class ngRemoteObjectsController {
  /**
  * @description holds component attribute which has all defined remoteObjects (i.e. 'Account, Contact')
  */
  public String remoteObjectNames { get; set; }
  
  /**
  * @description holds list of all remoteObjects that were defined in remoteObjectNames. This is necessary for the apex:repeat
  */
  public List<String> remoteObjectList { 
    get {
      remoteObjectList = new List<String>();
      if(this.remoteObjectNames != null) {
        for(String remoteObject : this.remoteObjectNames.split(',')) {
          remoteObjectList.add(remoteObject.trim());
        }
      }
      return remoteObjectList;
  } 
    private set; 
  }
  
  public ngRemoteObjectsController() {}
}