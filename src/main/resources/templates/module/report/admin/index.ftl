<!DOCTYPE html>
<html>
<head>



    <link rel="stylesheet" href="../../skin/skincss/starblue.css">
<#--<link rel="stylesheet" href="../skin/css/bootstrap.min.css">-->
    <link rel="stylesheet" href="../../skin/css/font-awesome/css/font-awesome.css">
<#--<link rel="stylesheet" href="../skin/css/style.css">-->
<#include "../../../inc/meta.ftl">
<#include  "../../../inc/js.ftl">

<#--    <script type="text/javascript" src="/js/sockjs.min.js"></script>
    <script type="text/javascript" src="/js/stomp.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/toast.style.css"/>-->
  <#--  <script src="/js/toast.script.js"></script>-->
    <style>
        .panel-title {
            color: #ffffff;
        }
    </style>
</head>
<script language="JavaScript">
    var timed; var testingTime; var time_alerm=Number("${(alerm)!60}");
    var bum=Number("${(alerm)!60}");
    var areaTitleName="${(areaTitleName)!}";
    var onclickAreaid='0';
    window.isshoye=true;
    var total=0;var showBotton=false;
    var levels1= 0,levels2= 0,levels3= 0,levels4= 0,levels5= 0,levels6= 0;

    var audio = document.createElement("AUDIO");

    //    $(function(){
    ////        timed = setInterval("cesjo()", bum * 60 * 1000);
    ////        testingTime = setInterval("queryAlermTime()", 10 * 1000);
    //
    ////        if(document.domain=="xian.bitnei.cn"){
    ////            $('#xitongtitle').html("新能源汽车及充换电设施综合管理平台");
    ////        }
    //
    //
    //    });



    function queryAlermTime(){
        if(bum!=time_alerm){
            clearInterval(timed);
            timed= setInterval("cesjo()", time_alerm * 60 * 1000);
            bum=time_alerm;
        }
    }

    function cesjo(){
        layer.confirm(content,
                {
                    title:'提醒信息',
                    skin:'layui-layer-lan',
//                          skin:'layui-layer-molv',
                    offset: 'rb', //右下角弹出
                    closeBtn: 1,
                    time:10000,//10s后自动关闭
                    btn: ['立即处理','提醒设置'] //按钮
                },
                function(){
                    layer.closeAll();
                    addTabFun('故障告警','/sysFaultAlarm/list.html?skip=2','m_'+'sysFaultAlarm','icon-nat_module',0);
                },
                function(){
                    layer.closeAll();
                    layer.prompt({title: '请设置推迟时间（分钟）'}, function(name){
                        clearInterval(timed);
                        var reg = new RegExp("^[0-9]*$");
                        var obj = Number(name);

                        if(!reg.test(name)){
                            layer.msg('请输入数字!');
                            //timed= setInterval("cesjo()", bum * 60 * 1000);
                        }else{
                            $.ajax({
                                url: '/admin/setAlermTime.html',
                                data: {alermTime: obj},
                                type: 'post',
                                success: function (data) {
                                }
                            });
                            //timed= setInterval("cesjo()", obj * 60 * 1000);
                            //time_alerm=obj;
                        }
                        layer.closeAll();
                    });
                }
        );
    }

    function showAlerm(){
        addTabFun('平台报警处理','/sysFaultAlarm/list.html?skip=2','m_'+'sysFaultAlarm','',0);
    }


    /**
     * 弹出窗口，主要用在弹出选择框
     * @param url
     * @param width
     * @param heiht
     * @param nameId 显示文本框ID
     */
    // var selObj;
    // var li;
    // var dialogVars = {};
    // function openSelectDialog(obj, title, url, width, height, extData) {
    //     $('#selectDlg').html("");
    //     dialogVars = {};
    //
    //     selObj = obj;
    //
    //     var nameId = $(obj).attr("id");
    //     if (nameId == "") {
    //         alert("显示文本框的ID不能为空");
    //         return;
    //     }
    //     var val = "";
    //     if($(selObj).nextAll().length>1){
    //         val = $(obj).siblings('input[type="hidden"]').val();
    //     }else{
    //         val = $(obj).val();
    //     }
    //     var w = width + "px";
    //     var h = height + "px";
    //     var u = '';
    //
    //     if (extData == undefined) {
    //         extData = {};
    //     }
    //     extData['val'] = val;
    //     dialogVars = extData;
    //
    //     $('#selectDlg').dialog({
    //         title: title,
    //         width: width,
    //         height: height,
    //         closed: false,
    //         cache: false,
    //         href: url,
    //         modal: true,
    //         onLoad: function () {
    //             initLoad();
    //         }
    //     });
    //
    // }

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

    function openHomeSelectDialog(obj, title, url, width, height, extData) {

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
                initLoad();
            }
        });

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
    // function openVehicleSelectDialog(obj, title, url, width, height, extData) {
    //     $('#selectDlg').html("");
    //     selObj = obj;
    //     var nameId = $(obj).attr("id");
    //     if (nameId == "") {
    //         alert("显示文本框的ID不能为空");
    //         return;
    //     }
    //     $('#selectDlg').dialog({
    //         title: title,
    //         width: width,
    //         height: height,
    //         closed: false,
    //         cache: false,
    //         href: url,
    //         modal: true,
    //         onLoad: function () {
    //             initLoad(extData);
    //         }
    //     });
    // }
    // function confirmSelect(name, val) {
    //     $(selObj).val(name);
    //     //配合弹出框改造，重置取值位置 add by yuexw 2017年4月28日
    //     if($(selObj).nextAll().length>1){
    //         $(selObj).siblings('input[type="hidden"]').val(val).change();
    //     }else{
    //         $(selObj).next().val(val).change();
    //     }
    //     $('#selectDlg').dialog("close");
    //     $('#selectDlg').html("");
    //
    // }
    function confirmVehicleSelect(name1, val1, name2, val2, name3, val3) {
//        $("#manuUnitName").val(name1);
//        $("#manuUnitId").val(val1);
//        $("#vehModelName").val(name2);
//        $("#vehModelId").val(val2);
//        $("#batchName").val(name3);
//        $("#batchId").val(val3);
//        $(selObj).val(name);
        var val = name1 + "," + val1 + "," + name2 + "," + val2 + "," + name3 + "," + val3;
        if($(selObj).nextAll().length > 1){
            //配合弹出框改造，重置取值位置 add by yuexw 2017年4月27日
            $(selObj).siblings('input[type="hidden"]').val(val).change();
        }else{
            $(selObj).next().val(val).change();
        }
        $('#selectDlg').dialog("close");
        $('#selectDlg').html("");

    }
    function confirmVehicleSelectUser(val0,name1, val1, name2, val2, name3, val3,val4,val5,val6) {

        var val = val0 + "," +name1 + "," + val1 + "," + name2 + "," + val2 + "," + name3 + "," + val3 +"," + val4 + "," +val5+ "," +val6;
        if($(selObj).nextAll().length > 1){
            //配合弹出框改造，重置取值位置 add by yuexw 2017年4月27日
            $(selObj).siblings('input[type="hidden"]').val(val).change();
        }else{
            $(selObj).next().val(val).change();
        }
        $('#selectDlg').dialog("close");
        $('#selectDlg').html("");
    }

    // function getDialogVar(key) {
    //     return dialogVars[key];
    // }

    function clearInputValue(obj) {
        $(obj).prev().val("");
        if ($(obj).next().length > 0) {
            $(obj).next().val("");
        }
    }

    function isSelect(data, val) {
        for (var i = 0; i < data.length; i ++) {
            if (data[i]['id'] == val) {
                return true;
            } else if (null != data[i]['children'] && data[i]['children'].length > 0) {
                if (isSelect(data[i]['children'], val)) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * 平台名称变换
     * @param cnname
     * @param enname
     */
    function changeEvmscTitle(cnname,enname){
        $("#evmscTitleCN").html(cnname);
        $("#evmscTitleEN").html(enname);
    }

    // /**用于dialog之间传递数据中间变量*/
    // var dialogResData;
    //
    // function setDialogResData(data){
    //     dialogResData = data;
    // }
    //
    // function getDialogResData(){
    //     return dialogResData;
    // }



    document.addEventListener("DOMContentLoaded", function() {
        // Remove elements with "noscript" class - <noscript> is not allowed in XHTML
        var noscripts = document.getElementsByClassName("noscript");
        for (var i = 0; i < noscripts.length; i++) {
            noscripts[i].parentNode.removeChild(noscripts[i]);
        }
    }, false);



    function  addSendInfo(response){
        var info = response.body.split("#");
        var infoStr = info[0];
        var type = info[1];
        var vin = info[2];
        var id = info[3];

        //addToast("hahah",id); //直接弹屏
        clickCounter(type,infoStr,vin,id);

        // datagridByVin(type,infoStr,vin,id); //测试浏览器窗口弹屏
    }




    function clickCounter(type,infoStr,vin,id) {
        if(typeof(Storage) !== "undefined") {

            if (sessionStorage.clickcount) {
                if(sessionStorage.clickcount.indexOf(id)>=0){
                    console.log("已经提示过了 不在提示");
                }else{
                    console.log("进来了没有4444？=======");
                    sessionStorage.clickcount += ","+ id;
                    datagridByVin(type,infoStr,vin,id);
                }

            } else {
                sessionStorage.clickcount = id;
                datagridByVin(type,infoStr,vin,id);

            }
        }
    }


    //请求车辆查询方法、根据不同用户车辆权限 提示故障信息 TODO 待优化 优化后放开
    function datagridByVin(type,infoStr,vin,id) {
        console.log("type ==========" + type);
        $.ajax({
            url: '/sysVehicle/datagrid.html?query.vin%26eqs='+vin,
            type: "get",
            timeout: 1200000, //超时时间：20分钟
            success: function (data) {
                var obj = JSON.parse(data);
                console.log("是否有权限？obj =======" + obj);
                if(obj.total > 0){
                    if(type == "1"){
                        addToast(infoStr,id);
                    }
                    if(type == "2"){
                        audio.play();
                        addToast(infoStr,id);
                    }
                }
            }
        });
    }


    var startTime = new Date().getTime();
    var startNum = 1;
    function addToast(value, id){
        var timeNow = new Date().getTime();
        var timeDis = timeNow - startTime;
        if(timeDis >= 11000*startNum){
            startTime = timeNow;
            startNum = 1;
            $.Toast("提示", value, "warning", {
                stack: true,
                has_icon:true,
                has_close_btn:true,
                fullscreen:false,
                timeout:10000,
                sticky:false,
                has_progress:true,
                rtl:false
            },function () {
                checkoutVehicleVin(id);
            });
        }else{
            setTimeout(function () {
                $.Toast("提示", value, "warning", {
                    stack: true,
                    has_icon:true,
                    has_close_btn:true,
                    fullscreen:false,
                    timeout:10000,
                    sticky:false,
                    has_progress:true,
                    rtl:false
                },function () {
                    checkoutVehicleVin(id);
                });
            }, startNum*11000 - timeDis);
            startNum++;
        }

    }

    //消息处理
    function checkoutVehicleVin(id) {

        $.ajax({
            url: '/sysInfoAlert/update.html',
            type: "post",
            dataType:'json',
            data:{
                id:id
            },
            success: function (jm) {
                if(jm.flag){
                    var faultType =   jm.resData.faultType; //根据不同预警信息跳转到不同的列表中
                    //var vin = jm.resData.vin;
                    // console.log('vin', vin);
                    if(faultType =="0"){
                        mngRol("/sysFaultAlarm/list.html", "平台报警处理", "" );
                    }
                    if(faultType =="1"){
                        mngRol("/sysFaultInfoRecord/list.html", "故障码报警处理", "");
                    }
                }

            }
        });

    }

    /**
     * 跳转
     * @param url
     * @param text
     */
    function mngRol(url, text, param) {
        //url = url + "?" + param;
        window.parent.window.parent.addTabFun(text, url, new Date().getTime(), "", 0, true);
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

</script>


<body id="indexLayout" class="easyui-layout" fit="true">
<div region="north"  data-options="border:false" href="north" style="height:50px; overflow: hidden" id="northDDiv" ></div>
<div region="west"   data-options="border:false" href="west" title="导航" split="false" style="top: 80px; width:220px;overflow: hidden;color:#ffffff" id="westRegion"></div>
<div region="center" data-options="border:false" href="center" style="top: 80px; overflow: hidden;"></div>
<#--<div region="south"  data-options="border:true" href="south" style="height:20px;overflow: hidden;"></div>-->
<div id="selectDlg" ></div>
<div id="dd" style="z-index:-999;position:relative;"></div>


</body>



</html>