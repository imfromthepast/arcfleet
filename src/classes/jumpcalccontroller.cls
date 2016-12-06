public class jumpcalccontroller {
    public decimal sourceJP             {get; set;}
    public decimal targetJP             {get; set;}
    public decimal distance             {get; set;}
    public decimal resistance           {get; set;}
    public decimal ChancesOfSuccess     {get; set;}
    public boolean LineOfSight          {get; set;}
    public boolean SourceInverter       {get; set;}
    public boolean TargetInverter       {get; set;}
    public decimal SourceLocalDensity   {get; set;}
    public decimal TargetLocalDensity   {get; set;}
    public string  Formula              {get; set;}
    
    public jumpcalccontroller(){
        //if(sourceJP == null) sourceJP = 5;
        //if(targetJP == null) targetJP = 10;
        //if(distance == null) distance = 10;
        
        //if(SourceLocalDensity == null) SourceLocalDensity = 0;
        //if(TargetLocalDensity == null) TargetLocalDensity = 0;
        //formula = ''+angleindegrees(1);
    }
    public long angleindegrees(decimal tangent){
        return math.roundtolong(math.atan(tangent)*(180/3.14));
    }
    //math.roundtolong(math.acos(math.cos((60*(3.14/180))))*(180/3.14))
    public pagereference Calc(){
        decimal tjp = 0;
        decimal sjp = 0;
        if(!TargetInverter)tjp = TargetJP;
        if(!SourceInverter)sjp = SourceJP;
        formula = ''+distance+'/(('+tJP+' + '+targetlocaldensity+') - ('+sJP+' + '+SourceLocalDensity+'))';
        resistance = distance/((tJP + targetlocaldensity) - (sJP + SourceLocalDensity));
        ChancesOfSuccess = (((tJP + targetlocaldensity) - (sJP + SourceLocalDensity))/(distance*distance))/resistance * 100;
        if(LineOfSight) ChancesOfSuccess = ChancesOfSuccess * 2;
        return null;
    }
}