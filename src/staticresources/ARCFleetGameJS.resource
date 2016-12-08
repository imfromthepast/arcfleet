Object.size = function(obj){
    var size = 0, key;
    for (key in obj) {
        if (obj.hasOwnProperty(key)) size++;
    }
    return size;
};
function randomIntFromInterval(min,max){
    return Math.floor(Math.random()*(max-min+1)+min);
}    
function randomArrayElem(arr){              
    return arr[randomIntFromInterval(0,arr.length-1)];
} 
function rifi(min,max){
    return randomIntFromInterval(min,max);
}  
function rae(arr){
    return randomArrayElem(arr);
} 
function rdfi(min,max){
    return Math.random()*(max-min+1)+min;
}
function arrayObjectIndexOf(myArray, searchTerm, property){
    for(var i = 0, len = myArray.length; i < len; i++) {
        if (myArray[i][property] === searchTerm) return i;
    }
    return -1;
}
function capitaliseFirstLetter(string){
    return string.charAt(0).toUpperCase() + string.slice(1);
}
createjs.Graphics.prototype.dashedLineTo = function( x1 , y1 , x2 , y2 , dashLen ){
    this.moveTo( x1 , y1 );

    var dX = x2 - x1;
    var dY = y2 - y1;
    var dashes = Math.floor(Math.sqrt( dX * dX + dY * dY ) / dashLen );
    var dashX = dX / dashes;
    var dashY = dY / dashes;

    var q = 0;
    while( q++ < dashes ){
        x1 += dashX;
        y1 += dashY;
        this[q % 2 == 0 ? 'moveTo' : 'lineTo'](x1, y1);
    }
    this[q % 2 == 0 ? 'moveTo' : 'lineTo'](x2, y2);
    return this;
}
/*
    /$$$$$$                                /$$                       /$$$$$  /$$$$$$ 
   /$$__  $$                              | $$                      |__  $$ /$$__  $$
  | $$  \ $$ /$$$$$$$   /$$$$$$  /$$   /$$| $$  /$$$$$$   /$$$$$$      | $$| $$  \__/
  | $$$$$$$$| $$__  $$ /$$__  $$| $$  | $$| $$ |____  $$ /$$__  $$     | $$|  $$$$$$ 
  | $$__  $$| $$  \ $$| $$  \ $$| $$  | $$| $$  /$$$$$$$| $$  \__//$$  | $$ \____  $$
  | $$  | $$| $$  | $$| $$  | $$| $$  | $$| $$ /$$__  $$| $$     | $$  | $$ /$$  \ $$
  | $$  | $$| $$  | $$|  $$$$$$$|  $$$$$$/| $$|  $$$$$$$| $$     |  $$$$$$/|  $$$$$$/
  |__/  |__/|__/  |__/ \____  $$ \______/ |__/ \_______/|__/      \______/  \______/ 
                       /$$  \ $$                                                     
                      |  $$$$$$/                                                     
                       \______/                                                      
*/
var arcfleetApp = angular.module('arcfleetApp', ['ui.bootstrap','ui.unique','ngRemoteObjects']);
var arfleetCon = arcfleetApp.controller('arcfleetCon',['$scope','$filter','$interval','GameService','$sce', function ($scope, $filter, $interval,GameService,$sce) {
    var ARCFleetSFX = new Howl({urls:[sfxUrl],sprite: {A1:[0,52],A2:[500,410],A3:[7500,1400],B1:[9000,1400],B2:[10500,4200],B3:[15000,680],X1:[1000,70],X2:[1500,70],X3:[2000,70],X4:[2500,70],X5:[3000,70],E1:[16000,2850],C1:[7000,70],S1:[3500,230],S2:[4000,500],S3:[5000,580],S4:[6000,288],S5:[6500,126],T1:[19000,80]},volume: 0.5});
    $scope.ARCFleetSFX          	= function(n){ARCFleetSFX.play(n);}
    $scope.sectors              	= [];
    $scope.constructs           	= [];
    $scope.discoveries				= [];
    $scope.terrainFilterShown   	= true;
    $scope.arcFilterShown       	= false;
    $scope.resourceFilterShown  	= true;
    $scope.beaconFilterShown    	= false;
    $scope.showInspectorPanel   	= false;
    $scope.resourcePoints       	= 0;
    $scope.constructionCosts 		= 0;
    $scope.SFXon                	= SFXon == 'true';
    $scope.turn						= turn;
    $scope.alienChatText            = '';
    $scope.talkedToAliens           = false;
    $scope.setVolume = function(){            
        if($scope.SFXon){
            Howler.unmute();
        }else{
            Howler.mute();
        }   
        if($scope.SFXon != SFXon){                    
            var game = new RemoteObjectModel.Game();
            var gameIds = [];
            gameIds.push(gameId);
            game.update(
                gameIds,
                {SfxOn: $scope.SFXon},
                function(err,ids){
                    if(err){
                    	notification('Mute Error',+err,'red');
                    }else{
                    	if($scope.SFXon){
                    		$scope.ARCFleetSFX('A1');
                    		//notification('Volume On','','yellow');
                    	}else{
                    		//notification('Volume Off','','yellow');
                    	}
                    }
                }
            );    
        }       
    }
    $scope.setVolume();
    $scope.setMood = function(m){		                
        $scope.foreignPolicy=m;  
        $scope.foreignPolicyColor($scope.foreignPolicy);
        var game = new RemoteObjectModel.Game();
        var gameIds = [];
        gameIds.push(gameId);
        game.update(
            gameIds,
            {foreignPolicy: $scope.foreignPolicy},
            function(err,ids){
                if(err){
                    notification('Foreign Policy Error',err,'red');
                }else{ 
                    notification('Foreign Policy Change','Your civilization\'s default foreign policy has changed to '+$scope.foreignPolicyLabel+'.','green');
                }
            }
        );           
    }
    $scope.foreignPolicyLabelFriendly = 'Appeasing';
    $scope.foreignPolicyLabelNeutral = 'Isolationist';
    $scope.foreignPolicyLabelHostile = 'Aggressive';
    $scope.friendlyContactDescription = 'Attempt First Contact';
    $scope.neutralContactDescription = 'Accertain Intentions';
    $scope.hostileContactDescription = 'Declare War!';
    $scope.foreignPolicyColor = function(m){
        if(m===1){
            $scope.foreignPolicyLabelClass = 'text-primary';
            $scope.foreignPolicyLabel = $scope.foreignPolicyLabelFriendly;
            $scope.contactButtonText = $scope.friendlyContactDescription;
            $scope.contactButtonClass = 'btn-primary';
        }
        if(m===2){
            $scope.foreignPolicyLabelClass = 'text-warning';
            $scope.foreignPolicyLabel = $scope.foreignPolicyLabelNeutral;
            $scope.contactButtonText = $scope.neutralContactDescription;
            $scope.contactButtonClass = 'btn-warning';
        }
        if(m===3){
            $scope.foreignPolicyLabelClass = 'text-danger';
            $scope.foreignPolicyLabel = $scope.foreignPolicyLabelHostile;
            $scope.contactButtonText = $scope.hostileContactDescription;
            $scope.contactButtonClass = 'btn-danger';
        }
    }
    $scope.relationshipList = [];
    $scope.relationshipMap = new Object();
    $scope.fuzzy = false;
    var raceId = gameId.substr(0,15);
    
    $scope.showARCScanner = false;
    $scope.showBlackHoleScanner = false;
    $scope.showDarkMatterScanner = false;
    $scope.foreignPolicy = mood;
    $scope.foreignPolicyColor($scope.foreignPolicy);
    $scope.sectorSize = 35;
    $scope.mapCols = 100;
    $scope.mapRows = 100;
    $scope.viewWidth = $j(window).width() - 100;
    $scope.viewHeight = $j(window).height() - 90;
    $scope.viewWidthInSectors = Math.ceil($scope.viewWidth / $scope.sectorSize);
    $scope.viewHeightInSectors = Math.ceil($scope.viewHeight / $scope.sectorSize);
    $scope.fromX = 1;
    $scope.fromY = 1;	
    $scope.sector_scale = 1;
    $scope.regularCost = 5;
    $scope.explorerCost = 7;
    $scope.destroyerCost = 9;
    
    $scope.arcCalcButtonEnabled = false;
    $scope.regular_fleetsSelected = 0;
    $scope.regular_actionButtonEnabled = false;
    $scope.explorer_fleetsSelected = 0;
    $scope.explorer_actionButtonEnabled = false;
    $scope.destroyer_fleetsSelected = 0;
    $scope.destroyer_actionButtonEnabled = false;
    $scope.attackButtonEnabled = false;
    $scope.fleet_arcCalc = 100;
    $scope.arc_distance = 0;
    $scope.dest_x = 0;
    $scope.dest_y = 0;
    $scope.curr_x = 0;
    $scope.curr_y = 0;
    $scope.r = 0;
    $scope.x1 = 0;
    $scope.y1 = 0;
    $scope.x2 = 0;
    $scope.y2 = 0;
    $scope.sectorsWithConstructsCount = 0;
    $scope.regularFleetCount = 0;
    $scope.explorerFleetCount = 0;
    $scope.destroyerFleetCount = 0;
    $scope.arcbaseCount = 0;
    $scope.potentialResourcePoints = 0;
// Build Game Map 
	generate();
	$scope.galaxyName = galaxyName;
	$scope.civilizationName = civName == ''?civilizationName:civName;
// Build Sector
    $scope.showMiniMapButton = true;
   	$scope.showMiniMap = function(){
   		$scope.showMiniMapButton = false;
   	}
   	$scope.hideMiniMap = function(){
   		$scope.showMiniMapButton = true;
   	}
    var relationshipsField = $j('[id$=relationships]');
   	var sectorJSON1Field = $j('[id$=sectorJSON1]');
   	var sectorJSON2Field = $j('[id$=sectorJSON2]');
   	var sectorJSON3Field = $j('[id$=sectorJSON3]');
   	var sectorJSON4Field = $j('[id$=sectorJSON4]');
   	var sectorJSON5Field = $j('[id$=sectorJSON5]');
   	var sectorJSON6Field = $j('[id$=sectorJSON6]');
   	var sectorJSON7Field = $j('[id$=sectorJSON7]');
   	var sectorJSON8Field = $j('[id$=sectorJSON8]');
   	var sectorJSON9Field = $j('[id$=sectorJSON9]');
   	var sectorJSON10Field = $j('[id$=sectorJSON10]');
	$scope.save = function(){
        console.log(JSON.stringify(relationships));
		var saveGame = new RemoteObjectModel.Game();    
        var gameIds = [];
        gameIds.push(gameId);                    
        saveGame.update(
            gameIds,
            {
            	SectorJSON1: sectorJSON1Field.val(),
            	SectorJSON2: sectorJSON2Field.val(),
            	SectorJSON3: sectorJSON3Field.val(),
            	SectorJSON4: sectorJSON4Field.val(),
            	SectorJSON5: sectorJSON5Field.val(),
            	SectorJSON6: sectorJSON6Field.val(),
            	SectorJSON7: sectorJSON7Field.val(),
            	SectorJSON8: sectorJSON8Field.val(),
            	SectorJSON9: sectorJSON9Field.val(),
            	SectorJSON10: sectorJSON10Field.val(),
                Relationships: JSON.stringify(relationships),
            	CivilizationName: $scope.civilizationName,
                CivilizationLevel: $scope.civLvl,
            	Turn: $scope.turn,
                StartX:$scope.setViewX,
                StartY:$scope.setViewY
            },
            function(err,ids){
                if(err){
                    notification('Save Error',err,'red');
                }
            }
        );
	}
    $scope.sectors=sectors;
	var TotalRegularCount = 0;
	var TotalExplorerCount = 0;
	var TotalDestroyerCount = 0;
	var editedSectors = {};
    populateGalaxy(sectorJSON);
	function populateGalaxy(sjson){
		editedSectors = {};
		if(is.undefined(sjson) || sjson==''){							
			sjson = homeSector.x+','+homeSector.y+',t,10,2,1,0,t,0,0,0,0,0;';
			for (var i = 0; i < alienSectors.length; i++) {
				var x = alienSectors[i].x;
				var y = alienSectors[i].y;
				sjson += spawnAlienCivilization(x,y);
			};
			$scope.save();
		}
		var pop = sjson.split(';');						
		for (var i = 0; i < pop.length; i++) {
			if(pop[i]!=''){
				var p = pop[i].split(',');								
				sectors[getIndex(p[populationName['x']],p[populationName['y']])].ActiveRegularCount = parseInt(p[populationName['r']]);
				sectors[getIndex(p[populationName['x']],p[populationName['y']])].ActiveExplorerCount = parseInt(p[populationName['e']]);
				sectors[getIndex(p[populationName['x']],p[populationName['y']])].ActiveDestroyerCount = parseInt(p[populationName['d']]);
				sectors[getIndex(p[populationName['x']],p[populationName['y']])].HasARCBase = p[populationName['a']] == 't';
				sectors[getIndex(p[populationName['x']],p[populationName['y']])].ARCBasePoints = parseInt(p[populationName['ap']]);
				sectors[getIndex(p[populationName['x']],p[populationName['y']])].Explored = p[populationName['ex']] == 't';
				sectors[getIndex(p[populationName['x']],p[populationName['y']])].AlienARCBase = parseInt(p[populationName['aa']]);
				sectors[getIndex(p[populationName['x']],p[populationName['y']])].AlienRegularCount = parseInt(p[populationName['ar']]);
				sectors[getIndex(p[populationName['x']],p[populationName['y']])].AlienExplorerCount = parseInt(p[populationName['ae']]);
				sectors[getIndex(p[populationName['x']],p[populationName['y']])].AlienDestroyerCount = parseInt(p[populationName['ad']]);
				sectors[getIndex(p[populationName['x']],p[populationName['y']])].AlienMood = parseInt(p[populationName['am']]);
				$scope.regularFleetCount+=parseInt(p[populationName['r']]);
				$scope.explorerFleetCount+=parseInt(p[populationName['e']]);
				$scope.destroyerFleetCount+=parseInt(p[populationName['d']]);
				$scope.resourcePoints+=parseInt(p[populationName['ap']]);
				if(p[populationName['a']] == 't'){
					$scope.arcbaseCount++;
					$scope.potentialResourcePoints += sectors[getIndex(p[populationName['x']],p[populationName['y']])].ResourceValue;
				}
				if(sectors[getIndex(p[0],p[1])].TotalRegularCount()+sectors[getIndex(p[0],p[1])].TotalExplorerCount()+sectors[getIndex(p[0],p[1])].TotalDestroyerCount() > 0) $scope.sectorsWithConstructsCount++;
				if(sectorShouldBeSaved(p)) editedSectors[p[0]+'x'+p[1]] = true;
			}
		};
		if($scope.turn == 0){
            $scope.setViewX = homeSector.x;
            $scope.setViewY = homeSector.y;
        }else{
            $scope.setViewX = is.empty(gameStartX)?50:gameStartX;
            $scope.setViewY = is.empty(gameStartY)?50:gameStartY;
        }
        console.log('Start Coords: '+$scope.setViewX+','+$scope.setViewY);
		$scope.save();
	}

    $scope.hasCivLvl2McGuffin = false;
    $scope.hasCivLvl3McGuffin = false;
    $scope.civLvl = 1;
    function checkCivLvl(){
        var civLvlThreshold = 10;
        var civilizationLevel = 0;                    
        if($scope.hasCivLvl3McGuffin || $scope.resourcePoints>(civLvlThreshold*2)){
            console.log('make civ 3')
            civilizationLevel = 3;
        }else if($scope.hasCivLvl2McGuffin || $scope.resourcePoints>civLvlThreshold){
            console.log('make civ 2')
            civilizationLevel = 2;
        }else{
            console.log('make civ 1')
            civilizationLevel = 1;
        }
        civilizationLevel = isDebug?3:civilizationLevel;
        $scope.civLvl = civilizationLevel;
    }
    checkCivLvl();
    $scope.hasARCScanner = $scope.civLvl > 1;
    $scope.hasBlackHoleScanner = $scope.civLvl > 1;
    $scope.hasDarkMatterScanner = $scope.civLvl > 1;

    $scope.regularCost = $scope.regularCost - $scope.civLvl < 1?1:$scope.regularCost - $scope.civLvl;
    $scope.explorerCost = $scope.explorerCost - $scope.civLvl < 1?1:$scope.explorerCost - $scope.civLvl;
    $scope.destroyerCost = $scope.destroyerCost - $scope.civLvl < 1?1:$scope.destroyerCost - $scope.civLvl;

    $scope.explorerViewRange = function(){return Math.floor(12*($scope.civLvl/2))};
    $scope.regularViewRange = function(){return Math.floor(8*($scope.civLvl/2))};
    $scope.destroyerViewRange = function(){return Math.floor(4*($scope.civLvl/2))};
    console.log('$scope.explorerViewRange: '+$scope.explorerViewRange())

	function sectorShouldBeSaved(s){
		var decision = false;
		if(!decision) decision = parseInt(s[populationName['r']]) > 0; 	//ActiveRegularCount
		if(!decision) decision = parseInt(s[populationName['e']]) > 0; 	//ActiveExplorerCount
		if(!decision) decision = parseInt(s[populationName['d']]) > 0; 	//ActiveDestroyerCount
		if(!decision) decision = s[populationName['a']] == 't'; 		//HasARCBase
		if(!decision) decision = s[populationName['ex']] == 't'; 		//Explored
		if(!decision) decision = parseInt(s[populationName['aa']]) > 0; //AlienARCBase
		if(!decision) decision = parseInt(s[populationName['ar']]) > 0; //AlienRegularCount
		if(!decision) decision = parseInt(s[populationName['ae']]) > 0; //AlienExplorerCount
		if(!decision) decision = parseInt(s[populationName['ad']]) > 0; //AlienDestroyerCount
		if(!decision) decision = parseInt(s[populationName['am']]) > 0; //AlienDestroyerCount
		return decision;
	}
	
/*
	 /$$$$$$$$                 /$$       /$$$$$$$$                           
	| $$_____/                | $$      |__  $$__/                           
	| $$       /$$$$$$$   /$$$$$$$         | $$ /$$   /$$  /$$$$$$  /$$$$$$$ 
	| $$$$$   | $$__  $$ /$$__  $$         | $$| $$  | $$ /$$__  $$| $$__  $$
	| $$__/   | $$  \ $$| $$  | $$         | $$| $$  | $$| $$  \__/| $$  \ $$
	| $$      | $$  | $$| $$  | $$         | $$| $$  | $$| $$      | $$  | $$
	| $$$$$$$$| $$  | $$|  $$$$$$$         | $$|  $$$$$$/| $$      | $$  | $$
	|________/|__/  |__/ \_______/         |__/ \______/ |__/      |__/  |__/
*/		            
	$scope.startOver = function(){
		console.log('start over');
		af__startOver();
	}
	$scope.sectorJSON1 ='';								
	$scope.endTurn = function(){
		var gwaveHit = false;
		var gameover = false;
		$scope.regularFleetCount = 0;
		$scope.explorerFleetCount = 0;
		$scope.destroyerFleetCount = 0;
		$scope.arcbaseCount = 0;
		$scope.resourcePoints = 0;
		$scope.constructionCosts = 0;
		$scope.potentialResourcePoints = 0;
		$scope.sectorsWithConstructsCount = 0;
        $scope.talkedToAliens = false;
        relationshipsField.val('');
		sectorJSON1Field.val('');
		sectorJSON2Field.val('');
		sectorJSON3Field.val('');
		sectorJSON4Field.val('');
		sectorJSON5Field.val('');
		sectorJSON6Field.val('');
		sectorJSON7Field.val('');
		sectorJSON8Field.val('');
		sectorJSON9Field.val('');
		sectorJSON10Field.val('');
		var keys = Object.keys(editedSectors);
		var i = 0;
		var canBuildRegulars = false;
		for (var i = 0; i <= keys.length; i++) {
			if(i<keys.length){
				if(editedSectors.hasOwnProperty(keys[i])){
					var x = keys[i].split('x')[0];
					var y = keys[i].split('x')[1];
					if($scope.sectors[getIndex(x,y)].GWaveSector()>0 && $scope.sectors[getIndex(x,y)].BlackHole == 0 && $scope.sectors[getIndex(x,y)].HasARCBase){
						gwaveHit = true;
						console.log('gWaveSector: '+x+'x'+y);
						if($scope.sectors[getIndex(x,y)].GWaveSector()==3){
							$scope.sectors[getIndex(x,y)].ARCBasePoints = Math.ceil($scope.sectors[getIndex(x,y)].ARCBasePoints*0.5);
						}
						if($scope.sectors[getIndex(x,y)].GWaveSector()==2){
							$scope.sectors[getIndex(x,y)].ARCBasePoints = Math.ceil($scope.sectors[getIndex(x,y)].ARCBasePoints*0.25);
						}
						if($scope.sectors[getIndex(x,y)].GWaveSector()==1){
							$scope.sectors[getIndex(x,y)].ARCBasePoints = Math.ceil($scope.sectors[getIndex(x,y)].ARCBasePoints*0.125);
						}
					}
					var hab = $scope.sectors[getIndex(x,y)].HasARCBase?'t':'f';
					var ex = $scope.sectors[getIndex(x,y)].Explored?'t':'f';
					var s = x+','+y+','+
						hab+','+
						$scope.sectors[getIndex(x,y)].ARCBasePoints+','+
						$scope.sectors[getIndex(x,y)].TotalRegularCount()+','+
						$scope.sectors[getIndex(x,y)].TotalExplorerCount()+','+
						$scope.sectors[getIndex(x,y)].TotalDestroyerCount()+','+
						ex+','+
						$scope.sectors[getIndex(x,y)].AlienARCBase+','+
						$scope.sectors[getIndex(x,y)].AlienRegularCount+','+
						$scope.sectors[getIndex(x,y)].AlienExplorerCount+','+
						$scope.sectors[getIndex(x,y)].AlienDestroyerCount+','+
						$scope.sectors[getIndex(x,y)].AlienMood+';';

					$scope.sectors[getIndex(x,y)].ActiveRegularCount = $scope.sectors[getIndex(x,y)].TotalRegularCount();
					$scope.sectors[getIndex(x,y)].ActiveExplorerCount = $scope.sectors[getIndex(x,y)].TotalExplorerCount();
					$scope.sectors[getIndex(x,y)].ActiveDestroyerCount = $scope.sectors[getIndex(x,y)].TotalDestroyerCount();
					$scope.sectors[getIndex(x,y)].InactiveRegularCount = 0;
					$scope.sectors[getIndex(x,y)].InactiveExplorerCount = 0;
					$scope.sectors[getIndex(x,y)].InactiveDestroyerCount = 0;
					$scope.sectors[getIndex(x,y)].ARCBaseIsActive = true;

					$scope.regularFleetCount+=$scope.sectors[getIndex(x,y)].TotalRegularCount();
					$scope.explorerFleetCount+=$scope.sectors[getIndex(x,y)].TotalExplorerCount();
					$scope.destroyerFleetCount+=$scope.sectors[getIndex(x,y)].TotalDestroyerCount();
					$scope.resourcePoints+=$scope.sectors[getIndex(x,y)].ARCBasePoints;
					if(!canBuildRegulars) canBuildRegulars = $scope.sectors[getIndex(x,y)].ARCBasePoints >= $scope.regularCost;
					if($scope.sectors[getIndex(x,y)].HasARCBase){
						$scope.potentialResourcePoints += $scope.sectors[getIndex(x,y)].ResourceValue;
						$scope.arcbaseCount++;
					}
					if($scope.sectors[getIndex(x,y)].TotalRegularCount()+$scope.sectors[getIndex(x,y)].TotalExplorerCount()+$scope.sectors[getIndex(x,y)].TotalDestroyerCount() > 0) $scope.sectorsWithConstructsCount++;
					if(sectorShouldBeSaved(s)){
						if(sectorJSON1Field.val() == ''){
							sectorJSON1Field.val(s);
						}else{
							sectorJSON1Field.val(sectorJSON1Field.val()+s);
						}
					}
				}
			}else{
				$scope.turn++;
				turn++;
                checkCivLvl();
				relationshipsField.val(relationships);
				$scope.save();
			}
		}
		gameover = !canBuildRegulars && $scope.regularFleetCount < 2;
		if(gwaveHit) notification('G-Wave Hit!','A gravity wave has hit your civilization and you have lost resource points!','red');
		if(gameover)$j('#gameOverModal').modal({backdrop:'static'}); 			
	}
	var civSettings = {
		lvl1:{
			explore:{
				'Interspiral':true,
				'Fringe':true,
				'Axis':true,
				'Nucleus':false,
				'Core':false,
				'BlackHoles':true,
				'CentralBlackHole':false
			},
			build:{
				'Interspiral':true,
				'Fringe':true,
				'Axis':true,
				'Nucleus':false,
				'Core':false,
				'BlackHoles':true,
				'CentralBlackHole':false
			},
			arc:{
				'Interspiral':true,
				'Fringe':true,
				'Axis':true,
				'Nucleus':false,
				'Core':false,
				'BlackHoles':true,
				'CentralBlackHole':false
			},
			canExplore:function(t){
				return this.explore[t];
			},
			canBuild:function(t){
				return this.build[t];
			},
			canARC:function(t){
				return this.arc[t];
			},
			canBlackHoleTravel: function(){return false;}
		},
		lvl2:{
			explore:{
				'Interspiral':true,
				'Fringe':true,
				'Axis':true,
				'Nucleus':true,
				'Core':true,
				'BlackHoles':true,
				'CentralBlackHole':false
			},
			build:{
				'Interspiral':true,
				'Fringe':true,
				'Axis':true,
				'Nucleus':true,
				'Core':true,
				'BlackHoles':true,
				'CentralBlackHole':false
			},
			arc:{
				'Interspiral':true,
				'Fringe':true,
				'Axis':true,
				'Nucleus':true,
				'Core':true,
				'BlackHoles':true,
				'CentralBlackHole':false
			},
			canExplore:function(t){
				return this.explore[t];
			},
			canBuild:function(t){
				return this.build[t];
			},
			canARC:function(t){
				return this.arc[t];
			},
			canBlackHoleTravel: function(){return true;}
		},
		lvl3:{
			explore:{
				'Interspiral':true,
				'Fringe':true,
				'Axis':true,
				'Nucleus':true,
				'Core':true,
				'BlackHoles':true,
				'CentralBlackHole':true
			},
			build:{
				'Interspiral':true,
				'Fringe':true,
				'Axis':true,
				'Nucleus':true,
				'Core':true,
				'BlackHoles':true,
				'CentralBlackHole':true
			},
			arc:{
				'Interspiral'		:true,
				'Fringe'			:true,
				'Axis'				:true,
				'Nucleus'			:true,
				'Core'				:true,
				'BlackHoles'		:true,
				'CentralBlackHole'	:true
			},
			canExplore:function(t){
				return this.explore[t];
			},
			canBuild:function(t){
				return this.build[t];
			},
			canARC:function(t){
				return this.arc[t];
			},
			canBlackHoleTravel: function(){return true;}
		}
	}
	var civlvl = civSettings['lvl'+$scope.civLvl];
	$scope.gwaveFilterShown = true;
	$scope.gWaveSectors = [];
	$scope.gWaveSector = function(x,y){
		var d = distance({x:50,y:50},{x:x,y:y});
		var t = turn%50;		
		var gw = (d >= t-1) && (d <= t+1);
		if(gw && $scope.sectors[getIndex(x,y)].BlackHole == 0){
			$scope.sectors[getIndex(x,y)].ARCBasePoints = 0;
		}
		return gw;
	}
	function showRange(x, y, r){
		$scope.VisibleInARCSpace = new Object;
	    for(var j=x-r; j<=x+r; j++){   
	    	for(var k=y-r; k<=y+r; k++){   
	        	if(distance({x:j,y:k},{x:x,y:y}) <= r){
	        		if(!darkMatterInPath({x: x,y: y}, {x: j,y: k})){
	        			$scope.VisibleInARCSpace[j+'x'+k] = true;
	        		}
	        		if(is.not.undefined($scope.sectors[getIndex(j,k)])){
                        if($scope.sectors[getIndex(j,k)].DarkMatter){
            				$scope.VisibleInARCSpace[j+'x'+k] = true;
            			}
                    }
	        	}
	        }
	    }
	}
	$scope.maintenanceCost = function(){
    	var mc = $scope.regularFleetCount + $scope.explorerFleetCount  + $scope.destroyerFleetCount;
    	mc = mc - ($scope.sectorsWithConstructsCount * $scope.civLvl);
    	return mc;
    }
    $scope.availableResourcePoints = function(){
    	return $scope.resourcePoints-($scope.maintenanceCost()+$scope.constructionCosts);
    }
    $scope.spendResources = function(amt){
    	$scope.constructionCosts+=amt;
    }
    if($scope.availableResourcePoints() < 0){
    	var debt = Math.abs($scope.availableResourcePoints());
    	for (var i = 0; i < debt; i++) {
    		// Delete fleets
    	};
    }
/*
     /$$      /$$                 /$$                 /$$$$$$$$                              /$$     /$$                              
    | $$$    /$$$                | $$                | $$_____/                             | $$    |__/                              
    | $$$$  /$$$$  /$$$$$$   /$$$$$$$  /$$$$$$       | $$    /$$   /$$ /$$$$$$$   /$$$$$$$ /$$$$$$   /$$  /$$$$$$  /$$$$$$$   /$$$$$$$
    | $$ $$/$$ $$ /$$__  $$ /$$__  $$ /$$__  $$      | $$$$$| $$  | $$| $$__  $$ /$$_____/|_  $$_/  | $$ /$$__  $$| $$__  $$ /$$_____/
    | $$  $$$| $$| $$  \ $$| $$  | $$| $$$$$$$$      | $$__/| $$  | $$| $$  \ $$| $$        | $$    | $$| $$  \ $$| $$  \ $$|  $$$$$$ 
    | $$\  $ | $$| $$  | $$| $$  | $$| $$_____/      | $$   | $$  | $$| $$  | $$| $$        | $$ /$$| $$| $$  | $$| $$  | $$ \____  $$
    | $$ \/  | $$|  $$$$$$/|  $$$$$$$|  $$$$$$$      | $$   |  $$$$$$/| $$  | $$|  $$$$$$$  |  $$$$/| $$|  $$$$$$/| $$  | $$ /$$$$$$$/
    |__/     |__/ \______/  \_______/ \_______/      |__/    \______/ |__/  |__/ \_______/   \___/  |__/ \______/ |__/  |__/|_______/ 
*/
// Change Mode
    $scope.changeMode = function(mode){                
// Default Scanner Mode
        $scope.mode = mode;
        $scope.showSectorInfo = true;
        $scope.showSectorContents = false;
        $scope.showResourcePoints = false;
        $scope.arcFilterShown = false;
        $scope.attackButtonEnabled = true;
        $scope.arcCalcButtonEnabled = true;
        $scope.hideArc();
        $scope.resizeConsoleLog();
        if(mode == 'ARC'){
// ARC Mode
            $scope.showSectorContents = true;
            $scope.showArcCalcContents = true;
            $scope.resizeConsoleLog();
        }else if(mode == 'ARC Calc'){
// ARC Calc Mode
            $scope.arcCalcButtonEnabled = false;
            $scope.showSectorContents = true;
            $scope.arcFilterShown = true;
        	$scope.attackButtonEnabled = false;
            $scope.resizeConsoleLog();
        }else if(mode == 'Explore'){
// Explore Mode
            $scope.showSectorContents = true;
            $scope.showResourcePoints = true;
            $scope.resizeConsoleLog();
        }else if(mode == 'Combat'){
// Combat Mode
            $scope.showSectorContents = true;
            $scope.resizeConsoleLog();
        }else if(mode == 'Construction'){
// Construction Mode
            $scope.showSectorContents = true;
            $scope.resizeConsoleLog();
        }
    }
    $scope.scannerMode = function(){
        $scope.changeMode('Scanner');
    }
    $scope.arcMode = function(){
        $scope.changeMode('ARC');
    }
    $scope.arcCalcMode = function(){
        $scope.changeMode('ARC Calc');
        var arcViewRange = 0;
        if($scope.explorer_fleetsSelected>0){
        	arcViewRange = $scope.explorerViewRange();
        }else if($scope.regular_fleetsSelected>0){
        	arcViewRange = $scope.regularViewRange();
        }else{
        	arcViewRange = $scope.destroyerViewRange();
        }               
        showRange($scope.selectedSector.X,$scope.selectedSector.Y,arcViewRange);
    }
    $scope.exploreMode = function(){
        $scope.changeMode('Explore');
    }
    $scope.combatMode = function(){
        $scope.changeMode('Combat');
    }
    $scope.constructionMode = function(){
        $scope.changeMode('Construction');
    }
    $scope.showArc = function(){
        $scope.showArcCalcContents = true;
        $scope.showArcLine = true;
        $scope.showArcCircle = true;
    }
    $scope.hideArc = function(){
        $scope.showArcCalcContents = false;
        $scope.showArcLine = false;
        $scope.showArcCircle = false;
    }
/*
     /$$$$$$$$                     /$$                              
    | $$_____/                    | $$                              
    | $$       /$$   /$$  /$$$$$$ | $$  /$$$$$$   /$$$$$$   /$$$$$$ 
    | $$$$$   |  $$ /$$/ /$$__  $$| $$ /$$__  $$ /$$__  $$ /$$__  $$
    | $$__/    \  $$$$/ | $$  \ $$| $$| $$  \ $$| $$  \__/| $$$$$$$$
    | $$        >$$  $$ | $$  | $$| $$| $$  | $$| $$      | $$_____/
    | $$$$$$$$ /$$/\  $$| $$$$$$$/| $$|  $$$$$$/| $$      |  $$$$$$$
    |________/|__/  \__/| $$____/ |__/ \______/ |__/       \_______/
                        | $$                                        
                        | $$                                        
                        |__/                                        
*/
    $scope.discovery = [
    	{
    		'Name':'0',
    		'Title':'Central Black Hole',
    		'Description':'Your explorer fleets have made crucial discoveries about the nature of the fabric of spacetime after studying the violent effects of gravity at the central black hole. The scientific knowledge gained from this exposure is valuable beyond calculation.'
    	},
    	{
    		'Name':'1',
    		'Title':'G-Waves Mystery Solved',
    		'Description':'Having established an ARC Base at the central black hole your civilization has unraveled the mysteries behind the dangerous G-Waves eminating from the galactic core.'
    	}
    ];
    $scope.exploreSector = function(){
// Determine explored Resource Value
        var exploredRP = randomIntFromInterval(0,7) + $scope.selectedSector.BaseRPot;
// Create new Explorer Log Entry
        var xpLog;
        var explored = $scope.selectedSector.Explored;
        var explorable = false;	                        
        if($scope.selectedSector.Terrain == 'Axis' || $scope.selectedSector.Terrain == 'Fringe' || $scope.selectedSector.Terrain == 'Interspiral' || ($scope.selectedSector.Terrain == 'Interspiral' && $scope.selectedSector.BlackHole > 0) || $scope.selectedSector.BlackHole > 0) explorable = true;
        if(explorable){
            if(!explored){  		                                         
                if($scope.selectedSector.GWaveSector()){
                	notification('Gravity Wave Interference','Exploration failed due to gravity wave interference.','red');
                }else{
	            	spendActionPoints(0,$scope.explorer_fleetsSelected,0,0);
	                var exploreRoll = isDebug?0:randomIntFromInterval(1,6);
                    if(exploreRoll <= $scope.explorer_fleetsSelected){
	                    $scope.ARCFleetSFX('E1');
	                    if($scope.selectedSector.BlackHole == 10){
	                    	notification($scope.discovery[0].Title,$scope.discovery[0].Description,'green');
	                    }else{
		                    if($scope.selectedSector.HasContacts()){
		                    	notification('Discovered Aliens!','Sector '+$scope.selectedSector.X+'x'+$scope.selectedSector.Y+' contains aliens.','yellow');
		                    }else{
		                		notification('Exploration','Sector '+$scope.selectedSector.X+'x'+$scope.selectedSector.Y+' has been explored. The fleet was able to discover '+$scope.selectedSector.ResourceValue+' potential resource points.','green');      
		                    }
		                    af__markExplored();
		                    var discoveryRoll = randomIntFromInterval(0,100);
		                    $scope.selectedSector.Explored = true;  
		                }
	                    $scope.save();		                   
	                }else{
	                    notification('Exploration Failed','Your '+$scope.explorer_fleetsSelected+' explorer fleet(s) proved unequal to the task of exploring this region. Maybe if you had more explorers...','red');
	                }
	            }
            }else{
                notification('Sector Already Explored','Sector '+$scope.selectedSector.X+'x'+$scope.selectedSector.Y+' has already been thouroughly explored. There is no need to explore it again, there is nothing new to discover.','yellow');     
            }
        }else{
            if($scope.selectedSector.Terrain == 'Empty'){
                notification('Nothing to Explore','Sector '+$scope.selectedSector.X+'x'+$scope.selectedSector.Y+' is in intergalactic space. There is nothing to discover here.','yellow');
            }else{
                notification('Galactic '+$scope.selectedSector.Terrain+' Unexplorable','Sector '+$scope.selectedSector.X+'x'+$scope.selectedSector.Y+' is in the Galactic '+$scope.selectedSector.Terrain+', it cannot be explored unless it contains a black hole.','yellow');     
            }
        }		                
    }
    function spendActionPoints(r,e,d,a){
    	if(r>0){
    		$scope.selectedSector.ActiveRegularCount -= r;
        	$scope.selectedSector.InactiveRegularCount += r;
    	}
    	if(e>0){
    		$scope.selectedSector.ActiveExplorerCount -= e;
        	$scope.selectedSector.InactiveExplorerCount += e;
    	}
    	if(d>0){
    		$scope.selectedSector.ActiveDestroyerCount -= d;
        	$scope.selectedSector.InactiveDestroyerCount += d;
    	}
    	if(a>0){
    		$scope.selectedSector.ARCBaseIsActive = false;
    	}
    }
/*
      /$$$$$$  /$$$$$$$   /$$$$$$ 
     /$$__  $$| $$__  $$ /$$__  $$
    | $$  \ $$| $$  \ $$| $$  \__/
    | $$$$$$$$| $$$$$$$/| $$      
    | $$__  $$| $$__  $$| $$      
    | $$  | $$| $$  \ $$| $$    $$
    | $$  | $$| $$  | $$|  $$$$$$/
    |__/  |__/|__/  |__/ \______/ 
*/
    $scope.arc = function(r){
// ARC Mode
        $scope.arcMode();
// Initiating initial variables                
        var arcRoll = 0;
// Scatter variables
        var intendedDestinationX = $scope.destinationSector.X;
        var intendedDestinationY = $scope.destinationSector.Y;
        var scatterDistance = $scope.arc_distance;
        var scatterDirection = 0;
        var scatterDissolution = 0;
        var scatterCoord = '';
        var scatterX;
        var scatterY;
// If no roll value has been passed, roll the dice
        if(r == null) arcRoll = randomIntFromInterval(1,100) + (50-($scope.civLvl*10));
        if(arcRoll >= 100) arcRoll = 99;
        if(arcRoll < $scope.fleet_arcCalc){
// Successful ARC
            $scope.ARCFleetSFX('A2');
// Notification
            notification('ARC Succeeded!','Your fleets have safely reached their destination','green');
            moveFleets($scope.regular_fleetsSelected,$scope.explorer_fleetsSelected,$scope.destroyer_fleetsSelected);
        }else{
// Scattered ARC		                    
            $scope.ARCFleetSFX('S'+randomIntFromInterval(1,5));		                    
// TODO: tweak with civLvl
// determine scatter distance
            scatterDistance = Math.ceil($scope.arc_distance*(arcRoll/100));
            scatterDissolution = scatterDistance/10;		                    
// Choose a random scatter direction
            scatterDirection = randomIntFromInterval(1,4);
            if(scatterDirection == 1){
// Scatter North
                scatterX = intendedDestinationX;
                scatterY = (parseInt(intendedDestinationY) - parseInt(scatterDistance));
            }else if(scatterDirection == 2){
// Scatter East
                scatterX = (parseInt(intendedDestinationX) + parseInt(scatterDistance));
                scatterY = intendedDestinationY;
            }else if(scatterDirection == 3){
// Scatter South
                scatterX = intendedDestinationX;
                scatterY = (parseInt(intendedDestinationY) + parseInt(scatterDistance));
            }else if(scatterDirection == 4){
// Scatter West
                scatterX = (parseInt(intendedDestinationX) - parseInt(scatterDistance));
                scatterY = intendedDestinationY;
            }
// Prevent fleets from scattering off map
            if(scatterX < 1) scatterX = 1;
            if(scatterY < 1) scatterY = 1;
            if(scatterX > $scope.mapCols) scatterX = $scope.mapCols;
            if(scatterY > $scope.mapRows) scatterY = $scope.mapRows;		                    
// Set scatter coordinates
            scatterCoord = scatterX+'x'+scatterY;
// Set destination of scattered Fleets
            $scope.destinationSector = $scope.sectors[getIndex(scatterX,scatterY)];		                
// Notification
            notification('Scattered!','Your fleets have scattered! They missed their destination by '+scatterDistance+' sectors.','red');		                            
            var totalARCingFleets = $scope.regular_fleetsSelected+$scope.explorer_fleetsSelected+$scope.destroyer_fleetsSelected;
            var numberOfLostFleets = Math.round(totalARCingFleets * scatterDissolution);
            var fleetLossMatrix = {
            	'r':[1,0,0],
            	'e':[0,1,0],
            	'd':[0,0,1],
            	're':[0.75,0.25,0],
            	'rd':[0.60,0,0.40],
            	'ed':[0,0.30,0.70],
            	'red':[0.50,0.15,0.35]
            };
            var fleetLossMatrixKey = '';
            if($scope.regular_fleetsSelected>0) fleetLossMatrixKey = 'r';
            if($scope.explorer_fleetsSelected>0) fleetLossMatrixKey+='e';
            if($scope.destroyer_fleetsSelected>0) fleetLossMatrixKey+='d';

            var numberOfLostRegulars = Math.max(0,Math.floor(numberOfLostFleets*fleetLossMatrix[fleetLossMatrixKey][0]));
            var numberOfLostExplorers = Math.max(0,Math.floor(numberOfLostFleets*fleetLossMatrix[fleetLossMatrixKey][1]));
            var numberOfLostDestroyers = Math.max(0,Math.floor(numberOfLostFleets*fleetLossMatrix[fleetLossMatrixKey][2]));

            if(numberOfLostFleets>0){
// Notification
                var regularLossMessage = numberOfLostRegulars>0?numberOfLostRegulars+' regulars':'';
                var explorerLossMessage = numberOfLostExplorers>0?numberOfLostExplorers+' explorers':'';
                var destroyerLossMessage = numberOfLostDestroyers>0?numberOfLostDestroyers+' destroyers':'';
                var lossMessageArray = [];
                if(regularLossMessage != '') lossMessageArray.push(regularLossMessage);
                if(explorerLossMessage != '') lossMessageArray.push(explorerLossMessage);
                if(destroyerLossMessage != '') lossMessageArray.push(destroyerLossMessage);
                var lossMessage = '';
                if(lossMessageArray.length == 1) lossMessage = lossMessageArray[0];
                if(lossMessageArray.length == 2) lossMessage = lossMessageArray[0]+' and '+lossMessageArray[1];
                if(lossMessageArray.length == 3) lossMessage = lossMessageArray[0]+', '+lossMessageArray[1]+', and '+lossMessageArray[2];
                notification('Dissolution!','Your fleet suffered '+(scatterDissolution*100)+'% dissolution, resulting in a loss of '+lossMessage+'.','red');
            }  
            moveFleets($scope.regular_fleetsSelected-numberOfLostRegulars,$scope.explorer_fleetsSelected-numberOfLostExplorers,$scope.destroyer_fleetsSelected-numberOfLostDestroyers);
        } 
// Enter Scanner Mode
        $scope.scannerMode();
    }
// Move Fleets
    function moveFleets(r,e,d){
    	if(civlvl.canBlackHoleTravel() && $scope.destinationSector.BlackHole>0 && $scope.destinationSector.BlackHole<10){
// Not central Black Hole
// Pick a connecting Black Hole
    		var blackHoleList = [];
    		var matchingBlackHoles = blackHoles[$scope.destinationSector.BlackHole].length;
    		if(matchingBlackHoles>0){
    			for (var i = 0; i < blackHoles[$scope.destinationSector.BlackHole].length; i++) {
        			if(blackHoles[$scope.destinationSector.BlackHole][i].x == $scope.destinationSector.X && blackHoles[$scope.destinationSector.BlackHole][i].y == $scope.destinationSector.Y){
						//console.log(blackHoles[$scope.destinationSector.BlackHole][i]);
            			//console.log($scope.destinationSector);
					}else{	
						blackHoleList.push(blackHoles[$scope.destinationSector.BlackHole][i])
        			}
        		};
    			var ran = randomIntFromInterval(0,blackHoleList.length-1);
    			var randomBlackHole = blackHoleList[ran];
    			$scope.destinationSector = sectors[getIndex(randomBlackHole.x,randomBlackHole.y)];
    			notification('Black Hole ARC','Your fleets have traveled through a black hole!','yellow');
    		}
    	}
    	$scope.selectedSector.ActiveRegularCount -= $scope.regular_fleetsSelected;
    	$scope.selectedSector.ActiveExplorerCount -= $scope.explorer_fleetsSelected;
    	$scope.selectedSector.ActiveDestroyerCount -= $scope.destroyer_fleetsSelected;
               	
    	if(!editedSectors[$scope.destinationSector.X+'x'+$scope.destinationSector.Y]){
    		editedSectors[$scope.destinationSector.X+'x'+$scope.destinationSector.Y] = true;
    	}
    	var destroyedByBlackhole = false;
    	if($scope.destinationSector.BlackHole == 10){
// Is central black hole
            if(!civlvl.canARC('CentralBlackHole')){
	    		destroyedByBlackhole = true;	    		
	    	}else{
		    	var centralBlackHoleMessage = 'Congratulations, after a long and arduous journey, you have finally reached the central black hole! What wonders are there to discover here at the heart of the galaxy?';
	    		centralBlackHoleMessage += e>0?' There is one way to find out.':' Too bad you didn\'t bring any explorers. ;(';
				notification('Central Black Hole',centralBlackHoleMessage,'green');
	    	}
    	}else{
	    	if($scope.destinationSector.Terrain == 'Core' || $scope.destinationSector.Terrain == 'Nucleus'){
	            notification('WARNING!!','This sector is part of the Galactic '+$scope.destinationSector.Terrain+' and is awash in radiation. It is dangerous to spend much time here. Proceed with caution.','yellow');
	        }    		
    	}
        if($scope.destinationSector.DarkMatter){
        	notification('DISASTER!!','Your entire fleet was lost in dark matter.','red');
        }else{
        	if(destroyedByBlackhole){
        		notification('Black Hole Too Powerful','The gravity of the central black hole proved too great for your fleets to endure.','red');
        	}else{
	        	if($scope.destinationSector.HasARCBase){		            		
	            	$scope.destinationSector.ActiveRegularCount += r;
	            	$scope.destinationSector.ActiveExplorerCount += e;
	            	$scope.destinationSector.ActiveDestroyerCount += d;
	        	}else{
	            	$scope.destinationSector.InactiveRegularCount += r;
	            	$scope.destinationSector.InactiveExplorerCount += e;
	            	$scope.destinationSector.InactiveDestroyerCount += d;
	        	} 
	        }
    	} 		                                
        $scope.selectSector($scope.destinationSector.X,$scope.destinationSector.Y);         
		$scope.save();		           
    }
/*
      /$$$$$$  /$$$$$$$$ /$$$$$$$$ /$$$$$$   /$$$$$$  /$$   /$$
     /$$__  $$|__  $$__/|__  $$__//$$__  $$ /$$__  $$| $$  /$$/
    | $$  \ $$   | $$      | $$  | $$  \ $$| $$  \__/| $$ /$$/ 
    | $$$$$$$$   | $$      | $$  | $$$$$$$$| $$      | $$$$$/  
    | $$__  $$   | $$      | $$  | $$__  $$| $$      | $$  $$  
    | $$  | $$   | $$      | $$  | $$  | $$| $$    $$| $$\  $$ 
    | $$  | $$   | $$      | $$  | $$  | $$|  $$$$$$/| $$ \  $$
    |__/  |__/   |__/      |__/  |__/  |__/ \______/ |__/  \__/
*/
	$scope.attacker = {
		'regularConstructs':[],
		'regularIds':[],
		'regulars':$scope.regular_fleetsSelected,
		'explorerConstructs':[],
		'explorerIds':[],
		'explorers':$scope.explorer_fleetsSelected,
		'destroyerConstructs':[],
		'destroyerIds':[],
		'destroyers':$scope.destroyer_fleetsSelected,
		'sum':function(){
			return this.regulars + this.explorers + this.destroyers;
		},
		'trueConflictCapacity':0,
		'strengthPercentage':0,
		'regularLosses':0,
		'explorerLosses':0,
		'destroyerLosses':0,
		'remaining':0
	};
	$scope.defender = {
		'sum':function(){return $scope.selectedSector.AlienRegularCount + $scope.selectedSector.AlienExplorerCount + $scope.selectedSector.AlienDestroyerCount;},
		'trueConflictCapacity':0,
		'strengthPercentage':0,
		'regularLosses':0,
		'explorerLosses':0,
		'destroyerLosses':0,
		'remaining':0
	};
	$scope.recon = function(){
        $scope.rand = randomIntFromInterval(1,10);
        $scope.augmentedRoll = Math.max(1,Math.ceil(($scope.rand + ($scope.attacker.destroyers - $scope.selectedSector.AlienDestroyerCount)) / 3));
        $scope.attacker.regulars = $scope.regular_fleetsSelected;
        $scope.attacker.explorers = $scope.explorer_fleetsSelected;
        $scope.attacker.destroyers = $scope.destroyer_fleetsSelected;
        $scope.attacker.trueConflictCapacity = Math.max(1,(($scope.attacker.sum() - $scope.attacker.explorers) + $scope.attacker.destroyers) + $scope.augmentedRoll);
        $scope.defender.trueConflictCapacity = Math.max(1,(($scope.defender.sum() - $scope.selectedSector.AlienExplorerCount) + $scope.selectedSector.AlienDestroyerCount) - $scope.augmentedRoll);		                
        $scope.attacker.strengthPercentage = $scope.attacker.trueConflictCapacity/$scope.defender.trueConflictCapacity;
        $scope.defender.strengthPercentage = $scope.defender.trueConflictCapacity/$scope.attacker.trueConflictCapacity;
	}
    $scope.getLosses = function(count,losses,sum,classmod){
        return Math.min(count,Math.round((losses * (count/sum))/classmod));
    }
    $scope.attack = function(){
// Figure total losses for each side
        $scope.attacker.losses = Math.max(0,Math.ceil((($scope.defender.strengthPercentage/$scope.defender.trueConflictCapacity) * $scope.defender.sum()) + $scope.augmentedRoll));
        $scope.defender.losses = Math.max(0,Math.ceil((($scope.attacker.strengthPercentage/$scope.attacker.trueConflictCapacity) * $scope.attacker.sum()) + $scope.augmentedRoll));
// Defender
// Figure per type losses
        $scope.defender.regularLosses = $scope.getLosses($scope.selectedSector.AlienRegularCount,$scope.defender.losses,$scope.defender.sum(),1);
        $scope.defender.explorerLosses = $scope.getLosses($scope.selectedSector.AlienExplorerCount,$scope.defender.losses,$scope.defender.sum(),2);
        $scope.defender.destroyerLosses = $scope.getLosses($scope.selectedSector.AlienDestroyerCount,$scope.defender.losses,$scope.defender.sum(),4);
// Attacker
// Figure per type losses
        $scope.attacker.regularLosses = $scope.getLosses($scope.attacker.regulars,$scope.attacker.losses,$scope.attacker.sum(),1);
        $scope.attacker.explorerLosses = $scope.getLosses($scope.attacker.explorers,$scope.attacker.losses,$scope.attacker.sum(),2);
        $scope.attacker.destroyerLosses = $scope.getLosses($scope.attacker.destroyers,$scope.attacker.losses,$scope.attacker.sum(),4);            
    	spendActionPoints($scope.attacker.regulars,$scope.attacker.explorers,$scope.attacker.destroyers,0);
    	if($scope.attacker.regulars   > 0 && $scope.attacker.regularLosses   > 0) $scope.selectedSector.InactiveRegularCount -= $scope.attacker.regularLosses;
        if($scope.attacker.explorers  > 0 && $scope.attacker.explorerLosses  > 0) $scope.selectedSector.InactiveExplorerCount -= $scope.attacker.explorerLosses;
        if($scope.attacker.destroyers > 0 && $scope.attacker.destroyerLosses > 0) $scope.selectedSector.InactiveDestroyerCount -= $scope.attacker.destroyerLosses;
        if($scope.selectedSector.AlienRegularCount   > 0 && $scope.defender.regularLosses   > 0) $scope.selectedSector.AlienRegularCount -= $scope.defender.regularLosses;
        if($scope.selectedSector.AlienExplorerCount  > 0 && $scope.defender.explorerLosses  > 0) $scope.selectedSector.AlienExplorerCount -= $scope.defender.explorerLosses;
        if($scope.selectedSector.AlienDestroyerCount > 0 && $scope.defender.destroyerLosses > 0) $scope.selectedSector.AlienDestroyerCount -= $scope.defender.destroyerLosses;
        notification('Combat Results ('+$scope.selectedSector.X+'x'+$scope.selectedSector.Y+')','Attacker Loses: <b><ul><li>Regulars: '+$scope.attacker.regularLosses+'</li><li>Explorers :'+$scope.attacker.explorerLosses+'</li><li>Destroyers: '+$scope.attacker.destroyerLosses+'</li></ul></b><p/>Defender Loses:<b><ul><li>Regulars: '+$scope.defender.regularLosses+'</li><li>Explorers: '+$scope.defender.explorerLosses+'</li><li>Destroyers: '+$scope.defender.destroyerLosses+'</li></ul></b>','blue');
        $scope.attacker.remaining = Math.max(0,Math.ceil($scope.attacker.sum() - $scope.attacker.losses));
        $scope.defender.remaining = Math.max(0,Math.ceil($scope.defender.sum() - $scope.defender.losses));
        $scope.scanSector($scope.selectedSector.X,$scope.selectedSector.Y);
    }
    $scope.reduced = false;
// Commented out until contacts is settled
    $scope.siege = function(){
    	// $scope.reductionDifferential = ($scope.destroyer_fleetsSelected + $scope.civLvl) - ($scope.sectorContactMap[$scope.selectedSector.X+'x'+$scope.selectedSector.Y].ResourcePoints + 1);
    	// var roll = randomIntFromInterval(1,6);
    	// if($scope.reductionDifferential >= -2){
    	// 	$scope.reduced = $scope.reductionDifferential < roll;
    	// }
    	// if(!$scope.reduced){
    	// 	$scope.sectorContactMap[$scope.selectedSector.X+'x'+$scope.selectedSector.Y].ResourcePoints = 0;		            		
    	// 	var reducedARCBase = new RemoteObjectModel.Construct();
    	// 	var cids = [];
    	// 	cids.push($scope.sectorContactMap[$scope.selectedSector.X+'x'+$scope.selectedSector.Y].Id);		            		
    	// 	reducedARCBase.update(
     //            cids,
     //            {
     //                ARCFleet__Race__c:'!Race.Id',
     //                ARCFleet__Resource_Points__c: 0
     //            },
     //            function(err, ids){
     //                if(err){
     //                    notification('Capture ARC Base Error',err,'red');
     //                }else{
     //                    for (var i = 0; i < $scope.attacker.destroyers.length; i++) {
		         //        	$scope.attacker.destroyerConstructs[i].ActionPoints--;
		         //        };
     //                    notification('ARC Base Captured!','This ARC Base will be yours starting next turn.' ,'green');
     //                    $scope.$apply();
     //                }
     //            }
     //        );
    	// }
    }
/*
     /$$   /$$ /$$$$$$$$ /$$$$$$ /$$       /$$$$$$ /$$$$$$$$ /$$     /$$       /$$$$$$$$ /$$   /$$ /$$   /$$  /$$$$$$  /$$$$$$$$ /$$$$$$  /$$$$$$  /$$   /$$  /$$$$$$ 
    | $$  | $$|__  $$__/|_  $$_/| $$      |_  $$_/|__  $$__/|  $$   /$$/      | $$_____/| $$  | $$| $$$ | $$ /$$__  $$|__  $$__/|_  $$_/ /$$__  $$| $$$ | $$ /$$__  $$
    | $$  | $$   | $$     | $$  | $$        | $$     | $$    \  $$ /$$/       | $$      | $$  | $$| $$$$| $$| $$  \__/   | $$     | $$  | $$  \ $$| $$$$| $$| $$  \__/
    | $$  | $$   | $$     | $$  | $$        | $$     | $$     \  $$$$/        | $$$$$   | $$  | $$| $$ $$ $$| $$         | $$     | $$  | $$  | $$| $$ $$ $$|  $$$$$$ 
    | $$  | $$   | $$     | $$  | $$        | $$     | $$      \  $$/         | $$__/   | $$  | $$| $$  $$$$| $$         | $$     | $$  | $$  | $$| $$  $$$$ \____  $$
    | $$  | $$   | $$     | $$  | $$        | $$     | $$       | $$          | $$      | $$  | $$| $$\  $$$| $$    $$   | $$     | $$  | $$  | $$| $$\  $$$ /$$  \ $$
    |  $$$$$$/   | $$    /$$$$$$| $$$$$$$$ /$$$$$$   | $$       | $$          | $$      |  $$$$$$/| $$ \  $$|  $$$$$$/   | $$    /$$$$$$|  $$$$$$/| $$ \  $$|  $$$$$$/
     \______/    |__/   |______/|________/|______/   |__/       |__/          |__/       \______/ |__/  \__/ \______/    |__/   |______/ \______/ |__/  \__/ \______/                                                                                                                                                                      
*/

/*
     /$$$$$$$            /$$ /$$       /$$
    | $$__  $$          |__/| $$      | $$
    | $$  \ $$ /$$   /$$ /$$| $$  /$$$$$$$
    | $$$$$$$ | $$  | $$| $$| $$ /$$__  $$
    | $$__  $$| $$  | $$| $$| $$| $$  | $$
    | $$  \ $$| $$  | $$| $$| $$| $$  | $$
    | $$$$$$$/|  $$$$$$/| $$| $$|  $$$$$$$
    |_______/  \______/ |__/|__/ \_______/
*/
    $scope.build = function(ncClass,ncType){
        if(ncType=='fleet'){
// Build Fleet
            $scope.ARCFleetSFX('B2');
           	if(ncClass=='regular'){
// Build Regular
           		$scope.spendResources($scope.regularCost);
           		$scope.selectedSector.InactiveRegularCount++;
           	}
    	    if(ncClass=='explorer'){
// Build Explorer
           		$scope.spendResources($scope.explorerCost);
               	$scope.selectedSector.InactiveExplorerCount++;
            }
            if(ncClass=='destroyer'){
// Build Destroyer
           		$scope.spendResources($scope.destroyerCost);
               	$scope.selectedSector.InactiveDestroyerCount++;
            }
            spendActionPoints(0,0,0,1);
            $scope.save();			                          	
        }else{
// Build ARCBase
            $scope.ARCFleetSFX('B2');
            $scope.selectedSector.ActiveRegularCount -= 2;
            $scope.selectedSector.HasARCBase = true;
            $scope.selectedSector.ARCBasePoints = 1;
            $scope.save();
        }
    }		        
/*
      /$$$$$$                                                          /$$    
     /$$__  $$                                                        | $$    
    | $$  \ $$ /$$   /$$  /$$$$$$  /$$$$$$/$$$$   /$$$$$$  /$$$$$$$  /$$$$$$  
    | $$$$$$$$| $$  | $$ /$$__  $$| $$_  $$_  $$ /$$__  $$| $$__  $$|_  $$_/  
    | $$__  $$| $$  | $$| $$  \ $$| $$ \ $$ \ $$| $$$$$$$$| $$  \ $$  | $$    
    | $$  | $$| $$  | $$| $$  | $$| $$ | $$ | $$| $$_____/| $$  | $$  | $$ /$$
    | $$  | $$|  $$$$$$/|  $$$$$$$| $$ | $$ | $$|  $$$$$$$| $$  | $$  |  $$$$/
    |__/  |__/ \______/  \____  $$|__/ |__/ |__/ \_______/|__/  |__/   \___/  
                         /$$  \ $$                                            
                        |  $$$$$$/                                            
                         \______/                                             
*/
    $scope.augment = function(ncClass,ncType){
// Enter Construction Mode
        $scope.constructionMode();
// What are we building?               
        if(ncType=='fleet'){
// We are building a Fleet
            $scope.build(ncClass,'fleet');
        }else{
// We are building an ARCBase
// Better check if there is a ARCBase here already
        	if($scope.selectedSector.HasARCBase){
// There is a ARCBase here already, better augment it instead
// Reset initial variables		                        
    			if($scope.selectedSector.ARCBasePoints < $scope.selectedSector.ResourceValue){
    				var ap = $scope.selectedSector.ARCBasePoints;			        				
                	$scope.selectedSector.ARCBasePoints++;
                	spendActionPoints(0,0,0,1);
                	$scope.selectedSector.ActiveRegularCount--;
                	$scope.save();		                            
    			}else{
    				notification('Cannot Augment ARC Base','This ARC Base has reached its full potential of resource point production and cannot be augmented further. ARC Bases that are operating at full capacity are outlined in blue.','red');
                }
            }else if($scope.selectedSector.ResourceValue > 0){
// There is no ARCBase here, let us build one
                notification('ARC Base Construction Begun','Construction of ARC Base is under way. When construction is complete next turn, it may be augmented by regular fleets in order to increase its resource point production.','blue');
                $scope.build('regular','arcbase');
            }else if($scope.selectedSector.HasContactARCBase()){
                notification('Cannot Build ARC Base','You may not build an ARC Base in an occupied sector.','yellow');
            }else if($scope.selectedSector.ResourceValue < 1){
                notification('Cannot Build ARC Base','Sector must be explored to build an ARC Base.','yellow');
            }
        }
// Return to Scanner Mode
        $scope.scannerMode();
        $scope.renderChunk();
        $scope.selectSector($scope.curr_x,$scope.curr_y); 
    }
/*
     /$$$$$$$                            /$$                            /$$$$$$  /$$                           /$$      
    | $$__  $$                          | $$                           /$$__  $$| $$                          | $$      
    | $$  \ $$  /$$$$$$  /$$$$$$$   /$$$$$$$  /$$$$$$   /$$$$$$       | $$  \__/| $$$$$$$  /$$   /$$ /$$$$$$$ | $$   /$$
    | $$$$$$$/ /$$__  $$| $$__  $$ /$$__  $$ /$$__  $$ /$$__  $$      | $$      | $$__  $$| $$  | $$| $$__  $$| $$  /$$/
    | $$__  $$| $$$$$$$$| $$  \ $$| $$  | $$| $$$$$$$$| $$  \__/      | $$      | $$  \ $$| $$  | $$| $$  \ $$| $$$$$$/ 
    | $$  \ $$| $$_____/| $$  | $$| $$  | $$| $$_____/| $$            | $$    $$| $$  | $$| $$  | $$| $$  | $$| $$_  $$ 
    | $$  | $$|  $$$$$$$| $$  | $$|  $$$$$$$|  $$$$$$$| $$            |  $$$$$$/| $$  | $$|  $$$$$$/| $$  | $$| $$ \  $$
    |__/  |__/ \_______/|__/  |__/ \_______/ \_______/|__/             \______/ |__/  |__/ \______/ |__/  |__/|__/  \__/
*/
    $scope.renderChunk = function(){
// Find sector in upper left corner of view
        var left = -3;
        if($scope.showInspectorPanel) left = 4;
        $scope.fromX = ($scope.setViewX - Math.ceil($scope.viewWidthInSectors/2))+left;
        $scope.fromY = ($scope.setViewY - Math.ceil($scope.viewHeightInSectors/2))+1;
// Set minimum coordinate of 1
        if($scope.fromX<1){
            $scope.setViewX = Math.ceil($scope.viewWidthInSectors/2)+1;
            $scope.fromX = 1;
        }
        if($scope.fromY<1){
            $scope.setViewY = Math.ceil($scope.viewHeightInSectors/2)+1;
            $scope.fromY = 1;
        }
// Reset viewSectors array
        $scope.viewSectors = [];
// Find bottom right sector
        $scope.finalX = ($scope.fromX + $scope.viewWidthInSectors)-1 ;
        $scope.finalY = ($scope.fromY + $scope.viewHeightInSectors)-2;
// Set maximum coordinates using the height and width of the map
        if ($scope.finalX > $scope.mapCols){
            $scope.setViewX = ($scope.mapCols - Math.ceil($scope.viewWidthInSectors/2))+1;
            $scope.fromX = ($scope.mapCols - $scope.viewWidthInSectors)+1;
            $scope.finalX = $scope.mapCols;
        }
        if ($scope.finalY > $scope.mapRows){
            $scope.setViewY = ($scope.mapRows - Math.ceil($scope.viewHeightInSectors/2))+1;
            $scope.fromY = ($scope.mapRows - $scope.viewHeightInSectors)+1;
            $scope.finalY = $scope.mapRows;
        }		                
// Add sectors from game map between top left and bottom right sectors to view
        for (var iY = $scope.fromY; iY < $scope.finalY; iY++) {
            for(var iX = $scope.fromX; iX < $scope.finalX; iX++){
                $scope.viewSectors.push($scope.sectors[getIndex(iX,iY)]);
            }
        }
    }
/*
     /$$      /$$ /$$           /$$       /$$      /$$                           /$$$$$$$                            /$$                    
    | $$$    /$$$|__/          |__/      | $$$    /$$$                          | $$__  $$                          | $$                    
    | $$$$  /$$$$ /$$ /$$$$$$$  /$$      | $$$$  /$$$$  /$$$$$$   /$$$$$$       | $$  \ $$  /$$$$$$   /$$$$$$   /$$$$$$$  /$$$$$$   /$$$$$$ 
    | $$ $$/$$ $$| $$| $$__  $$| $$      | $$ $$/$$ $$ |____  $$ /$$__  $$      | $$$$$$$  /$$__  $$ /$$__  $$ /$$__  $$ /$$__  $$ /$$__  $$
    | $$  $$$| $$| $$| $$  \ $$| $$      | $$  $$$| $$  /$$$$$$$| $$  \ $$      | $$__  $$| $$  \ $$| $$  \__/| $$  | $$| $$$$$$$$| $$  \__/
    | $$\  $ | $$| $$| $$  | $$| $$      | $$\  $ | $$ /$$__  $$| $$  | $$      | $$  \ $$| $$  | $$| $$      | $$  | $$| $$_____/| $$      
    | $$ \/  | $$| $$| $$  | $$| $$      | $$ \/  | $$|  $$$$$$$| $$$$$$$/      | $$$$$$$/|  $$$$$$/| $$      |  $$$$$$$|  $$$$$$$| $$      
    |__/     |__/|__/|__/  |__/|__/      |__/     |__/ \_______/| $$____/       |_______/  \______/ |__/       \_______/ \_______/|__/      
                                                                | $$                                                                        
                                                                | $$                                                                        
                                                                |__/                                                                        
*/
    $scope.minimapBorder = function(sector){
        $scope.minimapBorderClasses = '';
        if(sector.Y == $scope.fromY && (sector.X >= $scope.fromX && sector.X <= $scope.finalX)){
            $scope.minimapBorderClasses = $scope.minimapBorderClasses+' topBorder';
        }
        if(sector.X == $scope.finalX && (sector.Y >= $scope.fromY && sector.Y <= $scope.finalY)){
            $scope.minimapBorderClasses = $scope.minimapBorderClasses+' rightBorder';
        }
        if(sector.Y == $scope.finalY && (sector.X >= $scope.fromX && sector.X <= $scope.finalX)){
            $scope.minimapBorderClasses = $scope.minimapBorderClasses+' bottomBorder';
        }
        if(sector.X == $scope.fromX && (sector.Y >= $scope.fromY && sector.Y <= $scope.finalY)){
            $scope.minimapBorderClasses = $scope.minimapBorderClasses+' leftBorder';
        }
        return $scope.minimapBorderClasses;
    }
/*
      /$$$$$$  /$$ /$$       /$$                            /$$$$$$   /$$                        
     /$$__  $$| $$|__/      | $$                           /$$__  $$ | $$                        
    | $$  \__/| $$ /$$  /$$$$$$$  /$$$$$$   /$$$$$$       | $$  \__//$$$$$$    /$$$$$$   /$$$$$$ 
    |  $$$$$$ | $$| $$ /$$__  $$ /$$__  $$ /$$__  $$      |  $$$$$$|_  $$_/   /$$__  $$ /$$__  $$
     \____  $$| $$| $$| $$  | $$| $$$$$$$$| $$  \__/       \____  $$ | $$    | $$  \ $$| $$  \ $$
     /$$  \ $$| $$| $$| $$  | $$| $$_____/| $$             /$$  \ $$ | $$ /$$| $$  | $$| $$  | $$
    |  $$$$$$/| $$| $$|  $$$$$$$|  $$$$$$$| $$            |  $$$$$$/ |  $$$$/|  $$$$$$/| $$$$$$$/
     \______/ |__/|__/ \_______/ \_______/|__/             \______/   \___/   \______/ | $$____/ 
                                                                                       | $$      
                                                                                       | $$      
                                                                                       |__/      
*/
    $scope.sliderStop = function(){
        $scope.ARCFleetSFX('T1');
// Toggle button enable/disable based on fleet amounts
        if(!$scope.selectedSector.HasARCBase){
            $scope.regular_actionButtonEnabled = $scope.regular_fleetsSelected > 1 && $scope.explorer_fleetsSelected == 0 && $scope.destroyer_fleetsSelected == 0;
        }else{
// If ARCBase is out of Action Points, do not allow regular to augment  
            if(!$scope.selectedSector.ARCBaseIsActive){
                $scope.regular_actionButtonEnabled = false;
            }else{
                $scope.regular_actionButtonEnabled = $scope.regular_fleetsSelected > 0 && $scope.explorer_fleetsSelected == 0 && $scope.destroyer_fleetsSelected == 0;
            }
        }
        $scope.explorer_actionButtonEnabled = $scope.regular_fleetsSelected == 0 && $scope.explorer_fleetsSelected > 0 && $scope.destroyer_fleetsSelected == 0;
        $scope.attackButtonEnabled = $scope.regular_fleetsSelected > 0 || $scope.explorer_fleetsSelected > 0 || $scope.destroyer_fleetsSelected > 0;
        $scope.destroyer_actionButtonEnabled = $scope.regular_fleetsSelected == 0 && $scope.explorer_fleetsSelected == 0 && $scope.destroyer_fleetsSelected > 0;
        $scope.arcCalcButtonEnabled = $scope.regular_fleetsSelected > 0 || $scope.explorer_fleetsSelected > 0 || $scope.destroyer_fleetsSelected > 0;		                
// Call updateSelectedFleets() when slider stops
        $scope.updateSelectedFleets();
// This recalculates ARC Calc when slider stops
        if($scope.mode=='ARC Calc') $scope.arcCalc($scope.dest_x,$scope.dest_y);
    };

/*
      /$$$$$$  /$$ /$$       /$$                           /$$$$$$           /$$   /$$     /$$           /$$ /$$                                        
     /$$__  $$| $$|__/      | $$                          |_  $$_/          |__/  | $$    |__/          | $$|__/                                        
    | $$  \__/| $$ /$$  /$$$$$$$  /$$$$$$   /$$$$$$         | $$   /$$$$$$$  /$$ /$$$$$$   /$$  /$$$$$$ | $$ /$$ /$$$$$$$$  /$$$$$$   /$$$$$$   /$$$$$$$
    |  $$$$$$ | $$| $$ /$$__  $$ /$$__  $$ /$$__  $$        | $$  | $$__  $$| $$|_  $$_/  | $$ |____  $$| $$| $$|____ /$$/ /$$__  $$ /$$__  $$ /$$_____/
     \____  $$| $$| $$| $$  | $$| $$$$$$$$| $$  \__/        | $$  | $$  \ $$| $$  | $$    | $$  /$$$$$$$| $$| $$   /$$$$/ | $$$$$$$$| $$  \__/|  $$$$$$ 
     /$$  \ $$| $$| $$| $$  | $$| $$_____/| $$              | $$  | $$  | $$| $$  | $$ /$$| $$ /$$__  $$| $$| $$  /$$__/  | $$_____/| $$       \____  $$
    |  $$$$$$/| $$| $$|  $$$$$$$|  $$$$$$$| $$             /$$$$$$| $$  | $$| $$  |  $$$$/| $$|  $$$$$$$| $$| $$ /$$$$$$$$|  $$$$$$$| $$       /$$$$$$$/
     \______/ |__/|__/ \_______/ \_______/|__/            |______/|__/  |__/|__/   \___/  |__/ \_______/|__/|__/|________/ \_______/|__/      |_______/ 
*/
		            
    var regSlider = $j('#regularSlider').slider({
    	value: $scope.regular_fleetsSelected,
    	max: 0
    }).on('slideStop',function(slideEvt){
        $scope.$apply(function(){
            $scope.regular_fleetsSelected = slideEvt.value;
            $scope.sliderStop();
        });                      
    }).data('slider');    
    var exSlider = $j('#explorerSlider').slider({
    	value: $scope.explorer_fleetsSelected,
    	max: 0
    }).on('slideStop',function(slideEvt){
        $scope.$apply(function(){
            $scope.explorer_fleetsSelected = slideEvt.value;
            $scope.sliderStop();
        });                        
    }).data('slider');
    var desSlider = $j('#destroyerSlider').slider({
    	value: $scope.destroyer_fleetsSelected,
    	max: 0
    }).on('slideStop',function(slideEvt){
        $scope.$apply(function(){
            $scope.destroyer_fleetsSelected = slideEvt.value;
            $scope.sliderStop();
        });                        
    }).data('slider');
/*
      /$$$$$$            /$$                       /$$            /$$$$$$                        /$$                        
     /$$__  $$          | $$                      | $$           /$$__  $$                      | $$                        
    | $$  \__/  /$$$$$$ | $$  /$$$$$$   /$$$$$$$ /$$$$$$        | $$  \__/  /$$$$$$   /$$$$$$$ /$$$$$$    /$$$$$$   /$$$$$$ 
    |  $$$$$$  /$$__  $$| $$ /$$__  $$ /$$_____/|_  $$_/        |  $$$$$$  /$$__  $$ /$$_____/|_  $$_/   /$$__  $$ /$$__  $$
     \____  $$| $$$$$$$$| $$| $$$$$$$$| $$        | $$           \____  $$| $$$$$$$$| $$        | $$    | $$  \ $$| $$  \__/
     /$$  \ $$| $$_____/| $$| $$_____/| $$        | $$ /$$       /$$  \ $$| $$_____/| $$        | $$ /$$| $$  | $$| $$      
    |  $$$$$$/|  $$$$$$$| $$|  $$$$$$$|  $$$$$$$  |  $$$$/      |  $$$$$$/|  $$$$$$$|  $$$$$$$  |  $$$$/|  $$$$$$/| $$      
     \______/  \_______/|__/ \_______/ \_______/   \___/         \______/  \_______/ \_______/   \___/   \______/ |__/      
*/
    $scope.selectSector = function(x,y){
        if($scope.mode == 'Scanner'){
// Selecting Sector with no Functions activated
// This is the default behavior
            $scope.scanSector(x,y);
        }else if($scope.mode == 'ARC Calc'){
// Selecting a Sector with the ArcCalc Function activated
// Should calculate ARC chances and display ARC line.
            if(is.not.undefined($scope.destinationSector)){                
                console.log($scope.destinationSector);
                if($scope.destinationSector.X == x && $scope.destinationSector.Y == y){
                    if(isDebug){
                        $scope.arc(0);
                    }else{
                        $scope.arc();
                    }
                }else{
                    $scope.arcCalc(x,y);
                }   
            }else{
                $scope.arcCalc(x,y);
            }       
        }
    }
/*   /$$$$$$  /$$ /$$                           /$$$$$$$$                                                     /$$                               /$$      /$$                 /$$           /$$
    /$$__  $$| $$|__/                          | $$_____/                                                    | $$                              | $$$    /$$$                | $$          | $$
   | $$  \ $$| $$ /$$  /$$$$$$  /$$$$$$$       | $$       /$$$$$$$   /$$$$$$$  /$$$$$$  /$$   /$$ /$$$$$$$  /$$$$$$    /$$$$$$   /$$$$$$       | $$$$  /$$$$  /$$$$$$   /$$$$$$$  /$$$$$$ | $$
   | $$$$$$$$| $$| $$ /$$__  $$| $$__  $$      | $$$$$   | $$__  $$ /$$_____/ /$$__  $$| $$  | $$| $$__  $$|_  $$_/   /$$__  $$ /$$__  $$      | $$ $$/$$ $$ /$$__  $$ /$$__  $$ |____  $$| $$
   | $$__  $$| $$| $$| $$$$$$$$| $$  \ $$      | $$__/   | $$  \ $$| $$      | $$  \ $$| $$  | $$| $$  \ $$  | $$    | $$$$$$$$| $$  \__/      | $$  $$$| $$| $$  \ $$| $$  | $$  /$$$$$$$| $$
   | $$  | $$| $$| $$| $$_____/| $$  | $$      | $$      | $$  | $$| $$      | $$  | $$| $$  | $$| $$  | $$  | $$ /$$| $$_____/| $$            | $$\  $ | $$| $$  | $$| $$  | $$ /$$__  $$| $$
   | $$  | $$| $$| $$|  $$$$$$$| $$  | $$      | $$$$$$$$| $$  | $$|  $$$$$$$|  $$$$$$/|  $$$$$$/| $$  | $$  |  $$$$/|  $$$$$$$| $$            | $$ \/  | $$|  $$$$$$/|  $$$$$$$|  $$$$$$$| $$
   |__/  |__/|__/|__/ \_______/|__/  |__/      |________/|__/  |__/ \_______/ \______/  \______/ |__/  |__/   \___/   \_______/|__/            |__/     |__/ \______/  \_______/ \_______/|__/
*/    
    var stage = new createjs.Stage('alienCanvas');
    var bg = new createjs.Shape();
    var seed = '';
    var linesCont = new createjs.Container();
    var hudColor = 'hsl(193,40%,20%)';
    var hudBorder = 'rgb(41, 209, 255)';
    var orangeColor = '#F1AF16';
    var lineGraphWidth = 170;
    var dataCont = new createjs.Container();
    var stats = new createjs.Container();
    var widgets = new createjs.Container();
    var dashes = new createjs.Container();
    var centerline = rifi(20,30);
    var tkr = createjs.Ticker;
    tkr.framerate = 24;
    tkr.addEventListener("tick", handleTick);
    $scope.showAliens = function(alienseed){        
        stage.removeAllChildren();
        bg.graphics.beginFill('#000').drawRect(0, 0, 1000, 500);
        var alien = drawAlien(alienseed);
        var alien1 = new createjs.Container();
        alien1.x = 50;
        alien1.y = 50; 
        var head1 = alien.head;
        alien1.addChild(head1);
        var hud = new createjs.Container();
        var glow = new createjs.Shadow("hsl(193,40%,70%)", 0, 0, 15);
        var outline = new createjs.Shape();
        outline.graphics.setStrokeStyle(1).beginStroke(hudBorder).beginFill(hudColor)
            .mt(10,20).bt(10,10,10,10,20,10)
            .lt(580,10).bt(590,10,590,10,590,20)
            .lt(590,330).bt(590,340,590,340,580,340)
            .lt(400,340).bt(390,340,390,340,390,330)
            .lt(390,50).bt(390,40,390,40,380,40)
            .lt(20,40).bt(10,40,10,40,10,30)
            .lt(10,20);            
        var alienHeadParts = head1.getChildByName('partsContainer').children;
        for (var i = 0; i < alienHeadParts.length; i++) {
            var p = alienHeadParts[i];
            if(p.name.includes('_Flipped')){
                drawPointers(p.x+alien1.x+head1.x+p._bounds.x,p.y+alien1.y+head1.y,hud,350);
            }
        }
        drawPointers(rifi(150,200),rifi(100,300),hud,300);
        drawPointers(rifi(150,200),rifi(100,300),hud,300);
        drawPointers(rifi(150,200),rifi(100,300),hud,300);                        
        stats.x = 10;
        stats.y = 40;
        dnaXArray = [0,1,1,2,2,1,1,0,0];
        var dna = new createjs.Container();
        var dnaBox = new createjs.Shape();        
        var dnaWidth = 50;
        var scale = Math.floor(dnaWidth/dnaXArray.length);
        dnaBox.graphics.setStrokeStyle(1).beginStroke(hudBorder).rect(-5,-10,55,100);
        dna.addChild(dnaBox);
        var nucColors = ['rgba(255,255,0,0.5)','rgba(0,255,0,0.5)','rgba(255,0,0,0.5)','rgba(0,255,255,0.5)']
        var dnaX = 0;
        for (var i = 0; i < dnaXArray.length; i++) {                
            circleSize = 3;
            var nuc1 = new createjs.Shape();
            var nuc2 = new createjs.Shape();
            var bond = new createjs.Shape();
            nuc1.graphics.setStrokeStyle(1).beginFill(nucColors[alien.dna[i]%nucColors.length]).dc(dnaX,i*10,circleSize)
            nuc2.graphics.setStrokeStyle(1).beginFill(nucColors[alien.dna[i+dnaXArray.length]%nucColors.length]).dc(dnaWidth-dnaX-scale,i*10,circleSize);
            bond.graphics.setStrokeStyle(1).beginStroke(hudBorder).mt(dnaX,i*10).lt(dnaWidth-dnaX-scale,i*10);
            dna.addChild(bond,nuc1,nuc2);
            dnaX+=dnaXArray[i]*scale;
        }            
        dna.x=115;
        dna.y=140;            
        var axis = new createjs.Shape();
        axis.graphics.setStrokeStyle(0.5).beginStroke(hudBorder)
            .dashedLineTo(0,5,lineGraphWidth,5,1)
            .dashedLineTo(0,10,lineGraphWidth,10,1)
            .dashedLineTo(0,15,lineGraphWidth,15,1)
            .dashedLineTo(0,20,lineGraphWidth,20,1)
            .dashedLineTo(0,25,lineGraphWidth,25,1)
            .dashedLineTo(0,30,lineGraphWidth,30,1)
            .dashedLineTo(0,35,lineGraphWidth,35,1)
            .dashedLineTo(0,40,lineGraphWidth,40,1)
            .dashedLineTo(0,45,lineGraphWidth,45,1)
        var lineGraphBox = new createjs.Shape();
        var lineGraphCont = new createjs.Container();
        lineGraphBox.graphics.setStrokeStyle(1).beginStroke(hudBorder).mt(0,0).lt(0,50).mt(lineGraphWidth,0).lt(lineGraphWidth,50);
        lineGraphCont.addChild(axis,lineGraphBox,linesCont);
        lineGraphCont.x = 0;
        lineGraphCont.y = 240;
        dashes.x=10;
        dashes.y=130;            
        dataCont.x=10;
        dataCont.y=0;
        widgets.addChild(stats,dna,lineGraphCont,dataCont,dashes);
        widgets.x = 405;
        widgets.y = 30;
        hud.addChild(outline,widgets);
        stage.addChild(bg);
        stage.addChild(alien1);
        stage.addChild(hud);
        stage.update();
        $j('#history').html(alien.history);
        $j('#contactModal').modal('show');        
    }        
    function drawBargraph(h,w,fill,barcolor,graphcolor){
        if(graphcolor == null) graphcolor = hudBorder;
        if(barcolor == null) barcolor = 'hsla('+100*fill+',100%,50%,0.5)';
        var cont = new createjs.Container();
        var graph = new createjs.Shape();
        graph.graphics.setStrokeStyle(1).beginStroke(graphcolor).rect(0,0,w,h);
        var bar = new createjs.Shape();
        bar.graphics.setStrokeStyle(1).beginFill(barcolor).rect(2,2+(h-(fill*h)),w-4,(h*fill)-2);
        cont.addChild(graph);
        cont.addChild(bar);
        return cont;
    }
    function drawPointers(startX,startY,hud,endX){
        var endY = startY - 40;
        var pointer = new createjs.Shape();
        pointer.graphics.setStrokeStyle(1).beginStroke(hudBorder).mt(startX,startY).lt(endX,endY);
        var text = new createjs.Text(rifi(10,99999999),'bold 6px Arial',hudBorder);
        text.x = endX+5;
        text.y = endY;
        text.textBaseline = "alphabetic";
        hud.addChild(text);
        hud.addChild(pointer);
    }
    var i = 0;
    var blahblahblah = rifi(10,99999999);
    var gibI = 0;
    function handleTick(event){
        if (!event.paused) {
// twice a second
            if(i==0 || i==6 || i==12 || i == 18){
                drawGraph(6,lineGraphWidth); 
                stats.removeAllChildren();
                for (var ii = 0; ii < 10; ii++) {
                    var bargraph = drawBargraph(50,12,rifi(0,100)*0.01,orangeColor);
                    bargraph.x = ii*15;
                    stats.addChild(bargraph)
                }                   
            }
            if(i==0 || i==12){
                dataCont.removeAllChildren();
                blahblahblah += ' '+rifi(10,99999999);
                var gibberish = new createjs.Text(blahblahblah,'bold 6px Arial',hudBorder);
                gibberish.lineWidth = 150;
                dataCont.addChild(gibberish);
                dashes.removeAllChildren();
                for (var ii = 0; ii < 8; ii++) {                
                    var w = rifi(10,40);
                    var s = rifi(0,1);
                    var dash = new createjs.Shape();
                    dash.graphics.setStrokeStyle(1).beginFill('hsl(193,40%,'+(w+30)+'%)').rect(0,0,w,10)
                    dash.x=s==0?50-w:50;
                    dash.y=ii*12;
                    dashes.addChild(dash);
                }
            }
            stage.update();
            var top = 24;
            i = i<top?i+1:0;
            gibI = gibI<140?gibI+1:0;
            if(gibI==0) blahblahblah = blahblahblah.substring(blahblahblah.length/2,blahblahblah.length);
        }
    }
    function drawGraph(nooflines,width){            
        linesCont.removeAllChildren();            
        for (var i = 0; i < nooflines; i++) {
            var line = new createjs.Shape();
            var r1=centerline+(i*rifi(-5,5)),
                r2=centerline+(i*rifi(-5,5)),
                r3=centerline+(i*rifi(-5,5)),
                r4=centerline+(i*rifi(-5,5)),
                r5=centerline+(i*rifi(-5,5)),
                r6=centerline+(i*rifi(-5,5)),
                r7=centerline+(i*rifi(-5,5)),
                r8=centerline+(i*rifi(-5,5)),
                r9=centerline+(i*rifi(-5,5)),
                r10=centerline+(i*rifi(-5,5))
            line.graphics.setStrokeStyle(i/nooflines).beginStroke(orangeColor).mt(0,centerline-(i*3))
                .lt(width*0.1,r1)
                .lt(width*0.2,r2)
                .lt(width*0.3,r3)
                .lt(width*0.4,r4)
                .lt(width*0.5,r5)
                .lt(width*0.6,r6)
                .lt(width*0.7,r7)
                .lt(width*0.8,r8)
                .lt(width*0.9,r9)
                .lt(width,r10)
            linesCont.addChild(line);
        }            
        var readings = new createjs.Text(r1.toString()+r2.toString()+r3.toString()+r4.toString()+r5.toString()+r6.toString()+r7.toString()+r8.toString()+r9.toString()+r10.toString(),"10px Arial", hudBorder);
        readings.x = 0;
        readings.y = 50;
        linesCont.addChild(readings);
    }
/*
      /$$$$$$                                       /$$$$$$                        /$$                        
     /$$__  $$                                     /$$__  $$                      | $$                        
    | $$  \__/  /$$$$$$$  /$$$$$$  /$$$$$$$       | $$  \__/  /$$$$$$   /$$$$$$$ /$$$$$$    /$$$$$$   /$$$$$$ 
    |  $$$$$$  /$$_____/ |____  $$| $$__  $$      |  $$$$$$  /$$__  $$ /$$_____/|_  $$_/   /$$__  $$ /$$__  $$
     \____  $$| $$        /$$$$$$$| $$  \ $$       \____  $$| $$$$$$$$| $$        | $$    | $$  \ $$| $$  \__/
     /$$  \ $$| $$       /$$__  $$| $$  | $$       /$$  \ $$| $$_____/| $$        | $$ /$$| $$  | $$| $$      
    |  $$$$$$/|  $$$$$$$|  $$$$$$$| $$  | $$      |  $$$$$$/|  $$$$$$$|  $$$$$$$  |  $$$$/|  $$$$$$/| $$      
     \______/  \_______/ \_______/|__/  |__/       \______/  \_______/ \_______/   \___/   \______/ |__/      
*/
    $scope.scanSector = function(x,y){ 
// Set clicked sector to current sector
        $scope.destinationSector = $scope.sectors[-1];
        $scope.curr_x = x;
        $scope.curr_y = y;
        $scope.setViewX = x;
        $scope.setViewY = y;                
        $scope.selectedSector = $scope.sectors[getIndex(x,y)];
        $scope.selectedSectorId = $scope.selectedSector.Id;
        $scope.selectedSector.RegularContacts = [];
        $scope.selectedSector.ExplorerContacts = [];
        $scope.selectedSector.DestroyerContacts = [];
        $scope.selectedSector.ARCBaseContacts = false;
        $scope.selectedSector.Contacts = [];
        $scope.selectedSector.Races = [];
// Reset Fleet count
        $scope.regular_fleetsSelected = 0;
        $scope.explorer_fleetsSelected = 0;
        $scope.destroyer_fleetsSelected = 0;
// Disable all buttons
        $scope.regular_actionButtonEnabled = false;
        $scope.explorer_actionButtonEnabled = false;
        $scope.destroyer_actionButtonEnabled = false;
        $scope.arcCalcButtonEnabled = false;
        $scope.attackButtonEnabled = false;
        $j('#regularSlider').slider('disable');
        $j('#explorerSlider').slider('disable');
        $j('#destroyerSlider').slider('disable');       
// Update Selected Fleets
        $scope.updateSelectedFleets();
        $scope.showSectorContents = true;
    }
/*
      /$$$$$$      /$$$$$$$       /$$$$$$            /$$$$$$            /$$          
     /$$__  $$    | $$__  $$     /$$__  $$          /$$__  $$          | $$          
    | $$  \ $$    | $$  \ $$    | $$  \__/         | $$  \__/  /$$$$$$ | $$  /$$$$$$$
    | $$$$$$$$    | $$$$$$$/    | $$               | $$       |____  $$| $$ /$$_____/
    | $$__  $$    | $$__  $$    | $$               | $$        /$$$$$$$| $$| $$      
    | $$  | $$    | $$  \ $$    | $$    $$         | $$    $$ /$$__  $$| $$| $$      
    | $$  | $$ /$$| $$  | $$ /$$|  $$$$$$//$$      |  $$$$$$/|  $$$$$$$| $$|  $$$$$$$
    |__/  |__/|__/|__/  |__/|__/ \______/|__/       \______/  \_______/|__/ \_______/
*/
    $scope.arcCalc = function(x,y){
// Set initial coordinate variables
        var selectedCoords          = x+' x '+y;
        $scope.destinationSector    = $scope.sectors[getIndex(x,y)];
        $scope.dest_x               = x;
        $scope.dest_y               = y;		                
// Setup ARC Line and ARC target circle
        $scope.r = 2;
        $scope.x1 = (((($scope.curr_x - $scope.fromX)+1) * ($scope.sector_scale * $scope.sectorSize))-($scope.sector_scale * ($scope.sectorSize/2)));
        $scope.y1 = (((($scope.curr_y - $scope.fromY)+1) * ($scope.sector_scale * $scope.sectorSize))-($scope.sector_scale * ($scope.sectorSize/2)));
        $scope.x2 = (((($scope.dest_x - $scope.fromX)+1) * ($scope.sector_scale * $scope.sectorSize))-($scope.sector_scale * ($scope.sectorSize/2)));
        $scope.y2 = (((($scope.dest_y - $scope.fromY)+1) * ($scope.sector_scale * $scope.sectorSize))-($scope.sector_scale * ($scope.sectorSize/2)));		                
        $scope.tx = $scope.x2 - 15;		                
        if($scope.y1 - $scope.y2 > 0){
            $scope.ty = $scope.y2 - 10;
        }else if($scope.y1 - $scope.y2 < 0){
            $scope.ty = $scope.y2 + 16;
        }else{
            $scope.ty = $scope.y2 - 10;
        }
// Calculate ARC
// get Civilization Level
        var arcPot = 0;
//Get distance
        var a = Math.abs($scope.curr_x-$scope.dest_x);
        var b = Math.abs($scope.curr_y-$scope.dest_y);
        $scope.arc_distance = Math.floor(Math.sqrt((a*a)+(b*b)));
    	var isDarkMatterInPath = darkMatterInPath({
		    x: $scope.curr_x,
		    y: $scope.curr_y
		}, {
		    x: $scope.dest_x,
		    y: $scope.dest_y
		});
		if((is.undefined($scope.VisibleInARCSpace[$scope.destinationSector.X+'x'+$scope.destinationSector.Y]) && !$scope.destinationSector.HasARCBase) || $scope.destinationSector.DarkMatter){
         	arcPot = 0;
        }else{
            if($scope.arc_distance <= $scope.civLvl){
// ARC is guarenteed if distance is equal or less than Civ Level
                if($scope.destinationSector.Terrain != 'Empty') arcPot = 100;
            }else{
//Get GravPot Difference
                var gPotDiff = Math.ceil(Math.abs($scope.selectedSector.ARCPot() - $scope.destinationSector.ARCPot())/2); //2;
// Get slope
                var slope = Math.atan(gPotDiff/$scope.arc_distance);
// Calculate probability of successful ARC:
// slope + beacon star modifier + civilization level + arcbase modifier
                arcPot = Math.ceil(slope*100) + ($scope.destinationSector.BlackHole * 50) + $scope.civLvl + ($scope.destinationSector.ARCPot() * 3);  		                    
// Add 40 for a ARCBase, then take away one point for every sector of distance divided by Civ Lvl
                var sbs = 0;
                if($scope.destinationSector.HasARCBase){
                    arcPot += Math.ceil(((($scope.destinationSector.ARCBasePoints * ($scope.civLvl *5)) + $scope.destinationSector.ARCPot()) - ($scope.arc_distance/$scope.civLvl)));
                    sbs++;
                    if($scope.selectedSector.HasARCBase){
                        arcPot += Math.ceil(((($scope.selectedSector.ARCBasePoints * ($scope.civLvl *5)) + $scope.selectedSector.ARCPot()) - ($scope.arc_distance/$scope.civLvl)));
                        sbs++;
                    }
                }else{
                	if(isDarkMatterInPath) arcPot = 0;
                }
// Commented out until contacts is settled
                /*
                else if($scope.destinationSector.HasContactARCBase()){
                    if($scope.madeContactWith($scope.sectorContactMap[$scope.destinationSector.X+'x'+$scope.destinationSector.Y].Race)){
                        if($scope.relationshipMap[$scope.sectorContactMap[$scope.destinationSector.X+'x'+$scope.destinationSector.Y].Race].ARCFleet__Race_1_Interaction_Description__c == 1 || $scope.relationshipMap[$scope.sectorContactMap[$scope.destinationSector.X+'x'+$scope.destinationSector.Y].Race].ARCFleet__Race_1_Interaction_Description__c == 2 || $scope.relationshipMap[$scope.sectorContactMap[$scope.destinationSector.X+'x'+$scope.destinationSector.Y].Race].ARCFleet__Race_2_Interaction_Description__c == 1 || $scope.relationshipMap[$scope.sectorContactMap[$scope.destinationSector.X+'x'+$scope.destinationSector.Y].Race].ARCFleet__Race_2_Interaction_Description__c == 2){
                            arcPot += Math.ceil(((($scope.sectorContactMap[$scope.destinationSector.X+'x'+$scope.destinationSector.Y].ResourcePoints * ($scope.civLvl *5)) + $scope.destinationSector.BaseGPot) - ($scope.arc_distance/$scope.civLvl)));
                            sbs++;
                        }
                    }
                    if($scope.selectedSector.HasContactARCBase()){
                        if($scope.madeContactWith($scope.sectorContactMap[$scope.selectedSector.X+'x'+$scope.selectedSector.Y].Race)){
                            if($scope.relationshipMap[$scope.sectorContactMap[$scope.selectedSector.X+'x'+$scope.selectedSector.Y].Race].ARCFleet__Race_1_Interaction_Description__c == 1 || $scope.relationshipMap[$scope.sectorContactMap[$scope.selectedSector.X+'x'+$scope.selectedSector.Y].Race].ARCFleet__Race_1_Interaction_Description__c == 2 || $scope.relationshipMap[$scope.sectorContactMap[$scope.selectedSector.X+'x'+$scope.selectedSector.Y].Race].ARCFleet__Race_2_Interaction_Description__c == 1 || $scope.relationshipMap[$scope.sectorContactMap[$scope.selectedSector.X+'x'+$scope.selectedSector.Y].Race].ARCFleet__Race_2_Interaction_Description__c == 2){
                                arcPot += Math.ceil(((($scope.sectorContactMap[$scope.selectedSector.X+'x'+$scope.selectedSector.Y].ResourcePoints * ($scope.civLvl *5)) + $scope.selectedSector.BaseGPot) - ($scope.arc_distance/$scope.civLvl)));
                                sbs++;
                            }
                        }
                    }
                }
                */		                    
                if(sbs == 0) arcPot = Math.ceil(arcPot/2);		                    
// Add the Fleets
// Regulars add 2 points
                arcPot = arcPot + ($scope.regular_fleetsSelected*2);
// Explorers add 4 points
                arcPot = arcPot + ($scope.explorer_fleetsSelected*5);
// Destroyers add 1 point
                arcPot = arcPot + ($scope.destroyer_fleetsSelected);
// Max out at 100
                if(arcPot > 100) arcPot = 100;
// Cannot ARC to Empty space
                if($scope.destinationSector.Terrain == 'Empty') arcPot = 0;                
        	}
// Cannot ARC further than one sector while in the core
        	if($scope.destinationSector.Terrain == 'Core'){
                if(!civlvl.canARC('Core')){
                	arcPot = 0;
                	notification('Unable to ARC','You are unable to ARC in the galactic core at your current civilization level.','yellow');
                }
                if($scope.arc_distance > 1) arcPot = 0;
            }if($scope.destinationSector.Terrain == 'Nucleus'){
                if(!civlvl.canARC('Nucleus')){
                	arcPot = 0;
                	notification('Unable to ARC','You are unable to ARC in the galactic nucleus at your current civilization level.','yellow');
                }
                if($scope.arc_distance > 1) arcPot = 0;
            }
        }		                
// Pass ARC Pot to UI
        $scope.fleet_arcCalc = arcPot;
//Set color of ARC Line and Circle
        var m = 10;
        $scope.color = 'hsl('+120*(($scope.fleet_arcCalc-m)/100)+',100%,50%)';
        $scope.showArc();
    }
/*
	 /$$$$$$$                      /$$             /$$      /$$             /$$     /$$                               /$$$$$$                 /$$$$$$$             /$$     /$$      
	| $$__  $$                    | $$            | $$$    /$$$            | $$    | $$                              |_  $$_/                | $$__  $$           | $$    | $$      
	| $$  \ $$  /$$$$$$   /$$$$$$ | $$   /$$      | $$$$  /$$$$  /$$$$$$  /$$$$$$ /$$$$$$    /$$$$$$   /$$$$$$         | $$   /$$$$$$$       | $$  \ $$ /$$$$$$  /$$$$$$  | $$$$$$$ 
	| $$  | $$ |____  $$ /$$__  $$| $$  /$$/      | $$ $$/$$ $$ |____  $$|_  $$_/|_  $$_/   /$$__  $$ /$$__  $$        | $$  | $$__  $$      | $$$$$$$/|____  $$|_  $$_/  | $$__  $$
	| $$  | $$  /$$$$$$$| $$  \__/| $$$$$$/       | $$  $$$| $$  /$$$$$$$  | $$    | $$    | $$$$$$$$| $$  \__/        | $$  | $$  \ $$      | $$____/  /$$$$$$$  | $$    | $$  \ $$
	| $$  | $$ /$$__  $$| $$      | $$_  $$       | $$\  $ | $$ /$$__  $$  | $$ /$$| $$ /$$| $$_____/| $$              | $$  | $$  | $$      | $$      /$$__  $$  | $$ /$$| $$  | $$
	| $$$$$$$/|  $$$$$$$| $$      | $$ \  $$      | $$ \/  | $$|  $$$$$$$  |  $$$$/|  $$$$/|  $$$$$$$| $$             /$$$$$$| $$  | $$      | $$     |  $$$$$$$  |  $$$$/| $$  | $$
	|_______/  \_______/|__/      |__/  \__/      |__/     |__/ \_______/   \___/   \___/   \_______/|__/            |______/|__/  |__/      |__/      \_______/   \___/  |__/  |__/
	                                                                                                                                                                                
	                                                                                                                                                                                
	                                                                                                                                                                                
*/
    function darkMatterInPath(startPoint, endPoint) {
	    function useVisionLine(start, end) {
	        var y1 = start.x,
	            x1 = start.y,
	            y2 = end.x,
	            x2 = end.y
	        var i; // loop counter 
	        var ystep, xstep; // the step on y and x axis 
	        var error; // the error accumulated during the increment 
	        var errorprev; // *vision the previous value of the error variable 
	        var y = y1,
	            x = x1; // the line povars 
	        var ddy, ddx; // compulsory variables: the double values of dy and dx 
	        var dx = x2 - x1;
	        var dy = y2 - y1;
	        POINT(y1, x1); // first point 
	        // NB the last point can't be here, because of its previous point (which has to be verified) 
	        if (dy < 0) {
	            ystep = -1;
	            dy = -dy;
	        } else ystep = 1;
	        if (dx < 0) {
	            xstep = -1;
	            dx = -dx;
	        } else xstep = 1;
	        ddy = 2 * dy; // work with double values for full precision 
	        ddx = 2 * dx;
	        if (ddx >= ddy) { // first octant (0 <= slope <= 1) 
	            // compulsory initialization (even for errorprev, needed when dx==dy) 
	            errorprev = error = dx; // start in the middle of the square 
	            for (i = 0; i < dx; i++) { // do not use the first point (already done) 
	                x += xstep;
	                error += ddy;
	                if (error > ddx) { // increment y if AFTER the middle ( > ) 
	                    y += ystep;
	                    error -= ddx;
	                }
	                POINT(y, x);
	                errorprev = error;
	            }
	        } else { // the same as above 
	            errorprev = error = dy;
	            for (i = 0; i < dy; i++) {
	                y += ystep;
	                error += ddx;
	                if (error > ddy) {
	                    x += xstep;
	                    error -= ddy;
	                    if (error + errorprev < ddy) POINT(y, x - xstep);
	                    else if (error + errorprev > ddy) POINT(y - ystep, x);
	                    else {
	                        POINT(y, x - xstep);
	                        POINT(y - ystep, x);
	                    }
	                }
	                POINT(y, x);
	                errorprev = error;
	            }
	        }
	    }
	    var arr = []
        function POINT(x, y) {            
            if(is.not.undefined($scope.sectors[getIndex(x,y)])){
                if($scope.sectors[getIndex(x,y)].DarkMatter){			            
    	            arr.push({
    	                x: x,
    	                y: y
    	            });
                }
            }
        }
	    useVisionLine(startPoint, endPoint)
	    return arr.length > 0;
	}
    $scope.updateSelectedFleets = function(){
        if($scope.selectedSector.ActiveRegularCount > 0) $j('#regularSlider').slider('enable');
        if($scope.selectedSector.ActiveExplorerCount > 0) $j('#explorerSlider').slider('enable');
        if($scope.selectedSector.ActiveDestroyerCount > 0) $j('#destroyerSlider').slider('enable');
// Initiate Fleet sliders	
        regSlider.setValue($scope.regular_fleetsSelected).setAttribute('max',$scope.selectedSector.ActiveRegularCount);
        exSlider.setValue($scope.explorer_fleetsSelected).setAttribute('max',$scope.selectedSector.ActiveExplorerCount);
        desSlider.setValue($scope.destroyer_fleetsSelected).setAttribute('max',$scope.selectedSector.ActiveDestroyerCount);
    }
    $scope.getNumber = function(num) {
        return new Array(num);   
    }
    $scope.resizeConsoleLog = function(){
        $scope.consoleLogHeight = $scope.viewHeight - 495;
    }
    $scope.moveView = function(d){
        if(d=='1'){
            $scope.setView($scope.setViewX-5,$scope.setViewY,d);
        }
        if(d=='2'){
            $scope.setView($scope.setViewX,$scope.setViewY-5,d);
        }
        if(d=='3'){
            $scope.setView($scope.setViewX,$scope.setViewY+5,d);
        }
        if(d=='4'){
            $scope.setView($scope.setViewX+5,$scope.setViewY,d);
        }
    }
    $scope.setView = function(x,y,d){
        if(d == null) d = 4;
        $scope.ARCFleetSFX('X'+d); 
        $scope.setViewX = x; 
        $scope.setViewY = y;
        $scope.renderChunk();
    }
    $scope.regularFleetBuildDisabled = function(){
        if($scope.selectedSector.HasARCBase == null){
        	return true;
        }else{
        	return ($scope.selectedSector.ARCBasePoints < $scope.regularCost || $scope.availableResourcePoints() < $scope.regularCost) || ($scope.selectedSector.Terrain != 'Axis' && $scope.selectedSector.Terrain != 'Fringe' && $scope.selectedSector.Terrain != 'Interspiral');
        }
    }
    $scope.explorerFleetBuildDisabled = function(){
        if($scope.selectedSector.HasARCBase == null){
        	return true;
        }else{
        	return ($scope.selectedSector.ARCBasePoints < $scope.explorerCost || $scope.availableResourcePoints() < $scope.explorerCost) || ($scope.selectedSector.Terrain != 'Axis');
        }
    }
    $scope.destroyerFleetBuildDisabled = function(){
        if($scope.selectedSector.HasARCBase == null){
        	return true;
        }else{
        	return ($scope.selectedSector.ARCBasePoints < $scope.destroyerCost || $scope.availableResourcePoints() < $scope.destroyerCost) || ($scope.selectedSector.Terrain != 'Axis' && $scope.selectedSector.Terrain != 'Fringe');
        }
    }
    $scope.performFleetAction = function(){
        if($scope.regular_actionButtonEnabled){
            $scope.augment('regular','arcbase');
        }else if($scope.explorer_actionButtonEnabled){
            $scope.exploreSector();
        }else if($scope.destroyer_actionButtonEnabled){
        	$scope.siege();
        }
    }
    $scope.performARCorCalc = function(){
        if(!$scope.showArcCalcContents){
            $scope.arcCalcMode();
        }else{
            $scope.arc();
        }
    }
    $scope.selectAllRegulars = function(){
    	regSlider.setValue($scope.selectedSector.ActiveRegularCount);
    	$scope.regular_fleetsSelected = $scope.selectedSector.ActiveRegularCount;
        $scope.sliderStop();
    }
    $scope.selectAllExplorers = function(){
    	exSlider.setValue($scope.selectedSector.ActiveExplorerCount);
        $scope.explorer_fleetsSelected = $scope.selectedSector.ActiveExplorerCount;
        $scope.sliderStop();
    }
    $scope.selectAllDestroyers = function(){
    	desSlider.setValue($scope.selectedSector.ActiveDestroyerCount);
        $scope.destroyer_fleetsSelected = $scope.selectedSector.ActiveDestroyerCount;
        $scope.sliderStop();
    }
    $scope.selectAll = function(){
    	$scope.selectAllRegulars();
    	$scope.selectAllExplorers();
    	$scope.selectAllDestroyers();
    }
    $scope.madeContactWith = function(alienId){                
        var contactHasBeenMade = false;
        contactHasBeenMade = relationships[alienId] > 0; //$scope.relationshipMap[raceId] != null;
        // console.log('madeContactWith('+alienId+')');
        // console.log(contactHasBeenMade);
        return contactHasBeenMade;
    }
/*
     /$$      /$$           /$$                        /$$$$$$                        /$$                           /$$    
    | $$$    /$$$          | $$                       /$$__  $$                      | $$                          | $$    
    | $$$$  /$$$$  /$$$$$$ | $$   /$$  /$$$$$$       | $$  \__/  /$$$$$$  /$$$$$$$  /$$$$$$    /$$$$$$   /$$$$$$$ /$$$$$$  
    | $$ $$/$$ $$ |____  $$| $$  /$$/ /$$__  $$      | $$       /$$__  $$| $$__  $$|_  $$_/   |____  $$ /$$_____/|_  $$_/  
    | $$  $$$| $$  /$$$$$$$| $$$$$$/ | $$$$$$$$      | $$      | $$  \ $$| $$  \ $$  | $$      /$$$$$$$| $$        | $$    
    | $$\  $ | $$ /$$__  $$| $$_  $$ | $$_____/      | $$    $$| $$  | $$| $$  | $$  | $$ /$$ /$$__  $$| $$        | $$ /$$
    | $$ \/  | $$|  $$$$$$$| $$ \  $$|  $$$$$$$      |  $$$$$$/|  $$$$$$/| $$  | $$  |  $$$$/|  $$$$$$$|  $$$$$$$  |  $$$$/
    |__/     |__/ \_______/|__/  \__/ \_______/       \______/  \______/ |__/  |__/   \___/   \_______/ \_______/   \___/  
*/
    $scope.parseRelationship = function(relDesc){
        //Them: Friendly
        //You: Friendly
        if(relDesc == 7) return {title: 'Peace and Security!',contactSuceedMessage: 'You have forged a mutual alliance with an alien civilization', contactFailMessage: ''}
        //You: Neutral
        if(relDesc == 8) return {title: 'Take Advantage',contactSuceedMessage: 'The civilization you\'ve encountered is eager to please. They have offered you use of their ARC Bases despite the fact that you have witheld yours from them.', contactFailMessage: ''}
        //You: Hostile
        if(relDesc == 9) return {title: 'Pacifist Dogs!',contactSuceedMessage: 'This new civilization sent hippies to your parley! You will make easy work of these spineless prey.', contactFailMessage: ''}
        
        //Them: Neutral
        //You: Friendly
        if(relDesc == 14) return {title: 'Could Be Worse',contactSuceedMessage: 'It looks like this civilization is not very forthcoming. They refuse to let you use their ARC Bases, but in the hope that they will come around, you will allow them to use yours.', contactFailMessage: ''}
        //You: Neutral
        if(relDesc == 16) return {title: 'No Harm No Foul',contactSuceedMessage: 'The civilization you have encountered is as xenophobic as you and you have both decided to just ignore one another.', contactFailMessage: ''}
        //You: Hostile
        if(relDesc == 18) return {title: 'Cautious Prey!',contactSuceedMessage: 'Your adversary is not the trusting fools you thought they were. They suspected something and pulled back. Your sneak attack will not be as effective.', contactFailMessage: ''}
        
        //Them: Hostile
        //You: Friendly
        if(relDesc == 21) return {title: 'Sneak Attack!',contactSuceedMessage: 'Whoops! The alien civilization you encountered turned out to be a rude bunch. They ignored your peace offering and used the opportunity to launch an attack!', contactFailMessage: ''}
        //You: Neutral
        if(relDesc == 24) return {title: 'Invasion!',contactSuceedMessage: 'Despite your guarded approach, this aggresive civilization you\'ve discovered has caught you off guard and attacked.', contactFailMessage: ''}
        //You: Hostile
        if(relDesc == 27) return {title: 'WAR!',contactSuceedMessage: 'This new enemy is a worthy opponent! They throw themselves into the dance of death as willingly as your own peoples. You will bathe the galaxy in their ichor!', contactFailMessage: ''}
    }
    $scope.makeContact = function(fp){		                
        var alienId = $scope.selectedSector.X+'x'+$scope.selectedSector.Y;
        var alienMood = $scope.selectedSector.AlienMood;
        var relationshipCode = fp*alienMood;
        $scope.foreignPolicy = fp;
        console.log('Making contact with : '+alienId+' with mood: '+alienMood+' for relationship of: '+relationshipCode);
        console.log($scope.parseRelationship(relationshipCode).title+' - '+$scope.parseRelationship(relationshipCode).contactSuceedMessage)
        relationships[alienId] = relationshipCode;
        console.log(relationships);
        console.log(JSON.stringify(relationships));
        $scope.save();
        $scope.contactResults = $scope.parseRelationship(relationshipCode);
        //$j('#contactModal').modal('hide');
        /*
        var raceId = $scope.selectedSector.Contacts[0].Race;
        var relationship = {
            Race1 : '!race.Id}',
            Race2 : raceId,
            Race1Mood: fp,
            Race2Mood: $scope.selectedSector.Contacts[0].RaceMood
        }
        if($scope.relationshipMap[raceId] == null){
            // Attempt Contact
            RelationshipService.create(relationship).then(
                function(result){
                    RelationshipService.retrieveById(result.id).then(
                        function(newRel){
                            $scope.relationshipMap[raceId] = newRel.records[0];
                            $scope.contactModalTitle = $scope.parseRelationship($scope.relationshipMap[raceId].ARCFleet__Race_1_Interaction_Results__c).title;
                            $scope.contactModalBody = $scope.parseRelationship($scope.relationshipMap[raceId].ARCFleet__Race_1_Interaction_Results__c).contactSuceedMessage;
                            $j('#contactModal').modal();
                        },
                        function(newRelError){
                            console.log(newRelError);
                        }
                    );
                },
                function(e){
                    console.log(e.message);
                }
            );
        }else{
            relationship.Id = $scope.relationshipMap[raceId].Id;
            RelationshipService.update(relationship).then(
                function(updateResult){
                    RelationshipService.retrieveById(relationship.Id).then(
                        function(updatedRel){
                            $scope.relationshipMap[raceId] = updatedRel.records[0]; //.ARCFleet__Race_1_Interaction_Results__c;
                            $scope.contactModalTitle = $scope.parseRelationship($scope.relationshipMap[raceId].ARCFleet__Race_1_Interaction_Results__c).title;
                            $scope.contactModalBody = $scope.parseRelationship($scope.relationshipMap[raceId].ARCFleet__Race_1_Interaction_Results__c).contactSuceedMessage;
                            $j('#contactModal').modal();
                        },
                        function(updatedRelError){
                            console.log(updatedRelError);
                        }
                    );
                },
                function(e){
                    console.log(e.message);
                }
            );
        } 
        */  
    }
/*
  /$$$$$$  /$$ /$$                           /$$$$$$$  /$$           /$$
 /$$__  $$| $$|__/                          | $$__  $$|__/          | $$
| $$  \ $$| $$ /$$  /$$$$$$  /$$$$$$$       | $$  \ $$ /$$  /$$$$$$ | $$  /$$$$$$   /$$$$$$
| $$$$$$$$| $$| $$ /$$__  $$| $$__  $$      | $$  | $$| $$ |____  $$| $$ /$$__  $$ /$$__  $$
| $$__  $$| $$| $$| $$$$$$$$| $$  \ $$      | $$  | $$| $$  /$$$$$$$| $$| $$  \ $$| $$  \ $$
| $$  | $$| $$| $$| $$_____/| $$  | $$      | $$  | $$| $$ /$$__  $$| $$| $$  | $$| $$  | $$
| $$  | $$| $$| $$|  $$$$$$$| $$  | $$      | $$$$$$$/| $$|  $$$$$$$| $$|  $$$$$$/|  $$$$$$$
|__/  |__/|__/|__/ \_______/|__/  |__/      |_______/ |__/ \_______/|__/ \______/  \____  $$
                                                                                   /$$  \ $$
                                                                                  |  $$$$$$/
                                                                                   \______/
*/
    function capitalizeFirstLetter(string) {
        return string.charAt(0).toUpperCase() + string.slice(1);
    }
    function cap(string){
        return capitalizeFirstLetter(string)
    }
    var you = {
        friendly:['you', 'your ambasadors', 'your peace envoys','your explorers','the ambasadors you sent','your cultural attachés'],
        neutral:['you','your diplomats','your diplomat corps','your investigators','the scientists you sent','the diplomats you dispatched'],
        hostile:['you','your warriors','your recon personel','your spies','your explorer fleets','your armies','your espionage teams']
    };
    var actions = ['were able to learn','discovered','gleaned','recieved','learned','were able to discover','amassed','uncovered','pieced together','gathered','collected']
    var yourMoods = ['0','1','2','3','4','5','6','friendly','neutral','hostile'];
    var alienMoods = ['0','friendly','neutral','hostile'];
    var moods = {
        friendly:['friendly','pacifist','affable','amiable','amicable','attentive','cordial','helpful','neighborly','receptive','peaceful','sympathetic','welcoming','kind','sociable','benign','benevolent','genial','solicitous','consilliatory','convivial','civil'],
        neutral:['neutral','evenhanded','fair-minded','indifferent','aloof','clinical','stoic','detached','dispassionate','impersonal','easy-going','antisocial'],
        hostile:['hostile','beligerent','antagonistic','warlike','aggressive','contentious','bitter','hateful','inhospitable','inimical','nasty','unfriendly','militant','bellicose','dour','malevolent','malicious','malignant','ornery','pugnacious','rancorous','spiteful','vitriolic','viperous','combatative']
    }
    var amount = {
        full:['all the','an exhaustive amount of','reams of','petabytes of',''],
        lot:['a lot of','a tidal wave of','a ton of','a flood of','gobbs of','a copious amount of'],
        little:['appallingly little','little','very little','barely any','a good bit of','some'],
        none:['no','absolutely no']
    }
    var disclosure = {
        friendly:['0','full','lot','none'],
        neutral:['0','lot','little','little'],
        hostile:['0','little','none','lot']
    }
    var data = ['data','information','intel','intelligence','answers'];
    var civilizationDelta = [
        ['much less advanced','not very advanced','backward','unadvanced','primitive','neophyte','weak'],
        ['less advanced','developing','younger','adolecent','weaker'],
        ['equally advanced','','contemporary','advanced','progressive'],
        ['more advanced','superior','impressive','older','powerful','more progressive'],
        ['much more advanced','magical','much superior','godlike','ancient','super powerful']
    ]
    var subjects = {
        themselves:['their culture','their species','their civilization','their race','their government','themselves'],
        others:['other races','the other civilizations in this area','other civilizations','other spacefaring civilizations','other ARC Users'],
        past:['the past','the history of this area','the ancient past','the history of this part of the galaxy','the history of the galaxy'],
        gwaves:['G-Waves','the gravity waves','gravity waves'],
        blackholes:['black holes','wormholes','the black holes','collapsed stars'],
        core:['the core','the galactic core','the nucleus','the galactic nucleus','the center of the galaxy','the center','the core of the galaxy','the nucleus of the galaxy'],
        timeworn:['the Timeworn','the extinct race that once ruled the galaxy','the old lords of the galaxy','the ancient race','the Timeworn race','the Timeworn civilization','what happened to the Timeworn'],
        darkmatter:['dark matter','what dark matter is','what to do about dark matter','how to ARC through dark matter'],
        anomoly:['the anomoly','what the anomoly is','what they know about the anomoly','what the anomoly does']

    }
    var subs = Object.keys(subjects);
    $scope.askAbout = function(subject){            
        $scope.talkedToAliens = true;
        var dCiv = ($scope.selectedSector.AlienCivLvl-$scope.civLvl)+2;
        var relCode = 'rel'+$scope.foreignPolicy*$scope.selectedSector.AlienMood;
        var cv = 'civLvl'+$scope.civLvl;
        var yourMood = yourMoods[$scope.foreignPolicy];
        console.log('Delta Civ: '+dCiv);
        console.log('Relationship Code: '+relCode)
        console.log('cv: '+cv)
        console.log('subject: '+subject)
        console.log('yourMood: '+yourMood)
        var youVal = rae(you[yourMood]),
            actionVal = rae(actions),
            amountVal = rae(amount[disclosure[yourMood][$scope.selectedSector.AlienMood]]),
            dataVal = rae(data),
            deltaCivVal = rae(civilizationDelta[dCiv]),
            moodVal = rae(moods[alienMoods[$scope.selectedSector.AlienMood]]),
            subjectVal = rae(subjects[subject])
        console.log(youVal)
        console.log(actionVal)
        console.log(amountVal)
        console.log(dataVal)
        console.log(deltaCivVal)
        console.log(moodVal)
        console.log(subjectVal)
        $scope.alienChatText = cap(youVal+' '+actionVal+' '+amountVal+' '+dataVal+' from this '+deltaCivVal+', yet '+moodVal+', civilization about '+subjectVal)+'.'; //subjects[subject][dCiv][relCode])
    }
    $scope.showContactARCBase = function(x,y){
// Commented out until contacts is settled
		/*
        if($scope.sectorMap[x+'x'+y].HasContactARCBase()){
            return true;
            // if($scope.relationshipMap[$scope.sectorContactMap[x+'x'+y].Race] != null){
            //     if($scope.relationshipMap[$scope.sectorContactMap[x+'x'+y].Race].ARCFleet__Race_1_Interaction_Results__c == 1){
            //         return true;
            //     }else if($scope.relationshipMap[$scope.sectorContactMap[x+'x'+y].Race].ARCFleet__Race_1_Interaction_Results__c == 2){
            //         return true;
            //     }else if($scope.sectorMap[x+'x'+y].Explored){
            //         if($scope.relationshipMap[$scope.sectorContactMap[x+'x'+y].Race].ARCFleet__Race_1_Interaction_Results__c == 5) return true;
            //         if($scope.relationshipMap[$scope.sectorContactMap[x+'x'+y].Race].ARCFleet__Race_1_Interaction_Results__c == 6) return true;
            //         if($scope.relationshipMap[$scope.sectorContactMap[x+'x'+y].Race].ARCFleet__Race_1_Interaction_Results__c == 9) return true;
            //     }else{
            //         return false;
            //     }
            // }
        }else{
            return false;
        }
        */
       return false;
    }
    $scope.sectorContactInfoDisplayMatrix = function(){
    	var e = 1;
    	if(!$scope.selectedSector.Explored) e = 2;
    	var c = 3;
// Commented out until contacts is settled
    	//if( is.not.undefined($scope.sectorContactMap[$scope.selectedSector.X+'x'+$scope.selectedSector.Y]) ){
        //	if(!$scope.madeContactWith($scope.sectorContactMap[$scope.selectedSector.X+'x'+$scope.selectedSector.Y].Race)) c = 4;
        //}
    	var res = e*c;
    	return e*c;
    }
/*
	 /$$$$$$$$                           
	|__  $$__/                           
	   | $$  /$$$$$$  /$$   /$$  /$$$$$$ 
	   | $$ /$$__  $$| $$  | $$ /$$__  $$
	   | $$| $$  \ $$| $$  | $$| $$  \__/
	   | $$| $$  | $$| $$  | $$| $$      
	   | $$|  $$$$$$/|  $$$$$$/| $$      
	   |__/ \______/  \______/ |__/     
*/
    $scope.startTour = function (){
        var tour = new Tour({
            steps: [
                {
                    orphan: true,
                    title: "Welcome to ARC Fleet",
                    content: "This is a quick guided tour of the ARC Fleet UI. Use the Next and Previous buttons or your keyboard arrow keys to navigate through the tour. You may end the tour at any time. To take the tour again, well, since you're reading this I trust you know how to find it again.",
                    backdrop: true
                },
                {
                    element: "#mapFilterButton",
                    title: "Map Filters",
                    content: "<ul><li>ARC</li><li>Explore</li><li>Black Holes</li></ul>",
                    placement: "bottom",
                    onNext: function(){
                    	$scope.showInspector('Info');
                    	$scope.$apply();
                    }
                },
                {
                    element: "#InfoTab",
                    title: "General Info",
                    content: 'This is a running collection of information pertaining to events for a turn.',
                    placement: "left",
                    onNext: function(){
                    	$scope.showInspector('ForeignPolicy');
                    	$scope.$apply();
                    }
                },
                {
                    element: "#ForeignPolicyTab",
                    title: "Foreign Policy",
                    content: 'Use this section to set default foreign policy and to inspect or change relations with specific alien civilizations.',
                    placement: "bottom",
                    onNext: function(){
                    	$scope.showInspector('CivLevel');
                    	$scope.$apply();
                    }
                },
                {
                    element: "#CivLevelTab",
                    title: "Civilization Level",
                    content: 'In depth overview of your civilization\'s statistics.',
                    placement: "bottom",
                    onNext: function(){
                    	$scope.showInspector('Regular');
                    	$scope.$apply();
                    }
                },
                {
                    element: "#RegularsTab",
                    title: "Regular Fleets",
                    content: 'A list of all your Regular fleets. Click the magnifying glass to go to the sector containing this fleet. Click the red delete button to decommision this fleet.',
                    placement: "bottom",
                    onNext: function(){
                    	$scope.showInspector('Explorer');
                    	$scope.$apply();
                    }
                },
                {
                    element: "#ExplorersTab",
                    title: "Explorer Fleets",
                    content: 'A list of all your Explorer fleets. Click the magnifying glass to go to the sector containing this fleet. Click the red delete button to decommision this fleet.',
                    placement: "bottom",
                    onNext: function(){
                    	$scope.showInspector('Destroyer');
                    	$scope.$apply();
                    }
                },
                {
                    element: "#DestroyersTab",
                    title: "Destroyer Fleets",
                    content: 'A list of all your Destroyer fleets. Click the magnifying glass to go to the sector containing this fleet. Click the red delete button to decommision this fleet.',
                    placement: "bottom",
                    onNext: function(){
                    	$scope.showInspector('ARCBase');
                    	$scope.$apply();
                    }
                },
                {
                    element: "#ARCBasesTab",
                    title: "ARC Bases",
                    content: 'A list of all your ARC Basess. Click the magnifying glass to go to the sector containing this fleet. The RP column shows actual Resource points/potential resource points. Click the red delete button to decommision this fleet.',
                    placement: "bottom",
                    onNext: function(){
                    	$scope.showInspectorPanel = false;
                    	$scope.$apply();
                    }
                },
                {
                    orphan: true,
                    title: "Game Map",
                    content: "This is a 100x100 grid map of the galaxy. Each sector represents 1000x1000x1000 lightyears of space.",
                    backdrop: false
                }
            ]
        });
// Initialize the tour
        tour.init();
// Start the tour
        tour.restart();
    }
    $scope.scannerMode();
    $scope.selectSector($scope.setViewX, $scope.setViewY);
    $scope.renderChunk();
    $scope.finishLoad = true;
    var gamePromise;
    $scope.gameIsPaused = true;
    $scope.pausePlayGame = function(){
    	if($scope.gameIsPaused){
    		gamePromise = $interval(function(){
		    	$scope.endTurn();
		    },1000);
	    	$scope.gameIsPaused = false;
    	}else{
    		$scope.gameIsPaused = $interval.cancel(gamePromise);
    		gamePromise = undefined;
    	}
    }
    $scope.playGame = function(){
    	gamePromise = $interval(function(){
	    	$scope.endTurn();
	    },1000);
	    $scope.gameIsPaused = false;
    }
    $scope.pauseGame = function(){
    	$scope.gameIsPaused = $interval.cancel(gamePromise);
    	gamePromise = undefined;
    }
}]);