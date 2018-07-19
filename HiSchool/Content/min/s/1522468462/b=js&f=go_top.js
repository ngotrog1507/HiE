$(document).ready(function(){$('body').append('<a onclick="$(\'html,body\').animate({scrollTop: 0},300);" id="go_top" title="Lên đầu trang" style="display:none"></a>');var bigs_top_bottom=60;var bigs_bottom=10;if(typeof Tawk_API=='undefined')
{var bigs_tawkchat=0;}
else
{var bigs_tawkchat=36;}
var gotop_check=function()
{if($(window).width()<768&&parseInt(bigs_tawkchat))
{$('#go_top').css({'right':'20px'});bigs_bottom=40;}
else
{$('#go_top').css({'right':'12px'});bigs_bottom=10;}
if(this.isIE6||this.isIE7)
{var p_top=$(window).scrollTop()+$(window).height()-parseInt(bigs_tawkchat)-parseInt(bigs_top_bottom);$('#go_top').css({'top':p_top+'px'});}
else
{$('#go_top').css({'bottom':(bigs_tawkchat+bigs_bottom)+'px'});}
if($(window).scrollTop()>100)
{$('#go_top').show();}
else
{$('#go_top').hide()}}
gotop_check();$(window).resize(function()
{gotop_check();});$(window).scroll(function()
{gotop_check();});});