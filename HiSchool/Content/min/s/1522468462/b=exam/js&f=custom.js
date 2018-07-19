$(document).ready(function()
{$(function()
{var ink,d,x,y;$(".tp-btn").click(function(e)
{if($(this).find(".ink").length===0)
{$(this).prepend("<span class='ink'></span>");}
ink=$(this).find(".ink");ink.removeClass("btn-effect");if(!ink.height()&&!ink.width())
{d=Math.max($(this).outerWidth(),$(this).outerHeight());ink.css({height:d,width:d});}
x=e.pageX-$(this).offset().left-ink.width()/2;y=e.pageY-$(this).offset().top-ink.height()/2;ink.css({top:y+'px',left:x+'px'}).addClass("btn-effect");});});$('.extend-btn').click(function()
{alert("First handler for .toggle() called.");$('.search-extend').toggle(200);});});$(function()
{$('input[class=upload-file]').change(function()
{var label=$(this).parent().find('span');if(typeof(this.files)!='undefined')
{if(this.files.length==0)
{label.removeClass('withFile').text(label.data('default'));}
else
{var file=this.files[0];var name=file.name;var size=(file.size/1048576).toFixed(3);label.addClass('withFile').text(name+' ('+size+'mb)');}}
else
{var name=this.value.split("\\");label.addClass('withFile').text(name[name.length-1]);}
return false;});});