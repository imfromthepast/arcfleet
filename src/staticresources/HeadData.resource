 
function randomIntFromInterval(min,max){
    return Math.floor(Math.random()*(max-min+1)+min);
} 
function rifi(min,max){
    return randomIntFromInterval(min,max);
}           
function randomArrayElem(arr){              
    return arr[randomIntFromInterval(0,arr.length-1)];
} 
function rae(arr){
    return randomArrayElem(arr);
} 
var skinColors = ['yellow','pink','green'];
//var eyeColor = ['red','white','black'];
var eyeTypes = [{size:25,color:'red'},{size:8,color:'white'},{size:2,color:'red'}];
var hornTypes = [{size:1.5,color:'grey',rotation:-45},{size:3,color:'grey',rotation:80},{size:3,color:'grey',rotation:-45},{size:2,color:'grey',rotation:25}];
var hornShapes = [
    [{cx:0,cy:0,x:0,y:0},{cx:-10,cy:10,x:10,y:-20},{cx:-5,cy:-5,x:10,y:0},{cx:0,cy:0,x:0,y:0}],
    [
        // {cx:0,cy:0,x:5,y:0},
        {cx:0,cy:0,x:2,y:0},
        {cx:3,cy:-3,x:3,y:10},
        {cx:-3,cy:-3,x:0,y:15},
        {cx:-5,cy:1,x:5,y:20},
        {cx:1,cy:2,x:10,y:15},
        {cx:3,cy:0,x:7,y:10},
        {cx:-2,cy:-2,x:8,y:0}
    ]
];
var mouthShapes = [[{cx:0,cy:-10,x:10,y:-20},{cx:5,cy:-5,x:10,y:0}]];
var colorSchemes = [
    {
        skin:[
            {h:360,s:100,l:85,alt:30},
            {h:260,s:100,l:65,alt:20}
        ],horn:['grey','green'],eye:['red','orange','yellow']
    },
    {
        skin:[
            {h:80,s:100,l:50,alt:80},
            {h:20,s:100,l:40,alt:80}
        ],horn:['grey','orange'],eye:['red','pink','blue']
    },
    {
        skin:[
            {h:rifi(0,360),s:rifi(0,100),l:rifi(30,100),alt:rifi(20,80)},
            {h:rifi(0,360),s:rifi(0,100),l:rifi(30,100),alt:rifi(20,80)}
        ],horn:['grey','orange'],eye:['red','pink','blue']
    }
];

var headLayouts = [
	{
		symmetry:{mirrorX:true,mirrorY:false,radial:false},
		eyes:[{x:60, y:0},{x:15, y:60},{x:5, y:-20}],
		nostrils:[{x:5, y:10}],
		mouths:[{x:-35, y:95}],
		horns:[{x:-35,y:-40},{x:-20,y:-50}],
        shape:[
            {x:0,y:-100,f:'moveTo'},
            {x:-80,y:-20,cx1:50,cy1:-80,cx2:20,cy2:20,f:'bezierTo'},
            {x:-40,y:10,cx1:-10,cy1:80,cx2:0,cy2:0,f:'bezierTo'},
            {x:-60,y:100,cx1:10,cy1:0,cx2:0,cy2:0,f:'bezierTo'},
            {x:0,y:120,cx1:-10,cy1:0,cx2:-10,cy2:-0,f:'bezierTo'}
        ]
	},
	{
		symmetry:{mirrorX:true,mirrorY:false,radial:false},
		eyes:[{x:15, y:10}],
		nostrils:[{x:5, y:10}],
		mouths:[{x:50, y:-30}],
		horns:[{x:null,y:null}],
        shape:[
            {x:0,y:-50,f:'moveTo'},
            {x:-80,y:-80,cx1:50,cy1:-80,cx2:20,cy2:20,f:'bezierTo'},
            {x:-50,y:0,cx1:-10,cy1:80,cx2:0,cy2:0,f:'bezierTo'},
            {x:-60,y:80,cx1:10,cy1:0,cx2:0,cy2:0,f:'bezierTo'},
            {x:0,y:50,cx1:10,cy1:0,cx2:0,cy2:0,f:'bezierTo'}
        ]
	},
    {
        symmetry:{mirrorX:true,mirrorY:false,radial:false},
        eyes:[{x:rifi(0,50), y:rifi(0,50)},{x:rifi(30,50), y:rifi(30,50)},{x:rifi(40,55), y:rifi(-30,30)}],
        nostrils:[{x:5, y:10}],
        mouths:[{x:rifi(0,0), y:rifi(0,0)}],
        horns:[{x:rifi(10,30), y:rifi(-10,10)},{x:rifi(20,40), y:rifi(-40,-10)}],
        shape:[
            {x:0, y:rifi(-100,-40),f:'moveTo'},
            {x:rifi(-100,-30), y:rifi(-90,-30),cx1:rifi(0,10),cy1:rifi(0,10),cx2:rifi(0,10),cy2:rifi(0,10),f:'bezierTo'},
            {x:rifi(-100,-40), y:rifi(-90,-20),cx1:rifi(0,10),cy1:rifi(0,10),cx2:rifi(0,10),cy2:rifi(0,10),f:'bezierTo'},
            {x:rifi(-100,-40), y:rifi(20,90),cx1:rifi(0,10),cy1:rifi(0,10),cx2:rifi(0,10),cy2:rifi(0,10),f:'bezierTo'},
            {x:0, y:rifi(30,90),cx1:rifi(0,10),cy1:rifi(0,10),cx2:rifi(0,10),cy2:rifi(0,10),f:'bezierTo'}
        ]
    }
]
var eyeCount = [0,1,2,3,4,5,6];
