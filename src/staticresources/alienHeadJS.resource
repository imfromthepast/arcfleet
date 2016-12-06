var colors = ['orange','red','blue','grey','tan','black','white','green','yellow','purple','violet'];
var rotations = [0,22.5,45,67.5,90,112.5,135,157.5,180,202.5,225,247.5,270,292.5,315,337.5,360];
var sizes = [0.5,0.6,0.7,0.8,0.9,1,1.25,1.5,1.75,2,2.25,2.5,2.75,3,3.25,3.5];
var zIndexes = [0,0,1,1,1,1,1,1];            
var skinPatterns = [0,1,2,3,4,5,6,7,8,9,10];
var symmetry = 'Horizontal';
var nameParts = [
    "en" , "la" , "can", "be" ,
    "and", "phi", "eth", "ol" ,
    "ve" , "ho" , "a"  , "lia",
    "an" , "ar" , "ur" , "mi" ,

    "in" , "ti" , "qu" , "so" ,
    "ed" , "ess", "ex" , "io" ,
    "ce" , "ze" , "fa" , "ay" ,
    "wa" , "da" , "ack", "gre",
	'phe','ash','ka','lon','gor','o','tex','ark','an','lex','mas','nim','min','kli','vul','rac',
	'vor','tac','len','bar','ri'
];
var attitudes = [
	'warlike','insane','aggressive','hostile','brutish','mean','petty','abusive','passive aggresive','wise','impetuous','foolish',
	'neutral','indifferent','aloof','elusive','shy','depressed','depressing','whiny','selfish','haughty','perverted',
	'playful','funny','good natured','effusive','genial','loving','happy','joyful','erotic','affectionate','friendly','compassionate'
];
var personalities = [
	'tend to rub people the wrong way','are known to have studied the Gravity Waves extensively','are just a bunch of swindlers',
	'have a terrible reputation in this part of the galaxy','think very highly of themselves','think very highly of other species',
	'would just as soon eat you as look at you','have no interest in establishing relations with your species','can\'t be bothered with you right now',
	'can\'t wait to go into business with you','can be a bit much at first','cannot be trusted','can be trusted',
	'have your best interest at heart','are very fond of bow ties','doesn\'t know the meaning of the word "no"','might have telepathic powers',
	'travel through space via wormholes','invented a truely unique way to dispose of wastes','have no immune system to speak of',
	'travel through space in living ships','cannot stand the sight of yogurt','dispise the color yellow','claim to be close personal friends with God',
	'claim Elvis was from their homeworld','would love to tell you the coordinates of their homeworld, as soon as they find it again',
	'have a nice planet with a wonderful view to sell you','once ruled half the galaxy, but then the Gravity Waves knocked them down to their current size',
	'never invented the wheel, but they\'ve done pretty good for themselves without it','never discovered fire, but they did discover querf, so they\'re just dandy. When you ask them what "querf" is they look at you in shock and then in pity',
	'reproduce via excagulation, which is a very difficult process','are an immortal species whose biggest past time is ritualistic suicide',
	'beleive themselves to be gods and encourage this belief in younger, less advanced species','think the Gravity Waves are a form of punishment sent by an ancient race that live on the other side of the galaxy',
	'do not like to travel too far from their homeworld'
]
var biologies = [
	'leafy','aquatic','bony','fleshy','crab-like','sun-dried','slimy','reptilian','mamilian','amphibian','tri-gendered','non gendered',
	'tree-like','mutated','herbavorous','arboreal','nocturnal','carnivorous','visious','flexible','sturdy','stiff'
];
var ages = [' new',' young',' moderately young','n old','n advanced',' very advanced','n ancient'];
var descriptions = [' technologically','n ethically',' morally',' sexually',' mentally',' socially',' spiritually','n allegedly'];
var cultures = ['advanced','backward','retarded','stunted','growing','indifferent','obtuse','challenged','repressed','depraved','benign'];
var histories = [
	'blew up their homeworld in nuclear war','ruined their homeworld with pollution','are suffering from plummeting birthrates',
	'have fought many wars with other species','have made friends with many other species','suffer from irrepairably damaged genes',
	'discovered spaceflight rather easily','still follow a wise ruler from their ancient past','can never seem to be able to find their car keys',
	'suffer from an accute aversion to cats','seem to enjoy nothing but trading','are big fans of knots','eat their young',
	'have mating habits that are best described as horrifying. Seriously, this is eyeball bleach level stuff',
	'want nothing more than to be left alone','are really into sustainable energy','are not quite what they seem',
	'unwisely experimented on their own home star, causing it to collapse into a black hole','like to dabble in cloning'
];
var shinyArray = [true,false];
var sylablles = [2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4];
var alienRaceSeed = [];
// Whirlpool
!function(){var r,o,f,n,t,i,a,e,u,l,h,v,c=10,p=[],d=[],s="ᠣ웨螸ŏ㚦틵祯酒悼鮎ꌌ笵ᷠퟂ⹋﹗ᕷ㟥鿰䫚壉⤊놠殅뵝ჴ쬾է䆋Ᵹ闘ﯮ籦�䞞쨭뼇굚茳挂ꩱ젙䧙守騦㊰햀뻍㑈ｺ遟⁨᪮둔錢擱猒䀈쏬�贽需켫皂혛떯橐䗳ワ㽕ꋪ斺⿀�﵍鉵ڊ닦ฟ拔ꢖ暈╙葲㥌幸㢌톥댡鰞䏇ﰄ写洍﫟縤㮫츑轎럫㲁铷뤓ⳓ쐃噄義⪻셓�鵬ㅴ겉ᓡᘺ椉炶탭챂颤⡜";for(o=8;o-->0;)p[o]=[];for(f=0;256>f;f++){n=s.charCodeAt(f/2),a=0==(1&f)?n>>>8:255&n,e=a<<1,e>=256&&(e^=285),u=e<<1,u>=256&&(u^=285),l=u^a,h=u<<1,h>=256&&(h^=285),v=h^a,p[0][f]=[0,0],p[0][f][0]=a<<24|a<<16|u<<8|a,p[0][f][1]=h<<24|l<<16|e<<8|v;for(var o=1;8>o;o++)p[o][f]=[0,0],p[o][f][0]=p[o-1][f][0]>>>8|p[o-1][f][1]<<24,p[o][f][1]=p[o-1][f][1]>>>8|p[o-1][f][0]<<24}for(d[0]=[0,0],t=1;c>=t;t++)i=8*(t-1),d[t]=[0,0],d[t][0]=4278190080&p[0][i][0]^16711680&p[1][i+1][0]^65280&p[2][i+2][0]^255&p[3][i+3][0],d[t][1]=4278190080&p[4][i+4][1]^16711680&p[5][i+5][1]^65280&p[6][i+6][1]^255&p[7][i+7][1];var g=[],y=[],A=0,C=0,z=[],W=[],b=[],q=[],B=[],D=function(){var r,o,f,n,t;for(r=0,o=0;8>r;r++,o+=8)q[r]=[0,0],q[r][0]=(255&y[o])<<24^(255&y[o+1])<<16^(255&y[o+2])<<8^255&y[o+3],q[r][1]=(255&y[o+4])<<24^(255&y[o+5])<<16^(255&y[o+6])<<8^255&y[o+7];for(r=0;8>r;r++)B[r]=[0,0],W[r]=[0,0],B[r][0]=q[r][0]^(W[r][0]=z[r][0]),B[r][1]=q[r][1]^(W[r][1]=z[r][1]);for(f=1;c>=f;f++){for(r=0;8>r;r++)for(b[r]=[0,0],t=0,n=56,o=0;8>t;t++,n-=8,o=32>n?1:0)b[r][0]^=p[t][W[r-t&7][o]>>>n%32&255][0],b[r][1]^=p[t][W[r-t&7][o]>>>n%32&255][1];for(r=0;8>r;r++)W[r][0]=b[r][0],W[r][1]=b[r][1];for(W[0][0]^=d[f][0],W[0][1]^=d[f][1],r=0;8>r;r++)for(b[r][0]=W[r][0],b[r][1]=W[r][1],t=0,n=56,o=0;8>t;t++,n-=8,o=32>n?1:0)b[r][0]^=p[t][B[r-t&7][o]>>>n%32&255][0],b[r][1]^=p[t][B[r-t&7][o]>>>n%32&255][1];for(r=0;8>r;r++)B[r][0]=b[r][0],B[r][1]=b[r][1]}for(r=0;8>r;r++)z[r][0]^=B[r][0]^q[r][0],z[r][1]^=B[r][1]^q[r][1]};r=Whirlpool=function(o){return r.init().add(o).finalize()},r.version="3.0",r.init=function(){for(var o=32;o-->0;)g[o]=0;for(A=C=0,y=[0],o=8;o-->0;)z[o]=[0,0];return r};var E=function(r){var o,f,n=r.toString();for(r=[],o=0;o<n.length;o++)f=n.charCodeAt(o),f>=256&&r.push(f>>>8&255),r.push(255&f);return r};r.add=function(o,f){if(!o)return r;f||(o=E(o),f=8*o.length);var n,t,i,a=0,e=8-(7&f)&7,u=7&A,l=f;for(n=31,i=0;n>=0;n--)i+=(255&g[n])+l%256,g[n]=255&i,i>>>=8,l=Math.floor(l/256);for(;f>8;){if(t=o[a]<<e&255|(255&o[a+1])>>>8-e,0>t||t>=256)return"Whirlpool requires a byte array";y[C++]|=t>>>u,A+=8-u,512==A&&(D(),A=C=0,y=[]),y[C]=t<<8-u&255,A+=u,f-=8,a++}return f>0?(t=o[a]<<e&255,y[C]|=t>>>u):t=0,8>u+f?A+=f:(C++,A+=8-u,f-=8-u,512==A&&(D(),A=C=0,y=[]),y[C]=t<<8-u&255,A+=f),r},r.finalize=function(){var r,o,f,n="",t=[],i="0123456789ABCDEF".split("");if(y[C]|=128>>>(7&A),C++,C>32){for(;64>C;)y[C++]=0;D(),C=0,y=[]}for(;32>C;)y[C++]=0;for(y.push.apply(y,g),D(),r=0,o=0;8>r;r++,o+=8)f=z[r][0],t[o]=f>>>24&255,t[o+1]=f>>>16&255,t[o+2]=f>>>8&255,t[o+3]=255&f,f=z[r][1],t[o+4]=f>>>24&255,t[o+5]=f>>>16&255,t[o+6]=f>>>8&255,t[o+7]=255&f;for(r=0;r<t.length;r++)n+=i[t[r]>>>4],n+=i[15&t[r]];return n}}();
// End Whirlpool
function efa(index,arr){
	return arr[alienRaceSeed[index]%arr.length];
}
function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}
function drawAlien(alienSeed){   
    console.log(alienSeed);
    var featureQuantities = [3,4,5,6];
    var hashArray = Whirlpool(alienSeed).split('');
    alienRaceSeed = [];            
    for (var i = 0; i < hashArray.length; i+=2) {
        var seedPart = parseInt('0x'+hashArray[i]+hashArray[i+1]);
        alienRaceSeed.push(seedPart);
    }
    var parts = [];
    for (var i = 0; i < featureQuantities[alienRaceSeed[9]%featureQuantities.length]; i++) {                
        var f = {
            size:sizes[alienRaceSeed[10+(i*9)]%sizes.length],
            color:colors[alienRaceSeed[11+(i*9)]%colors.length],
            rotation:rotations[alienRaceSeed[12+(i*9)]%rotations.length],
            shape:alienRaceSeed[13+(i*9)],
            z:zIndexes[alienRaceSeed[14+(i*9)]%zIndexes.length],
            shiny:efa(15+(i*9),shinyArray),
            futureField:alienRaceSeed[16+(i*9)],
            futureField:alienRaceSeed[17+(i*9)],
            futureField:alienRaceSeed[18+(i*9)]
        };
        // console.log(10+(i*9) + ': '+alienRaceSeed[10+(i*9)])
        // console.log(11+(i*9) + ': '+alienRaceSeed[11+(i*9)])
        // console.log(12+(i*9) + ': '+alienRaceSeed[12+(i*9)])
        // console.log(13+(i*9) + ': '+alienRaceSeed[13+(i*9)])
        // console.log(14+(i*9) + ': '+alienRaceSeed[14+(i*9)])
        // console.log(15+(i*9) + ': '+alienRaceSeed[15+(i*9)])
        // console.log(16+(i*9) + ': '+alienRaceSeed[16+(i*9)])
        // console.log(17+(i*9) + ': '+alienRaceSeed[17+(i*9)])
        // console.log(18+(i*9) + ': '+alienRaceSeed[18+(i*9)])
        parts.push(f);
    }
    var headLayout = headLayouts[alienRaceSeed[0] % headLayouts.length];    
    symmetry = headLayout.symmetry;
    var colorScheme = colorSchemes[alienRaceSeed[1] % colorSchemes.length]; 
    var head = new createjs.Container();
    head.x=0;
    head.y=rifi(-10,50);
    var skinColor1 = getColor(colorScheme[0]); 
    var skinColor2 = getColor(colorScheme[1]);
    var skinColor3 = getColor(colorScheme[2]);
    var skinColor4 = getColor(colorScheme[3]);
    //console.log(skinColor1);
    var neck = drawPolygon(10,skinColor3,efa(0,headLayouts).shape,1,false);
    neck.x=0;
    neck.y=100;
    head.addChild(neck); 
    head.addChild(flipX(neck));
    var neck2 = drawPolygon(10,efa(4,colors),efa(3,headLayouts).shape,1,false);
    neck2.x=0;
    neck2.y=400;
    neck2.scaleY = -1;
    head.addChild(neck2); 
    if(headLayout.symmetry.mirrorX) head.addChild(flipX(neck2));

    var skin = new createjs.Shape();
    var x = rifi(50,100);
    var y = rifi(0,100);
    skin.graphics.beginFill(skinColor2).moveTo(x,y);
    var skinPattern = efa(2,skinPatterns); //skinPatterns[alienRaceSeed[2] % skinPatterns.length];
    for (var i = 0; i < 10; i++) {
        var jitter = 80;
        x = rifi(x-jitter,x+jitter);
        y = rifi(y-jitter,y+jitter);
        var cx1 = rifi(x-jitter,x+jitter); 
        var cy1 = rifi(y-jitter,y+jitter); 
        var cx2 = rifi(x-jitter,x+jitter); 
        var cy2 = rifi(y-jitter,y+jitter); 
        var radius = x/10<0?1:x/10;                
        if(skinPattern == 1 || skinPattern == 5 || skinPattern == 7 || skinPattern == 9) skin.graphics.qt(cx1,cy1,cx2,cy2,x,y);
        if(skinPattern == 2 || skinPattern == 5 || skinPattern == 8 || skinPattern == 10) skin.graphics.drawCircle(x,y,radius);
        if(skinPattern == 3 || skinPattern == 6 || skinPattern == 7 || skinPattern == 10) skin.graphics.drawEllipse(x,y,rifi(2,x),rifi(2,200-y));
        if(skinPattern == 4 || skinPattern == 6 || skinPattern == 8 || skinPattern == 9) skin.graphics.drawPolyStar(100,rifi(10,100),rifi(20,60),rifi(6,8),rifi(0.5,0.9),rifi(0,90));
    }           
    var shape = drawPolygon(10,skinColor1,headLayout.shape,30,false); 
    skin.clip = shape; 
    var skin2 = flipX(skin);
    skin2.clip = shape;   
    var rearshape = drawPolygon(10,skinColor3,headLayouts[alienRaceSeed[1] % headLayouts.length].shape,30,false)
    var rearshape2 = drawPolygon(10,skinColor4,headLayouts[alienRaceSeed[2] % headLayouts.length].shape,30,false)
    if(alienRaceSeed[3]<128){
	    head.addChild(rearshape2);
	    if(headLayout.symmetry.mirrorX) head.addChild(flipX(rearshape2));
	}
	//if(alienRaceSeed[3]>84 && alienRaceSeed[3]<170){
	    head.addChild(rearshape);  
	    if(headLayout.symmetry.mirrorX) head.addChild(flipX(rearshape));
	//}

    head.addChild(skin);
    if(headLayout.symmetry.mirrorX) head.addChild(skin2);
             
    drawParts(head,headLayout,parts,true);
    var name = '';
    for (var i = 1; i <= efa(0,sylablles); i++) {
    	name += efa(i,nameParts);
    }
    var history = 'A'+efa(0,ages)+', '+efa(1,attitudes)+' species, made up of '+efa(2,biologies)+' beings. Theirs is a'+efa(3,descriptions)+' '+efa(4,cultures)+' culture who '+efa(5,histories)+'. Typically '+efa(6,attitudes)+', this species '+efa(7,personalities)+'.';
    var alien = {head:head,name:name,attitude:efa(0,attitudes),seed:alienSeed,history:history,dna:alienRaceSeed};
    return alien;
}
function blur(s){
    var blurFilter = new createjs.BlurFilter(4, 4, 2);
    s.filters = [blurFilter];
    var bounds = blurFilter.getBounds();
    s.cache(-200+bounds.x, -200+bounds.y, 2000+bounds.width, 2000+bounds.height);
}
function drawParts(head,headLayout,parts,hilight){
    var behindTheHeadCount = 0;
    var partsContainer = new createjs.Container();
    partsContainer.name="partsContainer"
    for (var i = 0; i < parts.length; i++) {
        if(is.not.undefined(headLayout.anchors[i])){
            var shape = drawPolygon(parts[i].size,parts[i].color,partShapes[parts[i].shape % partShapes.length],1,parts[i].shiny);
            shape.rotation=parts[i].rotation;
            shape.name='part#'+i;
            var shapeBounds = shape.getBounds();
            shape.x=(headLayout.anchors[i].x*10)-shapeBounds.width;
            shape.y=headLayout.anchors[i].y*10;
            if(head.hitTest(shape.x,shape.y)){ //(shape.x+(shapeBounds.width/2),shape.y+(shapeBounds.height/2))){
                //console.log(parts[i].z);
                // if(behindTheHeadCount<3){
                    if(parts[i].z == 0){
                        behindTheHeadCount++;
                        head.addChildAt(shape,1);
                        if(headLayout.symmetry.mirrorX){
                            head.addChildAt(flipX(shape),1);
                        }
                        if(headLayout.symmetry.mirrorY){
                            head.addChildAt(flipY(shape),1);
                        }
                    }else{                        
                        partsContainer.addChild(shape);
                        if(headLayout.symmetry.mirrorX){
                            var flippedShape = flipX(shape);
                            flippedShape.name = shape.name+'_Flipped';
                            partsContainer.addChild(flippedShape);
                        }
                        if(headLayout.symmetry.mirrorY){
                            var flippedShape = flipY(shape);
                            flippedShape.name = shape.name+'_Flipped';
                            partsContainer.addChild(flippedShape);
                        }
                    }
                // }
            }
        }
    }
    head.addChild(partsContainer);
}        	
function drawPolygon(size,fillColor,points,modifier,hilight){
    //console.log(fillColor);
    var polygon = new createjs.Shape();
    polygon.graphics //.beginFill(fillColor)
    .beginRadialGradientFill([hilight?'white':fillColor,fillColor],[0.1,0.9],0,-((size*10)*.75),0,0,-((size*10)*.75),(size*10)) //beginFill(fillColor)
        .setStrokeStyle(2).beginStroke('black');
    var xs = 500;
    var xb = 0;
    var ys = 500;
    var yb = 0;
// ## New Poly
    var previousCx = 0;
	var previousCy = 0;
	var previousX = 0;
	var previousY = 0;
	// End

    for (var i = 0; i < points.length; i++) {
        // ## New Poly
        /*
		var x = points[i].x;
        var y = points[i].y;
        var cx1 = x;
        var cy1 = y;
        var cx2 = x;
        var cy2 = y;
        if(i==0){
			if(symmetry=='Vertical' || symmetry=='') x = rdfi(x-(modifier/size),x);
            if(symmetry=='Horizontal' || symmetry=='') y = rdfi(y-(modifier/size),y);
        }else if(i==points.length-1){
            if(symmetry=='Vertical' || symmetry=='') x = rdfi(x,x+(modifier/size));
            if(symmetry=='Horizontal' || symmetry=='') y = rdfi(y,y+(modifier/size));
        }else{
        	x = rdfi(x-(modifier/size),x);
        	y = rdfi(y-(modifier/size),y);
        }
        cx1+=1;
        cy1+=1;
        cx2+=1;
        cy2+=1;
        if(previousCx==0) previousCx = x;
        if(previousCy==0) previousCy = y;
        if(previousX==0) previousX = x;
        if(previousY==0) previousY = y;
    	var dx = 0;
		var dy = 0;        
        if(i>0){
        	dx = (previousX - previousCx);
        	dy = (previousY - previousCy);
        }
        if(i>1){
            cx1 = ( previousX+dx );
            cy1 = ( previousY+dy );
        	cx2 = x+-0.5;
        	cy2 = y+-0.5;
        }
        if(i==1){
        	cx1 = previousX+-0.5;
            cy1 = previousY+-0.5;
        	cx2 = x+-0.5;
        	cy2 = y+-0.5;
        }
        previousCx = cx2;
        previousCy = cy2;

        xb=x>xb?x:xb;
        xs=x<xs?x:xs;
        yb=y>yb?y:yb;
        ys=y<ys?y:ys;

        x=x*size;
        y=y*size;
        cx1=cx1*size;
        cy1=cy1*size;
        cx2=cx2*size;
        cy2=cy2*size;

        if(points[i].f=='moveTo') polygon.graphics.mt(x,y);
        if(points[i].f=='lineTo') polygon.graphics.lt(x,y);
        if(points[i].f=='curveTo') polygon.graphics.qt(cx1,cy1,x,y);
        if(points[i].f=='bezierTo') polygon.graphics.bt(cx1,cy1,cx2,cy2,x,y);

        previousX = points[i].x;
        previousY = points[i].y;
		*/
        // ## End New Poly


        /**/
        var x = points[i].x*size;
        var y = points[i].y*size;
        var cx1 = (points[i].x+points[i].cx1)*size;
        var cy1 = (points[i].y+points[i].cy1)*size;
        var cx2 = (points[i].x+points[i].cx2)*size;
        var cy2 = (points[i].y+points[i].cy2)*size;
        if(i>0 && i<points.length-1){
            x = rifi(x,x+modifier);
            y = rifi(y,y+modifier);
            // cx1 = (points[i].x+points[i].cx1)*size;
            // cy1 = (points[i].y+points[i].cy1)*size;
            // cx2 = (points[i].x+points[i].cx2)*size;
            // cy2 = (points[i].y+points[i].cy2)*size;
        }
        xb=x>xb?x:xb;
        xs=x<xs?x:xs;
        yb=y>yb?y:yb;
        ys=y<ys?y:ys;
        if(points[i].f=='moveTo') polygon.graphics.mt(x,y);
        if(points[i].f=='lineTo') polygon.graphics.lt(x,y);
        if(points[i].f=='curveTo') polygon.graphics.qt(cx1,cy1,x,y);
        if(points[i].f=='bezierTo') polygon.graphics.bt(cx1,cy1,cx2,cy2,x,y);
        /**/
    }
    polygon.setBounds(xs,ys,(xb-xs),(yb-ys));
    return polygon;
}
function flipX(part){
    var newPart = part.clone(true);
    newPart.rotation = part.rotation * -1;
    newPart.scaleX = -1;
    newPart.x = (part.x*-1)+200;
    return newPart;
}
function flipY(part){
    var newPart = part.clone(true);
    newPart.rotation = part.rotation * -1;
    newPart.scaleY = -1;
    newPart.y = part.y * -1;
    return newPart;
}
function getColor(c){
    return 'hsl('+rifi(c.h,c.h+c.alt)+','+c.s+'%,'+c.l+'%)';
}