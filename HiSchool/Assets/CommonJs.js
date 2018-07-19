var currentPage = 1;
function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}
function youtube_getId(url) {
    var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
    var match = url.match(regExp);
    return (match && match[7].length == 11) ? match[7] : false;
}
function isNumberKey(evt)
       {
          var charCode = (evt.which) ? evt.which : event.keyCode;
          if (charCode != 46 && charCode > 31
            && (charCode < 48 || charCode > 57))
             return false;

          return true;
       }
function AddRecord() {
    Reset();
    $("#modal-default").modal();
    $("#btnAdd").show();
    $("#btnEdit").hide();
}

function DeleteAll(id, url) {
    if (confirmDeleteAll()) {
        ajax_delete(id, url);
    }
}
function ajax_delete(id, url) {
    $("._modal").hide();
    var sData = "{'id':'" + getArrayItemInGridSelected() + "'}";
    sData = (id == null) ? sData : "{'id':'" + id + "'}";
    console.log(sData + "-" + url);
    $.ajax({
        type: "POST",
        url: url,
        data: sData,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msgSuccess) {
            if(msgSuccess.status=="success")
                ToastMessage("success", msgSuccess.Message);
            if (msgSuccess.status == "warning")
                ToastMessage("warning", msgSuccess.Message);
            refresh(currentPage);
        },
        error: function () {
            ToastMessage("error", "Xóa không thành công !");
        }
    });
}
function confirmDelete() {
    return confirm('Bạn có muốn xóa bản ghi ???');
}
function confirmDeleteAll() {
    if (CheckSelectAtLeastOne()) {
        return confirm('Bạn muốn xóa các bản ghi đã chọn ???');
    } else {
        alert('Chọn ít nhất một bản ghi!');
    }
    return false;
}
function CheckSelectAtLeastOne() {
    var checkboxes = $("input[type=checkbox][name=check-row]").filter("input:checked");
    if (checkboxes.length > 0) {
        return true;
    } else {
        return false;
    }
}
function CheckAllRole() {
    $(".check-all-role").on('change', function() { // on change of state
        if (this.checked) // if changed state is "CHECKED"
        {
            $('.check-row-role').prop('checked', true);
        }
        if (!this.checked) // if changed state is "CHECKED"
        {
            $('.check-row-role').prop('checked', false);
        }
    });
}
function CheckAllShow() {
    $(".check-all-show").on('change', function () { // on change of state
        if (this.checked) // if changed state is "CHECKED"
        {
            $('.check-item-show').prop('checked', true);
        }
        if (!this.checked) // if changed state is "CHECKED"
        {
            $('.check-item-show').prop('checked', false);
        }
    });
}
function CheckAll() {
    $(".check-all").on('change', function () { // on change of state
        if (this.checked) // if changed state is "CHECKED"
        {
            $('.check-row').prop('checked', true);
        }
        if (!this.checked) // if changed state is "CHECKED"
        {
            $('.check-row').prop('checked', false);
        }
    })
}
function getArrayItemInGridSelected() {
    var arrayOfId = [];
    $("input[type='checkbox'][name=check-row]:checked").each(function (index, result) {
        var id = $(result).attr("data-id");
        if (id != 0) {
            arrayOfId.push(id);
        }
    });
    return arrayOfId;
}

function paging(pageCount, pageIndex, keySearch) {
    var result = "";
    result = result + " <div class='row'>";
    result = result + "   <div class='col-xs-12'>";
    result = result + "     <div class='dataTables_paginate paging_simple_numbers' id='example1_paginate'>";

    var totalPage = pageCount;
    var pre_disabled = "";
    var next_disabled = "";
    if (pageIndex == 1) {
        pre_disabled = " disabled' style='pointer-events:none;'";
    }
    else {
        pre_disabled = "'";
    }
    if (pageIndex == totalPage || totalPage==0) {
        next_disabled = "disabled' style='pointer-events:none;'";
    }
    else {
        next_disabled = "'";
    }

    result = result + "            <ul class='pagination'>";
    result = result + " <li class='prev " + pre_disabled + ">";
    if (keySearch == "") {
        result = result + " <a class='noClick' href = '/' onclick='refresh(" + (pageIndex-1) + ")'>";
    }
    else {
        result = result + "  <a class='noClick'  href = '/' onclick='refresh(" + (pageIndex-1) + ")'>";
    }

    result = result + "   <i class='ace-icon'></i>";
    result = result + "    Trang trước";
    result = result + "    </a>";
    result = result + "   </li>";

    if (totalPage >= 1) {
        for (var i = 1; i <= totalPage; i++) {
            if (pageIndex == i) {
                result = result + "           <li class='active'>";
                if (keySearch == "") {
                    result = result + " <a class='noClick' href = '/' onclick='refresh(" + (i) + ")'>" + (i) + "</a>";
                }
                else {
                    result = result + " <a class='noClick' href = '/' onclick='refresh(" + (i) + ")'>" + (i) + "</a>";
                }
                result = result + " </li>";
            }
            else {
                result = result + " <li>";
                if (keySearch == "") {
                    result = result + " <a class='noClick' href = '/' onclick='refresh(" + (i ) + ")'>" + (i ) + "</a>";
                }
                else {
                    result = result + " <a class='noClick' href = '/' onclick='refresh(" + (i ) + ")'>" + (i ) + "</a>";
                }

                result = result + " </li>";
            }
        }
    }
    result = result + " <li class='next " + next_disabled + ">";
    if (keySearch == "") {
        result = result + " <a class='noClick' href = '/' onclick='refresh(" + (pageIndex + 1) + ")'>";
    }
    else {
        result = result + " <a class='noClick' href = '/' onclick='refresh(" + (pageIndex + 1) + ")'>";
    }
    result = result + " Trang tiếp";
    result = result + " <i class='ace-icon'></i>";
    result = result + " </a>";
    result = result + " </li>";
    result = result + " </ul>";
    result = result + " </div>";
    result = result + " </div>";
    result = result + " </div>";
    return result;

}