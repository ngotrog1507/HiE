var loading=false;function get_extension(filename)
{var parts=filename.split('.');return parts[parts.length-1].toLowerCase();}
$(document).ready(function()
{$('#home_select_subject_id').val('');$('#home_select_topic_id').val('');$('#home_select_topic2_id').val('');$('#home_select_grade_level').change(function()
{loadSubject();});loadSubject=function()
{$('#home_select_subject_id').addClass('input-disable');$('#home_select_topic_id').addClass('input-disable');$('#home_select_topic2_id').addClass('input-disable');$('#home_select_subject_id').val('');$('#home_select_topic_id').html('<option value="" disabled selected style="display:none;">Tất cả chương</option>');$('#home_select_topic2_id').html('<option value="" disabled selected style="display:none;">Tất cả chuyên đề</option>');if(parseInt($('#home_select_grade_level').val())>=0)
{subjects=class_subject[parseInt($('#home_select_grade_level').val())];$('#home_select_subject_id').val('');subjects.forEach(function(s)
{$('#home_select_subject_id option[value='+s+']').show();if(typeof(teacher_subject_id)!='undefined'&&teacher_subject_id==s)
{$('#home_select_subject_id').val(teacher_subject_id);loadTopic();}});$('#home_select_subject_id').removeClass('input-disable');$('[data-subject-id="6"]').html('Ngữ văn')
if(parseInt($('#home_select_grade_level').val())<6)
{$('[data-subject-id="6"]').html('Tiếng Việt');}}
else
{$('#home_select_subject_id').val('');}}
if(typeof(student_grade_level)!='undefined')
{$('#home_select_grade_level').val(student_grade_level);loadSubject();}
else
{$('#home_select_grade_level').val('');}
$('#home_select_subject_id').change(function()
{loadTopic();});loadTopic=function()
{$('#home_select_topic_id').addClass('input-disable');$('#home_select_topic2_id').addClass('input-disable');$('#home_select_lesson_id').html('<option value="" disabled selected style="display:none;">Chọn bài giảng</option>');if(parseInt($('#home_select_grade_level').val())>=0&&parseInt($('#home_select_subject_id').val())>=0)
{$.ajax({url:"ajax.php?act=topic&code=get_topics&c="+$('#home_select_grade_level').val()+'&s='+$('#home_select_subject_id').val(),type:"GET",dataType:"json",beforeSend:function()
{},success:function(response)
{data=response.data;var units=[];$.each(data.units,function(key,val){units.push("<option value='"+key+"'>"+val+"</option>");});var topics=[];$.each(data.topics,function(key,val){topics.push("<option value='"+key+"'>"+val+"</option>");});if(response.status==true){if(units.length>0){$('#home_select_topic_id').removeClass('input-disable');$('#home_select_topic_id').html('<option value="" disabled selected style="display:none;">Tất cả chương</option>'+units.join(""));}else{$('#home_select_topic_id').html('<option value="" disabled selected style="display:none;">Tất cả chương</option>');}
if(topics.length>0){$('#home_select_topic2_id').removeClass('input-disable');$('#home_select_topic2_id').html('<option value="" disabled selected style="display:none;">Tất cả chuyên đề</option>'+topics.join(""));}else{$('#home_select_topic2_id').html('<option value="" disabled selected style="display:none;">Tất cả chuyên đề</option>');}}else{$('#home_select_topic_id').html('<option value="" disabled selected style="display:none;">Tất cả chương</option>');$('#home_select_topic2_id').html('<option value="" disabled selected style="display:none;">Tất cả chuyên đề</option>');}},complete:function()
{}});}
else
{$('#home_select_topic_id').html('<option value="" disabled selected style="display:none;">Tất cả chương</option>');$('#home_select_topic2_id').html('<option value="" disabled selected style="display:none;">Tất cả chuyên đề</option>');}}
$('#home_select_topic_id').change(function()
{$('#home_select_topic2_id').val('');});$('#home_select_topic2_id').change(function()
{$('#home_select_topic_id').val('');});goToListLesson=function(_this)
{var topic_id=$('#home_select_topic_id').val();if(!topic_id>0)
{topic_id=$('#home_select_topic2_id').val();}
var grade_level=$('#home_select_grade_level').val();var subject_id=$('#home_select_subject_id').val();if(topic_id>0)
{window.location='lessond4f1.html?cmd=topic&amp;topic_id='+topic_id;return;}
else if(subject_id>0&&grade_level>0)
{window.location='lessonec8a.html?cmd=subject&amp;subject_id='+subject_id+'&grade_level='+grade_level;return;}
if(grade_level>0&&subject_id>0)
{window.location='lessonec8a.html?cmd=subject&amp;subject_id='+subject_id+'&grade_level='+grade_level;return;}
if(grade_level>0)
{window.location='lessoncff6.html?cmd=level&amp;grade_level='+grade_level;return;}
window.location='lesson.html';return;}
follow=function(fid,uid,_this)
{if(loading)
{return false;}
$.ajax({type:'POST',url:URL_IDS+"ajax.php",data:{"act":"follow","uid":uid,'fid':fid},crossDomain:true,success:function(result)
{if(result==1)
{$(_this).removeClass('btn-info');$(_this).addClass('btn-default');$(_this).html('<i class="fa fa-check"></i> Đang quan tâm');}
else if(result==2)
{$(_this).removeClass('btn-default');$(_this).addClass('btn-info');$(_this).html('<i class="fa fa-rss"></i> Quan tâm');}},complete:function()
{loading=false;}});}
$('#tmpRating').raty({cancel:true,starType:'i',score:parseInt($('#tmpRating').data('score')),click:function(score,evt)
{var teacher_lesson_id=$('#tmpRating').data('teacher-lesson-id');voteLesson(teacher_lesson_id,score);}});goToPart=function(k)
{$('html, body').animate({scrollTop:$("#part-"+k).offset().top-50},500);}
goToId=function(id)
{$('html, body').animate({scrollTop:$("#"+id).offset().top-50},500);}
var cuesTime=[];var onHover=[];jumpToTime=function(video_id,t)
{document.getElementById('video-'+video_id).currentTime=t+0.01;}
trackLoad=function(video_id)
{var track=document.getElementById("entrack-"+video_id).track;var cues=track.cues;for(var i=0;i<cues.length;i++)
{if(i==0)
{cuesTime[video_id]=[];cuesTime[video_id][i]=0;$('#display-cues-'+video_id).append('<p onclick="jumpToTime('+video_id+', '+cues[i].startTime+')" data-start-time-video-'+video_id+'="0" class="cue-active">'+cues[i].text+'</p>');}
else
{cuesTime[video_id][i]=cues[i].startTime;$('#display-cues-'+video_id).append('<p onclick="jumpToTime('+video_id+', '+cues[i].startTime+')" data-start-time-video-'+video_id+'="'+cues[i].startTime+'">'+cues[i].text+'</p>');}}
onHover[video_id]=false;$('#display-cues-'+video_id).scrollTop(0);track.mode="hidden";}
$('.bigschool-video').bind('webkitfullscreenchange mozfullscreenchange fullscreenchange',function(e)
{var state=document.fullScreen||document.mozFullScreen||document.webkitIsFullScreen;var event=state?'FullscreenOn':'FullscreenOff';});var slideCurrentPage=[];$(".bigschool-video").on("timeupdate",function(event)
{var video_id=(this.id).substring(6);var currentTime=this.currentTime;var _this=this;var subtitle_type=$(this).data('subtitle-type');if(subtitle_type=='text')
{var cueTimeCurrent=0;for(var i=0;i<cuesTime[video_id].length;i++)
{if((currentTime-cuesTime[video_id][i])<=0)
{cueTimeCurrent=cuesTime[video_id][i-1];break;}
cueTimeCurrent=cuesTime[video_id][i];}
if(currentTime==0)
{cueTimeCurrent=0;}
$('#display-cues-'+video_id+' .cue-active').removeClass('cue-active');$('[data-start-time-video-'+video_id+'="'+cueTimeCurrent+'"]').addClass('cue-active');var offsetTop=$('[data-start-time-video-'+video_id+'="'+cueTimeCurrent+'"]').offset().top-$('#start-point-'+video_id).offset().top;if(!onHover[video_id])
{$('#display-cues-'+video_id).scrollTop(offsetTop-150);}}
if(subtitle_type=='pdf')
{var dataSlideTimes=$(_this).data('slide-times');slideCurrentPage[video_id]=0;for(var i=0;i<dataSlideTimes.length;i++)
{if((currentTime-dataSlideTimes[i])<=0)
{slideCurrentPage[video_id]=i;break;}
slideCurrentPage[video_id]=i+1;}
$('#slide-page-'+video_id).html('-- '+slideCurrentPage[video_id]+' --');document.getElementById('iframe-'+video_id).contentWindow.jumpToPage(slideCurrentPage[video_id]);}});$('.display-cues').hover(function(event)
{var video_id=(this.id).substring(13);onHover[video_id]=true;},function()
{var video_id=(this.id).substring(13);onHover[video_id]=false;});slideNext=function(video_id)
{document.getElementById('iframe-'+video_id).contentWindow.nextPage();var dataSlideTimes=$('#video-'+video_id).data('slide-times');if(typeof(dataSlideTimes[slideCurrentPage[video_id]])!='undefined')
{jumpToTime(video_id,dataSlideTimes[slideCurrentPage[video_id]]);}}
slidePrev=function(video_id)
{document.getElementById('iframe-'+video_id).contentWindow.previousPage();var dataSlideTimes=$('#video-'+video_id).data('slide-times');if(typeof(dataSlideTimes[slideCurrentPage[video_id]-2])!='undefined')
{jumpToTime(video_id,dataSlideTimes[slideCurrentPage[video_id]-2]);}
else
{jumpToTime(video_id,dataSlideTimes[0]);}}
bigScreen=function(video_id)
{$('#attact_item_'+video_id).addClass('bigScreen');}
bigScreenStop=function(video_id)
{$('#attact_item_'+video_id).removeClass('bigScreen');var mediaElement=document.getElementById("video-"+video_id);mediaElement.pause();}
$('#grade_level').change(function()
{$('.topic-selectbox').addClass('hidden');editLesson_loadSubject();});editLesson_loadSubject=function()
{$('#subject_id').empty().html('<option value="-1" selected>-- Chọn môn --</option>');if(parseInt($('#grade_level').val())>=0)
{if(loading){return false;}
loading=true;$('#loading-layer').fadeIn();$.ajax({url:"ajax.php?act=lesson&code=get_subject&c="+$('#grade_level').val(),type:"GET",success:function(message)
{loading=false;$('#loading-layer').fadeOut();if(message.status)
{$('#subject_id').append(message.value);}},});}}
$('#subject_id').change(function()
{editLesson_loadTopic();});editLesson_loadTopic=function()
{$('#topic_id').empty();$('#thematic_id').empty();$('.lesson-selectbox').addClass('hidden');if(parseInt($('#grade_level').val())>=0&&parseInt($('#subject_id').val())>=0)
{$('.topic-selectbox').removeClass('hidden');if(loading){return false;}
loading=true;$('#loading-layer').fadeIn();$.ajax({url:"ajax.php?act=topic&code=get_topic&t=0&c="+$('#grade_level').val()+'&s='+$('#subject_id').val(),type:"GET",success:function(message)
{if(message.status)
{$('#topic_id').removeClass('hidden');$('#topic_group p').addClass('hidden');$('#topic_id').append('<option value="-1" selected >-- Chọn chương --</option>');$('#topic_id').append(message.value);}else{$('#topic_id').addClass('hidden');$('#topic_group p').removeClass('hidden');}},});$.ajax({url:"ajax.php?act=topic&code=get_topic&t=1&c="+$('#grade_level').val()+'&s='+$('#subject_id').val(),type:"GET",success:function(message)
{loading=false;$('#loading-layer').fadeOut();if(message.status)
{$('#thematic_id').removeClass('hidden');$('#thematic_group p').addClass('hidden');$('#thematic_id').append('<option value="-1" selected >-- Chọn chuyên đề --</option>');$('#thematic_id').append(message.value);}else{$('#thematic_id').addClass('hidden');$('#thematic_group p').removeClass('hidden');}},});}}
$('#topic_id').change(function()
{editLesson_loadLesson(parseInt($('#topic_id').val()),0);});$('#thematic_id').change(function()
{editLesson_loadLesson(parseInt($('#thematic_id').val()),1);});editLesson_loadLesson=function(topic_id,type)
{if(topic_id>=0)
{if(type==0)
{$('#lesson_id').html('<option value="" selected >-- Chọn bài --</option>');$.ajax({url:"ajax.php?act=lesson&code=get_lesson&t="+topic_id,type:"GET",success:function(message)
{if(message)
{$('#lesson_name_area').addClass('hidden');$('#lesson_id').html(message);$('.lesson-selectbox').removeClass('hidden');}
else
{$('.lesson-selectbox').addClass('hidden');$('#lesson_name_area').removeClass('hidden');}},});}
else if(type==1)
{$.ajax({url:"ajax.php?act=lesson&code=get_lesson&t="+$('#topic_id').val()+'&format=suggest',type:"GET",success:function(message){var names=JSON.parse(message);$('#lesson_name').autocomplete({lookup:names});$('#lesson_name_area').removeClass('hidden');}});}}}
requestToClass=function(btn){var notif_data={from_id:$(btn).data('from-id'),from_name:$(btn).data('from-name'),to_id:$(btn).data('to-id'),to_name:$(btn).data('to-name'),object_id:$(btn).data('object-id'),object_name:$(btn).data('object-name'),type:'STUDENT_REQUEST_TO_CLASS'};var request_message=$('#request_message').val();$.ajax({url:"ajax.php?act=class&code=request_to_class",type:"POST",data:{class_id:notif_data.object_id,content:request_message},beforeSend:function(){$(btn).attr('disabled','disabled').html('<i class="fa fa-spinner fa-pulse" aria-hidden="true"></i> Tải dữ liệu');},success:function(data){console.log('success');console.log(data);if(data.status==1)
{if(data.value.status==0)
{$('#request_to_class_div').html('<div class="alert alert-success">Đã xin vào lớp, bạn đợi thầy/cô đồng ý nhé !</div>');window.notif.send(notif_data);}
if(data.value.status==1)
{window.location.reload();}}},error:function(jqXHR,textStatus,errorThrown){console.log('error');$(btn).html('<i class="fa fa-exclamation-triangle" aria-hidden="true"></i> Xảy ra lỗi !');console.log(jqXHR);console.log(textStatus);console.log(errorThrown);}});}
acceptAllToClass=function(btn){var from_id=$(btn).data('from-id'),from_name=$(btn).data('from-name'),object_id=$(btn).data('object-id'),object_name=$(btn).data('object-name');$.ajax({url:"ajax.php?act=class&code=accept_all_to_class",type:"POST",data:{class_id:object_id},beforeSend:function(){$(btn).attr('disabled','disabled').html('<i class="fa fa-spinner fa-pulse" aria-hidden="true"></i> Tải dữ liệu');},success:function(data)
{if(data.status==1)
{notif_receivers.forEach(function(item,index){var data={from_id:from_id,from_name:from_name,to_id:item.uid,to_name:item.fullname,object_id:object_id,object_name:object_name,type:'TEACHER_ACCEPT_STUDENT_TO_CLASS'};window.notif.send(data);if((index+1)===notif_receivers.length){console.log('all notifications sent');window.location.reload();}});}},error:function(jqXHR,textStatus,errorThrown){console.log('error');$(btn).html('<i class="fa fa-exclamation-triangle" aria-hidden="true"></i> Xảy ra lỗi !');console.log(jqXHR);console.log(textStatus);console.log(errorThrown);}});}
acceptRequestToClass=function(btn){var notif_data={from_id:$(btn).data('from-id'),from_name:$(btn).data('from-name'),to_id:$(btn).data('to-id'),to_name:$(btn).data('to-name'),object_id:$(btn).data('object-id'),object_name:$(btn).data('object-name'),type:'TEACHER_ACCEPT_STUDENT_TO_CLASS'},request_id=$(btn).data('request-id');$.ajax({url:"ajax.php?act=class&code=accept_request_to_class",type:"POST",data:{request_id:request_id},beforeSend:function(){$(btn).attr('disabled','disabled').html('<i class="fa fa-spinner fa-pulse" aria-hidden="true"></i> Tải dữ liệu');},success:function(data)
{if(data.status==1)
{window.notif.send(notif_data);window.location.reload();}},error:function(jqXHR,textStatus,errorThrown){console.log('error');$(btn).html('<i class="fa fa-exclamation-triangle" aria-hidden="true"></i> Xảy ra lỗi !');console.log(jqXHR);console.log(textStatus);console.log(errorThrown);}});}
deleteRequestToClass=function(request_id)
{$.ajax({url:"ajax.php?act=class&code=delete_request_to_class",type:"POST",data:{request_id:request_id},beforeSend:function()
{},success:function(data)
{if(data.status==1)
{location.reload();}},complete:function()
{}});}
removeStudentFromClass=function(student_id,class_id)
{$.ajax({url:"ajax.php?act=class&code=remove_student",type:"POST",data:{class_id:class_id,student_id:student_id},beforeSend:function()
{},success:function(data)
{if(data.status==1)
{location.reload();}},complete:function()
{}});}
postMessage=function(btn)
{var content=$('#message_content').val(),class_id=$('#class_message_area').data('class-id'),class_name=$('#class_message_area').data('class-name'),teacher_id=$('#class_message_area').data('teacher-id'),teacher_name=$('#class_message_area').data('teacher-name');$.ajax({url:'ajax.php',type:'POST',data:{act:'message',code:'post_class_message',message:content,class_id:class_id},beforeSend:function(){$(btn).attr('disabled','disabled').html('<i class="fa fa-spinner fa-pulse" aria-hidden="true"></i> Tải dữ liệu');},success:function(data){if(data.status==1){$('#message_content').val('');$('#class_message_area').html('');loadMessage(class_id,0);goToId('noticeList');$(btn).removeAttr('disabled').html('Xong');notif_receivers.forEach(function(item,index){var data={from_name:teacher_name,from_id:teacher_id,to_name:item.fullname,to_id:item.uid,object_name:class_name,object_id:class_id,type:'TEACHER_ADD_NOTICE_TO_CLASS'};window.notif.send(data);if((index+1)===notif_receivers.length){console.log('all notifications sent');}});}},error:function(jqXHR,textStatus,errorThrown){console.log('error');$(btn).html('<i class="fa fa-exclamation-triangle" aria-hidden="true"></i> Xảy ra lỗi !');console.log(jqXHR);console.log(textStatus);console.log(errorThrown);}});}
loadMessage=function(class_id,page)
{$.ajax({url:"ajax.php?act=message&code=load_class_message&class_id="+class_id+'&page='+page,type:"GET",beforeSend:function()
{},success:function(message)
{$('#class_message_area').append(message);$('#class_message_area').magnificPopup({delegate:'.popup-link',type:'image',gallery:{enabled:true}});},complete:function()
{}});}
deleteMessage=function(id,class_id)
{$.ajax({url:"ajax.php?act=message&code=delete_class_message",type:"POST",data:{id:id},beforeSend:function()
{},success:function(data)
{if(data.status==1)
{$('#message_content').val('');$('#class_message_area').html('');loadMessage(class_id,0);}},complete:function()
{}});}
if($('#upload_class_image').length>0)
{var ajax=$('#upload_class_image').ajaxForm({beforeSend:function(xhr,opts){if(!($('#attach_image')[0].files[0].size<(2*1024*1024)&&(['jpg','png','gif']).indexOf(get_extension($('#attach_image').val()))>-1))
{alert('Chỉ chấp nhận ảnh jpg, png, gif dung lượng tối đa 2MB');xhr.abort();return false;}},success:function(d){if(d.status==false){alert(d.message);return false;}
var image_path=d.value.file;if(image_path!=''){var class_id=$('#class_message_area').data('class-id'),class_name=$('#class_message_area').data('class-name'),teacher_id=$('#class_message_area').data('teacher-id'),teacher_name=$('#class_message_area').data('teacher-name');$.ajax({url:'ajax.php',type:'POST',data:{act:'message',code:'post_class_message',message:image_path,type:1,class_id:class_id},beforeSend:function(){},success:function(data){if(data.status==1){$('#message_content').val('');$('#class_message_area').html('');loadMessage(class_id,0);goToId('noticeList');notif_receivers.forEach(function(item,index){var data={from_name:teacher_name,from_id:teacher_id,to_name:item.fullname,to_id:item.uid,object_name:class_name,object_id:class_id,type:'TEACHER_ADD_NOTICE_TO_CLASS'};window.notif.send(data);if((index+1)===notif_receivers.length){console.log('all notifications sent');}});}}});}},});}
if($('#class_message_area').length>0)
{loadMessage($('#class_message_area').data('class-id'),0);}
if($('#upload_class_avatar_form').length>0)
{var ajax=$('#upload_class_avatar_form').ajaxForm({beforeSend:function(xhr,opts)
{if(!($('#upload_class_avatar')[0].files[0].size<(3*1024*1024)&&(['jpg','png','gif']).indexOf(get_extension($('#upload_class_avatar').val()))>-1))
{alert('Chỉ chấp nhận ảnh jpg, png, gif dung lượng tối đa 2MB');xhr.abort();return false;}},uploadProgress:function(event,position,total,percentComplete)
{},success:function(d)
{if(d.status==false)
{alert(d.message);return false;}
$('#class_avatar').val(d.value.file);$('#class_avatar_img').attr('src','http://class.bigschool.vn/save_video'+d.value.file);},complete:function(xhr)
{}});}
$.ajax({url:'ajax.php',type:'GET',data:{act:'class',code:'get_student_follow',class_id:$('#add_follower').data('class-id'),teacher_id:$('#add_follower').data('teacher-id'),grade_level:$('#add_follower').data('grade-level')},beforeSend:function(){},success:function(res){$('#add_follower').autocomplete({lookup:JSON.parse(res),onSelect:function(suggestion){var notif_data={from_name:$('#add_follower').data('teacher-name'),from_id:$('#add_follower').data('teacher-id'),to_name:suggestion.data.fullname,to_id:suggestion.data.uid,object_name:$('#add_follower').data('class-name'),object_id:$('#add_follower').data('class-id'),type:'TEACHER_ADD_STUDENT_TO_CLASS'}
$.ajax({url:'ajax.php',type:'POST',data:{act:'class',code:'add_student',class_id:$('#add_follower').data('class-id'),student_id:suggestion.data.uid},beforeSend:function(){},success:function(res){window.notif.send(notif_data);window.location.reload();},error:function(jqXHR,textStatus,errorThrown){console.log('error');console.log(jqXHR);console.log(textStatus);console.log(errorThrown);}});}});},error:function(jqXHR,textStatus,errorThrown){console.log('error');console.log(jqXHR);console.log(textStatus);console.log(errorThrown);}});voteLesson=function(teacher_lesson_id,vote)
{$.ajax({url:"ajax.php?act=teacher_lesson&code=vote",type:"POST",data:{teacher_lesson_id:teacher_lesson_id,vote:vote},beforeSend:function()
{},success:function(data)
{console.log('zzz');},complete:function()
{}});}
loadStudentInClass=function(page)
{var class_id=$('[data-class-id]').data('class-id');$.ajax({url:"ajax.php?act=class&code=get_class_students&class_id="+class_id+"&page="+page,type:"GET",beforeSend:function()
{},success:function(message)
{$('#list_student_in_class').html(message);},complete:function()
{}});}
if($('#list_student_in_class').length>0)
{loadStudentInClass(0);}
exitClass=function(class_id)
{$.ajax({url:"ajax.php?act=class&code=exit_class",type:"POST",data:{class_id:class_id},beforeSend:function()
{},success:function(data)
{console.log(data);if(data.status==1)
{location.reload();}},complete:function()
{}});}
var onModalShow=false;if($('#cropContainerModal').length>0)
{var cropperHeader=new Croppic('cropContainerModal',{rotateControls:false,doubleZoomControls:false,customUploadButtonId:'upload_avatar_button',uploadUrl:'img_save_to_file.php',cropUrl:'img_crop_to_file.php',modal:true,onAfterImgUpload:function()
{onModalShow=true;$('body').addClass('stop-scrolling')
console.log('onAfterImgUpload')},onAfterImgCrop:function(data)
{onModalShow=false;$('body').removeClass('stop-scrolling')
console.log('onAfterImgCrop');if(data.status=='success')
{$('#class_avatar_img').attr('src',data.url);$('#class_avatar_img_input').val(data.url);}},onReset:function()
{onModalShow=false;$('body').removeClass('stop-scrolling')
console.log('onReset')},onError:function(errormessage)
{console.log('onError:'+errormessage)}});function moveObject(event)
{if(onModalShow)
{var delta=0;if(!event)
{event=window.event;}
if(event.wheelDelta)
{delta=event.wheelDelta/60;}
else if(event.detail)
{delta=-event.detail/2;}
if(delta>0)
{cropperHeader.zoom(10);}
else
{cropperHeader.zoom(-10);}}}
if(window.addEventListener)
document.addEventListener('DOMMouseScroll',moveObject,false);document.onmousewheel=moveObject;}});