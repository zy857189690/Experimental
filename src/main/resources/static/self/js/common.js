/**
 * Created by chenpeng on 2015/6/1 0001.
 */

var requestInterval=10000;


/**用于dialog之间传递数据中间变量*/
var dialogResData;

function setDialogResData(data){
    dialogResData = data;
}

function getDialogResData(){
    return dialogResData;
}
function getselObj() {
    return selObj;
}


/**
 * 弹出窗口，主要用在弹出选择框
 * @param url
 * @param width
 * @param heiht
 * @param nameId 显示文本框ID
 */
var selObj;
var dialogVars = {};
function openSelectDialog(obj, title, url, width, height, extData, isDictVeh) {

    if($("#selectDlg")[0]){

    } else {
        $("body").append("<div id=\"selectDlg\" ></div>");
    }
    $('#selectDlg').html("");
    dialogVars = {};

    selObj = obj;

    var nameId = $(obj).attr("id");
    if (nameId == "") {
        alert("显示文本框的ID不能为空");
        return;
    }
    var val = "";
    if($(selObj).nextAll().length>1){
        val = $(obj).siblings('input[type="hidden"]').val();
    }else{
        val = $(obj).val();
    }
    var w = width + "px";
    var h = height + "px";
    var u = '';

    if (extData == undefined) {
        extData = {};
    }
    extData['val'] = val;
    dialogVars = extData;

    $('#selectDlg').dialog({
        title: title,
        width: width,
        height: height,
        closed: false,
        cache: false,
        href: url,
        modal: true,
        onLoad: function () {
            if(isDictVeh) {
                initLoad(null, null, isDictVeh);
            } else {
                initLoad();
            }
        }
    });

}

function clearInputValue(obj) {
    $(obj).prev().val("");
    if ($(obj).next().length > 0) {
        $(obj).next().val("");
    }
}
/**
 * 弹出窗口，针对 多个回显值 所改造的弹框
 */
var selObjGroup;
function openSelectDialog4multiInput(group, title, url, width, height, extData, isDictVeh) {
    if($("#selectDlg")[0]){

    } else {
        $("body").append("<div id=\"selectDlg\" ></div>");
    }
    $('#selectDlg').html("");
    var obj = group[0];
    selObj = obj;
    dialogVars = {};

    selObjGroup = group;

    var nameId = $(obj).attr("id");
    if (nameId == "") {
        alert("显示文本框的ID不能为空");
        return;
    }
    var val = "";
    if($(selObj).nextAll().length>1){
        val = $(obj).siblings('input[type="hidden"]').val();
    }else{
        val = $(obj).val();
    }
    var w = width + "px";
    var h = height + "px";
    var u = '';

    if (extData == undefined) {
        extData = {};
    }
    extData['val'] = val;
    dialogVars = extData;

    $('#selectDlg').dialog({
        title: title,
        width: width,
        height: height,
        closed: false,
        cache: false,
        href: url,
        modal: true,
        onLoad: function () {
            if(isDictVeh) {
                initLoad(null, null, isDictVeh);
            } else {
                initLoad();
            }
        }
    });

}

/**
 * 弹出窗口，针对 车辆管理》电池包编号 所改造的弹框
 */
function openSelectDialog4battery(obj,dataObj,vid,title, url, width, height, extData, isDictVeh) {


    $('#selectDlg').remove();

    if($("#selectDlg")[0]){

    } else {
        $("body").append("<div id=\"selectDlg\" ></div>");
    }
    $('#selectDlg').html("");
    dialogVars = {};

    selObj = obj;

    var nameId = $(obj).attr("id");
    if (nameId == "") {
        alert("显示文本框的ID不能为空");
        return;
    }

    var val = dataObj.val();
    //   var val2 = vid.val();
    // if($(dataObj).nextAll().length>1){
    //     val = $(dataObj).siblings('input[type="hidden"]').val();
    // }else{
    //     val = $(dataObj).val();
    // }
    var w = width + "px";
    var h = height + "px";
    var u = '';

    if (extData == undefined) {
        extData = {};
    }
    extData['val'] = val;
    dialogVars = extData;

    $('#selectDlg').dialog({
        title: title,
        width: width,
        height: height,
        closed: false,
        cache: false,
        href: url,
        modal: true,
        onLoad: function () {
            if(isDictVeh) {

                initLoad(val, null, isDictVeh);
            } else {

                initLoad(val,'','',vid);
            }
        }
    });

}


function setFirstPage(ids){
    var opts = $(ids).datagrid('options');
    var pager = $(ids).datagrid('getPager');
    opts.pageNumber = 1;
    opts.pageSize = opts.pageSize;
    pager.pagination('refresh',{
        pageNumber:1,
        pageSize:opts.pageSize
    });
}

/*function typeConfig(type){
    console.log(type)
    sessionStorage.setItem('typeConfig',type);
}*/
function openVehicleSelectDialog(obj, title, url, width, height, extData) {
    if($("#selectDlg")[0]){

    } else {
        $("body").append("<div id=\"selectDlg\" ></div>");
    }

    $('#selectDlg').html("");
    selObj = obj;
    var nameId = $(obj).attr("id");
    if (nameId == "") {
        alert("显示文本框的ID不能为空");
        return;
    }
    $('#selectDlg').dialog({
        title: title,
        width: width,
        height: height,
        closed: false,
        cache: false,
        href: url,
        modal: true,
        onLoad: function () {
            initLoad(extData);
        }
    });
}



function confirmDBCSelect(val){
    $(selObj).val(val).change();
    $('#selectDlg').dialog("close");
    $('#selectDlg').html("");
}

function confirmSelect(name, val) {
    $(selObj).val(name);
    //配合弹出框改造，重置取值位置 add by yuexw 2017年4月28日
    if($(selObj).nextAll().length>1){
        $(selObj).siblings('input[type="hidden"]').val(val).change();
    }else{
        $(selObj).next().val(val).change();
    }
    $(selObj)[0].onChange && $(selObj)[0].onChange();
    $('#selectDlg').dialog("close");
    $('#selectDlg').html("");

}


function confirmSelect4multiInput(valGroup) {
    valGroup.forEach(function (item, index) {
        var selObj = selObjGroup[index];
        var name = item.name;
        var val = item.val;
        $(selObj).val(name);
        //配合弹出框改造，重置取值位置 add by yuexw 2017年4月28日
        if($(selObj).nextAll().length>1){
            $(selObj).siblings('input[type="hidden"]').val(val).change();
        }else{
            $(selObj).next().val(val).change();
        }
    });

    $('#selectDlg').dialog("close");
    $('#selectDlg').html("");
}

function confirmSelect4battery(name, val, code) {
    $(selObj).val(code);
    $(selObj).parent().find('.batteryLkId').val(val);
    $('#selectDlg').dialog("close");
    $('#selectDlg').remove();
}
function confirmSelect4fulBattery(name, val, code) {
    $(selObj).val(code);
    $(selObj).parent().find('.fulbatteryLkId').val(val);
    $('#selectDlg').dialog("close");
    $('#selectDlg').remove();
}
function getDialogVar(key) {
    return dialogVars[key];
}


/**
 * 重写alert
 */
function alert(msg){
    $.messager.alert("提示",msg);
}


function isObj(val){
    if(val!=undefined && val!=null){
        return true;
    }else{
        return false;
    }
}

function isEmpty(val){
    if(val==undefined || val=="" || val==null){
        return true;
    }else
        return false;
}



/*
 重写log
 */
function log(obj){
    //console.log(obj);
}

function my_layer(winid,url,title,width,height){
    layer.open({
        type: 2,
        title: title,
        maxmin: true,
        shadeClose: true, //点击遮罩关闭层
        area : ['400px' , '300px'],
        content: url
    });
}

function str2obj(str){
    return  eval('(' + str + ')');
}
//在最顶层弹出窗口
function my_window(winid,url,title,width,height, closable){
    if(!url) return;
    if(!width) width = 300;
    if(!height) height = 300;
    if (false != closable) {
        closable = true;
    }
    winid="pop";
    var html = "<div id=\"window_" + winid + "\" style=\"padding:0px;\">"
        +"<iframe src='" + url + "' frameborder='0' id='childFrame' name='childFrame' marginheight='0' style='width:100%;height:95%;' marginwidth='0' scrolling='auto'></iframe>"
        +"</div>";
    var win = window.top.$(html).appendTo(window.top.document.body);
    win.window({
        //标题
        title : title,
        //宽度
        width : width,
        //是否模态
        modal : true,
        //是否显示阴影
        shadow : false,
        //
        closed : true,
        //是否显示右上角的关闭按钮
        closable : closable,
        //是否能最小化
        minimizable : false,
        //是否可折叠
        collapsible : false,
        //是否能最大化
        maximizable : false,
        //高度
        height : height,
        //是否可拖动
        draggable : true,
        //浮动量
        zIndex : -999999,
        //对于主父窗口如何停留的定义，true 该窗口停留在父窗口上， false 该窗口始终显示在最顶层，默认为false(这个定义等同于javax.swing里的dialog)
        inline : true,
        //关闭事件执行详细
        onClose : function() {
            //顶层模态需在顶层关闭，否则无效
            window.setTimeout(function() {
                window.top.$(win).window('destroy', false);
            }, 0);
        }
    });
    win.window('open');
    return win;
}

//在最顶层弹出窗口 带加载中
function my_window2(winid,url,title,width,height, closable){
    if(!url) return;
    if(!width) width = 300;
    if(!height) height = 300;
    if (false != closable) {
        closable = true;
    }
    winid="pop";
    var html = "<div id=\"window_" + winid + "\" style=\"padding:0px;\">"
        +"<iframe src='" + url + "' frameborder='0' id='childFrame' name='childFrame' marginheight='0' style='width:100%;height:95%;' marginwidth='0' scrolling='auto'></iframe>"
        +"</div>";
    var win = window.top.$(html).appendTo(window.top.document.body);
    win.window({
        //标题
        title : title,
        //宽度
        width : width,
        //是否模态
        modal : true,
        //是否显示阴影
        shadow : false,
        //
        closed : true,
        //是否显示右上角的关闭按钮
        closable : closable,
        //是否能最小化
        minimizable : false,
        //是否可折叠
        collapsible : false,
        //是否能最大化
        maximizable : false,
        //高度
        height : height,
        //是否可拖动
        draggable : true,
        //浮动量
        zIndex : -999999,
        //对于主父窗口如何停留的定义，true 该窗口停留在父窗口上， false 该窗口始终显示在最顶层，默认为false(这个定义等同于javax.swing里的dialog)
        inline : true,
        //关闭事件执行详细
        onClose : function() {
            //顶层模态需在顶层关闭，否则无效
            window.setTimeout(function() {
                window.top.$(win).window('destroy', false);
            }, 0);
        }
    });
    win.window('open');
    var oMask;
    var oMsg;
    //弹出加载层
    function load(parent) {
        oMask = $("<div class=\"datagrid-mask\"></div>");
        oMsg = $("<div class=\"datagrid-mask-msg\"></div>");
        oMask.css({zindex:-1,display: "block", width: "100%", height: $(window).height() }).appendTo(parent);
        oMsg.html("加载中，请稍候。。。").appendTo(parent).css({ zindex:-1,display: "block", left: (parent.width() - 190) / 2, top: (parent.height() - 45) / 2 });
    }
    //取消加载层
    function disLoad() {
        oMask.remove();
        oMsg.remove();
    }

    load(win);
    var iframe = win.find('iframe');
    iframe.on('load', function () {
        disLoad();
    });
    return win;
}
//在最顶层弹出窗口
function imp_vehicle_win(winid,url,title,width,height, closable){
    if(!url) return;
    if(!width) width = 300;
    if(!height) height = 300;
    if (false != closable) {
        closable = true;
    }
    winid="pop";
    var html = "<div id=\"window_" + winid + "\" style=\"padding:0px;\">"
        +"<iframe src='" + url + "' frameborder='0' id='childFrame' name='childFrame' marginheight='0' style='width:100%;height:95%;' marginwidth='0' scrolling='auto'></iframe>"
        +"</div>";
    var win = window.top.$(html).appendTo(window.top.document.body);
    win.window({
        //标题
        title : title,
        //宽度
        width : width,
        //是否模态
        modal : true,
        //是否显示阴影
        shadow : false,
        //
        closed : true,
        //是否显示右上角的关闭按钮
        closable : closable,
        //是否能最小化
        minimizable : false,
        //是否可折叠
        collapsible : true,
        //是否能最大化
        maximizable : false,
        //高度
        height : height,
        //是否可拖动
        draggable : true,
        //浮动量
        zIndex : -999999,
        //对于主父窗口如何停留的定义，true 该窗口停留在父窗口上， false 该窗口始终显示在最顶层，默认为false(这个定义等同于javax.swing里的dialog)
        inline : true,
        //关闭事件执行详细
        onClose : function() {
            window.top.m_sysVehicleFrame.window.location.reload();
            //顶层模态需在顶层关闭，否则无效
            window.setTimeout(function() {
                window.top.$(win).window('destroy', false);
            }, 0);
        }
    });
    win.window('open');

    return win;
}



//在最顶层弹出窗口 带有加载中
function imp_vehicle_win2(winid,url,title,width,height, closable){
    if(!url) return;
    if(!width) width = 300;
    if(!height) height = 300;
    if (false != closable) {
        closable = true;
    }
    winid="pop";
    var html = "<div id=\"window_" + winid + "\" style=\"padding:0px;\">"
        +"<iframe src='" + url + "' frameborder='0' id='childFrame' name='childFrame' marginheight='0' style='width:100%;height:95%;' marginwidth='0' scrolling='auto'></iframe>"
        +"</div>";
    //var dom = $(html);
    var win = window.top.$(html).appendTo(window.top.document.body);
    win.window({
        //标题
        title : title,
        //宽度
        width : width,
        //是否模态
        modal : true,
        //是否显示阴影
        shadow : false,
        //
        closed : true,
        //是否显示右上角的关闭按钮
        closable : closable,
        //是否能最小化
        minimizable : false,
        //是否可折叠
        collapsible : true,
        //是否能最大化
        maximizable : false,
        //高度
        height : height,
        //是否可拖动
        draggable : true,
        //浮动量
        zIndex : -999999,
        //对于主父窗口如何停留的定义，true 该窗口停留在父窗口上， false 该窗口始终显示在最顶层，默认为false(这个定义等同于javax.swing里的dialog)
        inline : true,
        //关闭事件执行详细
        onClose : function() {
            window.top.m_sysVehicleFrame.window.location.reload();
            //顶层模态需在顶层关闭，否则无效
            window.setTimeout(function() {
                window.top.$(win).window('destroy', false);
            }, 0);
        }
    });
    win.window('open');




    var oMask;
    var oMsg;
    //弹出加载层
    function load(parent) {
        oMask = $("<div class=\"datagrid-mask\"></div>");
        oMsg = $("<div class=\"datagrid-mask-msg\"></div>");
        oMask.css({zindex:-1,display: "block", width: "100%", height: $(window).height() }).appendTo(parent);
        oMsg.html("加载中，请稍候。。。").appendTo(parent).css({ zindex:-1,display: "block", left: (parent.width() - 190) / 2, top: (parent.height() - 45) / 2 });
    }
    //取消加载层
    function disLoad() {
        oMask.remove();
        oMsg.remove();
    }

    load(win);
    var iframe = win.find('iframe');
    iframe.on('load', function () {
        disLoad();
    });


    return win;
}
////在最顶层弹出窗口
//function my_window(winid,url,title,width,height){
//    if(!url) return;
//    if(!width) width = 300;
//    if(!height) height = 300;
//    winid="pop";
//    var html = "<div id=\"window_" + winid + "\" style=\"padding:0px;\">"
//        +"<iframe src='' frameborder='0' id='childFrame' name='childFrame' marginheight='0' style='width:100%;height:95%;' marginwidth='0' scrolling='auto'></iframe>"
//        +"</div>";
//    var win = window.top.$(html).appendTo(window.top.document.body);
//    log(win);
//    win.window({
//        //标题
//        title : title,
//        //宽度
//        width : width,
//        //是否模态
//        modal : true,
//        //是否显示阴影
//        shadow : false,
//        //
//        closed : true,
//        //是否显示右上角的关闭按钮
////				closable : false,
//        //是否能最小化
//        minimizable : false,
//        //是否可折叠
//        collapsible : false,
//        //是否能最大化
////				maximizable : false,
//        //高度
//        height : height,
//        //是否可拖动
//        draggable : true,
//        //浮动量
//        zIndex : -999999,
//        //对于主父窗口如何停留的定义，true 该窗口停留在父窗口上， false 该窗口始终显示在最顶层，默认为false(这个定义等同于javax.swing里的dialog)
//        inline : true,
//        //关闭事件执行详细
//        onClose : function() {
//            //顶层模态需在顶层关闭，否则无效
//            window.setTimeout(function() {
//                window.top.$(win).window('destroy', false);
//            }, 0);
//        }
//    });
//    win.window('open');
//    $("#childFrame").attr("src", url);
//    return win;
//}

//在最顶层弹出窗口
function diyWindow(winid,url,title,width,height,maximizable,iframeHeight){
    if(!url) return;
    if(!width) width = 300;
    if(!height) height = 300;
    if(!iframeHeight) iframeHeight = '95%';
    var html = "<div id=\"window_" + winid + "\" style=\"padding:0px;\">"
        +"<iframe src='" + url + "' frameborder='0' id='"+winid+"' name='"+winid+"' marginheight='0' style='width:100%;height:"+iframeHeight+";' marginwidth='0' scrolling='auto'></iframe>"
        +"</div>";
    var win = window.top.$(html).appendTo(window.top.document.body);
    win.window({
        //标题
        title : title,
        //宽度
        width : width,
        //是否模态
        modal : true,
        //是否显示阴影
        shadow : false,
        //
        closed : true,
        //是否显示右上角的关闭按钮
//				closable : false,
        //是否能最小化
        minimizable : false,
        //是否可折叠
        collapsible : false,
        //是否能最大化
        maximizable : maximizable,
        //高度
        height : height,
        //是否可拖动
        draggable : true,
        //浮动量
        zIndex : 999,
        //对于主父窗口如何停留的定义，true 该窗口停留在父窗口上， false 该窗口始终显示在最顶层，默认为false(这个定义等同于javax.swing里的dialog)
        inline : true,
        //关闭事件执行详细
        onClose : function() {
            //顶层模态需在顶层关闭，否则无效
            window.setTimeout(function() {
                window.top.$(win).window('destroy', false);
            }, 0);
        }
    });
    win.window('open');
    return win;
}




// function close_win(){
//     window.top.window.$("#window_pop").window("close");
// }

/**
 * 区分 新增 修改页面 取消提示
 */
function close_win_affirm(id, winid){
    if(id  == -1){
        close_win_cencel(winid);
    }else{
        close_win();
    }
}


/**
 * 二次校验，系统 <取消>
 */
function close_win_cencel(winid){
    $.messager.confirm("操作提示", "您确定不保存信息？", function (data) {
        if (data) {
            if(!winid) winid = "pop";
            window.top.window.$("#window_"+winid).window("close");
        }
    });
}

/**
 * 弹框关闭方法
 */
function close_win(winid){
    if(!winid) winid = "pop";
    window.top.window.$("#window_"+winid).window("close");
}

/*
通用删除confirmSelect
 */
function del_common(action,name,ids,callback){

    //$.messager.confirm('删除提示', '您确定要删除所选'+name+"?", function(r){
    $.messager.confirm("删除提示", "您确定删除所选记录？", function(r) {
        if(r){
            $.ajax({
                url:action,
                type:"post",
                data:{ids:ids},
                success:function(data){
                    data = eval('(' + data + ')');
                    $.messager.alert("提示",data.msg,'info',function(){
                        callback();
                    });
                }
            });
        }
    });
}

function del_commonBatteryCode(action,name,ids,callback){
    $.messager.confirm("删除提示", "您所选择的电池包已绑定车辆,确定删除所选记录吗？", function(r) {
        if(r){
            $.ajax({
                url:action,
                type:"post",
                data:{ids:ids},
                success:function(data){
                    data = eval('(' + data + ')');
                    $.messager.alert("提示",data.msg,'info',function(){
                        callback();
                    });
                }
            });
        }
    });
}

/*
 重置密码
 */
function resetDPword(action,name,ids,callback){

    //$.messager.confirm('重置密码', '您确定要重置所选'+name+"密码?", function(r){
    $.messager.confirm('重置密码', '您确定要重置该用户的密码？', function(r){
        if(r){
            $.ajax({
                url:action,
                type:"post",
                data:{ids:ids},
                success:function(data){
                    data = eval('(' + data + ')');
                    $.messager.alert("提示",data.msg,'info',function(){

                    });
                }
            });
        }
    });
}


/*
 重置查询
 */
function reset_common(fn){
    document.getElementById("form_search").reset();
    $("#form_search .textbox-value").val("");
    $("#form_search .select2").select2().select2("val","");
    $("#form_search").form("reset");
    $("#form_search input[type='hidden']").val("");

    fn();
}



// 对Date的扩展，将 Date 转化为指定格式的String
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
// 例子：
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18
Date.prototype.Format = function (fmt) { //author: meizz
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}//

function formatDate(val,row,index){
    if(val != undefined && val != null)
    {
        var unixTimestamp = new Date(val);
        return unixTimestamp.Format("yyyy-MM-dd");
    }
}

function formatDateTime(val,row,index){
    if(val != undefined && val != null)
    {
        var unixTimestamp = new Date(val);
        return unixTimestamp.Format("yyyy-MM-dd hh:mm:ss");
    }
}

function formatBoolean(val,row,index){
    if(val != undefined && val != null){
        if(val==1){
            return "是";
        }else{
            return "否";
        }
    }
    return "";
}


function formatName(val,row,index){
    if(val != undefined && val !=null){
        return val.name;
    }
    return "";
}

var dictType=[];
dictType[0] = {'label':'请选择','value':''};
dictType[1] = {'label':'电池厂商','value':'0'};
dictType[2] = {'label':'电池类型','value':'1'};
dictType[3] = {'label':'车辆类别','value':'2'};
dictType[4] = {'label':'地标终端控制','value':'3'};
dictType[5] = {'label':'地标终端参数','value':'4'};
dictType[6] = {'label':'数据项类别','value':'5'};
dictType[7] = {'label':'算术运算符','value':'6'};
dictType[8] = {'label':'关系运算符','value':'7'};
dictType[9] = {'label':'协调部门','value':'9'};
dictType[10] = {'label':'国标终端控制','value':'10'};
dictType[11] = {'label':'国标终端参数','value':'11'};
dictType[12] = {'label':'故障类别','value':'800'};
dictType[13] = {'label':'安全和故障所属零部件类型','value':'900'};
dictType[14] = {'label':'开关','value':'12'};


/**
 * 格式化字典类型
 * @param val
 * @param row
 * @param index
 */
function formatDictType(val,row,index){
    if(val!=undefined && val!=null){
        for(var i=1;i<dictType.length;i++){
            var tp = dictType[i];
            if(tp.value == val){
                return tp.label;
            }
        }
    }
    return "未定义";
}

/**
 * 格式化约束类型
 * @param val
 * @param row
 * @param index
 * @returns {*}
 */
function formatDataConst(val,row,index){
    if(val!=undefined || val!=null){
        if(val==0){
            return "预处理";
        }else{
            return "预警";
        }
    }
    return "未定义";
}

function formatFaultType(val,row,index){

    if(val!=undefined || val!=null){
        if(row.type==1){
            if(val==0){
                return "动力蓄电池故障";
            }else if(val==1){
                return "终端故障";
            }
        }


    }
    return "";
}
/**
 * 格式化约束的处理类型
 * @param val
 * @param row
 * @param index
 * @returns {*}
 */
function formatterDealType(val,row,index){
    if(val!=undefined || val!=null){
        if(row.type==1){
            if(val==0){
                return "自动邮件";
            }
            else if(val==1){
                return "单人处理";
            }
            else if(val==2){
                return "两人处理";
            }
            else if(val==3){
                return "自动短信";
            }
        }


    }
    return "";
}


function formatDataItem1(val,row,index){
    if(isObj(val)){
        var ret = val.name;
        if(row.isLast1==1){
            ret+="<font color='red'>[上次]</font>";

        }
        return ret;

    }else{
        return "";
    }
}
function formatDataItem2(val,row,index){
    if(isObj(val)){
        var ret = val.name;
        if(row.isLast2==1){
            ret+="<font color='red'>[上次]</font>";
        }
        return ret;


    }else{
        return "";
    }
}

function onTreeGridContextMenu(e,row){
    e.preventDefault();
    $(this).treegrid('select', row.id);
    $("#menu").menu('show', {
        left: e.pageX,
        top: e.pageY

    });
}

function sqlValidate(param){
    var keys="";
    for (var i in param) {              //用js的for/in循环遍历JSON对象的属性，i：key，param[i]：value
        if(isSqlKey(param[i])){         //如果包含关键字则记录该参数名
            keys +=","+i;
        }
    }
    if(keys==""){                       //不包含SQL关键字则进行查询操作
        return true;
    }else{                              //包含SQL关键字则作出提示并终止此次查询
        console.info(keys);                                                         //eg:",query.taskName&lis,query.createBy&lis"
        var keyArr = keys.substring(1).split(",");
        for (var i = 0; i < keyArr.length; i++) {
            keyArr[i] = keyArr[i].substring(0,keyArr[i].lastIndexOf("&"));          //eg:["query.taskName","query.createBy"]
            var nameElements = document.getElementsByName(keyArr[i]);               //通过name选择器获取标签
            for(var j=0;j<nameElements.length;j++) {                                //获取该输入框前面的lable的文字内容
                var lableElement = $(nameElements[j]).parent().prev().children();   //获取父节点上一兄弟节点的子节点（lable）
                keyArr[i] = $(lableElement).text().toString().replace(":","");      //eg:任务名称
            }
        }
        console.info(keyArr);                                                       //eg:["任务名称", "操作人"]
        alert(keyArr+"中含有非法字符");
        return false;
    }
}

//判断是否包含SQL关键字
function isSqlKey(str){
    if(null == str ){
        return;
    }
    var value = str.toString();
    value = value.toLowerCase();
    var badStr = "and |or |exec |execute |insert |select |delete |truncate |update |alter |drop ";
    var arr = badStr.split("|");
    for (var i = 0; i < arr.length; i++) {
        if (value.indexOf(arr[i]) >= 0) {
            return true;
        }
    }
    return false;
}

function onDataGridContextMenu(e, rowIndex, row){
    e.preventDefault();
    $(this).datagrid("clearSelections"); //取消所有选中项
    $(this).datagrid("selectRow", rowIndex); //根据索引选中该行
    $("#menu").menu('show', {
        left: e.pageX,
        top: e.pageY

    });
}

/**
 * 将表格的toolbar转为menu
 * @param gridId
 * @param type
 */
function toolbar2Menu(gridId,type){
    if(gridId==undefined){
        gridId="table";
    }
    if(type==undefined){
        type=0;
    }
    var grid = $("#"+gridId);
    var toolId = '';

    if(type==0)
        toolId = grid.datagrid("options").toolbar;
    else if(type==1)
        toolId = grid.treegrid("options").toolbar;
    if(toolId==''){
        return;
    }

    var mm = $("<div id='menu' class='easyui-menu' style='width: 120px;display: none'/>").appendTo($("body"));
    $(toolId+" a").each(function(index,el){
        var menu = $(this).attr("menu");
        if( menu!=0){
            var options = $(el).attr('data-options');
            var clk = $(el).attr('onclick');
            var html = $(el).html();
            var item = $("<div/>");
            item.attr("data-options",options);
            item.attr("onclick",clk);
            item.html(html);
            item.appendTo(mm);

            $("<div class='menu-sep'/>").appendTo(mm);
        }

    });

    if(type==0){
        grid.datagrid('options').onRowContextMenu = onDataGridContextMenu;
        registerMoreColumns(grid, toolId.replace("#", ""));
    }
    else if(type==1){
        grid.datagrid('options').treegrid = onTreeGridContextMenu;
        registerMoreColumns(grid, toolId.replace("#", ""));
        //grid.treegrid({
        //    onContextMenu:onTreeGridContextMenu
        //});
    }

    if(type==0){
        grid.datagrid('options').onBeforeLoad = sqlValidate;
    }
    else if(type==1){
        grid.datagrid('options').onBeforeLoad = sqlValidate;
    }
}


/**
 * 表格内容过长，隐藏
 * @param val
 * @param row
 * @param index
 * @returns {*}
 */
function formatTip(val,row,index){
    var displayLen = 10;
    if(isObj(val) && !isEmpty(val)){
        var len = val.length;
        if(len<=displayLen){
            return val;
        }else{
            var displayMsg = val.substring(0,displayLen);
            return displayMsg + '<a href="#" title="' + val + '" class="easyui-tooltip">...详情</a>';
        }
    }
}

function alertTip(msg){
    layer.tips(msg);
}
function formatTime(val,row,index){
    return new Date(val).Format("yyyy-MM-dd hh:mm:ss");
}

/**
 *
 * @param val vehicle实体
 * @param row
 * @param index
 * @returns {*}
 */
function formatVehiclePlate(val,row,index){
    if(isObj(val))
        return val.licensePlate;
    else  return '';
}


function isArray(v){
    return toString.apply(v) === '[object Array]';
}




function searchData(formId) {
    if (formId==undefined || formId==null || formId==""){
        formId = 'form_search';
    }
    var data = {};
    $("#"+formId+" select,#"+formId+" .input-fat,#"+formId+" input[type='hidden']").each(function (index, el) {
        var name = $(this).attr("name");
        if (name != undefined && name != null && name.indexOf("query.") == 0) {
            var query_type = $("#"+formId+" input[textboxname='" + name + "'] ").attr("query_type");
            if(query_type==undefined){
                query_type = $(this).attr("query_type");

            }
            var val = $(this).val();
            log(val);
            var vv = '';
            if(isArray(val)){
                for(var i=0;i<val.length;i++){
                    vv+= val[i];
                    if(i!=(val.length-1)){
                        vv+=",";
                    }

                }
            }
            else{
                vv = val;
            }
            var key =  name;
            var v = data[key];
            if(v!=undefined && v!=null && v!=""){
                vv += (","+v);
            }

            if (vv != '') {
                data[key] = vv;
            }
        }
    });
    return data;
}

var validatew = "<span style='color: red;top: auto'> *必选</span>";

$.validator.addMethod("string",function(value,element){
    return this.optional(element) || /^[a-zA-Z0-9\u4e00-\u9fa5-_,，.。?？!！]+$/.test(value);
},"<span style='color: red; margin-left: 3px;'>*只能包含中文、英文、数字、下划线等字符!</span>");

$.validator.addMethod("mobile", function(value, element) {
    var length = value.length;
    return this.optional(element) || (length == 11 && /^1[3-8]+\d{9}$/.test(value));
}, "<span style='color: red; margin-left: 3px;'>*手机号码格式错误!</span>!");

$.validator.addMethod("numOrLetter", function(value, element, params){
    return this.optional(element) || /^[a-zA-Z0-9]+$/.test(value);
}, "<span style='color: red; margin-left: 3px;'>*只能输入字母或数字</span>");

/**
 * form转换为json
 * @returns {{}}
 */
$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
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
 * 判断是否为空
 * @param val
 * @returns {*}
 */
function isNull(val, rval) {
    if (undefined != val && null != val) {
        return val;
    }
    if (undefined != rval && null != rval) {
        return rval;
    }
    return "";
}

/////////////////////////////////////////////////// 公共处理自定义列和高级查询 /////////////////////////////////////////////////

function Base64() {

    // private property
    _keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

    // public method for encoding
    this.encode = function (input) {
        var output = "";
        var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
        var i = 0;
        input = _utf8_encode(input);
        while (i < input.length) {
            chr1 = input.charCodeAt(i++);
            chr2 = input.charCodeAt(i++);
            chr3 = input.charCodeAt(i++);
            enc1 = chr1 >> 2;
            enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
            enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
            enc4 = chr3 & 63;
            if (isNaN(chr2)) {
                enc3 = enc4 = 64;
            } else if (isNaN(chr3)) {
                enc4 = 64;
            }
            output = output +
                _keyStr.charAt(enc1) + _keyStr.charAt(enc2) +
                _keyStr.charAt(enc3) + _keyStr.charAt(enc4);
        }
        return output;
    }

    // public method for decoding
    this.decode = function (input) {
        var output = "";
        var chr1, chr2, chr3;
        var enc1, enc2, enc3, enc4;
        var i = 0;
        input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
        while (i < input.length) {
            enc1 = _keyStr.indexOf(input.charAt(i++));
            enc2 = _keyStr.indexOf(input.charAt(i++));
            enc3 = _keyStr.indexOf(input.charAt(i++));
            enc4 = _keyStr.indexOf(input.charAt(i++));
            chr1 = (enc1 << 2) | (enc2 >> 4);
            chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
            chr3 = ((enc3 & 3) << 6) | enc4;
            output = output + String.fromCharCode(chr1);
            if (enc3 != 64) {
                output = output + String.fromCharCode(chr2);
            }
            if (enc4 != 64) {
                output = output + String.fromCharCode(chr3);
            }
        }
        output = _utf8_decode(output);
        return output;
    }

    // private method for UTF-8 encoding
    _utf8_encode = function (string) {
        string = string.replace(/\r\n/g,"\n");
        var utftext = "";
        for (var n = 0; n < string.length; n++) {
            var c = string.charCodeAt(n);
            if (c < 128) {
                utftext += String.fromCharCode(c);
            } else if((c > 127) && (c < 2048)) {
                utftext += String.fromCharCode((c >> 6) | 192);
                utftext += String.fromCharCode((c & 63) | 128);
            } else {
                utftext += String.fromCharCode((c >> 12) | 224);
                utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                utftext += String.fromCharCode((c & 63) | 128);
            }

        }
        return utftext;
    }

    // private method for UTF-8 decoding
    _utf8_decode = function (utftext) {
        var string = "";
        var i = 0;
        var c = c1 = c2 = 0;
        while ( i < utftext.length ) {
            c = utftext.charCodeAt(i);
            if (c < 128) {
                string += String.fromCharCode(c);
                i++;
            } else if((c > 191) && (c < 224)) {
                c2 = utftext.charCodeAt(i+1);
                string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
                i += 2;
            } else {
                c2 = utftext.charCodeAt(i+1);
                c3 = utftext.charCodeAt(i+2);
                string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
                i += 3;
            }
        }
        return string;
    }
}

/**
 * 为datagrid注册自定义列
 * @param datagrid     数据表格对象
 * @param datagridId   数据唯一标识，不能重复
 */
function registerMoreColumns(datagrid, toolbarId, did){
    //注册更多表
    var datagridId = "";
    if(did != undefined){
        datagridId = did;
    } else {
        if (undefined != toolbarId) {
            datagridId = toolbarId;
        } else {
            var path = window.location.pathname;
            var search = window.location.search;
            datagridId = path + search;
        }
    }
    var base = new Base64();
    datagridId = base.encode(datagridId);
    //首先动态增加Dom
    var datafields = getDataFields(datagrid);
    if(!toolbarId) {
        toolbarId = "toolbar";
    }
    //首次注册需要从系统读取用户配置列
    /*$.ajax({
        url: '/common/profile/getHiddenColumns.html',
        method: 'post',
        dataType: 'json',
        data:{
            datagridId: datagridId
        },
        success: function(resp){
            var d = resp.data;
            var columns = d.columns;
            var arr = columns.split(",");
            for(var i=0; i<arr.length; i++){
                var column =  arr[i];
                //将现有的设置为隐藏
                for(var j=0; j<datafields.length; j++){
                    if(datafields[j].value ==  column){
                        datafields[j].show = false;
                        datagrid.datagrid("hideColumn",column);
                    }
                }
            }
        },
        complete: function(){
            var elem = $("#"+toolbarId+" div[moreId='"+datagridId+"'");
            if(elem.length>0) {
                elem.remove()
            }
            //先隐藏现有的更多按钮
            $('#'+toolbarId+' .moreColumns').hide();
            //创建新的更多元素
            var html = '<div moreId="'+datagridId+'" class="moreColumns"><span class="cg-moreBtn" datagridId="'+datagridId+'">显示/隐藏项</span>';
            html += '<div class="cg-tbList" datagridId="'+datagridId+'">';
            html += '<div class="cg-ttop" datagridId="'+datagridId+'">请选择</div>';
            html += '<ul class="cg-tul" datagridId="'+datagridId+'">';
            for(var i =0 ;i<datafields.length;i++ ){
                var t = datafields[i];
                html += '<li class="cg-tli" datagridId="'+datagridId+'" ><label class="cg-tinli" datagridId="'+datagridId+'"><input type="checkbox" datagridId="'+datagridId+'"';
                if(t.show){
                    html += ' checked ';
                }
                html += ' field_value="'+ t.value+'"><span>'+ t.name +'</span></label></li>';
            }
            html += '</ul>';
            html += '<div class="cg-tbtngp" datagridId="'+datagridId+'">';
            html += '<span class="cg-tbtn fl cg-tcpte" datagridId="'+datagridId+'">完成</span>';
            html += '<span class="cg-tbtn fr cg-tcle" datagridId="'+datagridId+'">取消</span>';
            html += '</div>';
            html += ' </div></div>';
            if(toolbarId==undefined){
                $("#toolbar").append(html);
            } else {
                $("#"+toolbarId).append(html);
            }
            // 更多按钮，打开联动列表
            $('.cg-moreBtn[datagridId="'+datagridId+'"]').on('click', function () {
                $('.cg-tbList[datagridId="'+datagridId+'"]').fadeIn();
            });
            // 联动列表   完成按钮功能
            $('.cg-tcpte[datagridId="'+datagridId+'"]').on('click', function () {
                var hiddenColumns = "id";
                $('.cg-tli[datagridId="'+datagridId+'"]').each(function(){
                    var name = $(this).find('span').html();
                    var show = $(this).find('input')[0].checked;
                    var value = $($(this).find('input')[0]).attr("field_value");
                    if (show) {
                        datagrid.datagrid("showColumn",value);
                    } else {
                        datagrid.datagrid("hideColumn",value);
                        hiddenColumns += ',';
                        hiddenColumns += value;
                    }
                });
                $.ajax({
                    url: '/common/profile/hiddenColumns.html',
                    method: 'post',
                    data:{
                        datagridId: datagridId,
                        columns: hiddenColumns
                    },
                    dataType: 'json',
                    success: function(resp){
                        //不作处理
                    },
                    error: function(resp){
                        console.log(resp);
                    }
                });
                $('.cg-tbList[datagridId="'+datagridId+'"]').fadeOut();
            });
            // 联动列表   取消按钮功能
            $('.cg-tcle[datagridId="'+datagridId+'"]').on('click', function () {
                var fields = getDataFields(datagrid);
                fields.forEach(function (f, i){
                    $(".cg-tli[datagridId='"+datagridId+"']  input[field_value='"+ f.value+"']")[0].checked = f.show;
                });
                $('.cg-tbList[datagridId="'+datagridId+'"]').fadeOut();
            });
        }
    });*/
}

/**
 * 获取当前列情况
 * @param datagrid
 */
function getDataFields(datagrid){

    var datafields = [];
    var fields = datagrid.datagrid('getColumnFields');
    for(var i=0; i<fields.length; i++){
        var field = fields[i];
        var col = datagrid.datagrid('getColumnOption', field);
        if(col.field == 'ck'){
            continue;
        }
        var item = {};
        item.value = col.field;
        item.name = col.title;
        // 是否显示该列  暂时设置为随机的  true/false
        item.show = (!col.hidden);
        datafields.push(item);
    }
    //console.log(datafields);
    return datafields;
}

/**
 * 注册更多查询条件支持
 */
function registerMoreSearchItem(){


    var oForm = $('.cg-form');
    var oTable = $('.cg-form').find('tr');
    var aTd = oForm.find('td');
    var len = aTd.length;
    var line = 0;

    if(len > 17) {
        var hdTdArr = [];
        var secTr = $('<tr></tr>');
        aTd.each(function (i, t) {
            if (i > 15 && i < len - 1) {
                hdTdArr.push(t);
                $(t).hide();
            }
            if(i>7){
                secTr[0].appendChild(t);
            }
        });

        $('.cg-form tbody').append(secTr);
        var oPopTd = $('<td class="cg-poptd"></td>');
        var closeBtn = $('<span class="cg-closeh3"></span>');
        var oH3 = $('<h3 class="cg-poph3">更多查询 </h3>');
        var openBtn = $('<a href="#" onclick="javascript:void(0);" class="cg-highbtn">更多查询</a>&nbsp;&nbsp;&nbsp;&nbsp;');
        var searchBtn = oForm.find('a.l-btn-small')[0].cloneNode(true);
        var resetBtn = oForm.find('a.l-btn-small')[1].cloneNode(true);
        oH3.append(closeBtn);
        oPopTd.append(oH3);
        oTable.append(oPopTd);
        $('.cg-btnGroup').prepend(openBtn);

        hdTdArr.forEach(function (t, i) {

            var marginLeft = ['-270px', '-190px', '20px', '98px'];

            $(t).css({
                position: 'fixed',
                top: 98 + line * 34 + 'px',
                left: '50%',
                marginLeft: marginLeft[i % 4],
                zIndex: 100001
            });

            if (i % 4 === 3) line++;
        });
        if (hdTdArr.length % 4 !== 0) line++;
        $(searchBtn).css({
            position: 'fixed',
            top: 102 + line * 34 + 'px',
            left: '50%',
            marginLeft: '-62px',
            zIndex: 100001
        });
        $(resetBtn).css({
            position: 'fixed',
            top: 102 + line * 34 + 'px',
            left: '50%',
            marginLeft: '20px',
            zIndex: 100001
        });

        oPopTd.append(searchBtn);
        oPopTd.append(resetBtn);
        oPopTd.css('height', 40 + 24 + 30 + line * 34 + 'px');


        openBtn.on('click', function () {
            oPopTd.fadeIn();
            hdTdArr.forEach(function (t) {
                $(t).fadeIn();
            });
        });
        closeBtn.on('click', function () {
            oPopTd.fadeOut();
            hdTdArr.forEach(function (t) {
                $(t).fadeOut();
            });
        });

        oForm.show();
    }
    else if(len > 9){
        var secTr = $('<tr></tr>');
        aTd.each(function (i, t) {
            if(i>7){
                secTr[0].appendChild(t);
            }
        });
        $('.cg-form tbody').append(secTr);
        oForm.show();
    }
    else{
        oForm.show();
    }

}

function openSelectEDialog(obj, title, url, width, height, extData) {
    $('#selectDlg').html("");
    dialogVars = {};

    selObj = obj;

    var nameId = $(obj).attr("id");
    if (nameId == "") {
        alert("显示文本框的ID不能为空");
        return;
    }
    var val = $(obj).next().val();

    var w = width + "px";
    var h = height + "px";
    var u = '';

    if (extData == undefined) {
        extData = {};
    }
    extData['val'] = val;
    dialogVars = extData;

    $('#selectDlg').dialog({
        title: title,
        width: width,
        height: height,
        closed: false,
        cache: false,
        href: url,
        modal: true,
        onLoad: function () {
            initLoad(extData);
        }
    });
}


function openSelectEDialogX(obj, title, url, width, height, extData) {
    alert("hello");
    $('#selectDlg').html("");
    dialogVars = {};

    selObj = obj;

    var nameId = $(obj).attr("id");
    if (nameId == "") {
        alert("显示文本框的ID不能为空");
        return;
    }
    var val = $(obj).next().val();

    var w = width + "px";
    var h = height + "px";
    var u = '';

    if (extData == undefined) {
        extData = {};
    }
    extData['val'] = val;
    dialogVars = extData;

    $('#selectDlg').dialog({
        title: title,
        width: width,
        height: height,
        closed: false,
        cache: false,
        href: url,
        modal: true,
        onLoad: function () {
            initLoad(extData);
        }
    });
}


$(function(){
    registerMoreSearchItem();
});


/////////////////////////////////////////////////// 结束公共处理自定义列和高级查询 /////////////////////////////////////////////////
