body{padding-top: 0px;}
.spinnerParent{display: none;}
.navbar-flat{background: #3c3c3c !important;}
.navbar{margin-bottom: 0px !important;}
.table td{border-top: 1px solid hsl(193,40%,50%) !important;}
.table th{border-bottom: 1px solid hsl(193,40%,50%) !important;}
.table-condensed>tbody>tr>td{padding:3px 5px;}
.table{margin-bottom: 0px !important;}
.table-scroll{position: relative;top: -20px;height: 540px;overflow-y: scroll;-webkit-overflow-scrolling: touch;}
.table-scroll tr:hover{background: #fff;color: #999;}
.clickable{cursor: pointer;color: #777;}
.clickable:hover{background-color: #565656; color: #fff; border-radius: 4px;}
.bottomSidebar{border-top: 1px solid rgb(41,209,255);padding:10px;}
.blackhole-1{left:11px; top:6px;}
.blackhole-2{left:12px; top:7px;}
.blackhole-3{left:13px; top:8px;}
.blackhole-4{left:14px; top:9px;}
.blackhole-5{left:15px; top:10px;}
.blackhole-10{left:10px; top:5px;}
/*
     /$$$$$$                                                     /$$                        
    |_  $$_/                                                    | $$                        
      | $$   /$$$$$$$   /$$$$$$$  /$$$$$$   /$$$$$$   /$$$$$$$ /$$$$$$    /$$$$$$   /$$$$$$ 
      | $$  | $$__  $$ /$$_____/ /$$__  $$ /$$__  $$ /$$_____/|_  $$_/   /$$__  $$ /$$__  $$
      | $$  | $$  \ $$|  $$$$$$ | $$  \ $$| $$$$$$$$| $$        | $$    | $$  \ $$| $$  \__/
      | $$  | $$  | $$ \____  $$| $$  | $$| $$_____/| $$        | $$ /$$| $$  | $$| $$      
     /$$$$$$| $$  | $$ /$$$$$$$/| $$$$$$$/|  $$$$$$$|  $$$$$$$  |  $$$$/|  $$$$$$/| $$      
    |______/|__/  |__/|_______/ | $$____/  \_______/ \_______/   \___/   \______/ |__/      
                                | $$                                                        
                                | $$                                                        
                                |__/                                                        
*/
#mobileMiniMap{
    z-index: 1031;
    position: absolute;
    top: 35px;
    right: 35px;
    background-color: hsla(193,40%,10%,0.75);
    border-radius:5px;
    border-width: 1px;
    border-style: solid;
    border-color: hsl(193,40%,50%);
    height: 315px;
    width: 315px;
}
#inspectorPanel, #showMiniMapButton{
    /*padding: 0px 10px;*/
    z-index: 1031;
    position: absolute;
    top: 35px;
    right: 35px;
    background-color: hsla(193,40%,10%,0.75);
    border-radius:5px;
    border-width: 1px;
    border-style: solid;
    border-color: hsl(193,40%,50%);
}
#showMiniMapButton{
    height: 30px;
    width: 30px;
}
#inspectorContent, #showMiniMapButton{
    color: hsl(193,40%,50%);
    overflow: hidden;
    padding: 0 10px;
}

.pills{width:60px;}
.contents{position: absolute;width: 200px;top: 0px; left: 80px;}
.hiddenInspector{width: 300px; height: 30px; padding-top: 5px; transition: 0.25s ease all;}
.visibleInspector{width: 300px; height: 525px; transition: 0.25s ease all;}
.inspectorRowSelected{
    background: #fff !important;
    color: #999;
}
.alienCivName{
    width: 202px;
    font-size: 11px;
    position: absolute;
    top: -10px;
}
.alienConstructs{
    margin-top: 5px !important;
}
.alienInteractionButtons{
    margin-top: 5px !important;
    margin-bottom: 0px !important;
}
.nav>li>a:hover, .nav>li>a:focus,.nav-pills>li.active>a, .nav-pills>li.active>a:hover, .nav-pills>li.active>a:focus {background-color: #337ab7 !important; color: #fff !important;}
.closedInfoPill{
    width: 93px;
    display: inline-block;
    text-align: center;
    padding: 9px 0px 3px 0px;
    border-radius: 5px;
}
.infoPill{padding: 10px 5px !important;color: #777;}
.infoPill:hover{color: #777;}

.noActionConstruct{color: #8f8f8f; opacity: 0.25;}
.ui-widget-content{border: 0px;}
.shrink{
    font-size: 0px;
    -webkit-transition: font-size 1s;
    transition: font-size 1s;
}
.orange-text {    
  color: #F1AF16;
}
b.orange-text{
  font-family: 'ARCFleet';
  text-shadow: -1px 0 red, 0 1px red, 1px 0 red, 0 -1px red;
}
#contactModalAlienName{
  position: absolute;  
  top: 24px;
  left: 35px;
  font-size: 24px;
  font-family: 'ARCFleetLined';
}
/*Delete*/
.panel-heading, .panel-body, .list-group-item{
    padding: 5px !important;
}
.list-group-item, .list-group-item>span{
    font-size: 10px !important;
}
.panel-heading>h5{
    margin: 0px !important;
}
/*End Delete*/

.icon-spin-0{}
.icon-spin-1{-webkit-animation: spin 20s infinite linear !important;}
.icon-spin-2{-webkit-animation: spin 18s infinite linear !important;}
.icon-spin-3{-webkit-animation: spin 16s infinite linear !important;}
.icon-spin-4{-webkit-animation: spin 14s infinite linear !important;}
.icon-spin-5{-webkit-animation: spin 12s infinite linear !important;}
.icon-spin-6{-webkit-animation: spin 10s infinite linear !important;}
.icon-spin-7{-webkit-animation: spin 8s infinite linear !important;}
.icon-spin-8{-webkit-animation: spin 6s infinite linear !important;}
.icon-spin-9{-webkit-animation: spin 4s infinite linear !important;}
.icon-spin-10{-webkit-animation: spin 2s infinite linear !important;}

@-webkit-keyframes spin {
    0% {-webkit-transform: rotate(0deg);}
    100% {-webkit-transform: rotate(360deg);}
}

.modal-content{
    /*color: #999 !important;*/
    color: rgb(41,209,255) !important;
    /*background: #3c3c3c !important;*/
    background: #000 !important;
    border-color: rgb(41,209,255) !important;
    /*box-shadow: inset 1px 1px 1px rgba(255,255,255,.15),0 1px 15px rgba(0,0,0,.5) !important; */
}
.modal-header{
    border-color: rgb(41,209,255) !important;
}
.modal-footer{
    border-color: rgb(41,209,255) !important;
}
.modal-dialog{
    margin:80px auto !important;
}
/*
     /$$   /$$             /$$     /$$  /$$$$$$  /$$                       /$$     /$$                    
    | $$$ | $$            | $$    |__/ /$$__  $$|__/                      | $$    |__/                    
    | $$$$| $$  /$$$$$$  /$$$$$$   /$$| $$  \__/ /$$  /$$$$$$$  /$$$$$$  /$$$$$$   /$$  /$$$$$$  /$$$$$$$ 
    | $$ $$ $$ /$$__  $$|_  $$_/  | $$| $$$$    | $$ /$$_____/ |____  $$|_  $$_/  | $$ /$$__  $$| $$__  $$
    | $$  $$$$| $$  \ $$  | $$    | $$| $$_/    | $$| $$        /$$$$$$$  | $$    | $$| $$  \ $$| $$  \ $$
    | $$\  $$$| $$  | $$  | $$ /$$| $$| $$      | $$| $$       /$$__  $$  | $$ /$$| $$| $$  | $$| $$  | $$
    | $$ \  $$|  $$$$$$/  |  $$$$/| $$| $$      | $$|  $$$$$$$|  $$$$$$$  |  $$$$/| $$|  $$$$$$/| $$  | $$
    |__/  \__/ \______/    \___/  |__/|__/      |__/ \_______/ \_______/   \___/  |__/ \______/ |__/  |__/
*/

.alert-arcfleet {
    color: #fff;
    background-color: rgba(0,0,0,0.5);
    padding: 10px;
    border-radius:5px;

    /*background-color: #3c3c3c;*/
    border-color: #000;
    border-width: 1px;
    /*color: #999;*/
    /*box-shadow: inset 1px 1px 1px rgba(255,255,255,.15),0 1px 15px rgba(0,0,0,.5) !important;*/
    width: 350px;
}
.alert-arcfleet-red{
    border-color: #ff0000;
}
.alert-arcfleet-blue{
    border-color: rgb(41,209,255);
}
.alert-arcfleet-green{
    border-color: #00ff00;
}
.alert-arcfleet-yellow{
    border-color: #ffff00;
}
#notificationPanel{
    background: #000;
    color: rgb(41,209,255);
    border-radius: 5px;            
    position: relative;
    margin-top: 10px;
    /*left: 0px;
    right:10px;
    width: 210px;*/
    font-family:"Lucida Console", Monaco, monospace;
    font-size: 12px;
    box-shadow: inset -1px -1px 1px rgba(255,255,255,.5);
}
#notificationPanelScreen{
    background-image: -webkit-repeating-linear-gradient(90deg, #164350 0, #040d10 0.25em, #164350 0.5em);
    opacity: 0.35;
    position: absolute;
    left: 2px;
    width: 200px;
    pointer-events:none;
}
#notifications{
    overflow-y: scroll;
}
.notification-header{
    background-color: rgb(41,209,255); 
    color: #000;
}
.notification-header-red{
    color: #fff;
    background-color: #c70003;
}
.notification{
    margin: 10px;
}
.iconLabel{padding-top: 4px;}
.mapNavigationWrapper{position: absolute;}
/*
      /$$$$$$                        /$$                               /$$$$$$            /$$$$$$         
     /$$__  $$                      | $$                              |_  $$_/           /$$__  $$        
    | $$  \__/  /$$$$$$   /$$$$$$$ /$$$$$$    /$$$$$$   /$$$$$$         | $$   /$$$$$$$ | $$  \__//$$$$$$ 
    |  $$$$$$  /$$__  $$ /$$_____/|_  $$_/   /$$__  $$ /$$__  $$        | $$  | $$__  $$| $$$$   /$$__  $$
     \____  $$| $$$$$$$$| $$        | $$    | $$  \ $$| $$  \__/        | $$  | $$  \ $$| $$_/  | $$  \ $$
     /$$  \ $$| $$_____/| $$        | $$ /$$| $$  | $$| $$              | $$  | $$  | $$| $$    | $$  | $$
    |  $$$$$$/|  $$$$$$$|  $$$$$$$  |  $$$$/|  $$$$$$/| $$             /$$$$$$| $$  | $$| $$    |  $$$$$$/
     \______/  \_______/ \_______/   \___/   \______/ |__/            |______/|__/  |__/|__/     \______/ 
*/
.logoText{
  color: #F1AF16;
  font-family: 'ARCFleetLined';
  font-size: 20px;
  text-shadow: -1px 0 red, 0 1px red, 1px 0 red, 0 -1px red;
  display: inline-block;
  margin-left: 10px;
  margin-top: -5px;
  position: absolute;
}
.sectorSection, .inspectorSection{
    padding: 0 10px 0 10px;
    /*background: #494949;*/
    /*border-radius: 5px;*/
    /*padding: 5px;
    margin-top: 10px;
    position: relative;*/
    /*box-shadow: inset -1px -1px 1px rgba(255,255,255,0.5),inset 1px 1px 1px rgba(0,0,0,0.5);*/
}
.disabledSectorSection{
    /*background: #3e3e3e !important;*/
    /*box-shadow: inset -1px -1px 1px rgba(111, 111, 111, 0.5),inset 1px 1px 1px rgba(47, 47, 47, 0.5) !important;*/
    overflow: hidden;
    display: none;
}
.disabledSectorSection i{
    font-size: 190px;
    /*color: #494949;*/
    color: rgba(0,0,0,0.25);
}
#sectorFleetsSection{
    height: 160px;
}
#sectorARCBaseSection{
    height: 70px;
}
#sectorContactsSection{
    height: 70px;
}
.disabledIcon{
    opacity: 0.4;
    color: #000 !important;
}
/*
   /$$$$$$$                        /$$                /$$                                         /$$$$$$  /$$ /$$       /$$                    
  | $$__  $$                      | $$               | $$                                        /$$__  $$| $$|__/      | $$                    
  | $$  \ $$  /$$$$$$   /$$$$$$  /$$$$$$   /$$$$$$$ /$$$$$$    /$$$$$$  /$$$$$$   /$$$$$$       | $$  \__/| $$ /$$  /$$$$$$$  /$$$$$$   /$$$$$$ 
  | $$$$$$$  /$$__  $$ /$$__  $$|_  $$_/  /$$_____/|_  $$_/   /$$__  $$|____  $$ /$$__  $$      |  $$$$$$ | $$| $$ /$$__  $$ /$$__  $$ /$$__  $$
  | $$__  $$| $$  \ $$| $$  \ $$  | $$   |  $$$$$$   | $$    | $$  \__/ /$$$$$$$| $$  \ $$       \____  $$| $$| $$| $$  | $$| $$$$$$$$| $$  \__/
  | $$  \ $$| $$  | $$| $$  | $$  | $$ /$$\____  $$  | $$ /$$| $$      /$$__  $$| $$  | $$       /$$  \ $$| $$| $$| $$  | $$| $$_____/| $$      
  | $$$$$$$/|  $$$$$$/|  $$$$$$/  |  $$$$//$$$$$$$/  |  $$$$/| $$     |  $$$$$$$| $$$$$$$/      |  $$$$$$/| $$| $$|  $$$$$$$|  $$$$$$$| $$      
  |_______/  \______/  \______/    \___/ |_______/    \___/  |__/      \_______/| $$____/        \______/ |__/|__/ \_______/ \_______/|__/      
                                                                                | $$                                                            
                                                                                | $$                                                            
                                                                                |__/                                                            
*/

.slider-handle{
  box-shadow: inset 0 0 0 #fff, 0 0 0 #fff !important;
  -webkit-box-shadow: inset 0 0 0 #fff, 0 0 0 #fff !important;
  margin-top: -8px !important;
}
.slider.slider-disabled{
  opacity: 0.25;
}
.slider.slider-disabled .slider-handle{
  background-image: none !important;
}
.slider.slider-horizontal .slider-track{
  height: 8px !important;
}
/*.slider.slider-disabled .slider-handle.custom::before{
  color: #000 !important;
}
.slider.slider-disabled .slider-track-high{
  background: #000 !important;
}*/
#regularSliderSlider .slider-selection {
  background: #797979;
}
#explorerSliderSlider .slider-selection {
  background: #5A8EF9;
}
#destroyerSliderSlider .slider-selection {
  background: #D62C2C;
}
.slider-handle.custom::before {
  font-family: 'arcfleet';
  font-size: 20px;
  line-height: 1;
}
#regularSliderSlider .slider-handle.custom::before {
  color: #797979;
  content: '\e605';  
}
#explorerSliderSlider .slider-handle.custom::before {
  color: #5A8EF9;
  content: '\e601'; 
}
#destroyerSliderSlider .slider-handle.custom::before {
  color: #D62C2C;
  content: '\e602';  
}
.slider-handle.custom{  
  text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black; 
}

/*
     /$$$$$$$                              
    | $$__  $$                             
    | $$  \ $$ /$$$$$$   /$$$$$$$  /$$$$$$ 
    | $$$$$$$/|____  $$ /$$_____/ /$$__  $$
    | $$____/  /$$$$$$$| $$      | $$$$$$$$
    | $$      /$$__  $$| $$      | $$_____/
    | $$     |  $$$$$$$|  $$$$$$$|  $$$$$$$
    |__/      \_______/ \_______/ \_______/
*/

.pace {
  -webkit-pointer-events: none;
  pointer-events: none;

  -webkit-user-select: none;
  -moz-user-select: none;
  user-select: none;

  z-index: 2000;
  position: fixed;
  margin: auto;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  height: 5px;
  width: 200px;
  background: #fff;
  border: 1px solid #5A8EF9;

  overflow: hidden;
}

.pace .pace-progress {
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  -ms-box-sizing: border-box;
  -o-box-sizing: border-box;
  box-sizing: border-box;

  -webkit-transform: translate3d(0, 0, 0);
     -moz-transform: translate3d(0, 0, 0);
      -ms-transform: translate3d(0, 0, 0);
       -o-transform: translate3d(0, 0, 0);
          transform: translate3d(0, 0, 0);

  max-width: 200px;
  position: fixed;
  z-index: 2000;
  display: block;
  position: absolute;
  top: 0;
  right: 100%;
  height: 100%;
  width: 100%;
  background: #5A8EF9;
}
.civilizationLevelControls{
    /*position: absolute;*/
    /*z-index: 10;*/
    text-align: right;
    /*width: 198px;*/
    /*top: -10px;*/
    /*font-size: 10px;*/
}
.fa-stack-text{
    margin-left: -0.5px;
    margin-top: -0.5px;
}
.pace.pace-inactive {
  display: none;
}
.galaxyName{
    position: absolute;
    top: 174px;
    left: 2px;
}
/*
      /$$$$$$                                  /$$                                     /$$             
     /$$__  $$                                | $$                                    | $$             
    | $$  \__/  /$$$$$$  /$$$$$$$   /$$$$$$$ /$$$$$$    /$$$$$$  /$$   /$$  /$$$$$$$ /$$$$$$   /$$$$$$$
    | $$       /$$__  $$| $$__  $$ /$$_____/|_  $$_/   /$$__  $$| $$  | $$ /$$_____/|_  $$_/  /$$_____/
    | $$      | $$  \ $$| $$  \ $$|  $$$$$$   | $$    | $$  \__/| $$  | $$| $$        | $$   |  $$$$$$ 
    | $$    $$| $$  | $$| $$  | $$ \____  $$  | $$ /$$| $$      | $$  | $$| $$        | $$ /$$\____  $$
    |  $$$$$$/|  $$$$$$/| $$  | $$ /$$$$$$$/  |  $$$$/| $$      |  $$$$$$/|  $$$$$$$  |  $$$$//$$$$$$$/
     \______/  \______/ |__/  |__/|_______/    \___/  |__/       \______/  \_______/   \___/ |_______/ 
*/
.inactive{opacity: 0.4;}
/*.inactive::after{-webkit-text-stroke-width: 1px !important;}*/
.augmentIcon{color: #797979;}
.exploreIcon{color: #5A8EF9;}
.attackIcon{color: #D62C2C !important; font-size: 12px !important;-webkit-text-stroke:0px !important;}

.col-xs-1, .col-sm-1, .col-md-1, .col-lg-1, .col-xs-2, .col-sm-2, .col-md-2, .col-lg-2, .col-xs-3, .col-sm-3, .col-md-3, .col-lg-3, .col-xs-4, .col-sm-4, .col-md-4, .col-lg-4, .col-xs-5, .col-sm-5, .col-md-5, .col-lg-5, .col-xs-6, .col-sm-6, .col-md-6, .col-lg-6, .col-xs-7, .col-sm-7, .col-md-7, .col-lg-7, .col-xs-8, .col-sm-8, .col-md-8, .col-lg-8, .col-xs-9, .col-sm-9, .col-md-9, .col-lg-9, .col-xs-10, .col-sm-10, .col-md-10, .col-lg-10, .col-xs-11, .col-sm-11, .col-md-11, .col-lg-11, .col-xs-12, .col-sm-12, .col-md-12, .col-lg-12{
    padding-right:2px !important;
    padding-left:2px !important;
}
#sectorInfo{margin-bottom: 5px;}
/*#sectorInfoPanel{
    position: absolute; 
    right: 0px;
    top: 0px;
    color: #999;
    overflow-y: scroll;
    -webkit-overflow-scrolling: touch;
    background: #3c3c3c;
    border: #000 solid 1px;
    padding: 10px !important;
    box-shadow: inset 1px 0px 0 rgba(255,255,255,.15),0 1px 5px rgba(0,0,0,0.075); 
    z-index: 1035;
    font-size: 12px;
    width: 222px;
}*/
.panelButton, .panelButton.active{
    background: hsl(193,40%,20%);
    border-color: hsl(193,40%,50%) !important;
    color: hsl(193,40%,50%) !important;
}
.panelButton:disabled{
    background: hsl(193,40%,10%) !important;
    border:1px solid hsl(193,40%,20%) !important;
    opacity: 1;
}
.panelButton.inactive{
    background: hsl(193,40%,10%) !important;
    border:1px solid hsl(193,40%,50%) !important;
    opacity: 1;
}
.panelButton:disabled i{
    opacity: 0.5;
}
/*.panelButton.active{
    background-color: hsl(193,40%,30%) !important;
    color: hsl(193,40%,50%) !important;
}*/
.panelButton:hover{
    background-color: hsl(193,40%,30%) !important;
    color: hsl(193,40%,50%) !important;
}
.scannerIndicator:hover{
    background-color: hsl(193,40%,30%) !important;
}
/*#sectorInfoPanel::-webkit-scrollbar { width: 0 !important }*/
.map::-webkit-scrollbar { width: 0 !important }

#mapContainer{
    position: relative;
    min-height: 1px;
    float:left;
    padding-right:2px !important;
    padding-left:2px !important;
}
.mapSVG{
    position: absolute; 
    left: 0px; 
    top: 0px;
    z-index: 102;
    pointer-events: none;
}
.arcCalcBadge{z-index: 103; background: #000; padding: 4px; border-radius: 5px;}
#mobileMiniMapContainer{
    background-color: rgb(0,0,0);
    width: 302px; 
    height: 302px; 
    position: relative; 
    top:5px; 
    left: 5px;
    /*box-shadow: inset 0px 0px 5px hsl(193,100%,60%);*/
    overflow: hidden;
    /*background-image: -webkit-repeating-linear-gradient(90deg, #164350 0, #040d10 0.25em, #164350 0.5em);*/
}
#miniMap{
    background-color: rgb(0,0,0);
    border-top-right-radius: 5px;
    border-top-left-radius: 5px;
    border: 1px solid hsl(193,40%,50%);
    width: 202px; height: 202px; position: relative; top:-1px; left: -1px;
    /*box-shadow: inset 0px 0px 5px hsl(193,100%,60%);*/
    overflow: hidden;
    /*background-image: -webkit-repeating-linear-gradient(90deg, #164350 0, #040d10 0.25em, #164350 0.5em);*/
}
@-webkit-keyframes ani_scan {
    /* 0% will fallback to the default background-color of #rgb*/
    0% {
        background-position: 0 0;
    }
    50% {
        background-position: 0 1em;
    }
    100% {
        background-position: 0 2em;
    }
}

/*
     /$$$$$$$          /$$$$$$$                 /$$
    | $$__  $$        | $$__  $$               | $$
    | $$  \ $$        | $$  \ $$ /$$$$$$   /$$$$$$$
    | $$  | $$ /$$$$$$| $$$$$$$/|____  $$ /$$__  $$
    | $$  | $$|______/| $$____/  /$$$$$$$| $$  | $$
    | $$  | $$        | $$      /$$__  $$| $$  | $$
    | $$$$$$$/        | $$     |  $$$$$$$|  $$$$$$$
    |_______/         |__/      \_______/ \_______/
*/
.moveButton{
  position: absolute;
  z-index: 100;
  color: #fff;
  background-color: rgba(0,0,0,0.25);
  font-size: 30px;
  cursor: pointer;
}
.moveButton:hover{
  background-color: rgba(0,0,0,0.5);
  font-size: 34px;
}
.moveButton>i{
  position: absolute;
}
.moveButton.hor{
  text-align: center;
  width: 100%;
  height: 35px;
}
.moveButton.vert{
  vertical-align: center;
  height: 100%;
  width: 35px;
}
.upButton{
  top:0;
}
.downButton{
  bottom:0;
}
.leftButton{
  left:0;
}
.rightButton{
  right:0;
}
.phone-dpad{display: inline-block}
.phone-dpad>button{display: inline-block}
#dPad{
    position: relative;
    height: 70px;
    width: 200px;
    margin: 10px 0px 10px 0px;
}
#moveUpButton{ position:absolute; top: 0px; left: 83px;}
#moveRightButton{ position:absolute; top: 20px; left: 120px;}
#moveDownButton{ position:absolute; top: 40px; left: 83px;}
#moveLeftButton{ position:absolute; top: 20px; left: 50px;}

.modal-scroll{
    height: 400px;
    overflow-y: scroll;
}
.constructs, .contacts, .sectorFilters{position: relative;}

#regularSliderSlider, #explorerSliderSlider, #destroyerSliderSlider, #regularSlider, #explorerSlider, #destroyerSlider{margin-bottom: 5px; margin-top: 5px; width: 100%;}

#regularSlider .ui-widget-content{border: 0px;}
#regularSlider .ui-slider-range{background: grey !important; border: 0px !important;} 
#regularSlider .ui-slider-handle{background: grey; border: 1px solid #fff; border-radius: 15px;}
#regularSlider .ui-slider-handle:focus{ outline: 0;}

#explorerSlider .ui-widget-content{border: 0px;}
#explorerSlider .ui-slider-range{background: blue !important; border: 0px !important;} 
#explorerSlider .ui-slider-handle{background: blue; border: 1px solid #fff; border-radius: 15px;}
#explorerSlider .ui-slider-handle:focus{ outline: 0;}

#destroyerSlider .ui-widget-content{border: 0px;}
#destroyerSlider .ui-slider-range{background: red !important; border: 0px !important;} 
#destroyerSlider .ui-slider-handle{background: red; border: 1px solid #fff; border-radius: 15px;}
#destroyerSlider .ui-slider-handle:focus{outline: 0;}
.arcfleetLogo{
    position: absolute;
    z-index: 106;
    top: -10px;
    left: -20px;
}
.logoFleet{
    color: #5A8EF9;
    text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;
    font-size: 34px;
    left: 2px !important;
    top: 0px !important;
    width: 35px;
    height: 35px;
}
.logoBase{
    left: 2px;
    top: 1px;
    color: #777;
    z-index: 0 !important;
    width: 35px;
    height: 35px;
}
.gameName{
    position: absolute;
    z-index: 106;
    top: 7px;
    right: 5px;
    text-align: right;
    width: 300px;
    pointer-events: none;
    font-size: 16px;
    line-height: 26px;
}
.sectorInfo{
    position: relative; 
    z-index: 105;
    /* top: 35px; */
    /* left: 37px; */
    width: 202px;
    /*width: 250px;*/
    color: hsl(193,40%,50%); /*#F1AF16;*/
    background-color: hsla(193,40%,10%,0.5);
    /*padding:10px 10px !important;*/
    border-radius:5px;
    border-width: 1px;
    border-style: solid;
    margin-bottom: 10px;
    /*border-color: rgb(41,209,255);*/
    border-color: hsl(193,40%,50%);
}
.sectorInfo>h3{margin-top:10px;}
.sectorInfo>h5>small{color: #ddd;}
.sliderBody{position: relative; height: 30px; margin-left: 10px;}

.construct,.contact{
    position: absolute; 
    pointer-events: none; 
    font-size: 10px;
    
}
.fleet{z-index: 101;font-size: 12px;text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;}
.footerIcon{font-size: 16px !important;text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;-webkit-text-stroke:0px !important;}
/*.construct::after,.contact::after{
    position: absolute;
    left: 0;
    top: 0;
    z-index: -1;
}*/
/*.construct::after{
    -webkit-text-stroke: 2px #000;
}*/
/*.contact::after{
    -webkit-text-stroke: 3px #000;
}*/
/*.fullARCBase::after{
    -webkit-text-stroke: 2px #00f;
}*/
/*.construct-regular::after{content: "\e605";}
.construct-explorer::after{content: "\e601";}
.construct-destroyer::after{content: "\e603";}
.construct-arcbase::after{content: "\e606";}*/
.arc-regular, .arc-regular-o{color: #797979;left: 10px; }
.arc-explorer, .arc-explorer-o{color:#5A8EF9;left: 10px; }
.arc-destroyer, .arc-destroyer-o{color:#D62C2C;left: 10px; }
.pos-1-1{top:12px;}
.pos-1-2{top:4px;}
.pos-2-2{top:20px;}
.pos-1-3{top:0px;}
.pos-2-3{top:12px;}
.pos-3-3{top:25px;}

.lineOfSight{background-color: #fff !important;}
.darkMatter{
    background-color: #000 !important; 
    z-index: 102;
    /* -moz-box-shadow: 0 0 30px 18px #000; */
    /* -webkit-box-shadow: 0 0 30px 18px #000; */
    /* box-shadow: 0px 0px 10px 0px rgba(0,0,0,0); */
    opacity: 0.65;
    height: 35px !important;
    width: 35px !important;
    /* top: 18px !important; */
    /* left: 18px !important; */
}

.constructCount{
    position: absolute;
    z-index: 101;
    left: 24px;
    min-width: 10px;
    padding: 1px;
    font-size: 8px;
    font-weight: 700;
    line-height: 1;
    background-color: #000;
    text-align: center;
    white-space: nowrap;
    vertical-align: baseline;    
    border-radius: 10px;
}
.regularCount{
    color: #797979;
    pointer-events: none;
}
.explorerCount{
    color: #5A8EF9;
    pointer-events: none;
}
.destroyerCount{
    color: #D62C2C;
    pointer-events: none;
}

.contactARCBase{
    font-size: 20px !important;
    position: absolute;
    left: 7px !important;
    top: 7px !important; 
    pointer-events: none;
}
.statusARCBase{
    position: absolute;
    top:2px;
    left: 4px;
    font-size: 32px;
    z-index: 99;
    color: #999;
    opacity: 0.75;
    pointer-events: none;
}
.fullARCBase{
    color: rgb(163, 203, 255);
    opacity: 0.75;
}
.homeSector{
    color: #f1af16;
    opacity: 0.75;
}
.arc-arcbase{z-index:100;color:#A6A6A6;font-size:33px;top:1px;left:1px;-webkit-text-stroke: 1px black;}

hr{border-top: 1px solid #030303 !important; margin-top: 2px !important; margin-bottom: 2px !important;}
.sector{float:left; color: #ddd; position: xabsolute !important; z-index: 10;}
.selected, .sectorFilter:hover{
    box-sizing: border-box; 
    -moz-box-sizing: border-box; 
    -webkit-box-sizing: border-box; 
    border: 3px dotted #fff; 
    /*position: absolute !important;*/
    height: 41px !important;
    width: 41px !important;
    top: -3px !important;
    left: -3px !important;
}

.sectorFilter:hover{border-color: #a39dff; }
.sectorFilter{position: absolute; top: 0px; cursor: crosshair;}

.terrain-{background-color: rgba(255,255,255,0);}
.terrain-Interspiral.fuzzy{box-shadow: 0px 0px 30px 18px hsla(193,40%,30%,0.3);}
.terrain-Fringe.fuzzy{box-shadow: 0px 0px 30px 18px hsla(193,40%,40%,0.4);}
.terrain-Axis.fuzzy{box-shadow: 0px 0px 30px 18px hsla(193,40%,50%,0.5);}
.terrain-Nucleus.fuzzy{box-shadow: 0px 0px 30px 18px hsla(193,40%,80%,1);}
.terrain-Core.fuzzy{ box-shadow: 0px 0px 30px 18px hsla(193,40%,90%,1);}

.terrain-Interspiral{background-color:  hsla(193,40%,30%,0.3);}
.terrain-Fringe{background-color:       hsla(193,40%,40%,0.4);}
.terrain-Axis{background-color:         hsla(193,40%,50%,0.5);}
.terrain-Nucleus{background-color:      hsla(193,40%,80%,0.8);}
.terrain-Core{background-color:         hsla(193,40%,90%,0.9);}
.fuzzy{opacity: 0.5;
    height: 1px !important;
    width: 1px !important;
    top: 18px !important;
    left: 18px !important;}

/* Other Fleets */        
.contactSector{}

@-webkit-keyframes throb {
    from { opacity: 1; }
    50% { opacity: 0.2;  }
    to { opacity: 1;  }
}
.otherFleetSize-0{background-color: hsla(200,100%,50%,0);}
.otherFleetSize-1{background-color: hsla(205,100%,50%,0.3);}
.otherFleetSize-2{background-color: hsla(210,100%,50%,0.3);}
.otherFleetSize-3{background-color: hsla(215,100%,50%,0.3);}
.otherFleetSize-4{background-color: hsla(220,100%,50%,0.3);}
.otherFleetSize-5{background-color: hsla(225,100%,50%,0.3);}
.otherFleetSize-6{background-color: hsla(230,100%,50%,0.3);}
.otherFleetSize-7{background-color: hsla(235,100%,50%,0.3);}
.otherFleetSize-8{background-color: hsla(240,100%,50%,0.3);}
.otherFleetSize-9{background-color: hsla(245,100%,50%,0.3);}
.otherFleetSize-10{background-color: hsla(250,100%,50%,0.3);}

/* ARC */
.gPot-0{background-color: hsla(0,100%,50%,0.15);}
.gPot-1{background-color: hsla(10,100%,50%,0.15);}
.gPot-2{background-color: hsla(20,100%,50%,0.15);}
.gPot-3{background-color: hsla(30,100%,50%,0.15);}
.gPot-4{background-color: hsla(40,100%,50%,0.15);}
.gPot-5{background-color: hsla(50,100%,50%,0.15);}
.gPot-6{background-color: hsla(60,100%,50%,0.15);}
.gPot-7{background-color: hsla(70,100%,50%,0.15);}
.gPot-8{background-color: hsla(80,100%,50%,0.15);}
.gPot-9{background-color: hsla(90,100%,50%,0.15);}
.gPot-10{background-color: hsla(100,100%,50%,0.15);}

/* Resource */
.exploredSector{border: 4px solid rgba(0,0,255,0.5);}
.explored{  
    background-color: blue;
    padding: .2em;
    font-size: 70%;
    font-weight: 500;
    line-height: 1;
    color: #fff;
    text-align: center;
    white-space: nowrap;
    vertical-align: baseline;
    border-radius: 15px; 
    position: relative;
    top: 3px; //-3px;
    left: 8px; //0px;
}
.resource-0{background-color: hsla(240,100%,50%,0);}
.resource-1{background-color: hsla(240,100%,50%,0.10);}
.resource-2{background-color: hsla(240,100%,50%,0.20);}
.resource-3{background-color: hsla(240,100%,50%,0.30);}
.resource-4{background-color: hsla(240,100%,50%,0.40);}
.resource-5{background-color: hsla(240,100%,50%,0.50);}
.resource-6{background-color: hsla(240,100%,50%,0.60);}
.resource-7{background-color: hsla(240,100%,50%,0.70);}
.resource-8{background-color: hsla(240,100%,50%,0.80);}
.resource-9{background-color: hsla(240,100%,50%,0.90);}
.resource-10{background-color: hsla(240,100%,50%,1);}

/*.selected{border: 1px solid #000;}  */

/* MiniMap */
/* Terrain */
.Empty{background-color:        rgba(0,255,0,0);}
.Interspiral{background-color:  hsla(193,40%,30%,0.5);}
.Fringe{background-color:       hsla(193,40%,40%,0.5);}
.Axis{background-color:         hsla(193,40%,50%,0.5);}
.Nucleus{background-color:      hsla(193,40%,80%,0.5);}
.Core{background-color:         hsla(193,40%,90%,0.5);}

.sectorFilters{position:relative;}
.sectorFilter{position:absolute;top:0px;cursor:crosshair;}
/*.construct-0{border: 1px solid rgb(41,209,255);}*/
.construct-minimap{background-color:hsl(193,40%,50%);}
.minimapSector{height:2px; width:2px; cursor:crosshair;}
.minimapSectorFilter{height:2px;width:2px;position:absolute;top:0px;}
.mobileMinimapSector{height:3px; width:3px; cursor:crosshair;}
.mobileMinimapSectorFilter{height:3px;width:3px;position:absolute;top:0px;}
.arc-minimap{background-color:#fff;}
.blackHole-minimap{background-color:#f00;}
.gwave-minimap{background-color:#000;}
.darkMatter-minimap{background-color:blue;}
.gwave-1,.gwave-2,.gwave-3{
    border: 0.75px solid black;
    background: rgb(0,0,0);
}
/*.gwave-1{
    border: 0.75px solid black;
    background: rgba(128, 0, 0, 0.4); 
}
.gwave-2{
    border: 0.75px solid black;
    background: rgba(238, 130, 238, 0.4);
}
.gwave-3{
    border: 0.75px solid black;
    background: rgba(0, 0, 255, 0.4); 
}*/
.scannerIndicator{
    position: absolute;
    left:235px;
    z-index: 104;
    width: 120px;
    /*color: hsl(193,40%,50%);*/
    background-color: hsla(193,40%,10%,0.5);
    padding:5px 10px !important;
    border-radius:5px;
    border-width: 1px;
    border-style: solid;
    border-color: hsl(193,40%,50%);
    cursor: pointer;
}
.arcScanner{color:#fff;top:40px;}
.blackHoleScanner{color:#f00;top:75px;}
.darkMatterScanner{color:blue;top:110px;}

/*.construct-1{background-color: rgba(41,209,255,0.1);}
.construct-2{background-color: rgba(41,209,255,0.2);}
.construct-3{background-color: rgba(41,209,255,0.3);}
.construct-4{background-color: rgba(41,209,255,0.4);}
.construct-5{background-color: rgba(41,209,255,0.5);}
.construct-6{background-color: rgba(41,209,255,0.6);}
.construct-7{background-color: rgba(41,209,255,0.7);}
.construct-8{background-color: rgba(41,209,255,0.8);}
.construct-9{background-color: rgba(41,209,255,0.9);}
.construct-10{background-color: rgba(41,209,255,1);}*/

.topBorder{background-color: hsl(193,40%,50%);}
.rightBorder{background-color: hsl(193,40%,50%);}
.bottomBorder{background-color: hsl(193,40%,50%);}
.leftBorder{background-color: hsl(193,40%,50%);}
/* End MiniMap */

.blackhole{color: #000; position: relative; -webkit-animation: spin 0.1s infinite linear !important;pointer-events: none;}
.blackholeName{font-size: 8px; color: #fff;}

.purplecoat { display: none; position: absolute; padding: 5px; box-sizing: border-box; background-color: rgba(142, 68, 173, 0.9); color: #FFF; text-align: center; font-weight: bold; overflow: hidden; z-index: 9999; } 
.purplecoat-inner { display: table; width: 100%; height: 100%; } 
.purplecoat-inner-text { display: table-cell; vertical-align: middle;}

.count{
    display: inline-block;
    position: relative;
    top: -8px;
    min-width: 10px;
    padding: 4px;
    font-size: 10px;
    font-weight: 500;
    color: #fff;
    line-height: 1;
    vertical-align: baseline;
    white-space: nowrap;
    text-align: center;
    background-color: #272727;
    border-radius: 15px;
}
.container-flush{
    margin-right: auto;
    margin-left: auto;
    padding-right: 0px;
    padding-left: 0px;
}
/*
      /$$$$$$                                      /$$      /$$                              
     /$$__  $$                                    | $$$    /$$$                              
    | $$  \__/ /$$$$$$$   /$$$$$$   /$$$$$$       | $$$$  /$$$$  /$$$$$$  /$$$$$$$  /$$   /$$
    |  $$$$$$ | $$__  $$ |____  $$ /$$__  $$      | $$ $$/$$ $$ /$$__  $$| $$__  $$| $$  | $$
     \____  $$| $$  \ $$  /$$$$$$$| $$  \ $$      | $$  $$$| $$| $$$$$$$$| $$  \ $$| $$  | $$
     /$$  \ $$| $$  | $$ /$$__  $$| $$  | $$      | $$\  $ | $$| $$_____/| $$  | $$| $$  | $$
    |  $$$$$$/| $$  | $$|  $$$$$$$| $$$$$$$/      | $$ \/  | $$|  $$$$$$$| $$  | $$|  $$$$$$/
     \______/ |__/  |__/ \_______/| $$____/       |__/     |__/ \_______/|__/  |__/ \______/ 
                                  | $$                                                       
                                  | $$                                                       
                                  |__/                                                       
*/
.snap-content {
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    width: auto;
    /*height: auto;*/
    z-index: 2;
    overflow: hidden;
    -webkit-overflow-scrolling: touch;
    -webkit-transform: translate3d(0, 0, 0);
       -moz-transform: translate3d(0, 0, 0);
        -ms-transform: translate3d(0, 0, 0);
         -o-transform: translate3d(0, 0, 0);
            transform: translate3d(0, 0, 0);
}

.snap-drawers {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  width: auto;
  height: auto;
}

.snap-drawer {
    position: absolute;
    top: 0;
    right: auto;
    bottom: 0;
    left: auto;
    width: 265px;
    height: auto;
    overflow: auto;
    -webkit-overflow-scrolling: touch;
    -webkit-transition: width 0.3s ease;
       -moz-transition: width 0.3s ease;
        -ms-transition: width 0.3s ease;
         -o-transition: width 0.3s ease;
            transition: width 0.3s ease;
}
.snap-drawer-content{
    height: auto;
    color: #999;
    background: #3c3c3c;
    border-color: #000000;
    border-bottom-left-radius: 5px;
    border-top-left-radius: 5px;
    box-shadow: inset -1px 1px 1px rgba(255,255,255,.15),0 1px 15px rgba(0,0,0,.5); 
    padding: 10px;
}
.snap-drawer-left {
    left: 0;
    z-index: 1;
}

.snap-drawer-right {
    right: 0;
    z-index: 1;
}

.snapjs-left .snap-drawer-right,
.snapjs-right .snap-drawer-left {
    display: none;
}

.snapjs-expand-left .snap-drawer-left,
.snapjs-expand-right .snap-drawer-right {
    width: 100%;
}
/*
      /$$$$$$                                /$$ /$$
     /$$__  $$                              | $$|__/
    | $$  \__/  /$$$$$$$  /$$$$$$  /$$$$$$$ | $$ /$$ /$$$$$$$   /$$$$$$   /$$$$$$$
    |  $$$$$$  /$$_____/ |____  $$| $$__  $$| $$| $$| $$__  $$ /$$__  $$ /$$_____/
     \____  $$| $$        /$$$$$$$| $$  \ $$| $$| $$| $$  \ $$| $$$$$$$$|  $$$$$$
     /$$  \ $$| $$       /$$__  $$| $$  | $$| $$| $$| $$  | $$| $$_____/ \____  $$
    |  $$$$$$/|  $$$$$$$|  $$$$$$$| $$  | $$| $$| $$| $$  | $$|  $$$$$$$ /$$$$$$$/
     \______/  \_______/ \_______/|__/  |__/|__/|__/|__/  |__/ \_______/|_______/
 */
#alienCanvas{border-radius: 10px;}
.scanlines {
    position: relative;
    overflow: hidden;
}
.scanlines:before, .scanlines:after {
  display: block;
  pointer-events: none;
  content: '';
  position: absolute;
}
.scanlines:before {
  width: 100%;
  height: 2px;
  z-index: 2147483649;
  background: rgba(0, 0, 0, 0.3);
  opacity: 0.75;
  -webkit-animation: scanline 6s linear infinite;
          animation: scanline 6s linear infinite;
}
.scanlines:after {
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 2147483648;
  background: -webkit-linear-gradient(top, transparent 50%, rgba(0, 0, 0, 0.3) 51%);
  background: linear-gradient(to bottom, transparent 50%, rgba(0, 0, 0, 0.3) 51%);
  background-size: 100% 4px;
  -webkit-animation: scanlines 1s steps(60) infinite;
          animation: scanlines 1s steps(60) infinite;
}

/* ANIMATE UNIQUE SCANLINE */
@-webkit-keyframes scanline {
  0% {
    -webkit-transform: translate3d(0, 200000%, 0);
            transform: translate3d(0, 200000%, 0);
  }
}
@keyframes scanline {
  0% {
    -webkit-transform: translate3d(0, 200000%, 0);
            transform: translate3d(0, 200000%, 0);
  }
}
@-webkit-keyframes scanlines {
  0% {
    background-position: 0 50%;
  }
}
@keyframes scanlines {
  0% {
    background-position: 0 50%;
  }
}

/*
     /$$$$$$            /$$$$$$                /$$$$$$$                               /$$
    |_  $$_/           /$$__  $$              | $$__  $$                             | $$
      | $$   /$$$$$$$ | $$  \__//$$$$$$       | $$  \ $$ /$$$$$$  /$$$$$$$   /$$$$$$ | $$
      | $$  | $$__  $$| $$$$   /$$__  $$      | $$$$$$$/|____  $$| $$__  $$ /$$__  $$| $$
      | $$  | $$  \ $$| $$_/  | $$  \ $$      | $$____/  /$$$$$$$| $$  \ $$| $$$$$$$$| $$
      | $$  | $$  | $$| $$    | $$  | $$      | $$      /$$__  $$| $$  | $$| $$_____/| $$
     /$$$$$$| $$  | $$| $$    |  $$$$$$/      | $$     |  $$$$$$$| $$  | $$|  $$$$$$$| $$
    |______/|__/  |__/|__/     \______/       |__/      \_______/|__/  |__/ \_______/|__/
*/
