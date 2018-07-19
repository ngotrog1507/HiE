var comment={parrams:{new_id:0,comment_id:0,order_by:1,page:0},refresh:false,back_end:false,is_child_load:false,just_posted:false,children_offset:0,errors:[],url:"",load:function(obj){$('.reply-form').each(function()
{if($(this).hasClass('active-form'))
{$(this).removeClass('active-form');}});var order_object=$('.order-comments.active');if(order_object.hasClass('order-by-latest'))
{comment.parrams.order_by=1;}
else if(order_object.hasClass('order-by-like-count'))
{comment.parrams.order_by=2;}
else if(order_object.hasClass('order-by-unapproved'))
{comment.parrams.order_by=3;}
if(!comment.is_child_load)
{var id=obj.getAttribute('id');var page=id.substring(5);}
comment.submit('load_comments');},post:function(obj){var id=obj.getAttribute('id');this.class_suffix=(id=='post-comment')?'':id.substring(11);var is_admin=$(".comment-as-admin"+this.class_suffix).prop("checked");if(comment.is_user_logged_in==0){window.location=comment.sign_in_url;}
this.parrams.is_admin=(is_admin)?true:false;this.parrams.message=$(".message"+this.class_suffix).val();this.parrams.parent_comment_id=parseInt($(".parent-comment-id"+this.class_suffix).val());if($.trim(this.parrams.message)=="")
{this.errors.push("Bạn chưa nhập bình luận!");}
if(this.parrams.new_id<=0){this.errors.push("Hệ thống lỗi, bạn vui lòng gửi bình luận sau!");}
for(i=0;i<this.errors.length;i++){if(this.parrams.parent_comment_id>0){this.showNotice('notice-comment-'+this.parrams.parent_comment_id,this.errors[i],false,0);}else{this.showNotice('notice-comment',this.errors[i],false,0);}
this.errors=[];return false;}
this.submit("post_comment");},approve:function(obj,approved)
{var id=obj.getAttribute('data-target');var comment_id=id.substring(12);comment.parrams.comment_id=comment_id;comment.parrams.approved=approved;comment.submit('approve_comment');},like:function(obj){var id=obj.getAttribute('id');var comment_id=id.substring(9);comment.parrams.comment_id=comment_id;comment.submit('like_comment');},delete:function(comment_id){if(confirm('Bạn có chắc chắn xóa bình luận này không?'))
{comment.parrams.comment_id=comment_id;comment.submit('delete_comment');}},showNotice:function(holderId,msg,reload_page,type){var class_name=(type==0)?'alert-danger':'alert-success';$('#'+holderId).fadeIn();$('#'+holderId).html('<div class="alert '+class_name+'">\
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>\
        <strong>(!)</strong> '+msg+'\
        </div>');setTimeout(function(){$('#'+holderId).fadeOut("slow",function(){$('#'+holderId).html('');if(reload_page)
{window.location.reload();}});},3000);},showReplyForm:function(obj)
{if(comment.is_user_logged_in==0)
{window.location=comment.sign_in_url;}
var form_class_name=obj.getAttribute('id');if(form_class_name!="")
{var comment_id=form_class_name.substring(13);$('.reply-form').each(function(){if($(this).hasClass(form_class_name))
{$("."+form_class_name).toggle('slow');}
else
{$(this).fadeOut();}});$(".message-"+comment_id).attr('placeholder',"Viết trả lời").focus();}},sort:function(obj){if(obj.hasClass('active')){return;}
$('.order-comments').each(function(){if($(this).hasClass('active')){$(this).removeClass('active');}});if(obj.hasClass('order-by-latest')){comment.parrams.order_by=1;}else if(obj.hasClass('order-by-like-count')){comment.parrams.order_by=2;}else if(obj.hasClass('order-by-unapproved')){comment.parrams.order_by=3;}
obj.addClass('active');comment.parrams.page=0;comment.refresh=true;comment.submit('load_comments');},submit:function(code)
{var form_data=new FormData();$.each(comment.parrams,function(key,val)
{form_data.append(key,val);});form_data.append('act',"default");form_data.append('code',code);$.ajax({url:this.url,dataType:'json',cache:false,contentType:false,processData:false,data:form_data,type:'post',success:function(response)
{comment.afterSubmit(code,response);}});},afterSubmit:function(code,response)
{if(response.status==false)
{for(i=0;i<response.errors.length;i++)
{if(typeof($("#notice-comment-"+comment.parrams.comment_id)!=='undefined'))
{comment.showNotice("notice-comment-"+comment.parrams.comment_id,response.errors[i],false,0);}
else
{comment.showNotice('notice-comment',response.errors[i],false,0);}
return false;}}
switch(code)
{case"load_comments":if(response.comments.length<=0)
{this.msg="Không tìm thấy Bình luận nào.";comment.showNotice('notice-comment',this.msg,false,1);}
else
{var html=comment.render(response);if(comment.is_child_load)
{if(html!=''){$('.pagination-'+comment.parrams.parent_comment_id).remove();$('.children-'+comment.parrams.parent_comment_id).html($('.children-'+comment.parrams.parent_comment_id).html()+html);}
comment.parrams.parent_comment_id=0;comment.parrams.children_offset=0;comment.is_child_load=false;}
else
{if(html!='')
{$('#list-of-comments').fadeIn('slow',function()
{if(comment.refresh===true)
{$('#list-of-comments').html(html);comment.refresh=false;}
else
{$('.pagination').remove();$('#list-of-comments').html($('#list-of-comments').html()+html);}})}}}
break;case"like_comment":$(".like-count-"+comment.parrams.comment_id).html(response.comment.like_count);if(response.comment.like_count>0)
{$("#like-"+comment.parrams.comment_id).show();}
else
{$("#like-"+comment.parrams.comment_id).hide();}
$("#like-for-"+comment.parrams.comment_id).toggleClass('active');break;case"approve_comment":this.msg="Cập nhật thành công!";var reload=(comment.back_end)?1:0;comment.showNotice("notice-comment-"+comment.parrams.comment_id,this.msg,reload,1);$('#c-content-'+comment.parrams.comment_id).removeClass("status-0").addClass('status-'+comment.parrams.approved);$('#c-btn-'+comment.parrams.comment_id).hide();if(comment.parrams.approved==0)
{$('#flag-status-'+comment.parrams.comment_id+'-2').hide();$('#flag-status-'+comment.parrams.comment_id+'-0').show();}
else if(comment.parrams.approved==2)
{$('#flag-status-'+comment.parrams.comment_id+'-0').hide();$('#flag-status-'+comment.parrams.comment_id+'-2').show();}
else
{$('#flag-status-'+comment.parrams.comment_id+'-0').hide();$('#flag-status-'+comment.parrams.comment_id+'-2').hide();if(typeof($('.comment-id-'+comment.parrams.comment_id+' .comment-tool'))!=='undefined')
{var html='<a id="like-for-'+comment.parrams.comment_id+'" class="like-comment" onclick="comment.like(this)">Thích</a>'+'<span class="sep"> · </span>'+'<a id="comment-form-'+comment.parrams.comment_id+'" class="reply-link" style="white-space:nowrap" onclick="comment.showReplyForm(this)"><b>Trả lời</b></a>'+'<span id="like-'+comment.parrams.comment_id+'" style="display:none;">'+'   <span class="sep"> · </span>'+'<span class="like-count">'+'   <span class="like-count-icon"></span>'+'   <span class="like-count-'+comment.parrams.comment_id+'">0</span>'+'</span>'+'</span>'+'<span class="sep"> · </span>';$('.comment-id-'+comment.parrams.comment_id+' .comment-tool').html(html+$('.comment-id-'+comment.parrams.comment_id+' .comment-tool').html());}}
comment.parrams.approved=0;break;case"delete_comment":$(".comment-id-"+comment.parrams.comment_id).fadeOut(300,function(){$(".comment-id-"+comment.parrams.comment_id).remove();this.msg="Xóa bình luận thành công!";comment.showNotice("notice-comment-"+comment.parrams.comment_id,this.msg,false,1);});break;case"update_comment":this.msg="Cập nhật thành công!";comment.showNotice("comment-form-"+comment.parrams.comment_id,this.msg,true,1);break;case"restore_comment":this.msg="Khôi phục thành công!";comment.showNotice("comment-form-"+comment.parrams.comment_id,this.msg,true,1);break;case"post_comment":this.msg="Bình luận thành công!";$(".message"+this.class_suffix).val("");$(".comment-as-admin"+this.class_suffix).prop("checked",false);if(comment.parrams.parent_comment_id>0)
{comment.showNotice('notice-comment-'+comment.parrams.parent_comment_id,this.msg,0,1);var top_comment_id=response.comment.parent_comment_id;var html=comment.renderOne(response.comment,response,'')+$('#c-children-'+top_comment_id).html();$('#c-children-'+top_comment_id).html(html).show();$('.comment-form-'+comment.parrams.parent_comment_id).hide();}
else
{comment.showNotice('notice-comment',this.msg,0,1);var row_class_name=($('#list-of-comments .comment').length%2==0)?'row-odd':'row-even';comment.just_posted=true;var html=comment.renderOne(response.comment,response,row_class_name)+$('#list-of-comments').html();$('#list-of-comments').html(html);$('#notice_top').hide();}
setTimeout(function(){$('html,body').animate({scrollTop:$(".comment-id-"+response.comment.id).offset().top},500);},500);break;}},renderOne:function(c_data,response,row_class){var html='';html+=' <div class="'+row_class+' comment comment-id-'+c_data.id+'">';html+=' <p class="full_content status-'+c_data.approved+'" id="c-content-'+c_data.id+'">';var profile_url=(c_data.comment_as_bigschool!=1&&c_data.user_name!=''&&c_data.user_name!='null')?comment.ids_url+c_data.user_name:'';if(c_data.comment_as_bigschool!=1&&c_data.avatar_url!='')
{html+=' <a class="avatar" '+(profile_url!=''?'target="_blank" href="'+profile_url+'"':'')+'>'+' <img src="'+c_data.avatar_url+'" class="img-circle">'+' </a>';}
html+=' <a class="user_link" '+(profile_url!=''?'target="_blank" href="'+profile_url+'"':'')+'>';if(c_data.comment_as_bigschool==1)
{html+=' <b style="color:blue">'+comment.BIGSCHOOL_TITLE+'</b>';}
else
{html+=' <b>'+c_data.full_name+'</b>';}
html+=' </a>';if(c_data.comment_as_bigschool==1&&response.is_comment_admin===true)
{html+=' <span style="color:red">(Bởi: <a href="'+comment.ids_url+c_data.full_name+'">'+c_data.full_name+'</a>)</span>';}
html+=' '+c_data.message+'</p>';html+='<div class="comment-tool">';if(c_data.approved==1)
{html+=' <a id="like-for-'+c_data.id+'" class="like-comment'+(c_data.liked?' active':'')+'" onclick="comment.like(this)">'+'Thích'+'</a> ';html+=' <span class="sep"> · </span> '+' <a id="comment-form-'+c_data.id+'" class="reply-link" style="white-space:nowrap"  onclick="comment.showReplyForm(this)">'+' <b>Trả lời</b> '+' </a>';html+=' <span id="like-'+c_data.id+'" '+(c_data.like_count<=0?' style="display:none;"':'')+'>'+' <span class="sep"> · </span> '+' <span class="like-count">'+' <span class="like-count-icon"></span>'+' <span class="like-count-'+c_data.id+'">'+c_data.like_count+' </span>'+' </span>'+' </span>'+' <span class="sep"> · </span>';}
html+='<span class="comment-time">'+c_data.created+' </span>';if(response.is_comment_admin||c_data.user_id==comment.user_id)
{html+=' <span class="approve-status approve-status-'+c_data.approved+'" id="flag-status-'+c_data.id+'-0" '+(c_data.approved!=0?'style="display:none"':'')+' title="Bình luận chờ duyệt hiển thị">(Chờ duyệt)</span>';html+=' <span class="approve-status approve-status-'+c_data.approved+'" id="flag-status-'+c_data.id+'-2"  '+(c_data.approved!=2?'style="display:none"':'')+' title="Bình luận không được hiển thị">(Bị ẩn)</span>';}
if(response.is_comment_admin||(comment.user_id==c_data.user_id&&c_data.approved!=1))
{if(response.is_comment_admin&&c_data.approved==0)
{html+=' <span id="c-btn-'+c_data.id+'">';html+='  <span class="sep"> · </span> <a data-target="approve-for-'+c_data.id+'" class="approve-comment" onclick="comment.approve(this, 1);">Duyệt</a>';html+='  <span class="sep"> · </span> <a data-target="approve-for-'+c_data.id+'" class="approve-comment disapprove" onclick="comment.approve(this, 2);">Không duyệt</a>';html+=' </span>';}
html+=' <span class="sep"> · </span> <a id="delete-for-'+c_data.id+'" class="delete-comment" onclick="comment.delete('+c_data.id+')" title="Xóa"><i class="fa fa-trash" aria-hidden="true"></i> Xóa</a>';}
html+=' </div>';html+=' <div id="notice-comment-'+c_data.id+'"></div>';html+=' <div class="reply-form comment-form-'+c_data.id+'" style="display: none">';html+='    <input type="hidden" class="parent-comment-id-'+c_data.id+'" name="parent_comment_id" value="'+c_data.id+'">';if(response.is_user_logged_in===true)
{html+='  <textarea class="message-'+c_data.id+' form-control textareaAuto mt5" id="reply-message" name="message" placeholder="Ý kiến của bạn sẽ được phê duyệt trước khi đăng. Xin vui lòng gõ tiếng Việt có dấu." rows="1"></textarea>';html+='  <h6 class="pull-right" id="count_message"></h6>';html+='       <div class="clearfix mt5">';if(response.is_comment_admin===true)
{html+='  <label class="comment-as-bigschool">'+'    <input type="checkbox" class="form-control comment-as-admin-'+c_data.id+'" name="comment_as_admin" value="'+comment.BIGSCHOOL_TITLE+'">'+'    <span>Gửi dưới tư cách  '+comment.BIGSCHOOL_TITLE+' </span>'+'   </label>';}
html+='   <a class="btn btn-info post-comment" onclick="comment.post(this)" id="comment-for-'+c_data.id+'">Gửi bình luận</a>';html+='  </div>';}
html+=' </div>';if(typeof row_class=='undefined'||row_class===null||row_class===''||comment.just_posted)
{html+='</div>';comment.just_posted=false;}
return html;},render:function(response){var comments=response.comments;var html='';if(comment.is_child_load)
{$.each(comments,function(key,value)
{if(value.approved==1||(value.approved!=1&&(response.is_comment_admin==true||value.user_id==comment.user_id)))
{html+=comment.renderOne(value,response);}});if(response.count<response.total)
{html+=' <div class="child-pagination pagination-'+comment.parrams.parent_comment_id+'">'+' <a onclick="comment.is_child_load = true; comment.parrams.parent_comment_id = '+comment.parrams.parent_comment_id+'; comment.parrams.children_offset = '+response.count+'; comment.load(this)">'+'<span class="glyphicon glyphicon-share-alt"></span> Xem thêm phản hồi'+' </a>'+' </div>';}
return html;}
$.each(comments,function(key,value)
{var row_class_name=(key%2==0)?'row-even':'row-odd';if(value.approved==1||(value.approved!=1&&(response.is_comment_admin==true||value.user_id==comment.user_id)))
{html+=comment.renderOne(value,response,row_class_name);var children=' <div class="children children-'+value.id+'" id="c-children-'+value.id+'" style="display:none">';if(typeof(value.children.length)!='undefined'&&value.children.length>0)
{children=' <div class="children children-'+value.id+'" id="c-children-'+value.id+'">';$.each(value.children,function(k,v)
{if(v.approved==1||(v.approved!=1&&(response.is_comment_admin==true||(v.user_id==comment.user_id&&value.approved==1))))
{children+=comment.renderOne(v,response,'');}});if(value.counting_of_children_loaded<value.total_of_children)
{children+=' <div class="child-pagination pagination-'+value.id+'">'+' <a onclick="comment.is_child_load = true; comment.parrams.parent_comment_id = '+value.id+'; comment.parrams.children_offset = '+value.counting_of_children_loaded+'; comment.load(this)"><span class="glyphicon glyphicon-share-alt"></span> Xem thêm phản hồi</a>'+' </div>';}}
html+=children;html+=' </div>';html+=' </div>';}});var count=comment.limit+(comment.parrams.page*comment.limit)+1;if(comment.total_parent_comments>count)
{html+=' <div class="pagination">';html+='  <a class="load-more-comments" id="page-'+comment.parrams.page+'" onclick="comment.parrams.page++;comment.load(this);">Xem thêm bình luận</a>';html+=' </div>';}
return html;}}