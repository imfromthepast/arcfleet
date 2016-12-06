/* the norm */
#gritter-notice-wrapper {
	position:fixed;
	top:20px;
	right:20px;
	width:240px;
	z-index:9999;
}
#gritter-notice-wrapper.top-left {
    left: 20px;
    right: auto;
}
#gritter-notice-wrapper.bottom-right {
    top: auto;
    left: auto;
    bottom: 50px;
    right: 5px;
}
#gritter-notice-wrapper.bottom-left {
    top: auto;
    right: auto;
    bottom: 20px;
    left: 20px;
}
.gritter-item-wrapper {
	position:relative;
	margin:0 0 10px 0;
	/*background:url({!URLFOR($Resource.Gritter, "images/ie-spacer.gif")});*/ /* ie7/8 fix */ 
}
/*.gritter-top {
	background:url(../images/gritter.png) no-repeat left -30px;
	height:10px;
}*/
/*.hover .gritter-top {
	background-position:right -30px;
}*/
/*.gritter-bottom {
	background:url(../images/gritter.png) no-repeat left bottom;
	height:8px;
	margin:0;
}*/
/*.hover .gritter-bottom {
	background-position: bottom right;
}*/
.gritter-item {
	display:block;
	background: rgba(0,0,0,0.75);
	border-radius: 10px;
	color:#eee;
	padding:11px;
	font-size: 11px;
	font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
}
.hover .gritter-item {
	background: rgba(0,0,0,1);
}
.gritter-item p {
	padding:0;
	margin:0;
	word-wrap:break-word;
}
:focus {
	outline: 0;
}
.gritter-close:hover{
	color: #fff;
}
.gritter-close {
	display:none;
	position:absolute;
	top:5px;
	right:5px;
	background: rgba(0,0,0,1);
	font-size: 30px;
	line-height: 0.5;
	color: #fff;
	cursor:pointer;
	width:30px;
	height:30px;
	/*text-indent:-9999em;*/
}
.gritter-title {
	font-size:14px;
	font-weight:bold;
	padding:0 0 7px 0;
	display:block;
	text-shadow:1px 1px 0 #000; /* Not supported by IE :( */
}
.gritter-image {
	width:48px;
	height:48px;
	float:left;
}
.gritter-with-image,
.gritter-without-image {
	padding:0;
}
.gritter-with-image {
	width:220px;
	float:right;
}
/* for the light (white) version of the gritter notice */
.gritter-light .gritter-item,
.gritter-light .gritter-close {
    background: rgba(255,255,255,0.75);
    color: #222;
}
.gritter-light .gritter-title {
    text-shadow: none;
}
