$('[data-toggle="tooltip"]').tooltip();(function($){$(".ripple-effect").click(function(e){var rippler=$(this);if(rippler.find(".ink").length==0){rippler.append("<span class='ink'></span>");}
var ink=rippler.find(".ink");ink.removeClass("animate");if(!ink.height()&&!ink.width())
{var d=Math.max(rippler.outerWidth(),rippler.outerHeight());ink.css({height:d,width:d});}
var x=e.pageX-rippler.offset().left-ink.width()/2;var y=e.pageY-rippler.offset().top-ink.height()/2;ink.css({top:y+'px',left:x+'px'}).addClass("animate");})})(jQuery);var hoverTimeout;$('#cat-dropdown-button').hover(function(){clearTimeout(hoverTimeout);$(this).addClass('open');},function(){var $self=$(this);hoverTimeout=setTimeout(function(){if(!$($self).hasClass('dropdown-static')){$self.removeClass('open');}},500);});$(document).ready(function(){var overlay=$('.sidebar-overlay');$('.sidebar-toggle').on('click',function(){var sidebar=$('#sidebar');sidebar.toggleClass('open');if((sidebar.hasClass('sidebar-fixed-left')||sidebar.hasClass('sidebar-fixed-right'))&&sidebar.hasClass('open')){overlay.addClass('active');$('body').css({"overflow":"hidden","position":"fixed"});}else{overlay.removeClass('active');$('body').css({"overflow":"auto","position":"static"});}});overlay.on('click',function(){$(this).removeClass('active');$('#sidebar').removeClass('open');$('body').css({"overflow":"auto","position":"static"});});});(function($){var dropdown=$('.dropdown');dropdown.on('show.bs.dropdown',function(e){});dropdown.on('hide.bs.dropdown',function(e){});})(jQuery);(function(removeClass){jQuery.fn.removeClass=function(value){if(value&&typeof value.test==="function"){for(var i=0,l=this.length;i<l;i++){var elem=this[i];if(elem.nodeType===1&&elem.className){var classNames=elem.className.split(/\s+/);for(var n=classNames.length;n--;){if(value.test(classNames[n])){classNames.splice(n,1);}}
elem.className=jQuery.trim(classNames.join(" "));}}}else{removeClass.call(this,value);}
return this;}})(jQuery.fn.removeClass);$(function(){function xsMenu(){var activeState=$("#xs-menu-container .xs-menu-list").hasClass("active");$("#xs-menu-container .xs-menu-list").animate({left:activeState?"0%":"-100%"},300);}
$("#xs-menu-button,.xs-overlay-1").click(function(event){event.stopPropagation();$("#xs-menu-button").toggleClass("open");$("#xs-menu-container .xs-menu-list").toggleClass("active");xsMenu();$("body").toggleClass("xs1-overflow-hidden");});$(".xs-menu-list").find(".accordion-toggle").click(function(){$(this).next().toggleClass("open").slideToggle("fast");$(this).toggleClass("active-tab").find(".menu-link").toggleClass("active");$(".xs-menu-list .accordion-content").not($(this).next()).slideUp("fast").removeClass("open");$(".xs-menu-list .accordion-toggle").not(jQuery(this)).removeClass("active-tab").find(".menu-link").removeClass("active");});});$("#owl-bs-tv").owlCarousel({loop:true,items:2,margin:10,nav:true,navigation:true,autoPlay:true,navigationText:['<i class="fa fa-angle-left"</i>','<i class="fa fa-angle-right"</i>'],responsive:{0:{items:1},600:{items:2},1000:{items:2}}});$("#doi-tac").owlCarousel({autoPlay:3000,items:8,itemsMobile:[479,4],itemsTablet:[992,6],});$('[data-toggle="tooltip-dt"]').tooltip();$(document).ready(function(){$(window).scroll(function(){var scroll_top=$(window).scrollTop(),scroll_height=700,scroll_max_height=$('.section-tin').height()-350;if(scroll_top>scroll_height&&scroll_top<scroll_max_height){$('#banner_exam').addClass('fixed');}else{$('#banner_exam').removeClass('fixed');}});});$("#tin-moi").owlCarousel({autoPlay:true,slideSpeed:300,paginationSpeed:400,items:1,itemsDesktop:false,itemsDesktopSmall:false,itemsTablet:false,itemsMobile:false});$('.xs-submenu-btn-sort-desc, .xs-overlay-2').on('click',function(){$('#xs-submenu-fade-in').toggleClass('show');$("body").toggleClass("xs2-overflow-hidden");});