public with sharing class testcontroller {
    Public task[] getActivities(){
        List<Task> tasks = new list<Task>();
        String accId = ApexPages.currentPage().getParameters().get('whatId');   
        String q =  'select id,subject,ActivityDate,Type,Status,Description,OwnerId,Owner.Name,Who.FirstName,Who.LastName FROM Task';
        For(contact c : database.query('select id,(' + q + 's) from contact where accountID = :accId')){
                Tasks.addall(c.tasks);
        }
        For(task t :database.query(q+' WHERE whatId = :accId')){
            Tasks.add(t);
        }
        Return tasks;
    }
}