public class dyadoneController {
    public string pg {get; set;}
    public dyadoneController(){
        pg=apexpages.currentpage().getParameters().get('pg');
    }
}