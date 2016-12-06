trigger CopySectors on Game__c (before insert) {
    list<Game_Sector__c> gameSectors = new list<Game_Sector__c>();
    list<string> mapIds = new list<string>();
    map<string,list<Sector__c>> mapSectorsMap = new map<string,list<Sector__c>>();
    map<integer,Alien_Civilization__c> alienMap = new map<integer,Alien_Civilization__c>();
    map<string, Game_Sector__c> gameSectorMap = new map<string, Game_Sector__c>();
    map<string, Sector__c> sectorMap = new map<string, Sector__c>();
    list<game__c> games = new list<Game__c>();
    for(Game__c newGame : trigger.new){
        mapIds.add(newGame.Map__c);
    }
    for(Sector__c s : [SELECT Id, Map__c, Terrain__c, X__c, Y__c, Home_Sector__c, Beacon_Star__c, Beacon_Star_Name__c, Order__c, Base_Gpot__c, Base_RPot__c, Dark_Matter__c FROM Sector__c WHERE Map__c IN: mapIds ORDER BY Order__c]){
        if(mapSectorsMap.get(s.Map__c) != null){
            mapSectorsMap.get(s.Map__c).add(s);
        }else{
            list<Sector__c> mapSectorList = new list<Sector__c>();
            mapSectorList.add(s);
            mapSectorsMap.put(s.Map__c,mapSectorList);
        }
    }
    integer aci = 0;
    for(Alien_Civilization__c ac:[SELECT Id, Name, Civilization_Name__c, Civilization_Level__c, Mood__c, ARCBase_Sector_Count__c, ARCFleet_Sector_Count__c, Defense_Factor__c, Destroyer_Sector_Count__c, Explorer_Sector_Count__c, Regular_Sector_Count__c FROM Alien_Civilization__c]){
        aci++;
        alienmap.put(aci,ac);
    }
    for(Game__c g : trigger.new){
        list<Game_Sector__c> alienhomesectors = new list<Game_Sector__c>();
        integer i = 0;
        integer randomIndex = randomIntFromInterval(1,10);
        integer order = 0;
        for(Sector__c s : mapSectorsMap.get(g.Map__c)){
            Boolean IsHomeSector = false;
            Decimal rv = 0;
            Decimal hab = 0;
            Decimal abp = 0;
            Decimal aReg = 0;
            Decimal aEx = 0;
            order++;
            integer terrain = 0;
            Decimal blackhole = 0;
            Decimal gpot = 0;
            Boolean darkMatter = (s.Dark_Matter__c || (gpot == 0 && terrain < 4)) && terrain != 0;
            //if(String.IsNotBlank(s.Terrain__c)) terrain = s.Terrain__c;
            if(s.Terrain__c == 'Empty') terrain = 0;
            if(s.Terrain__c == 'Interspiral') terrain = 1;
            if(s.Terrain__c == 'Fringe') terrain = 2;
            if(s.Terrain__c == 'Axis') terrain = 3;
            if(s.Terrain__c == 'Nucleus') terrain = 4;
            if(s.Terrain__c == 'Core') terrain = 5;
            if(s.Home_Sector__c && !IsHomeSector){
                if(i == randomIndex){
                    g.Start_X__c = s.X__c;
                    g.Start_Y__c = s.Y__c;
                    IsHomeSector = true;
                    rv = 10;
                    hab = 1;
                    abp = 10;
                    aReg = 2;
                    aEx = 1;
                }
                i++;
            } 
            if(s.Beacon_Star__c != null){
                if(s.Beacon_Star__c > 0){
                    blackHole = s.Beacon_Star__c;
                }
            }
            if(terrain == 3){
                gpot = Math.min(10,Math.max(6,s.Base_GPot__c + 3));
            }
            if(terrain == 2){
                gpot = Math.min(7,Math.max(3,s.Base_GPot__c));
            }
            if(terrain == 1){
                gpot = Math.min(4,Math.max(0,s.Base_GPot__c - 3));
            }
            string sjson =  s.X__c+','+                         // X
                            s.Y__c+','+                         // Y
                            terrain+','+                        // Terrain
                            IsHomeSector+','+                   // IsHomeSector
                            blackHole+','+                      // BlackHole
                            gpot+','+                           // Base Grav Pot
                            s.Base_RPot__c+','+                 // Base Resource Pot
                            darkMatter+','+                     // Dark Matter
                            rv+','+                             // ResourceValue
                            hab+','+                            // HasARCBase
                            abp+','+                            // ARCBasePoints
                            aReg+','+                           // ActiveRegularCount
                            aEx+','+                            // ActiveExplorerCount
                            0+','+                              // ActiveDestroyerCount
                            0+','+                              // AlienARCBasePoints
                            0+','+                              // AlienActiveRegularCount
                            0+','+                              // AlienActiveExplorerCount
                            0;                                  // AlienActiveDestroyerCount
            
            if(order < 1001){
                if(String.IsBlank(g.Sector_JSON_1__c)){
                    g.Sector_JSON_1__c = sjson + ';';
                }else{
                    g.Sector_JSON_1__c += sjson;
                    if(order < 1000) g.Sector_JSON_1__c += ';';
                }
            }else if(order < 2001){
                if(String.IsBlank(g.Sector_JSON_2__c)){
                    g.Sector_JSON_2__c = sjson + ';';
                }else{
                    g.Sector_JSON_2__c += sjson;
                    if(order < 2000) g.Sector_JSON_2__c += ';';
                }
            }else if(order < 3001){
                if(String.IsBlank(g.Sector_JSON_3__c)){
                    g.Sector_JSON_3__c = sjson + ';';
                }else{
                    g.Sector_JSON_3__c += sjson;
                    if(order < 3000) g.Sector_JSON_3__c += ';';
                }
            }else if(order < 4001){
                if(String.IsBlank(g.Sector_JSON_4__c)){
                    g.Sector_JSON_4__c = sjson + ';';
                }else{
                    g.Sector_JSON_4__c += sjson;
                    if(order < 4000) g.Sector_JSON_4__c += ';';
                }
            }else if(order < 5001){
                if(String.IsBlank(g.Sector_JSON_5__c)){
                    g.Sector_JSON_5__c = sjson + ';';
                }else{
                    g.Sector_JSON_5__c += sjson;
                    if(order < 5000) g.Sector_JSON_5__c += ';';
                }
            }else if(order < 6001){
                if(String.IsBlank(g.Sector_JSON_6__c)){
                    g.Sector_JSON_6__c = sjson + ';';
                }else{
                    g.Sector_JSON_6__c += sjson;
                    if(order < 6000) g.Sector_JSON_6__c += ';';
                }
            }else if(order < 7001){
                if(String.IsBlank(g.Sector_JSON_7__c)){
                    g.Sector_JSON_7__c = sjson + ';';
                }else{
                    g.Sector_JSON_7__c += sjson;
                    if(order < 7000) g.Sector_JSON_7__c += ';';
                }
            }else if(order < 8001){
                if(String.IsBlank(g.Sector_JSON_8__c)){
                    g.Sector_JSON_8__c = sjson + ';';
                }else{
                    g.Sector_JSON_8__c += sjson;
                    if(order < 8000) g.Sector_JSON_8__c += ';';
                }
            }else if(order < 9001){
                if(String.IsBlank(g.Sector_JSON_9__c)){
                    g.Sector_JSON_9__c = sjson + ';';
                }else{
                    g.Sector_JSON_9__c += sjson;
                    if(order < 9000) g.Sector_JSON_9__c += ';';
                }
            }else if(order < 10001){
                if(String.IsBlank(g.Sector_JSON_10__c)){
                    g.Sector_JSON_10__c = sjson + ';';
                }else{
                    g.Sector_JSON_10__c += sjson;
                    if(order < 10000) g.Sector_JSON_10__c += ';';
                }
            }



/*
            Game_Sector__c gs = new Game_Sector__c();
            gs.Sector__c = s.Id;
            gs.Temp_X__c = s.X__c;
            gs.Temp_Y__c = s.Y__c;
            //gs.Game__c = g.Id;
            if(s.Home_Sector__c){
                i++;
                if(randomIndex == i){
                    // Player home sector here
                    gs.Home_Sector__c = true;
                    gs.Resource_Value__c = 10;
                    gs.Has_ARCBase__c = true;
                    gs.Total_Regular_Count__c = 2;
                    gs.Total_Explorer_Count__c = 1;
                    gs.ARCBase_Points__c = 10;
                }else{
                    // Alien Civilizations here
                    alienhomesectors.add(gs);
                }
            }
            gameSectorMap.put(s.X__c+'x'+s.Y__c,gs);
            sectorMap.put(s.X__c+'x'+s.Y__c,s);
        }
        integer ahsi=0;
        for(Game_Sector__c gs: alienhomesectors){
            ahsi++;
            if(ahsi <= alienmap.size()){
                Alien_Civilization__c ac = alienmap.get(ahsi);
                gs.Alien_ARCBase__c = 10;
                gs.Alien_Destroyer_Count__c = ac.Destroyer_Sector_Count__c * 2;
                gs.Alien_Regular_Count__c = ac.Regular_Sector_Count__c * 2;
                gs.Alien_Explorer_Count__c = ac.Explorer_Sector_Count__c * 2;
                for(Integer ii = 1; ii < ac.ARCBase_Sector_Count__c; ii++) {
                    randomPlacement(gs, ac, true,ii);
                }
                for(Integer ii = 1; ii < ac.ARCFleet_Sector_Count__c; ii++) {
                    randomPlacement(gs, ac, false,ii);
                }
            }
            */
        }
    //} 
    /*
    integer order = 0;
    for(Game_Sector__c gs:gameSectorMap.values()){
        order++;
        integer terrain = 0;
        if(gs.Terrain__c == 'Empty') terrain = 0;
        if(gs.Terrain__c == 'Interspiral') terrain = 1;
        if(gs.Terrain__c == 'Fringe') terrain = 2;
        if(gs.Terrain__c == 'Axis') terrain = 3;
        if(gs.Terrain__c == 'Nucleus') terrain = 4;
        if(gs.Terrain__c == 'Core') terrain = 5;

        string sjson = '{"X":'+gs.Temp_X__c+','+
                        '"Y":'+gs.Temp_Y__c+','+
                        '"T":'+'"'+terrain+'"'+
                        '}';
        
        if(order < 1001){
            if(String.IsBlank(g.Sector_JSON_1__c)){
                g.Sector_JSON_1__c = sjson + ',';
            }else{
                g.Sector_JSON_1__c += sjson;
                if(order < 1000) g.Sector_JSON_1__c += ',';
            }
        }
        /*else if(order < 2001){
            if(String.IsBlank(g.Sector_JSON_2__c)){
                g.Sector_JSON_2__c = sjson + ',';
            }else{
                g.Sector_JSON_2__c += sjson;
                if(order < 2000) g.Sector_JSON_2__c += ',';
            }
        }else if(order < 3001){
            if(String.IsBlank(g.Sector_JSON_3__c)){
                g.Sector_JSON_3__c = sjson + ',';
            }else{
                g.Sector_JSON_3__c += sjson;
                if(order < 3000) g.Sector_JSON_3__c += ',';
            }
        }else if(order < 4001){
            if(String.IsBlank(g.Sector_JSON_4__c)){
                g.Sector_JSON_4__c = sjson + ',';
            }else{
                g.Sector_JSON_4__c += sjson;
                if(order < 4000) g.Sector_JSON_4__c += ',';
            }
        }else if(order < 5001){
            if(String.IsBlank(g.Sector_JSON_5__c)){
                g.Sector_JSON_5__c = sjson + ',';
            }else{
                g.Sector_JSON_5__c += sjson;
                if(order < 5000) g.Sector_JSON_5__c += ',';
            }
        }else if(order < 6001){
            if(String.IsBlank(g.Sector_JSON_6__c)){
                g.Sector_JSON_6__c = sjson + ',';
            }else{
                g.Sector_JSON_6__c += sjson;
                if(order < 6000) g.Sector_JSON_6__c += ',';
            }
        }else if(order < 7001){
            if(String.IsBlank(g.Sector_JSON_7__c)){
                g.Sector_JSON_7__c = sjson + ',';
            }else{
                g.Sector_JSON_7__c += sjson;
                if(order < 7000) g.Sector_JSON_7__c += ',';
            }
        }else if(order < 8001){
            if(String.IsBlank(g.Sector_JSON_8__c)){
                g.Sector_JSON_8__c = sjson + ',';
            }else{
                g.Sector_JSON_8__c += sjson;
                if(order < 8000) g.Sector_JSON_8__c += ',';
            }
        }else if(order < 9001){
            if(String.IsBlank(g.Sector_JSON_9__c)){
                g.Sector_JSON_9__c = sjson + ',';
            }else{
                g.Sector_JSON_9__c += sjson;
                if(order < 9000) g.Sector_JSON_9__c += ',';
            }
        }else if(order < 10001){
            if(String.IsBlank(g.Sector_JSON_10__c)){
                g.Sector_JSON_10__c = sjson + ',';
            }else{
                g.Sector_JSON_10__c += sjson;
                if(order < 10000) g.Sector_JSON_10__c += ',';
            }
        }
        /**
    }
    */
    //games.add(g);
}
//update games;
    //insert gameSectorMap.values();
    public void randomPlacement(Game_Sector__c gs, Alien_Civilization__c ac, Boolean hasArcBase, integer ii){
        gs.Alien_Civilization__c = ac.Id;
        decimal x = gs.Temp_X__c;
        decimal y = gs.Temp_Y__c;
        integer d = randomIntFromInterval(4, integer.valueof((4+ii)*ac.Civilization_Level__c));
        integer q = randomIntFromInterval(1,4);
        if(q==1){
            x += randomIntFromInterval(4,d);
            y += randomIntFromInterval(4,d);
        }else if(q == 2){
            x += randomIntFromInterval(4,d);
            y -= randomIntFromInterval(4,d);
        }else if(q == 3){
            x -= randomIntFromInterval(4,d);
            y -= randomIntFromInterval(4,d);
        }else if(q == 4){
            x -= randomIntFromInterval(4,d);
            y += randomIntFromInterval(4,d);
        }           
        x = math.min(math.max(1,x),100);
        y = math.min(math.max(1,y),100);
        if(x==1) x+=randomIntFromInterval(1,10);
        if(x==100) x-=randomIntFromInterval(1,10);
        if(y==1) y+=randomIntFromInterval(1,10);
        if(y==100) y-=randomIntFromInterval(1,10);  
        if(sectorMap.get(x+'x'+y).Terrain__c == 'Axis' || sectorMap.get(x+'x'+y).Terrain__c == 'Fringe' || sectorMap.get(x+'x'+y).Terrain__c == 'Interspiral'){
            if(hasArcBase) gameSectorMap.get(x+'x'+y).Alien_ARCBase__c = randomIntFromInterval(5, 10);
            gameSectorMap.get(x+'x'+y).Alien_Destroyer_Count__c = Math.Max(0,Math.Floor(ac.Destroyer_Sector_Count__c - randomIntFromInterval(4, integer.valueof(ac.Destroyer_Sector_Count__c))));
            gameSectorMap.get(x+'x'+y).Alien_Regular_Count__c = Math.Max(0,Math.Floor(ac.Regular_Sector_Count__c - randomIntFromInterval(4, integer.valueof(ac.Regular_Sector_Count__c))));
            gameSectorMap.get(x+'x'+y).Alien_Explorer_Count__c = Math.Max(0,Math.Floor(ac.Explorer_Sector_Count__c - randomIntFromInterval(4, integer.valueof(ac.Explorer_Sector_Count__c))));
        }   
    }
    public boolean isEven(integer i){
        return Math.mod(i,2) == 0;
    }
    public integer randomIntFromInterval(integer min,integer max){
        return integer.valueof(Math.floor(Math.random()*(max-min+1)+min));
    }
}