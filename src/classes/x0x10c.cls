public class x0x10c {
    public list<string> getimagecount(){
        list<string> imagecount = new list<string>();
        for(integer i = 1; i < 20; i++){
            string count = '';
            if(i<10){
                count = '00' + string.valueof(i);
            }
            imagecount.add(count);
        }    
        return imagecount;
    }
}