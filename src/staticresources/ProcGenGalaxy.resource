// Whirlpool
!function(){var r,o,f,n,t,i,a,e,u,l,h,v,c=10,p=[],d=[],s="ᠣ웨螸ŏ㚦틵祯酒悼鮎ꌌ笵ᷠퟂ⹋﹗ᕷ㟥鿰䫚壉⤊놠殅뵝ჴ쬾է䆋Ᵹ闘ﯮ籦�䞞쨭뼇굚茳挂ꩱ젙䧙守騦㊰햀뻍㑈ｺ遟⁨᪮둔錢擱猒䀈쏬�贽需켫皂혛떯橐䗳ワ㽕ꋪ斺⿀�﵍鉵ڊ닦ฟ拔ꢖ暈╙葲㥌幸㢌톥댡鰞䏇ﰄ写洍﫟縤㮫츑轎럫㲁铷뤓ⳓ쐃噄義⪻셓�鵬ㅴ겉ᓡᘺ椉炶탭챂颤⡜";for(o=8;o-->0;)p[o]=[];for(f=0;256>f;f++){n=s.charCodeAt(f/2),a=0==(1&f)?n>>>8:255&n,e=a<<1,e>=256&&(e^=285),u=e<<1,u>=256&&(u^=285),l=u^a,h=u<<1,h>=256&&(h^=285),v=h^a,p[0][f]=[0,0],p[0][f][0]=a<<24|a<<16|u<<8|a,p[0][f][1]=h<<24|l<<16|e<<8|v;for(var o=1;8>o;o++)p[o][f]=[0,0],p[o][f][0]=p[o-1][f][0]>>>8|p[o-1][f][1]<<24,p[o][f][1]=p[o-1][f][1]>>>8|p[o-1][f][0]<<24}for(d[0]=[0,0],t=1;c>=t;t++)i=8*(t-1),d[t]=[0,0],d[t][0]=4278190080&p[0][i][0]^16711680&p[1][i+1][0]^65280&p[2][i+2][0]^255&p[3][i+3][0],d[t][1]=4278190080&p[4][i+4][1]^16711680&p[5][i+5][1]^65280&p[6][i+6][1]^255&p[7][i+7][1];var g=[],y=[],A=0,C=0,z=[],W=[],b=[],q=[],B=[],D=function(){var r,o,f,n,t;for(r=0,o=0;8>r;r++,o+=8)q[r]=[0,0],q[r][0]=(255&y[o])<<24^(255&y[o+1])<<16^(255&y[o+2])<<8^255&y[o+3],q[r][1]=(255&y[o+4])<<24^(255&y[o+5])<<16^(255&y[o+6])<<8^255&y[o+7];for(r=0;8>r;r++)B[r]=[0,0],W[r]=[0,0],B[r][0]=q[r][0]^(W[r][0]=z[r][0]),B[r][1]=q[r][1]^(W[r][1]=z[r][1]);for(f=1;c>=f;f++){for(r=0;8>r;r++)for(b[r]=[0,0],t=0,n=56,o=0;8>t;t++,n-=8,o=32>n?1:0)b[r][0]^=p[t][W[r-t&7][o]>>>n%32&255][0],b[r][1]^=p[t][W[r-t&7][o]>>>n%32&255][1];for(r=0;8>r;r++)W[r][0]=b[r][0],W[r][1]=b[r][1];for(W[0][0]^=d[f][0],W[0][1]^=d[f][1],r=0;8>r;r++)for(b[r][0]=W[r][0],b[r][1]=W[r][1],t=0,n=56,o=0;8>t;t++,n-=8,o=32>n?1:0)b[r][0]^=p[t][B[r-t&7][o]>>>n%32&255][0],b[r][1]^=p[t][B[r-t&7][o]>>>n%32&255][1];for(r=0;8>r;r++)B[r][0]=b[r][0],B[r][1]=b[r][1]}for(r=0;8>r;r++)z[r][0]^=B[r][0]^q[r][0],z[r][1]^=B[r][1]^q[r][1]};r=Whirlpool=function(o){return r.init().add(o).finalize()},r.version="3.0",r.init=function(){for(var o=32;o-->0;)g[o]=0;for(A=C=0,y=[0],o=8;o-->0;)z[o]=[0,0];return r};var E=function(r){var o,f,n=r.toString();for(r=[],o=0;o<n.length;o++)f=n.charCodeAt(o),f>=256&&r.push(f>>>8&255),r.push(255&f);return r};r.add=function(o,f){if(!o)return r;f||(o=E(o),f=8*o.length);var n,t,i,a=0,e=8-(7&f)&7,u=7&A,l=f;for(n=31,i=0;n>=0;n--)i+=(255&g[n])+l%256,g[n]=255&i,i>>>=8,l=Math.floor(l/256);for(;f>8;){if(t=o[a]<<e&255|(255&o[a+1])>>>8-e,0>t||t>=256)return"Whirlpool requires a byte array";y[C++]|=t>>>u,A+=8-u,512==A&&(D(),A=C=0,y=[]),y[C]=t<<8-u&255,A+=u,f-=8,a++}return f>0?(t=o[a]<<e&255,y[C]|=t>>>u):t=0,8>u+f?A+=f:(C++,A+=8-u,f-=8-u,512==A&&(D(),A=C=0,y=[]),y[C]=t<<8-u&255,A+=f),r},r.finalize=function(){var r,o,f,n="",t=[],i="0123456789ABCDEF".split("");if(y[C]|=128>>>(7&A),C++,C>32){for(;64>C;)y[C++]=0;D(),C=0,y=[]}for(;32>C;)y[C++]=0;for(y.push.apply(y,g),D(),r=0,o=0;8>r;r++,o+=8)f=z[r][0],t[o]=f>>>24&255,t[o+1]=f>>>16&255,t[o+2]=f>>>8&255,t[o+3]=255&f,f=z[r][1],t[o+4]=f>>>24&255,t[o+5]=f>>>16&255,t[o+6]=f>>>8&255,t[o+7]=255&f;for(r=0;r<t.length;r++)n+=i[t[r]>>>4],n+=i[15&t[r]];return n}}();
// End Whirlpool
var debug = false;
var seed = '';
var sectors = [];
var metadataArray = [];
var galaxyName = '';
var civilizationName = '';
var giberish = '';
var homeSector;
var homeSectors = [];
var alienSectors = [];
var giberishArray = [];
var blackHoles = {
	0:[],
	1:[],
	2:[],
	3:[],
	4:[],
	5:[],
	6:[],
	7:[],
	8:[],
	9:[],
	10:[]
};
// Attribute Arrays
var galaxyTypeArray = [
	'S','S','S','S','S','S','S','S',
	'SB','SB','SB','SB','SB','SB','SB','SB'
];
var galaxyTypeSuffixArray = ['c','b','a'];
var coreSizeArray = [
	2,2,2,2,2,2,2, 	// 0-6
	1,1,1,1,1,		// 7-11
	0,0,0,0			// 12-15
];
var terrainArray =[
	'Axis',			// 0
	'Fringe',		// 1
	'Interspiral',	// 2
	'Nucleus',		// 3
	'Core'			// 4
];
var terrainValue = {
	'Axis':3,
	'Fringe':2,
	'Interspiral':1,
	'Nucleus':0,
	'Core':0	
}
var tightnessArray = [
	0.7,0.7,0.7,0.7,0.7,0.7,	// 0-5
	0.85,0.85,0.85,0.85,0.85,	// 6-10
	1.05,1.05,1.05,1.05,1.05			// 11-15
];
var pointsArray = [
	13,13,13,13,13,13,			// 0-5
	9,9,9,9,9,					// 6-10
	6,6,6,6,6					// 11-15
];
var civilizationType = [
	'Empire','Federation','Hegemony','Confederacy','Conglomerate','Coalition',
	'Aristocracy','Autocracy','Theocracy','Monarchy ','Empire','Republic',
	'Empire','Federation','Republic','Empire'
];
var namePartArray = [
    "en" , "la" , "can", "be" ,
    "and", "phi", "eth", "ol" ,
    "ve" , "ho" , "a"  , "lia",
    "an" , "ar" , "ur" , "mi" ,

    "in" , "ti" , "qu" , "so" ,
    "ed" , "ess", "ex" , "io" ,
    "ce" , "ze" , "fa" , "ay" ,
    "wa" , "da" , "ack", "gre"
];
var cloudsArray = [
	0,0,0,0,0,					// 0-4
	1,1,1,						// 5-7
	2,2,2,2,2,2,				// 8-13
	3,3							// 14-15
];
var cloudTypeArray = [
	3,3,3,3,3,3,3,3,3,3,3,		// 0-10
	2,2,2,						// 11-13
	1,1							// 14-15
];
var cloudSizeArray = [
	/*
	6,6,6,6,6,6,
	9,9,9,9,
	8,8,8,
	9,9,
	10
	*/
	/**/
	1,1,1,1,1,1,				// 0-5
	2,2,2,2,					// 6-9
	3,3,3,						// 10-12
	4,4,						// 13-14
	5							// 15
	/**/
];
var metadataName = {
	'galaxyShapeName':0,
	'galaxyShape':1,
	'coreSize':2,
	'galaxyType':3,
	'galaxyNameSyllables':4,
	'galaxyNameSyllable-0':5,
	'galaxyNameSyllable-1':6,
	'galaxyNameSyllable-2':7,
	'galaxyNameSyllable-3':8,
	'civilizationNameSyllables':9,
	'civilizationNameSyllable-0':10,
	'civilizationNameSyllable-1':11,
	'civilizationNameSyllable-2':12,
	'civilizationNameSyllable-3':13,
	'civilizationType':14,
	'clouds':15,
	'cloudDistance-0':16,
	'cloudDistance-1':17,
	'cloudDistance-2':18,
	'cloudSize-0':19,
	'cloudSize-1':20,
	'cloudSize-2':21,
	'cloudSize-3':22,
	'galaxyNameSyllable-0x':23,
	'galaxyNameSyllable-1x':24,
	'galaxyNameSyllable-2x':25,
	'galaxyNameSyllable-3x':26,
	'civilizationNameSyllable-0x':27,
	'civilizationNameSyllable-1x':28,
	'civilizationNameSyllable-2x':29,
	'civilizationNameSyllable-3x':30,
	'cloudType':31,
	'giberishSeed':32,
	'giberishSeedx':33
}
var populationName = {
	'x':0,
	'y':1,
	'a':2,
	'ap':3,
	'r':4,
	'e':5,
	'd':6,
	'ex':7,
	'aa':8,
	'ar':9,
	'ae':10,
	'ad':11,
	'am':12
}
var syllableArray = [
	2,2,2,2,					// 0-3
	3,3,3,3,3,3,3,3,			// 4-11
	4,4,4,4
];
// Utility Functions
function getXY(i){
	i++;
	var x = i % 100==0?100:Math.ceil(i % 100);
	var y = Math.ceil(i/100);
    
    return {x:x,y:y};
}
function getIndex(x,y){
	return (((parseInt(y)-1)*100)+parseInt(x))-1;
}
function distance(p1, p2){
   dx = p2.x - p1.x; dx *= dx;
   dy = p2.y - p1.y; dy *= dy;
   return Math.floor( Math.sqrt( dx + dy ) );
}
function randomIntFromInterval(min,max){
    return Math.floor(Math.random()*(max-min+1)+min);
}
function metadata(n){
	var i = metadataName[n];
	return parseInt('0x'+metadataArray[parseInt('0x'+i)]);
}
//var gWaveSectors = [];
// Galaxy Gen Functions
function generate(){
	var hash = '';
	var hash2 = '';
	var hashArray = Whirlpool(seed).split('');
	for (var i = 0; i < hashArray.length; i++) {
		hash += Whirlpool(hashArray[i]);
	};
	var gPotArray = hash.substring(0,10000).split('');
	// console.log('hash length: '+hashArray.length);
	// console.log('gPot length: '+hash.length);
	sectors = [];
	//gWaveSectors = [];
	for (var i = 0; i < gPotArray.length; i++) {
		sectors[i] = {
			Id 						: getXY(i).x +'x'+ getXY(i).y,
			Order					: i+1,
			X						: getXY(i).x,
			Y						: getXY(i).y,
			Terrain					: 'Empty',
			IsHomeSector			: false,
			BlackHole				: getXY(i).x == 50 && getXY(i).y == 50 ? 10 : 0,
			BaseGPot				: Math.min(5,Math.floor(parseInt('0x'+gPotArray[i])/2)),
			BaseRPot				: Math.min(5,Math.floor(parseInt('0x'+gPotArray[i])/2)),
			DarkMatter				: false,
			ResourceValue			: 0,
			ARCBasePoints			: 0,
			HasARCBase				: false,
			Explored				: false,
			IsAlienHome				: false,
			AlienId 				: '',
			AlienCivName			: 'Aliens!',
			AlienCivLvl				: 0,
			AlienARCBase			: 0,
			AlienRegularCount		: 0,
			AlienExplorerCount		: 0,
			AlienDestroyerCount		: 0,
			AlienMood				: 0,
			InactiveRegularCount	: 0,
            InactiveExplorerCount	: 0,
            InactiveDestroyerCount	: 0,
            ActiveRegularCount		: 0,
            ActiveExplorerCount		: 0,
            ActiveDestroyerCount	: 0,
            ARCBaseIsActive			: true,
            TotalRegularCount		: function(){return this.ActiveRegularCount + this.InactiveRegularCount;},
            TotalExplorerCount		: function(){return this.ActiveExplorerCount + this.InactiveExplorerCount;},
            TotalDestroyerCount		: function(){return this.ActiveDestroyerCount + this.InactiveDestroyerCount;},
            FullARCBase				: function(){return this.ResourceValue == this.ARCBasePoints;},
            //VisibleInARCSpace		: false, //function(){return false;}, //{return $scope.VisibleInARCSpace.indexOf(this.X+'x'+this.Y)>=0;},
            ARCPot 					: function(){return this.Terrain == 'Empty'?0:this.BaseGPot;},
            GWaveSector 			: function(){
				var d = distance({x:50,y:50},{x:this.X,y:this.Y});
				var t = turn%50;
				var gw1 = d==t && this.BaseGPot>2;
				var gw2 = d==t-1 && this.BaseGPot>3;
				var gw3 = d==t-2 && this.BaseGPot>4;	
				var gw =0;

				if(gw1) gw = 3;
				if(gw2) gw = 2;
				if(gw3) gw = 1;	
				//var gw = (d >= t-1) && (d <= t+1) && this.BaseGPot>2;
				//if(gw1 && this.BlackHole == 0 && this.HasARCBase) gWaveSectors.push({x:this.X,y:this.Y});
				if(this.Terrain == 'Empty') gw = 0;
				return gw;
			},
            RegularPositionClass	: function(){
            	var pos = 1;
            	var amt = 1;
            	if(this.HasExplorerFleet()) amt++;
            	if(this.HasDestroyerFleet()) amt++;
				return 'pos-'+pos+'-'+amt;
            },
            ExplorerPositionClass	: function(){
            	var pos = 1;
            	var amt = 1;
            	if(this.HasRegularFleet()){
            		pos = 2;
            		amt++;
            	}
            	if(this.HasDestroyerFleet()){
            		if(this.HasRegularFleet()){
            			pos = 2;
            		}else{
            			pos = 1;
            		}		                    		
            		amt++;
            	}		                    	
            	return 'pos-'+pos+'-'+amt;
            },
            DestroyerPositionClass	: function(){	
            	var pos = 1;
            	var amt = 1;
            	if(this.HasRegularFleet()){
            		pos++;
            		amt++;
            	}
            	if(this.HasExplorerFleet()){
            		pos++;
            		amt++;
            	}
            	return 'pos-'+pos+'-'+amt;
            },	
            HasRegularFleet 		: function(){return this.TotalRegularCount()>0;},
            HasExplorerFleet 		: function(){return this.TotalExplorerCount()>0;},
            HasDestroyerFleet 		: function(){return this.TotalDestroyerCount()>0;},                    
            HasARCFleet 			: function(){return this.HasRegularFleet() || this.HasExplorerFleet() || this.HasDestroyerFleet();},
            HasContactFleets 		: function(){return (this.AlienRegularCount + this.AlienExplorerCount + this.AlienDestroyerCount) > 0;},
            HasContactARCBase 		: function(){return this.AlienARCBase > 0;},
            HasContacts 			: function(){return this.HasContactARCBase() || this.HasContactFleets();},
            HasConstructs			: function(){return this.HasARCBase || this.HasARCFleet();}
		};
	};
	metadataArray = hash.substring(10000).split('');
	// console.log('metadata length: '+metadataArray.length);
	// function metadata(n){
	// 	var i = metadataName[n];
	// 	return parseInt('0x'+metadataArray[parseInt('0x'+i)]);
	// }
	var galaxyShapeName = metadata('galaxyShapeName');
	var tightness = tightnessArray[metadata('galaxyShape')];		    		
	var points = pointsArray[metadata('galaxyShape')];
	var coreSize = 1; //0.5; //coreSizeArray[metadata('coreSize')];
	var galaxyType = galaxyTypeArray[metadata('galaxyType')] + galaxyTypeSuffixArray[coreSize];
	giberishArray = [];
	giberish = '';
	var giberishHashArray = Whirlpool(metadata('giberishSeed')).split('');
	for (var i = 0; i < giberishHashArray.length; i++) {
		var index = metadata('giberishSeedx')>8?parseInt('0x'+giberishHashArray[i])+16:parseInt('0x'+giberishHashArray[i]);
		giberishArray.push(namePartArray[index]);
		giberish += namePartArray[index];
	};
	civilizationName = '';
	galaxyName = '';
	for (var i = 0; i < syllableArray[metadata('galaxyNameSyllables')]; i++) {
		var index = metadata('galaxyNameSyllable-'+i+'x')>8?metadata('galaxyNameSyllable-'+i)+16:metadata('galaxyNameSyllable-'+i);
		galaxyName += namePartArray[index];
	};
	for (var i = 0; i < syllableArray[metadata('civilizationNameSyllables')]; i++){
		var index = metadata('civilizationNameSyllable-'+i+'x')>8?metadata('civilizationNameSyllable-'+i)+16:metadata('civilizationNameSyllable-'+i);
		civilizationName += namePartArray[index];
	};
	civilizationName = civilizationName.charAt(0).toUpperCase() + civilizationName.slice(1)+ ' ' + civilizationType[metadata('civilizationType')];
	var rot = 0;
	genGalaxy(points,[0,2],tightness,rot,coreSize);
	// console.log('clouds: '+cloudsArray[metadata('clouds')]);
	for (var i = 0; i < cloudsArray[metadata('clouds')]; i++) {
		// console.log('cloud distance: '+(15+metadata('cloudDistance-'+i)));
		// console.log('cloud size: '+cloudSizeArray[metadata('cloudSize-'+i)]);
		genCloud(
			cloudSizeArray[metadata('cloudSize-'+i)],
			i,
			tightness,
			rot,
			15+metadata('cloudDistance-'+i),
			cloudTypeArray[metadata('cloudType')]
		);
	};
	setAliens();
	setHomeSector();
	// console.log(sectors.length);
	// console.log('black holes: ');
	// console.log(blackHoles);
	return metadataArray;
}
function genGalaxy(p,d,t,r,c){
	homeSectors = [];
	alienSectors = [];
	drawArm(p,d[0],t,'Interspiral',r,c,1);
	drawArm(p,d[1],t,'Interspiral',r,c,1);
	drawArm(p,d[0],t,'Fringe',r,c,1);
	drawArm(p,d[1],t,'Fringe',r,c,1);
	drawArm(p,d[0],t,'Axis',r,c,1);
	drawArm(p,d[1],t,'Axis',r,c,1);
	drawArm(2,d[0],t,'Nucleus',r,c,1);
	drawArm(2,d[1],t,'Nucleus',r,c,1);
	drawArm(2,d[0],t,'Core',r,c,1);
	drawArm(2,d[1],t,'Core',r,c,1);
}
function genCloud(p,d,t,r,c,ct){
	drawArm(p,d,t,'Interspiral',r,c,4);
	drawArm(p,d,t,'Fringe',r,c,4);
	drawArm(p,d,t,'Axis',r,c,4);
}
function drawArm(numMax,dir,t,ter,rot,coreSize,step){
    var x = 50;
    var y = 50;
    //var step = 1;
    var cx,cy = 0;
    if(dir==0){
    	x += coreSize;
    	y -= coreSize;
    }
    if(dir==1){
    	x += coreSize;
    	y += coreSize;
    }
    if(dir==2){
    	x -= coreSize;
    	y += coreSize;
    }
    if(dir==3){
    	x -= coreSize;
    	y -= coreSize;
    }
    var Arr1_0 = [4,3,2,1];
    var Arr2_0 = [3,2,1,4];
    var Arr3_0 = [2,1,4,3];
    var Arr4_0 = [1,4,3,2];
    var Arr1_1 = [2,1,4,3];
    var Arr2_1 = [1,4,3,2];
    var Arr3_1 = [4,3,2,1];
    var Arr4_1 = [3,2,1,4];
    var rotation = {
    	s1_0:Arr1_0[rot],
    	s1_1:Arr1_1[rot],
    	s2_0:Arr2_0[rot],
    	s2_1:Arr2_1[rot],
    	s3_0:Arr3_0[rot],
    	s3_1:Arr3_1[rot],
    	s4_0:Arr4_0[rot],
    	s4_1:Arr4_1[rot]
    }
    //console.log('coreSize: '+coreSize+' '+x+'x'+y);
	drawArc(1,x,y,rotation.s1_0,ter,numMax);
    for(i=0,j=step,k=0; k<numMax; i=j,j=f,k++ ){
        f= Math.ceil((i+j)*t);
        if(step == 1){
        	if(dir==0){
        		x+=f;
        		y-=f;
        		cx = x;
        		cy = y+f;
        		drawArc(f,cx,cy,rotation.s1_0,ter,numMax - k);
        	}else{
        		x-=f;
        		y+=f;
        		cx = x;
        		cy = y-f;
        		drawArc(f,cx,cy,rotation.s1_1,ter,numMax - k);
        	}
        }else if(step == 2){
        	if(dir==0){
        		x+=f;
        		y+=f;
        		cx=x-f;
        		cy=y;
        		drawArc(f,cx,cy,rotation.s2_0,ter,numMax - k);
        	}else{
        		x-=f;
        		y-=f;
        		cx=x+f;
        		cy=y;
        		drawArc(f,cx,cy,rotation.s2_1,ter,numMax - k);
        	}
        }else if(step == 3){
        	if(dir==0){
        		x-=f;
        		y+=f;
        		cx=x;
        		cy=y-f;
        		drawArc(f,cx,cy,rotation.s3_0,ter,numMax - k);
        	}else{
        		x+=f;
        		y-=f;
        		cx=x;
        		cy=y+f;
        		drawArc(f,cx,cy,rotation.s3_1,ter,numMax - k);
        	}
        }else if(step == 4){
        	if(dir==0){
        		x-=f;
        		y-=f;
        		cx=x+f;
        		cy=y;
        		drawArc(f,cx,cy,rotation.s4_0,ter,numMax - k);
        	}else{
        		x+=f;
        		y+=f;
        		cx=x-f;
        		cy=y;
        		drawArc(f,cx,cy,rotation.s4_1,ter,numMax - k);
        	}
        }
        step = step==4?step=1:step+1;
    }
}
function drawArc(r,cx,cy,q,t,at){

	if(debug) sectors[getIndex(cx,cy)].Terrain = 'arcCenter';
	var min = 8;
	if(q == 1){	
        for (var xx = cx; xx >= cx - r; xx--) {
        	for (var yy = cy; yy <= cy + r; yy++) {
        		if(distance({x:xx,y:yy},{x:cx,y:cy}) == r){
        			if(xx<=100 && yy<=100){
        				drawArmTexture(xx,yy,at,t);
        			}
        		}
        	};
        };					    
	}
	if(q == 2){						
        for (var xx = cx; xx <= cx + r; xx++) {
        	for (var yy = cy; yy <= cy + r; yy++) {
        		if(distance({x:xx,y:yy},{x:cx,y:cy}) == r){
        			if(xx<=100 && yy<=100){
        				drawArmTexture(xx,yy,at,t);
        			}
        		}
        	};
        };						
	}
	if(q == 3){						
        for (var xx = cx; xx <= cx + r; xx++) {
        	for (var yy = cy; yy >= cy - r; yy--) {
        		if(distance({x:xx,y:yy},{x:cx,y:cy}) == r){
        			if(xx<=100 && yy<=100){
        				drawArmTexture(xx,yy,at,t);
        			}
        		}
        	};
        };					    
	}
	if(q == 4){						
        for (var xx = cx; xx >= cx - r; xx--) {
        	for (var yy = cy; yy >= cy - r; yy--) {
        		if(distance({x:xx,y:yy},{x:cx,y:cy}) == r){
        			if(xx<=100 && yy<=100){
        				drawArmTexture(xx,yy,at,t);
        			}
        		}
        	};
        };					    
	}					
}
var addBlackHole = false;
function setAliens(){
	//console.log('turn: '+turn);
	for (var i = 0; i < alienSectors.length; i++) {
		var x = alienSectors[i].x;
		var y = alienSectors[i].y;

		sectors[getIndex(x,y)].BaseGPot = 10;
		sectors[getIndex(x,y)].DarkMatter = false;
		sectors[getIndex(x,y)].IsAlienHome = true;
		sectors[getIndex(x,y)].IsHomeSector = false;
		sectors[getIndex(x,y)].Terrain = 'Axis';
		spawnAlienCivilization(x,y,i);	
		// if(turn == 1){
			
		// 	var index = x+'x'+y;
		// 	console.log(index);
		// 	relationships[index] = 0;
		// }
		//relationships.push({id:x+','+y,val:0}) //[] = 0;	
	};
}
function setHomeSector(){	
	homeSector = homeSectors[Math.floor(homeSectors.length/2)];
	var x = homeSector.x;
	var y = homeSector.y;
	sectors[getIndex(x,y)].BaseGPot = 10;
	sectors[getIndex(x,y)].DarkMatter = false;
	sectors[getIndex(x,y)].IsAlienHome = false;
	sectors[getIndex(x,y)].IsHomeSector = true;
	sectors[getIndex(x,y)].ResourceValue = 10;
	sectors[getIndex(x,y)].Terrain = 'Axis';
	// console.log('setHomeSector: ');
	// console.log(sectors[getIndex(x,y)]);
}
function drawArmTexture(x,y,r,t){
	
	if(t=='Axis'){
		spray(x,y,Math.min(4,r),t,0);
		spray(x,y,Math.min(2,r-1),t,2); 
		var adjacentSectorgPot = sectors[getIndex(x+1,y+1)].BaseGPot;
		var gPot = sectors[getIndex(x,y)].BaseGPot;
		if(adjacentSectorgPot == 0 && distance({x:x,y:y},{x:50,y:50})>10 && distance({x:x,y:y},{x:50,y:50})<30){
			if(addBlackHole){
				sectors[getIndex(x,y)].BlackHole = gPot; //<5?gPot:0;
				blackHoles[sectors[getIndex(x,y)].BlackHole].push({x:x,y:y});
			}
			addBlackHole = !addBlackHole;
		}
		if(adjacentSectorgPot == 5 && distance({x:x,y:y},{x:50,y:50})>30){
			homeSectors.push({x:x,y:y});
		}
		if(adjacentSectorgPot == 2 && distance({x:x,y:y},{x:50,y:50})>10){
			if(gPot == 5) alienSectors.push({x:x,y:y});
		}
    }
    if(t=='Fringe'){
        spray(x,y,Math.min(10,r*3),t,0);
        spray(x,y,Math.min(5,r*2),t,1); //8
    }
    if(t=='Interspiral'){
        spray(x,y,Math.min(15,r*6),t,0);
        spray(x,y,Math.min(10,r*4),t,1); //15
    }
    if(t=='Nucleus'){
        spray(x,y,7,t,3); //15
    }
    if(t=='Core'){
        spray(x,y,3,t,6); //15
    }
}
function spray(x,y,r,t,f){
	var i = 0;
	var textureArray = Whirlpool(t+r+seed+x+'x'+y).split('');
	if(debug) sectors[getIndex(x,y)].Terrain = 'arc';
	for(var j=x-r; j<=x+r; j++){
    	$j.merge(textureArray,Whirlpool(j+t+r+seed+x+'x'+y).split(''));
    	for(var k=y-r; k<=y+r; k++){
        	if(distance({x:j,y:k},{x:x,y:y}) <= r){	
				if(parseInt('0x'+textureArray[i]) <= f){
	        		if(is.not.undefined(sectors[getIndex(j,k)])){
			        	if(sectors[getIndex(j,k)].BaseGPot == 0) sectors[getIndex(j,k)].DarkMatter = true;
			        	if(sectors[getIndex(j,k)].Terrain!='arc' && sectors[getIndex(j,k)].Terrain!='arcCenter'){
			        		sectors[getIndex(j,k)].Terrain = t;
			        		if(t=='Core' || t=='Nucleus') sectors[getIndex(j,k)].BaseGPot = 1;
			        		if(t=='Empty') sectors[getIndex(j,k)].BaseGPot = 0;
			        		sectors[getIndex(j,k)].ResourceValue = terrainValue[t]+sectors[getIndex(j,k)].BaseRPot;
			        	}
			        }
		        }
		    }
		    i++;
       	}
    }
}

var alienARCBaseArray 	= ['10','10','8','8','6','6','4','4','4','4','0','0','0','0','0','0'];
var alienRegularArray 	= ['5','5','5','3','3','3','3','3','1','1','1','1','0','0','0','0'];
var alienExplorerArray 	= ['7','7','4','4','4','4','4','2','2','2','2','2','0','0','0','0'];
var alienDestroyerArray = ['4','4','3','3','3','3','3','3','1','1','1','0','0','0','0','0'];
var alienSizeArray 		= [5,5,5,4,4,4,3,3,3,2,2,1,1,0,0,0];
var alienDecisionArray 	= [2,3,4,5,6,2,3,4,5,6,2,3,4,5,6,2];
var alienMoodArray 		= [1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3];
var alienCivLvlArray 	= [1,1,1,1,1,1,1,1,1,1,2,2,2,2,3,3];

function spawnAlienCivilization(x,y,ai){
	
	var civArray = Whirlpool(seed+x+'x'+y).split('');
	var sjson = x+','+y+',f,0,0,0,0,f,'+
		alienARCBaseArray[parseInt('0x'+civArray[2])]+','+
		alienRegularArray[parseInt('0x'+civArray[3])]+','+
		alienExplorerArray[parseInt('0x'+civArray[4])]+','+
		alienDestroyerArray[parseInt('0x'+civArray[5])]+','+
		alienMoodArray[parseInt('0x'+civArray[6])]+';';
	var alienNameSyllables = syllableArray[parseInt('0x'+civArray[7])];
	var alienCivName = '';
	for (var i = 0; i < alienNameSyllables; i++) {
		alienCivName += giberishArray[i+ai];
	};
	alienCivName = 'The '+capitaliseFirstLetter(alienCivName)+' ' + civilizationType[parseInt('0x'+civArray[8])]
	var alienCivLvl = alienCivLvlArray[parseInt('0x'+civArray[9])];
	sectors[getIndex(x,y)].AlienCivName = alienCivName; //+' Home Sector';
	sectors[getIndex(x,y)].AlienCivLvl = alienCivLvl;
	var i = 10;
	var r = alienSizeArray[parseInt('0x'+civArray[0])];
	for(var j=x-r; j<=x+r; j++){
    	for(var k=y-r; k<=y+r; k++){
        	if(distance({x:j,y:k},{x:x,y:y}) <= r){	
				if(parseInt('0x'+civArray[i]) == alienDecisionArray[parseInt('0x'+civArray[1])]){
	        		if(is.not.undefined(sectors[getIndex(j,k)])){
			        	var civThisSectorArray = Whirlpool(seed+j+'x'+k).split('');
			        	sjson += j+','+k+',f,0,0,0,0,f,'+
			        		alienARCBaseArray[parseInt('0x'+civThisSectorArray[0])]+','+
			        		alienRegularArray[parseInt('0x'+civThisSectorArray[1])]+','+
			        		alienExplorerArray[parseInt('0x'+civThisSectorArray[2])]+','+
			        		alienDestroyerArray[parseInt('0x'+civThisSectorArray[3])]+','+
			        		alienMoodArray[parseInt('0x'+civArray[6])]+';';			        	
			        	sectors[getIndex(j,k)].IsAlienHome = true;
			        	sectors[getIndex(j,k)].AlienCivName = alienCivName;
			        	sectors[getIndex(j,k)].AlienCivLvl = alienCivLvl;
			        	sectors[getIndex(j,k)].AlienId = x+','+y;
			        }
		        }
		    }
		    i++;
       	}
    }
    return sjson;
}
function capitaliseFirstLetter(string){
    return string.charAt(0).toUpperCase() + string.slice(1);
}