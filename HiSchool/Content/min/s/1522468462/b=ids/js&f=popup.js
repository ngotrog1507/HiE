var follow_loading=false;var loading=false;$(document).ready(function(){var popup_url_on_hover=false;var popup_info_on_hover=false;var popup_info_show=false;var this_url;var last_popup_user_id=0;var lastPopupData={id:0,data:{},}
$('[data-popup-user-id]').hover(function(){this_url=this;popup_url_on_hover=true;onHoverEvent();},function(){popup_url_on_hover=false;onHoverEvent();});$(document).on({mouseenter:function(){popup_info_on_hover=true;onHoverEvent();},mouseleave:function(){popup_info_on_hover=false;onHoverEvent();}},'.tp-popup-wrapper');function onHoverEvent(){if(popup_url_on_hover==true||popup_info_on_hover==true){setTimeout(function(){showInfoPopup();},400);}else if(popup_url_on_hover==false||popup_info_on_hover==false){setTimeout(function(){removeInfoPopup();},10);}}
function removeInfoPopup(){if(popup_url_on_hover==false&&popup_info_on_hover==false){$('.tp-popup-wrapper').remove();popup_info_show=false;}}
function showInfoPopup(){if((popup_url_on_hover==true||popup_info_on_hover==true)&&(popup_info_show==false||last_popup_user_id!=$(this_url).data('popup-user-id'))){last_popup_user_id=$(this_url).data('popup-user-id');popup_info_show=true;$('.tp-popup-wrapper').remove();var pos=$(this_url).offset();$('body').append('<div class="tp-popup-wrapper" style="top: '+parseInt(pos.top+$(this_url).height()+8)+'px; left: '+parseInt(pos.left)+'px;">'+'<div id="popup_cover_div" class="tp-info-popup '+$(this_url).data('color')+'">'+'<div class="rgbabg"></div><a href="'+URL_IDS+'personal.html?id='+$(this_url).data('popup-user-id')+'">'+'<h4>'+$(this_url).data('popup-user-name')+' <span id="popup-fb-url"></span></h4></a>'+'<span style="display: block; height: 18px;"><p id="popup_student_info" style="display:none;"><strong id="popup_follow_count">...</strong><em>bạn theo học</em></p></span>'+'<div class="number-wrapper">'+'<div class="col-md-12">'+'<div class="col-md-offset-1 col-md-2 text-center"><a href="'+URL_CLASS+'profile.html?cmd=teacher&id='+$(this_url).data('popup-user-id')+'"><i class="tp-icon-bg-40 blue"></i></a></div>'+'<div class="col-md-2 text-center"><a href="'+URL_EXAM+'personal.html?id='+$(this_url).data('popup-user-id')+'"><i class="tp-icon-bg-40 green"></i></a></div>'+'<div class="col-md-2 text-center"><a href="'+URL_GAME+'"><i class="tp-icon-bg-40 red"></i></a></div>'+'<div class="col-md-2 text-center"><a href="'+URL_ASK+'personal.html?id='+$(this_url).data('popup-user-id')+'"><i class="tp-icon-bg-40 brown"></i></a></div>'+'<div class="col-md-2 text-center"><a href="'+URL_LIB+'profile.html?uid='+$(this_url).data('popup-user-id')+'"><i class="tp-icon-bg-40 orange"></i></a></div>'+'</div>'+(parseInt($(this_url).data('user-id'))>0?('<div  class="clearfix"></div><a style="display:none;" id="popup_follow_button" onclick="popup_follow('+$(this_url).data('user-id')+', '+$(this_url).data('popup-user-id')+', this);return false;" class="tp-btn">...</a>'):'')
+'</div>'+'</div>'+'</div>');if(lastPopupData.id==$(this_url).data('popup-user-id')){res=lastPopupData.data;if(res.value.userInfo.cover_url!=''){$('#popup_cover_div').attr('style','background: url('+res.value.userInfo.cover_url+');');}
if(res.value.userInfo.facebook){$('#popup-fb-url').html('<i class="fa fa-facebook-square" onclick="window.open(\''+res.value.userInfo.facebook+'\', \'_blank\');return false;"></i>');}
if(res.value.follow){$('#popup_follow_button').html('<i class="fa fa-check"></i> Đang '+(($(this_url).data('user-group')==2||$(this_url).data('user-group')==3)?'Quan tâm':'Theo học'));}else{$('#popup_follow_button').html('<i class="fa fa-rss"></i> '+(($(this_url).data('user-group')==2||$(this_url).data('user-group')==3)?'Quan tâm':'Theo học'));}
if(res.value.isTeacher){$('#popup_follow_count').html(res.value.userInfo.afl);if($(this_url).data('user-id')!=$(this_url).data('popup-user-id')){$('#popup_follow_button').show();}
$('#popup_student_info').show();}
if(res.value.isStudent){$('#popup_student_info').html('Học sinh lớp '+res.value.userInfo['class']);$('#popup_student_info').show();}}else{$.ajax({url:'https://ids.bigschool.vn/services/api/popup_user_info.php?uid='+$(this_url).data('user-id')+'&pid='+$(this_url).data('popup-user-id'),type:"GET",beforeSend:function(){},success:function(res){if(res.status==true){if(res.value.userInfo.cover_url!=''){$('#popup_cover_div').attr('style','background: url('+res.value.userInfo.cover_url+');');}
if(res.value.userInfo.facebook){$('#popup-fb-url').html('<i class="fa fa-facebook-square" onclick="window.open(\''+res.value.userInfo.facebook+'\', \'_blank\');return false;"></i>');}
if(res.value.follow){$('#popup_follow_button').html('<i class="fa fa-check"></i> Đang '+(($(this_url).data('user-group')==2||$(this_url).data('user-group')==3)?'quan tâm':'theo học'));}else{$('#popup_follow_button').html('<i class="fa fa-rss"></i> '+(($(this_url).data('user-group')==2||$(this_url).data('user-group')==3)?'Quan tâm':'Theo học'));}
if(res.value.isTeacher){$('#popup_follow_count').html(res.value.userInfo.afl);if($(this_url).data('user-id')!=$(this_url).data('popup-user-id')){$('#popup_follow_button').show();}
$('#popup_student_info').show();}
if(res.value.isStudent){$('#popup_student_info').html('Học sinh lớp '+res.value.userInfo['class']);$('#popup_student_info').show();}
lastPopupData.id=$(this_url).data('popup-user-id');lastPopupData.data=res;}},complete:function(){}});}}}
popup_follow=function(fid,uid,_this){if(follow_loading){return false;}
follow_loading=true;$.ajax({type:'POST',url:"https://ids.bigschool.vn/ajax.php",data:{"act":"follow","uid":uid,'fid':fid},crossDomain:true,success:function(result){if(result==1){lastPopupData.data.value.follow=true;lastPopupData.data.value.userInfo.afl=parseInt($('#popup_follow_count').html())+1;$(_this).html('<i class="fa fa-check"></i> Đang '+(($(this_url).data('user-group')==2||$(this_url).data('user-group')==3)?'quan tâm':'theo học'));$('#popup_follow_count').html(parseInt($('#popup_follow_count').html())+1);}else if(result==2){lastPopupData.data.value.follow=false;lastPopupData.data.value.userInfo.afl=parseInt($('#popup_follow_count').html())-1;$(_this).html('<i class="fa fa-rss"></i> '+(($(this_url).data('user-group')==2||$(this_url).data('user-group')==3)?'Quan tâm':'Theo học'));$('#popup_follow_count').html(parseInt($('#popup_follow_count').html())-1);}},complete:function(){follow_loading=false;}});}
$("#ResendemailVerify").click(function(){if(loading){return false;}
loading=true;$('#loading-layer').fadeIn();$.ajax({type:'POST',url:"ajax.php",data:{"act":"default","code":"resendemail_verify"},success:function(result){if(result==1)
{loading=false;$('#loading-layer').fadeOut();$("#needConfirm").modal('hide');}}});});$("#next_step").click(function(){var user_group=$("#User_group input[type=radio]:checked").val();$.ajax({type:'POST',url:"ajax.php",data:{"act":"default","code":"set_user_group","user_group":user_group},success:function(result){if(result>0)
{$('#signModal').modal('hide');window.location.reload();}else if(result!=""&&result==0){window.location.href=URL_IDS+'register.html?step=2';}}});});$("#update_user_group").click(function(){$('#signModal').modal('show');});$(".user_group").on("click",function(){$("#next_step").removeAttr("disabled");});$(".btn_update_email").click(function(){var email=$("#email_info").val();var regex=/^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;if(email=="")
{$(".email_update_error").css("display","block");$(".email_update_error").text("Bạn chưa nhập email!");}
else if(!regex.test(email))
{$(".email_update_error").css("display","block");$(".email_update_error").text("Email không đúng định dạng!");}
else{$.ajax({type:'POST',url:"ajax.php",data:{"act":"default","code":"update_email_verify","email":email},success:function(result){if(result>0)
{window.location.reload(true);}
else if(result!=""&&result==0){$(".email_update_error").css("display","block");$(".email_update_error").text("Lỗi thao tác hệ thống!");}}});}});$('#change_type').click(function(){$.ajax({type:'POST',url:"ajax.php",data:{"act":"default","code":"change_type_user_group",},success:function(result){if(result>0)
{window.location.reload();}}});});});