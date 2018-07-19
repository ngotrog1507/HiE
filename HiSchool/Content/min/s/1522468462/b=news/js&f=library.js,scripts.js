jQuery(document).ready(function(){jQuery("#loading-layer").ajaxSend(function(){jQuery(this).show();});jQuery("#loading-layer").ajaxStop(function(){jQuery(this).fadeOut("slow");});jQuery("#loading-layer").ajaxComplete(function(){jQuery(this).fadeOut("slow");});if(window.IS_ADMIN){jQuery(".div_admin_config_form").css("display","");}
$('#user_name, #password').keypress(function(event){var keycode=(event.keyCode?event.keyCode:event.which);if(keycode=='13'){validate_login();}});$('#register_user_name, #register_password, #register_cp').keypress(function(event){var keycode=(event.keyCode?event.keyCode:event.which);if(keycode=='13'){validate_register();}});});var loading=false;function isEmail(email){var reg=/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;return reg.test(email);}
function on_submit_login(){var captcha="";if(count_regist>=3){captcha=jQuery("#captcha_login").val();}
if(!getValueId('user_name')||!getValueId('password')){count_regist++;log_faile('Đăng nhập không thành công');jQuery('#overlay').click(function(){jQuery.unblockUI();});setTimeout(jQuery.unblockUI,2000);}
else{if(getValueId('set_cookie','checked')){var jset_cookie='on';}
else{var jset_cookie='off';}
jQuery.post(WEB_DIR+"ajax.php?act=user&code=login_user",{user:getValueId('user_name'),pass:getValueId('password'),count:count_regist,captcha:captcha,set_cookie:jset_cookie},function(msg){if(msg=='success'){location.reload();}
else if(msg=='captcha_error'){log_faile('Mã bảo mật không chính xác.');}
else if(msg=='unsuccess'){count_regist++;log_faile('Đăng nhập không thành công.');}
else if(msg=='nodata'){count_regist++;log_faile('Đăng nhập không thành công.');}
else if(msg=='un_active'){count_regist++;log_faile('Tài khoản của bạn chưa được kích hoạt!<br />Vui lòng kiểm tra lại email của mình!<br />hoặc <a href="'+BASE_URL+'reg_success.html&cmd=active">vào đây</a> để kích hoạt lại.',1000000);}
else{log_faile(msg,1000000);jQuery('#overlay').click(function(){window.location.reload();});jQuery('#bound_log_faile').click(function(){window.location.reload();});}});}}
function on_submit_login_this(){if(!getValueId('user_name_this')||!getValueId('password_this')){log_faile('Đăng nhập không thành công');jQuery('#overlay').click(function(){jQuery.unblockUI();});setTimeout(jQuery.unblockUI,2000);}
else{if(getValueId('set_cookie','checked')){var jset_cookie='on';}
else{var jset_cookie='off';}
jQuery.post(WEB_DIR+"ajax.php?act=user&code=login_user",{user:getValueId('user_name_this'),pass:getValueId('password_this'),set_cookie:jset_cookie},function(msg){if(msg=='success'){location.reload();}
else if(msg=='unsuccess'){log_faile('Đăng nhập không thành công.');}
else if(msg=='nodata'){log_faile('Đăng nhập không thành công.');}
else if(msg=='un_active'){log_faile('Tài khoản của bạn chưa được kích hoạt!<br />Vui lòng kiểm tra lại email của mình!<br />hoặc <a href="'+BASE_URL+'reg_success.html&cmd=active">vào đây</a> để kích hoạt lại.',1000000);}
else{log_faile(msg,1000000);jQuery('#overlay').click(function(){window.location.reload();});jQuery('#bound_log_faile').click(function(){window.location.reload();});}});}}
function login_error(message){if(message)
message_all=message;else message_all='Bạn phải đăng nhập mới được dùng chức năng này';var str_openid='';str_height=99;if(OPENID_ON){str_openid='<div class="othrAcc" style="margin-left:70px;border-bottom:1px solid #cbcac8"> Đăng nhập dùng nick : <a class="google" href="'+OID_URL_GOG+'" title="Đăng nhập vào ChọnMón.vn bằng nick Google tại Google.com">Google</a> hoặc <a class="yahoo" href="'+OID_URL+'" title="Đăng nhập vào ChọnMón.vn bằng nick Yahoo tại Yahoo.com">Yahoo</a></div>';var str_height=130;}
jQuery.blockUI({message:'<div style="width:410px; border:1px solid #d1d4d3; background-color:#fff; padding:1px;" align="left"><div style=" height:26px; background-color:#A5120F" align="left"><span style=" line-height:26px;color: #fff; padding-left:10px;">Thông báo !</span><img src="style/images/i_close2.gif" width="13" height="13" id="close_box" title="Close..." style="cursor:pointer; padding:2px; margin-top:3px; _margin-top:0px; margin-left:300px; _margin-left:300px; position:absolute" /></div><div style=" background:url(style/images/bg_log_faile.gif) repeat-x bottom; min-height:99px;height:'+str_height+'px; "><div style="background:url(style/images/icon_log_login.gif) no-repeat 10px 10px; min-height:90px;_height:90px;"><div style="margin-left:76px; padding-top:20px;">'+message_all+'</div><div style="margin-top:10px;" align="center"><input type="button" name="sign_in" class="btnLogLogin"  id="login" value="Đăng nhập" /><input type="button" name="sign_in" class="btnLogOut"  id="no" value="Đóng" /></div></div>'+str_openid+'</div></div>',css:{border:'none',padding:0}});jQuery('#overlay').click(function(){jQuery.unblockUI();});jQuery('#login').mouseover(function(){jQuery(this).toggleClass("btnLogLoginOver");jQuery(this).removeClass("btnLogLogin");});jQuery('#login').mouseout(function(){jQuery(this).toggleClass("btnLogLogin");jQuery(this).removeClass("btnLogLoginOver");});jQuery('#no').mouseover(function(){jQuery(this).toggleClass("btnLogOutOver");jQuery(this).removeClass("btnLogOut");});jQuery('#no').mouseout(function(){jQuery(this).toggleClass("btnLogOut");jQuery(this).removeClass("btnLogOutOver");});jQuery('#close_box').click(function(){jQuery.unblockUI();});closeBlockUI();jQuery('#login').click(function(){login_div();});jQuery('#no').click(function(){jQuery.unblockUI();return false;});}
function set_client_cookie(cname,cvalue,exdays){var d=new Date();d.setTime(d.getTime()+(exdays*24*60*60*1000));var expires="expires="+d.toGMTString();document.cookie=cname+"="+cvalue+"; "+expires;}
function get_client_cookie(cname){var name=cname+"=";var ca=document.cookie.split(';');for(var i=0;i<ca.length;i++){var c=ca[i];while(c.charAt(0)==' ')c=c.substring(1);if(c.indexOf(name)!=-1)return c.substring(name.length,c.length);}
return"";}
function validate_login(){if(!getValueId('user_name')){$("p.error").hide();$("#error_user_name").show();$("#user_name").focus();}else if(!getValueId('password')){$("p.error").hide();$("#error_password").show();$("#password").focus();}else{if(getValueId('set_cookie','checked')){var jset_cookie='on';}else{var jset_cookie='off';}
var data={user:getValueId('user_name'),pass:getValueId('password'),set_cookie:jset_cookie};jQuery.post(WEB_DIR+"ajax.php?act=user&code=login_user",data,function(msg){if(msg=='success'){var remember=$('#set_cookie:checked').val();if(remember){set_client_cookie('client_username',getValueId('user_name'),365);set_client_cookie('client_password',getValueId('password'),365);set_client_cookie('client_remember',"1",365);}else{set_client_cookie('client_username',null,365);set_client_cookie('client_password',null,365);set_client_cookie('client_remember',"0",365);}
if($('#islanding').val()==1||$('#islanding').val()==2)
location.href='http://cpvm.vn/?play=1';else if($('#playnow').val()==1){var url=location.protocol+'//'+location.host+location.pathname;location.href=url+'?play=1';}else
location.reload();}
else if(msg=='unsuccess'){$("p.error").hide();$("#error_general").text('Không tồn tại tài khoản hoặc mật khẩu sai').show();}
else if(msg=='nodata'){$("p.error").hide();$("#error_general").text('Không tồn tại tài khoản hoặc mật khẩu sai').show();}
else{$("p.error").hide();$("#error_general").text('Không tồn tại tài khoản hoặc xác nhận mật khẩu sai').show();}});}}
function validate_register(){if(!getValueId('register_user_name')){$("p.error").hide();$("#error_register_name").show();$("#register_user_name").focus();}else if(!getValueId('register_password')){$("p.error").hide();$("#error_register_password").show();$("#register_password").focus();}else if(!getValueId('register_cp')){$("p.error").hide();$("#error_register_cp").show();$("#register_cp").focus();}else if($('#register_src').val()==-1){$("p.error").hide();$("#error_register_src").show();$("#register_src").focus();}else{var src=get_client_cookie('source');console.log($('#register_src').val());if(($('#register_src').val()==''||$('#register_src').val()==undefined)&&src!='')
var data={user:getValueId('register_user_name'),pass:getValueId('register_password'),confirm:getValueId('register_cp'),mobile:getValueId('register_mobile'),src:src};else
var data={user:getValueId('register_user_name'),pass:getValueId('register_password'),confirm:getValueId('register_cp'),mobile:getValueId('register_mobile'),src:getValueId('register_src')};jQuery.post(WEB_DIR+"ajax.php?act=user&code=register_user",data,function(msg){if(msg=='success'){set_client_cookie('src','',-1);if($('#islanding').val()==1)
location.href='http://cpvm.vn/landingpage.html?cmd=success';else if($('#islanding').val()==2)
location.href='http://cpvm.vn/?play=1';else if($('#playnow').val()==1){var url=location.protocol+'//'+location.host+location.pathname;location.href=url+'?play=1';}else
location.reload();}
else if(msg=='unsuccess'){$("p.error").hide();$("#register_error_general").text('Đăng ký không thành công').show();}
else if(msg=='specialchar'){$("p.error").hide();$("#register_error_general").text('Tài khoản chứa ký tự đặc biệt').show();}
else if(msg=='wronglen'){$("p.error").hide();$("#register_error_general").text('Tài khoản chỉ từ 6 đến 20 ký tự').show();}
else if(msg=='specialpass'){$("p.error").hide();$("#register_error_general").text('Mật khẩu chỉ từ 6 đến 20 ký tự').show();}
else if(msg=='existacc'){$("p.error").hide();$("#register_error_general").text('Tài khoản đã có trong hệ thống').show();}
else if(msg=='wrongconfirm'){$("p.error").hide();$("#register_error_general").text('Xác nhận mật khẩu sai').show();}
else if(msg=='wrongsrc'){$("p.error").hide();$("#register_error_general").text('Chưa điền bạn đến từ nguồn nào').show();}
else{$("p.error").hide();$("#register_error_general").text('Xác nhận mật khẩu sai').show();}});}}
function change_form(type){if(type==0){$('#login_form').show();$('#register_form').hide();}else{$('#login_form').hide();$('#register_form').show();}}
function open_login(type){if($('#check_login').val()==1)
location.href='http://cpvm.vn/?play=1';if(type==1)
$('#playnow').val(1);else
$('#playnow').val(0);var client_username=get_client_cookie('client_username');var client_password=get_client_cookie('client_password');var client_remember=get_client_cookie('client_remember');if(client_username!="null"&&client_password!="null"&&client_username!=null){$("#user_name").val(client_username);$("#password").val(client_password);}
if(client_remember=="1"){$("#set_cookie").attr("checked",true);}else{$("#set_cookie").attr("checked",false);}
open_dialog('frm_user');}
function login_div(){var fw=$(window).width().toString().replace("px","");var block=$(".pop-content");if($(block).size()>0){var bw=$(block).width().toString().replace("px","");var ml=((fw-bw)/2);$(block).css({"left":ml+"px"});}
if(count_regist>=3){var captcha='<table><tr><td><label for="captcha_login" style="font-weight:normal; width:120px;color:#000">Mã bảo mật:</label>&nbsp;&nbsp;</td>';captcha+='<td><img id="captcha_img" alt="captcha" src="/captcha.php" style="margin-right:10px" width="50" height="23"/></td><td><img id="reload_button" onclick="fn_reload_captcha()" src="/style/images/indicator_arrows_static.gif" title="Tạo mã khác" alt="Tạo mã khác" class="creatNewCaptchaButton"></td>';captcha+='<td><input name="captcha_login" type="text" id="captcha_login" maxlength="100"  style="width:50px;"></td></tr></table>';jQuery("#field_captcha").html(captcha);jQuery("#captcha_img").attr({src:'/captcha.php'+'?'+(new Date()).getTime()});}
$("#login_wrapper").fadeIn();var client_username=get_client_cookie('client_username');var client_password=get_client_cookie('client_password');var client_remember=get_client_cookie('client_remember');if(client_username!="null"&&client_password!="null"&&client_username!=null){$("#user_name").val(client_username);$("#password").val(client_password);}
if(client_remember=="1"){$("#set_cookie").attr("checked",true);}else{$("#set_cookie").attr("checked",false);}
jQuery("#btn_login").click(function(){validate_login();return false;});return false;}
function close_login_dialog(){$("#login_wrapper").fadeOut();return false;}
function log_success(message_all,livetime){jQuery.blockUI({message:'<div style="width:360px; border:1px solid #d1d4d3; background-color:#fff; padding:1px;" align="left"><div style=" height:26px; background-color:#A5120F" align="left"><span style=" line-height:26px;color: #fff; padding-left:10px;">Thông báo !</span></div><div style=" background:url(style/images/bg_log_faile.gif) repeat-x bottom; min-height:119px;_height:119px;"><div style="background:url(style/images/icon_log_success.gif) no-repeat 10px 20px; min-height:119px;_height:119px;"><div style="margin-left:76px; padding-top:40px">'+message_all+'</div></div></div></div>',css:{border:'none',padding:0}});jQuery('div.blockUI').click(function(){jQuery.unblockUI();});if(livetime)
livetime_all=livetime;else livetime_all=0;setTimeout(jQuery.unblockUI,livetime_all);}
function log_faile(message_all,livetime){is_hided_blockUI=0;jQuery.blockUI({message:'<div id="bound_log_faile" style="width:360px;border:1px solid #d1d4d3; background-color:#fff; padding:1px;" align="left"><div style=" height:26px; background-color:#c12000" align="left"><span style=" line-height:26px;color: #fff; padding-left:10px;">Thông báo !</span></div><div style=" background:url(style/images/bg_log_faile.gif) repeat-x bottom; min-height:119px;_height:119px;"><div style="background:url(style/images/icon_log_faile.gif) no-repeat 10px 20px; min-height:119px;_height:119px;"><div style="margin-left:76px; padding-top:40px">'+message_all+'</div></div></div></div>',css:{border:'none',padding:0}});jQuery('div.blockUI').click(function(){jQuery.unblockUI();is_hided_blockUI=1;});if(livetime)
livetime_all=livetime;else livetime_all=0;setTimeout(hide_blockUI,livetime_all);}
function hide_blockUI(){if(is_hided_blockUI)return;jQuery.unblockUI();}
function closeBlockUI(){jQuery(window).keydown(function(e){if(e.which==27){jQuery.unblockUI();}});}
function getValueId(id,type,svalue){if(document.getElementById(id)){if(typeof(type)=='undefined'){var type='value';}
if(typeof(svalue)=='undefined'){var svalue='';}
if(type=='value'){return document.getElementById(id).value;}
else if(type=='checked'){return document.getElementById(id).checked;}
else if(type=='assign'){return document.getElementById(id).value=svalue;}
else{return'';}}}
function MM_preloadImages(){var d=document;if(d.images){if(!d.MM_p)d.MM_p=new Array();var i,j=d.MM_p.length,a=MM_preloadImages.arguments;for(i=0;i<a.length;i++)
if(a[i].indexOf("#")!=0){d.MM_p[j]=new Image;d.MM_p[j++].src=a[i];}}}
function getVar(href_val){var arr_view=new Array();if(href_val){var view=href_val.replace(/^.*#/,'');}
else{var view=(window&&window.location&&window.location.hash)?window.location.hash:'#inbox';view=view.replace(/^.*#/,'');}
arr_view=view.split('index.html');return arr_view;}
Array.prototype.inArray=function(value){var i;for(i=0;i<this.length;i++){if(this[i]==value){return true;}}
return false;};function Shuffle_arr(v){for(var j,x,i=v.length;i;j=parseInt(Math.random()*i),x=v[--i],v[i]=v[j],v[j]=x);return v;}
function in_array(needle,haystack,argStrict){var key='',strict=!!argStrict;if(strict){for(key in haystack){if(haystack[key]===needle){return true;}}}else{for(key in haystack){if(haystack[key]==needle){return true;}}}
return false;}
function overlay(curobj,subobjstr,opt_position){if(document.getElementById){var subobj=document.getElementById(subobjstr)
subobj.style.display=(subobj.style.display!="block")?"block":"none"
var xpos=getposOffset(curobj,"left")+((typeof opt_position!="undefined"&&opt_position.indexOf("right")!=-1)?-(subobj.offsetWidth-curobj.offsetWidth):0)
var ypos=getposOffset(curobj,"top")+((typeof opt_position!="undefined"&&opt_position.indexOf("bottom")!=-1)?curobj.offsetHeight:0)
if((typeof opt_position!="undefined"&&opt_position.indexOf("top")!=-1))
ypos=getposOffset(curobj,"top")-subobj.offsetHeight-3;subobj.style.left=xpos+"px";subobj.style.top=ypos+"px";return false}
else
return true}
function overlayclose(subobj){if(document.getElementById(subobj)){document.getElementById(subobj).style.display="none";}}
function getposOffset(overlay,offsettype){var totaloffset=(offsettype=="left")?overlay.offsetLeft:overlay.offsetTop;var parentEl=overlay.offsetParent;while(parentEl!=null){totaloffset=(offsettype=="left")?totaloffset+parentEl.offsetLeft:totaloffset+parentEl.offsetTop;parentEl=parentEl.offsetParent;}
return totaloffset;}
function number_format(Num){if(Num==undefined)
Num=0;Num=Num.toString().replace(/^0+/,"").replace(/\./g,"").replace(/,/g,"");Num=""+parseInt(Num);var temp1="";var temp2="";if(Num==0||Num==undefined||Num=='0'||Num==''||isNaN(Num)){return 0;}
else{var count=0;for(var k=Num.length-1;k>=0;k--){var oneChar=Num.charAt(k);if(count==3){temp1+=".";temp1+=oneChar;count=1;continue;}
else{temp1+=oneChar;count++;}}
for(var k=temp1.length-1;k>=0;k--){var oneChar=temp1.charAt(k);temp2+=oneChar;}
return temp2;}}
function currency_to_number(value){return Number(value.replace(/[$.]+/g,""));}
function dumpObj(obj,level){var output="";if(!level)level=0;var padding="";for(var j=0;j<level+1;j++){padding+="    ";}
if(typeof(obj)=='object'){for(var item in obj){var value=obj[item];if(typeof(value)=='object'){output+=padding+"'<b>"+item+"'</b>=><b>{</b>\n";output+=dumpObj(value,level+1);}else{output+=padding+"  '<b>"+item+"</b>' => \"<i>"+value+"</i>\",\n";}}
output+=padding+'<b>}</b>\n';}else{output="===>"+obj+"<===("+typeof(obj)+")";}
return output;}
function fn_reload_captcha(){jQuery('#reload_button').attr({src:"/style/images/indicator_arrows.gif"});jQuery("#captcha_img").attr({src:'/captcha.php'+'?'+(new Date()).getTime()});setTimeout(function(){jQuery('#reload_button').attr({src:"/style/images/indicator_arrows_static.gif"});},500);}
function readURL(input){if(input.files&&input.files[0]){var reader=new FileReader();reader.onload=function(e){jQuery('#blah').attr('src',e.target.result)};reader.readAsDataURL(input.files[0]);}}
function check_district(ftype){ftype=typeof ftype!=='undefined'?ftype:0;$('#loading-layer').show();jQuery.post(WEB_DIR+"ajax.php?act=default&code=check_district",{},function(data){$('#loading-layer').hide();if(!isNaN(data)){if(ftype!=0)
window.location.href=WEB_DIR+"nha-hang/"+data+"/"+ftype+".html";else
window.location.href=WEB_DIR+"nha-hang/"+data+".html";}else{if(ftype!=0)
choice_district(data,"index.html",ftype);else
choice_district(data,"index.html");}});}
function choice_district(data,link,ftype){ftype=typeof ftype!=='undefined'?ftype:0;var ftype_str='';if(ftype!=0)
ftype_str='<input type="hidden" name="ftype" value="'+ftype+'" />';var back_btn='';var popup_content=str_join
('<div id="cart-check-out-step1" style="margin:0 auto;width:555px;text-align:left">')
('<div style="background-color: transparent;">')
('<div style="padding: 0px; color: black; font-size: 12px; height: auto; display: block;" id="popup-container">')
('<div class="classic-popup_eb">')
('<div class="classic-popup-top_eb">')
('<div class="right_eb">')
('<div class="bg_eb"></div>')
('</div>')
('</div>')
('<div class="classic-popup-main_eb">')
('<div class="classic-popup-title_eb">')
('<div class="fl_eb">Chọn địa điểm của bạn</div>')
('<a onclick="pay_cancel();" title="Đóng" class="classic-popup-close_eb" href="javascript:void(0)">x</a>')
('<div class="c_eb"></div>')
('</div>')
('<div class="classic-popup-content_eb">')
('<form name="choiceDistrictPopupForm" id="choiceDistrictPopupForm" method="get" action="'+link+'">')
('<div style="padding:20px; padding-right:0px; width:530px">')
('<div id="search_select" style="padding-right:15px;">')
('<select class="select" title="Bạn đang ở tỉnh thành nào?" name="city" id="popup_city" onchange="change_popup_city()">')
('<option value="0">Bạn đang ở tỉnh thành nào?</option>')
(data)
('</select>')
('</div>')
('<div id="search_select">')
('<select class="select" title="Quận" name="district" id="popup_district">')
('<option value="0">Quận</option>')
('</select>')
('</div>')
('<div class="c_eb"></div>')
('<div id="search_button" style="padding-top:10px">')
(ftype_str)
('<input type="image" src="images/btnChoice.png" />')
('</div>')
('</div>')
('</form>')
('</div>')
('</div>')
('<div class="classic-popup-bottom_eb">')
('<div class="right_eb">')
('<div class="bg_eb"></div>')
('</div>')
('</div>')
('</div>')
('</div>')
('</div>')
('</div>')();pay_popup(popup_content);if(!$.browser.opera){var arr=['popup_city','popup_district'];$.each(arr,function(){var title=$('#'+this).attr('title');if($('option:selected','#'+this).val()!='')title=$('option:selected','#'+this).text();$('#'+this).css({'z-index':10,'opacity':0,'-khtml-appearance':'none'}).after('<span class="select" id="'+$('#'+this).attr('id')+'_span" style="border:1px solid #bbb;">'+title+'</span>')});$('#popup_city').change(function(){val=$('option:selected','#popup_city').text();$('#popup_city').next().text(val);});$('#popup_district').change(function(){val=$('option:selected','#popup_district').text();$('#popup_district').next().text(val);});};}
function change_popup_city(){jQuery.get(WEB_DIR+"ajax.php?act=default&code=find_district",{city:getValueId('popup_city')},function(msg){data='<option value = "0">Quận</option>'+msg;$("#popup_district").html(data);$("#popup_district").val("0");$("#popup_district_span").html("Quận");});}
function str_join(str){var store=[str];return function extend(other){if(other!=null&&'string'==typeof other){store.push(other);return extend;}
return store.join('');}}
function pay_popup(popUpContent){jQuery('body').block({message:popUpContent,overlayCSS:{opacity:0.8,background:'#000000'},centerY:false,css:{top:(jQuery(window).scrollTop()+50)+'px',border:'none',width:'900px','background-color':'transparent'}});}
function message_popup(message_content){jQuery('body').block({message:message_content,overlayCSS:{opacity:0.8,background:'#000000'},centerY:true,position:'static',css:{top:(jQuery(window).scrollTop()+50)+'px',border:'none',width:'900px','background-color':'transparent'}});}
function close_message(){jQuery.unblockUI();return false;}
function pay_cancel(update){jQuery.unblockUI();return false;}
function show_message(message){var popup=' <div id="frm_message" class="frame_block">';popup+='<div class="chonmon_block">';popup+='<div class="chonmon_block_padding">';popup+='<div class="chonmon_block_heading">';popup+='<h3 class="left">Thông báo</h3>';popup+='<div class="right close_button">&nbsp;</div>';popup+='</div>';popup+='<div class="chonmon_block_content">';popup+='<div class="message clearfix" style="margin-bottom: 10px; font-size: 13px">';popup+='<p align="center">Thông tin của bạn đã được thay đổi</p>';popup+='</div>';popup+='<div align="center">';popup+='<input type="button" class="close_btn" value=" Đóng cửa sổ " />';popup+='</div>';popup+='</div>';popup+='</div>';popup+='</div>';popup+='</div>';var check_exists=$("#frm_message").size();if(check_exists==0){$("body").append($(popup));}
$('#frm_message .chonmon_block_content p').text(message);$('#frm_message .close_button, #frm_message .close_btn').click(function(){close_dialog('frm_message');})
open_dialog('frm_message');}
function change_lang(lang,referer_url){if($('#referer_url').val()!=undefined&&$('#referer_url').val()!='')
referer_url=$('#referer_url').val();var web_domain='.suma.vn';if(lang==1)
jQuery.cookie('lang',2,{path:'/',expires:1,domain:web_domain});else
jQuery.cookie('lang',1,{path:'/',expires:1,domain:web_domain});if(referer_url!=undefined&&referer_url!=''){if(decode_base64(referer_url).length==3&&decode_base64(referer_url).indexOf('vi')==0)
window.location.href=WEB_DIR;else
window.location.href=WEB_DIR+decode_base64(referer_url);}else
window.location.href=WEB_DIR+'vi';return false;}
function add_to_cart(id,price,number){if(loading){return false;}
loading=true;if(number==undefined)
number=$('#product_number').val();if(id<=0||number<=0||price<=0)
return;$('#loading-layer').show();jQuery.post(WEB_DIR+"ajax.php?act=default&code=add_to_cart",{id:id,num:number,price:price},function(data){if(data[4]==1){$(".sm_block_heading strong").text('Notice');}else{$(".sm_block_heading strong").text('Thông báo');}
$("#frm_cart_message .main_message").html(data[3]);open_dialog('frm_cart_message');$('#cart_content').html(data[2]);$('#loading-layer').hide();loading=false;window.setTimeout(function(){close_dialog('frm_cart_message');},2000);},'json');}
function decode_base64(s){var e={},i,k,v=[],r='',w=String.fromCharCode;var n=[[65,91],[97,123],[48,58],[43,44],[47,48]];for(z in n){for(i=n[z][0];i<n[z][1];i++){v.push(w(i));}}
for(i=0;i<64;i++){e[v[i]]=i;}
for(i=0;i<s.length;i+=72){var b=0,c,x,l=0,o=s.substring(i,i+72);for(x=0;x<o.length;x++){c=e[o.charAt(x)];b=(b<<6)+c;l+=6;while(l>=8){r+=w((b>>>(l-=8))%256);}}}
return r;}
var arrKeyCode={BACKSPACE:8,TAB:9,ENTER:13,SHIFT:16,CTRL:17,ESCAPE:27,SPACE:32,PAGE_UP:33,PAGE_DOWN:34,END:35,HOME:36,LEFT:37,UP:38,RIGHT:39,DOWN:40,DELETE:46,NUMPAD_MULTIPLY:106,NUMPAD_ADD:107,NUMPAD_ENTER:108,NUMPAD_SUBTRACT:109,NUMPAD_DECIMAL:110,NUMPAD_DIVIDE:111,PERIOD:190,COMMA:188};(function($){$.popupCommon=function(objSetting){var settings=$.extend({wrapHtml:''+'<div class="popup-common">'+'<div class="overlay-bl-bg"></div>'+'<div class="pop-content">'+'<div class="opacity-border"></div>'+'<div class="wrap-content sys_wrap_popup_content">'+'<div class="main-content">'+'html <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> content'+'</div>'+'</div>'+'<img class="closePopup" src="/images/close-hoangnm.png" alt="CLOSE">'+'</div>'+'</div>',htmlContent:'<div style="padding: 10px;color: red;text-align: center;font-size: 14px;">Có lỗi xảy ra trong quá trình xử lý, vui lòng thử lại!</div>',attrId:'sys_popup_common',widthPop:'700px',toParent:null,successOpen:function(){},preClose:function(){}},objSetting||{});var _$this=null;function initPopup(){if(settings.toParent){_$this=$(settings.wrapHtml).appendTo($(settings.toParent));}else{_$this=$(settings.wrapHtml).appendTo("body");}
_$this.attr("id",settings.attrId);_$this.find(".main-content").first().html(settings.htmlContent);_$this.css({"display":"block","visibility":"hidden"});$("body").css("overflow","hidden");var popContent=_$this.find(".pop-content").css("width",settings.widthPop);var setTopCSS,setLeftCSS;setTopCSS=Math.abs(($(window).height()-popContent.height())/2-$(window).height()/10);setLeftCSS=Math.abs(($(window).width()-popContent.width())/2);popContent.css({"top":setTopCSS,"left":setLeftCSS});_$this.css({"display":"none","visibility":"visible"});_$this.fadeIn();onEvents();if($.isFunction(settings.successOpen)){settings.successOpen.call(this);}}
function onEvents(){$("#"+settings.attrId).on("click.closePopup",".closePopup,.overlay-bl-bg",function(){if($.isFunction(settings.preClose)){settings.preClose.call(this);}
$("#"+settings.attrId).fadeOut(function(){$(this).remove();$("body").off("keydown.closePopup").css("overflow","");});});$("#"+settings.attrId).on("click",".main-content",function(e){e.stopPropagation();});$("body").on("keydown.closePopup",function(e){var getCode=e.keyCode?e.keyCode:e.which;if(getCode==arrKeyCode.ESCAPE){$("#"+settings.attrId).find(".closePopup").trigger("click");}});}
initPopup();};}(jQuery));;if(typeof jQuery==='undefined'){throw new Error('Uncaught Error: JavaScript requires jQuery')}
var bigs_news={tooltip:'[data-toggle="tooltip"]'};bigs_news.init=function(){$(bigs_news.tooltip).tooltip();};$(document).ready(function(){bigs_news.init();});$(window).on('scroll',function(e){var scroll_top=$(window).scrollTop(),scroll_height=$(".header_top").height();if(scroll_top>scroll_height){$('body > header').addClass('on-scroll');}else{$('body > header').removeClass('on-scroll');}});