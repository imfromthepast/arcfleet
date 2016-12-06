
'use strict';

function VirtualMap(config){
	  var sectorSize = this.sectorSize = config.sectorSize;
  	var width = (config && config.w + 'px') || '100%';
  	var height = (config && config.h + 'px') || '100%';
    var setViewX = (config && config.setViewX || 1);
    var setViewY = (config && config.setViewY || 1);
  	var mapWidth = (config && (config.totalCols * config.sectorSize) + 'px') || '100%';
  	var mapHeight = (config && (config.totalRows * config.sectorSize) + 'px') || '100%';

    this.onComplete = config.onComplete;
    this.sectorGeneratorFn = config.sectorGeneratorFn;
  	this.sectors = config.sectors;
    this.totalSectors = config.totalSectors || (config.sectors && config.sectors.length);
  	this.totalRows = (config && config.totalRows);
  	this.totalCols = (config && config.totalCols);

  	var scrollerY = VirtualMap.createScrollerY(sectorSize * this.totalRows);
  	var scrollerX = VirtualMap.createScrollerX(sectorSize * this.totalCols);
  	this.container = VirtualMap.createContainer(width, height);
  	this.container.appendChild(scrollerY);
  	this.container.appendChild(scrollerX);

  	//var screenSectorsAmt = Math.ceil(config.h / sectorSize) * Math.ceil(config.w / sectorSize);
  	this.screenSectorWidth = Math.ceil(config.w / sectorSize);
  	this.screenSectorHeight = Math.ceil(config.h / sectorSize);
    console.log('screenSectorWidth: '+this.screenSectorWidth);
  	// Cache 3 times the number of sectors that fit in the container viewport
  	this.cachedSectorWidth = this.screenSectorWidth + 10;
  	this.cachedSectorHeight = this.screenSectorHeight + 10;
  	this._renderChunk(this.container,setViewX,setViewY);
    //this.scroll(setViewX,setViewY);

  	var self = this;
  	var lastRepaintX;
  	var lastRepaintY;
  	var maxBufferX = this.screenSectorWidth * sectorSize;
  	var maxBufferY = this.screenSectorHeight * sectorSize;
    console.log('cachedSectors: '+this.cachedSectorWidth+'x'+this.cachedSectorHeight);
  	var lastScrolled = 0;

  	// As soon as scrolling has stopped, this interval asynchronously removes all
  	// the nodes that are not used anymore
  	this.rmNodeInterval = setInterval(function(){
  		if(Date.now() - lastScrolled > 100){
  			var badNodes = document.querySelectorAll('[data-rm="1"]');
  			for (var i = 0; i < badNodes.length; i++) {
  				self.container.removeChild(badNodes[i]);
  			};
  		}
  	}, 300);
  	function onScroll(e){
  		var scrollTop = e.target.scrollTop;
  		var scrollLeft = e.target.scrollLeft;
      console.log('scrollTop x scrollLeft: '+scrollTop+'x'+scrollLeft);
      console.log('Scroll: '+Math.ceil(scrollTop/self.sectorSize)+'x'+Math.ceil(scrollLeft/self.sectorSize));
  		//if((!lastRepaintY || Math.abs(scrollTop - lastRepaintY) > maxBufferY) || (!lastRepaintX || Math.abs(scrollLeft - lastRepaintX) > maxBufferX)){			
        var firstY = parseInt(scrollTop / self.sectorSize) - 0;
  			var firstX = parseInt(scrollLeft / self.sectorSize) - 0;
        console.log('first: '+firstX+','+firstY);
  			self._renderChunk(self.container, firstX < 1 ? 1 : firstX, firstY < 1 ? 1 : firstY);
  			lastRepaintX = scrollLeft;
  			lastRepaintY = scrollTop;
  		//}
  		lastScrolled = Date.now();
  		e.preventDefault && e.preventDefault();
  	}
  	//this.container.addEventListener('scroll', onScroll);
}
VirtualMap.prototype.scroll = function(x,y,sectorSize){
        var firstY = y - Math.ceil(this.screenSectorHeight/2);
        var firstX = x - Math.ceil(this.screenSectorWidth/2);
        console.log('firstY,firstX: '+firstY+','+firstX);

        this._renderChunk(this.container, firstX < 1 ? 1 : firstX, firstY < 1 ? 1 : firstY);
        
        this.lastScrolled = Date.now();
}
VirtualMap.prototype.createSector = function(fromX,fromY,x,y){
  	var sector;
    if (this.sectorGeneratorFn){
        sector = this.sectorGeneratorFn(x,y);
    }else{
        sector = this.sectors[x+'x'+y];
    }

    sector.style.height = this.sectorSize + 'px';
    sector.style.width = this.sectorSize + 'px';
    sector.style.top = (y * this.sectorSize) - (fromY * this.sectorSize) + 'px';
    sector.style.left = (x * this.sectorSize) - (fromX * this.sectorSize) + 'px';
    return sector;
}
/**
 * Renders a particular, consecutive chunk of the total sectors in the Map. To
 * keep acceleration while scrolling, we mark the nodes that are candidate for
 * deletion instead of deleting them right away, which would suddenly stop the
 * acceleration. We delete them once scrolling has finished.
 *
 * @param {Node} node Parent node where we want to append the children chunk.
 * @param {Number} from Starting position, i.e. first children index.
 * @return {void}
 */
VirtualMap.prototype._renderChunk = function(node, fromX, fromY) {
  console.log('render from: '+ fromX+','+fromY);
  var finalSectorX = fromX + this.cachedSectorWidth;
  var finalSectorY = fromY + this.cachedSectorHeight;
  if (finalSectorX > this.totalCols) finalSectorX = this.totalCols;
  if (finalSectorY > this.totalRows) finalSectorY = this.totalRows;
  console.log('render to: '+this.totalCols+':'+finalSectorX+','+this.totalRows+':'+finalSectorY);

  // Append all the new rows in a document fragment that we will later append to
  // the parent node
  var fragment = document.createDocumentFragment();
  for (var iY = fromY; iY < finalSectorY; iY++) {
    for(var iX = fromX; iX < finalSectorX; iX++){
    	fragment.appendChild(this.createSector(fromX,fromY,iX,iY));
    }
  }

  // Hide and mark obsolete nodes for deletion.
  for (var j = 1, l = node.childNodes.length; j < l; j++) {
    node.childNodes[j].style.display = 'none';
    node.childNodes[j].setAttribute('data-rm', '1');
  }
  node.appendChild(fragment);
  this.onComplete();
};

VirtualMap.createContainer = function(w, h) {
  var c = document.createElement('div');
  c.style.width = w;
  c.style.height = h;
  c.classList.add('map');
  c.style.overflow = 'hidden';
  c.style.position = 'relative';
  c.style.padding = 0;
  c.style.border = '1px solid black';
  // c.style['-webkit-overflow-scrolling'] = 'touch';
  return c;
};
VirtualMap.createScrollerX = function(w) {
	return VirtualMap.createScroller('1',w);
};
VirtualMap.createScrollerY = function(h) {
	return VirtualMap.createScroller(h,'1');
};
VirtualMap.createScroller = function(h,w) {
  console.log('scroller: '+h+','+w);
  var scroller = document.createElement('div');
  scroller.style.opacity = 0;
  scroller.style.position = 'absolute';
  scroller.style.top = 0;
  scroller.style.left = 0;
  scroller.style.width = w + 'px';
  scroller.style.height = h + 'px';
  return scroller;
};