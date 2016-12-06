
function sector(){
    this.id = '';
    this.name = '';
    this.x = 0;
    this.y = 0;
    this.terrain = '';
    this.beaconName = '';
    this.beacon = 0;
    this.rPot = 0;
    this.gPot = 0;
    this.starbase = function(sbGpot){
        this.gPot = this.gPot + sbGpot;
    };
}

function construct(){
    var me = this;
    me.id = '';
    me.sectorId = '';
    me.x = 0;
    me.y = 0;
    me.gPot = 0;
    me.current =  sector;
    me.type = '';
    me.icon = '';
    me.class = 'regular';
}
construct.prototype.setCurrent =  function(c){
    this.current = c;
    this.sectorId = c.id;
    this.x = c.x;
    this.y = c.y;
    this.gPot = c.gPot;
};
construct.prototype.createMarkup =  function(){
    var markup = '<span class="fa-stack fa-lg '+this.type+' '+this.class+' object" id="'+this.id+'" ><i class="'+this.icon+'"></i></span>';
    $j('.map').prepend(markup);
    
};
construct.prototype.place = function(did){
    var ui = $j('#'+this.id);
    console.log('Place: this.current.id: '+did);
    var d = $j('#'+did);
    d.append(ui);
};
construct.prototype.build =  function(c,t){
    var me = this;
    var ctDetails = {class: c, type: t, sector: me.sectorId, game: '{!g.id}'};
    var newConstruct = new RemoteObjectModel.Construct();
    newConstruct.create(ctDetails, function(err){
        if(err){
            statusVM.statusColor('red').statusMessage(err);
            console.log(err);
        }else{
            if(t=='fleet'){
                console.log('Building new Fleet');
                var newFleet = new fleet(newConstruct.get('Id'),c,me.sectorId);
                newFleet.createMarkup();
                newFleet.place(me.sectorId);
                $j('#'+me.sectorId).trigger('click');
            }else{
                console.log('Building new Fleet');
                var newStarbase = new starbase(newConstruct.get('Id'),c,me.sectorId);
                newStarbase.createMarkup();
                newStarbase.place(me.sectorId);
                $j('#'+me.sectorId).trigger('click');
            }
            
        }
    });
    sectorFunction = 'getInfo';
};


function starbase(id,c,sid){
    var me = this;
    construct.call(me);
    me.id = id;
    me.sectorId = sid;
    me.type = 'starbase';
    me.class = c;
    me.icon = '{!starbaseLargeIcon}';
}
starbase.prototype = new construct();
starbase.prototype.constructor = starbase;

function fleet(id,c,sid,x,y){
    var me = this;
    construct.call(me);
    me.id = id;
    me.type ='fleet';
    me.class = c;
    me.sectorId = sid;
    me.x = x;
    me.y = y;
    me.destinationId = '';
    me.destX = 0;
    me.destY = 0;
    me.icon ='{!fleetLargeIcon}';
    me.destination = sector;
    me.arcLimit =1;
    me.exploreLimit =1;
    me.distance = 0;
    me.gPotDiff = 0;
    me.arcPot = 0;
}
fleet.prototype = new construct();
fleet.prototype.constructor = fleet;
fleet.prototype.arcCalc = function(){
    // get Civilization Level
    var civLvl = 0;

    //Get distance
    var a = Math.abs(this.x-this.destination.x);
    var b = Math.abs(this.y-this.destination.y);
    this.distance = Math.floor(Math.sqrt((a*a)+(b*b)));

    //Get GravPot Difference
    //this.gPotDiff = this.destination.gPot-this.gPot;
    this.gPotDiff = 2; // + this.destination.gPot;

    // Get slope
    var slope = Math.atan(this.gPotDiff/this.distance);

    // Calculate probability of successful ARC:
    // slope + beacon star modifier + civilization level + starbase modifier
    this.arcPot = Math.ceil(slope*100) + (this.destination.beacon * 3) + civLvl + (this.destination.gPot * 3);
    //this.showDetails();
    
    return this.arcPot;
};
fleet.prototype.setDestination = function(d){
    this.destination = d; 
};
fleet.prototype.arc = function(arcPot,arcRoll){
    console.log('Prepping A.R.C. engines...');
    statusVM.statusColor('light').statusMessage('Prepping A.R.C. Engines...');
    var fid = this.id;
    var cid = this.current.id;
    var did = this.destination.id;
    var fleetUI = $j('#'+fid);
    var flt = this;
    if(this.arcLimit > 0){
        var scattered = false;
        console.log('arcRoll: '+arcRoll);
        console.log('arcPot: '+arcPot);
        var me = this;    
        if(arcRoll < 9000){
            //this is not an attack
            var scatterDistance = 0;
            var scatterDirection = 0;
            
            arcSuccessSFX.play();
            // Enter Hyperspace
            console.log('Entering Hyperspace');
            statusVM.statusColor('light').statusMessage('Attempting Asynchronous Radial Collapse...');
            fleetUI.delay(500).fadeOut(500,function(){
                
                if(arcRoll > arcPot){
                    // determine scatter distance
                    if(arcRoll < 30){
                        //miss the target by half the distance arced
                        scatterDistance = 2; //me.distance-5;
                    }else if(arcRoll < 60){
                        // miss the target by the distance arced
                        scatterDistance = 3; //me.distance;
                    }else{
                        // miss the target by twice the distance arced
                        scatterDistance = 4; //me.distance+5;
                    }
                    console.log('Oh No! The Fleet has been scattered!');
                    scattered = true;
                    console.log('Scatter Distance: '+scatterDistance);
                    // determin scatter scatterDirection
                    scatterDirection = randomIntFromInterval(1,4);
                    console.log('Scatter Direction: '+scatterDirection);
                    var scatterCoord = '';
                    var scatterX;
                    var scatterY;
                    if(scatterDirection == 1){
                        scatterX = me.destination.x;
                        scatterY = (parseInt(me.destination.y) - parseInt(scatterDistance));
                    }else if(scatterDirection == 2){
                        scatterX = (parseInt(me.destination.x) + parseInt(scatterDistance));
                        scatterY = me.destination.y;
                    }else if(scatterDirection == 3){
                        scatterX = me.destination.x;
                        scatterY = (parseInt(me.destination.y) + parseInt(scatterDistance));
                    }else if(scatterDirection == 4){
                        scatterX = (parseInt(me.destination.x) - parseInt(scatterDistance));
                        scatterY = me.destination.y;
                    }
                    console.log('scatterX: '+scatterX);
                    console.log('scatterY: '+scatterY);
                    if(scatterX < 1) scatterX = 1;
                    if(scatterY < 1) scatterY = 1;
                    if(scatterX > 20) scatterX = 20;
                    if(scatterY > 20) scatterY = 20;
                    scatterCoord = scatterX+'x'+scatterY;
                    console.log('Scatter Coordinates: '+scatterCoord);
                    did = sectorMap[scatterCoord].Id;

                    console.log('Scatter Sector: '+sectorMap[scatterCoord].Id);
                }
                console.log('fid: '+fid);
                console.log('did: '+did);
                // Move Fleet
                var roConstruct = new RemoteObjectModel.Construct();
                roConstruct.update(
                    [fid],
                    {sector:did},
                    function(err, ids){
                        if (err) {
                            statusVM.statusColor('red').statusMessage(err);
                            console.log(err);
                        }else{
                            flt.place(did);
                        }
                    }
                );
                me.arcLimit = me.arcLimit - 1;
                me.setCurrent(me.destination);
            });
            // Exit Hyperspace
            
            fleetUI.fadeIn(500,function(){
                console.log('Exiting Hyperspace');
                if(scattered){
                    statusVM.statusColor('yellow').statusMessage('Oh No! The Fleet has been scattered!');
                }else{
                    statusVM.statusColor('green').statusMessage('Asynchronous Radial Collapse has succeeded!');
                }
                $j('#'+did).trigger('click');
                mapVM.showArcLine(false);
            });
        }else{
            //Attack
            window.setTimeout(function () {
                arcFailSFX.play();
                var roConstruct = new RemoteObjectModel.Construct();
                roConstruct.del(fid);
                statusVM.statusColor('red').statusMessage('Target Fleet has been sent to Space-Davey Jones\' Locker!');
                fleetUI.addClass('animated bounceOut');  
            
                //fleetUI.remove(); 
                $j("#constructList #"+fid).remove();
                $j('.constructButtons').hide();
            }, 2000);
        }
    }else{
        statusVM.statusColor('yellow').statusMessage('A.R.C. engines depleted, this fleet cannot arc this turn.');
        fleetUI.addClass('animated rubberBand');
    }  
    sectorFunction = 'getInfo'; 
};
fleet.prototype.explore = function(){
    var cid = thisFleet.current.id;
    console.log('Beginning Sensor Sweep...');
    if(this.class == 'explorer'){
        if(this.exploreLimit > 0){
            statusVM.statusColor('light').statusMessage('Exploring...');
            var exploreResults = randomIntFromInterval(0,10);
            sectorInfoVM.showResourcePoints(true);
            var roSector = new RemoteObjectModel.Sector();
            roSector.update(
                [cid],
                {rPot:exploreResults},
                function(err,ids){
                    if(err){
                        statusVM.statusColor('red').statusMessage(err);
                    }else{
                        $j('#resourcePointsFor_'+cid).text(exploreResults);
                        $j('#resourceFilterFor_'+cid).addClass('resource-'+exploreResults);
                        statusVM.statusColor('light').statusMessage('Discovered '+exploreResults+' Resource Points.');
                        console.log('Explore results: '+exploreResults);
                    }
                }
            );
            this.exploreLimit = this.exploreLimit-1;
        }else{
            statusVM.statusColor('yellow').statusMessage('This fleet has explored enough for this turn. They\'re tired.');
            fleetUI.addClass('animated rubberBand');
        }
    }else{
        statusVM.statusColor('red').statusMessage('This is not an explorer fleet.');
    }
    sectorFunction = 'getInfo';
};
fleet.prototype.attack = function(){
    console.log('ATTACK!');
    sectorFunction = 'attack';
};
fleet.prototype.augment = function(c,t){
    console.log('Augment');
    this.build(c,t);

    sectorFunction = 'getInfo';
};

