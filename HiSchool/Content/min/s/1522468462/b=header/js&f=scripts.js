if(typeof jQuery==='undefined'){throw new Error('Uncaught Error: JavaScript requires jQuery')}
var bigs_header={tooltip:'body > header [data-toggle="tooltip"]',open_mobile_nav_module:'#open-mobile-nav-module',primary_nav:'body > header .navbar.primary'}
bigs_header.init=function(){$(bigs_header.tooltip).tooltip({trigger:'hover'});$(bigs_header.open_mobile_nav_module).sidr({name:'sidr-nav-module',source:'#nav-module-source',renaming:false,onOpen:function(){$(bigs_header.open_mobile_nav_module).addClass('active');$('body').css({'position':'fixed'});},onClose:function(){$(bigs_header.open_mobile_nav_module).removeClass('active');$('body').css({'position':'static'});}});}
$(window).on('resize',function(e){if($('body').hasClass('sidr-open')&&$(window).width()>=991){$.sidr('close','sidr-nav-module');}});$(window).on('scroll',function(e){var scroll_top=$(window).scrollTop(),scroll_height=$(bigs_header.primary_nav).height();if(scroll_top>scroll_height){$('body > header').addClass('on-scroll');}else{$('body > header').removeClass('on-scroll');}});$(document).ready(function(){bigs_header.init();});function showNotification(id,title,notify,module)
{if($('[id = "'+id+'"]').length)
{$('[id = "'+id+'"]').remove();}
if(typeof module=='undefined')
{module='exam';}
var html='<div class="modal-'+module+' modal fade" id="'+id+'" tabindex="-1" role="dialog">'
+'<div class="modal-dialog" role="document">'
+'<div class="modal-content">'
+'<div class="modal-header">'
+'<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>'
+'<h4 class="modal-title" id="myModalLabel">'+title+'</h4>'
+'</div>'
+'<div class="modal-body">'
+notify
+'</div>'
+'<div class="modal-footer"><button type="button" class="btn btn-primary" data-dismiss="modal">Đóng</button></div>'
+'</div>'
+'</div>'
+'</div>';$('body').append(html);$('[id = "'+id+'"]').modal();}
$(function(){function xsMenu(){var activeState=$("#xs-menu-container .xs-menu-list").hasClass("active");$("#xs-menu-container .xs-menu-list").animate({left:activeState?"0%":"-100%"},300);}
$("#xs-menu-button,.xs-overlay-1").click(function(event){event.stopPropagation();$("#xs-menu-button").toggleClass("open");$("#xs-menu-container .xs-menu-list").toggleClass("active");xsMenu();$("body").toggleClass("xs1-overflow-hidden");});$(".xs-menu-list").find(".accordion-toggle").click(function(){$(this).next().toggleClass("open").slideToggle("fast");$(this).toggleClass("active-tab").find(".menu-link").toggleClass("active");$(".xs-menu-list .accordion-content").not($(this).next()).slideUp("fast").removeClass("open");$(".xs-menu-list .accordion-toggle").not(jQuery(this)).removeClass("active-tab").find(".menu-link").removeClass("active");});});var fucnav=$(".md-nav-fuc");$(window).scroll(function(){var scroll=$(window).scrollTop();if(scroll>=50){fucnav.addClass("fixed");}else{fucnav.removeClass("fixed");}});