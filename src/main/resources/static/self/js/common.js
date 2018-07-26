
/**
 * 公共常用JS
 */
$.fn.serializeObject = function () {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function () {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

/**
 * 弹出窗口
 */
function openModuleWin(winid, title, url, width, height) {
    my_window(winid, title, url, width, height);
}

/**
 * 新增窗口
 */
function openAddDataWin(winid, title, url, width, height, gridId) {
    openModuleWin(winid, url, title, width, height);
}

/**
 * 查看窗口
 */
function openViewDataWin(winid, title, url, width, height, gridId, id) {
    if ('' == id || id == undefined) {
        var row = $("#" + gridId).datagrid("getSelections");
        if (row != null && row.length == 1) {
            id = row[0].id;
        } else {
            alert("请选择单条记录！");
            return;
        }
    }
    url += ('?id=' + id);
    console.log(url);
    openModuleWin(winid, url, title, width, height);
}

/**
 * 编辑窗口
 */
function openUpdateDataWin(winid, title, url, width, height, gridId) {
    if ('' == id || id == undefined) {
        var row = $("#" + gridId).datagrid("getSelections");
        if (row != null && row.length == 1) {
            id = row[0].id;
        } else {
            alert("请选择单条记录！");
            return;
        }
    }
    openModuleWin(id, url, title, width, height);
}

/**
 * 删除记录
 */
function delRecord(title, url, gridId) {
    var rows = $("#" + gridId).datagrid("getSelections");
    if (rows != null && rows.length != 0) {
        var ids = "";
        for (var i = 0; i < rows.length; i++) {
            ids += rows[i].id;
            if (i != (rows.length - 1))
                ids += ","
        }
        $.messager.confirm('删除提示', '您确定要删除所选' + title + "?", function (r) {
            if (r) {
                $.ajax({
                    url: url,
                    type: "post",
                    data: {ids: ids},
                    dataType: 'json',
                    success: function (data) {
                        $.messager.alert("提示", data.message, 'info', function () {
                            $("#" + gridId).datagrid("reload");
                        });
                    }
                });
            }
        });
    } else {
        alert("请选择记录！");
        return;
    }
}

/**
 * 查询
 * @param formId
 * @param gridId
 */
function searchDatagrid(formId, gridId) {
    var searchParames = $('#' + formId).serializeObject();
    $("#" + gridId).datagrid("load", searchParames);
}

/**
 * 重置
 * @param formId
 * @param gridId
 */
function resetDatagrid(formId, gridId) {
    document.getElementById(formId).reset();
    $("#" + formId + " .textbox-value").val("");
    $("#" + formId + " .select2").select2().select2("val", "");
    $("#" + formId).form("reset");
    $("#" + formId + " input[type='hidden']").val("");
    searchDatagrid(formId, gridId);

}


function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires;
}

/**
 * 导出
 * @param url
 * @param formId
 * @param gridId
 */
function exportDatagrid(url,formId,gridId){

    if(formId==undefined || formId==null){
        formId = "form_search";
    }
    var myUrl = url;
    var searchParames = $('#'+formId).serializeObject();


    var rows = $("#"+gridId).datagrid("getSelections");
    if (rows != null && rows.length != 0) {
        var ids = "";
        for(var i=0;i<rows.length;i++){
            ids += rows[i].id;
            if(i!=(rows.length-1))
                ids += ","
        }

    }
    searchParames['query.ids'] = ids;

    myUrl += '?exportId='+new Date().getTime();
    for(var key in searchParames){
        var value = searchParames[key];
        if(value!=""){
            myUrl += ("&"+key+"="+value);
        }
    }

    var cookieName = "fileDownload";
    var win;
    $.fileDownload(myUrl,{

        prepareCallback:function(url){
            setCookie(cookieName, "", -1);
            win = $.messager.progress({
                title:'数据导出',
                msg:'数据导出处理中，请耐心等待...'
            });

        },
        successCallback:function(url){

            setCookie(cookieName, "", -1);
            $.messager.progress('close');
            $.messager.alert('数据导出','文件导出成功!');
        },
        failCallback: function (html, url) {
            setCookie(cookieName, "", -1);
            $.messager.progress('close');
            var begin=html.indexOf("[");
            var end=html.indexOf("]");

            if(begin!=-1&&end!=-1){

                $.messager.alert('数据导出', html.substring(begin+1,end),'error');
            }else{
                $.messager.alert('数据导出','数据导出错误!','error');
            }


        }
    });

    //window.open(myUrl,'_blank');
}


/**
 * 格式化日期
 * @param fmt
 * @returns {*}
 * @constructor
 */
Date.prototype.Format = function (fmt) {
    var o = {
        "y+": this.getFullYear(),
        "M+": this.getMonth() + 1,                 //月份
        "d+": this.getDate(),                    //日
        "h+": this.getHours(),                   //小时
        "m+": this.getMinutes(),                 //分
        "s+": this.getSeconds(),                 //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S+": this.getMilliseconds()             //毫秒
    };
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(fmt)){
            if(k == "y+"){
                fmt = fmt.replace(RegExp.$1, ("" + o[k]).substr(4 - RegExp.$1.length));
            }
            else if(k=="S+"){
                var lens = RegExp.$1.length;
                lens = lens==1?3:lens;
                fmt = fmt.replace(RegExp.$1, ("00" + o[k]).substr(("" + o[k]).length - 1,lens));
            }
            else{
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            }
        }
    }
    return fmt;
}

