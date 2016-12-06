public class imageLoader {
    public string Id {get; set;}
    public string attId {get; set;}
    
    public imageLoader(ApexPages.StandardController controller) {
        Id = Apexpages.currentpage().getParameters().get('id');
        attId = [select id, Name from attachment where parentId = :Id order by Name limit 1].Id;
    }

}