
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<#include "../../../../inc/meta.ftl">
<#include "../../../../inc/js.ftl">
    <style type="text/css">
        .td_input a:not(.bg_button) {
            right: 20px !important;
        }
    </style>
    <script language="javascript">
    </script>
</head>
<body class="easyui-layout" fit="true" id="fullid">

<div region="center" style="overflow: hidden;width: 100%;">


<div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 120px">
    <div style="width: 100%;border: 1;margin:5 5 5 10 ">
        <form id="form_search" name="" class="sui-form cg-form">
            <div style="width: 90%; height: 20px; margin: 10px;">
                <label>条件查询</label>
                <input type="radio" id="tiaojian" name="query.adminFlag" checked="checked" data-option="selected:true" value="0"></input>
                <label>导入查询</label>
                <input type="radio" id="daoru" name="query.adminFlag" value="1"></input>
            </div>
            <table class="table_search">
                <tr>
                    <td class="td_label"  id="filetitle">
                        <label>导入查询文件</label>
                    </td>
                    <td class="td_input" id="fileinput">
                        <input type="file" id="file" style="width:100px;" name="query.myfile" />
                    </td>
                    <td class="td_label">
                        <label>查询日期</label>
                    </td>
                    <td class="td_input">
                        <input type="text" id="startTime" class="easyui-datetimebox"  style="width: height: 26px;width:170px;" name="query.startTime" autocomplete="off">
                    </td>
                    <td class="td_label">
                        <label>至</label>
                    </td>
                    <td class="td_input">
                        <input type="text" id="endTime" class="easyui-datetimebox" style="width: height: 26px;width:170px;" name="query.endTime" autocomplete="off">
                    </td>
                    <td class="td_label">
                        <label>运营单位</label>
                    </td>
                    <td class="td_input">
                        <input type="text" id="useUnitId" class="input-fat input" style="width: height: 26px;width:150px;" name="query.useUnitName" autocomplete="off">
                    </td>
                    <td class="td_label">
                        <label>车牌号</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" style="width: height: 26px;width:150px;" name="query.licensePlate" autocomplete="off">
                    </td>
                    <td class="td_label">
                        <label>VIN</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" style="width: height: 26px;width:150px;" name="query.vin" autocomplete="off">
                    </td>
                    <td class="td_label">
                        <label>车辆种类</label>
                    </td>
                    <td class="td_input">
                        <input type="text" id="vehTypeId" class="input-fat input" style="width: height: 26px;width:150px;" name="query.vehTypeName" autocomplete="off">
                    </td>
                    <td class="td_label">
                        <label>车辆型号名称</label>
                    </td>
                    <td class="td_input">
                        <input type="text" id="vehModelName" class="input-fat input" style="width: height: 26px;width:150px;" name="query.vehModelName" autocomplete="off">
                    </td>
                    <td class="td_label">
                        <label>车辆阶段</label>
                    </td>
                    <td class="td_input">
                        <input type="text" id="vehStage" class="input-fat input" style="width: height: 26px;width:150px;" name="query.vehStage" autocomplete="off">
                    </td>
                    <td class="td_label">
                        <label>上牌城市</label>
                    </td>
                    <td class="td_input">
                        <input type="text" id="areaId" class="input-fat input" style="width: height: 26px;width:150px;" name="query.areaName" autocomplete="off">
                    </td>

                    <td style="vertical-align: center;text-align: right;border: 1px" class="cg-btnGroup">
                        <a href="#" onclick="searchButton()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
                        <a href="#" onclick="resetButton()" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>
                        <a href="#" onclick="downFile()" id = "downLadfile" data-options="iconCls:'icon-reset'">导入查询模板下载</a>
                    </td>
                </tr>


            </table>
        </form>
    </div>
</div>
    <div id="toolbar" style="padding:5px" class="cg-moreBox">
    <@shiro.hasPermission name="/report/demo1/export">
        <a href="#" onclick="exportButton()" class="easyui-linkbutton"
           data-options="iconCls:'icon-export'" menu="0">导出</a>
    </@shiro.hasPermission>

    </div>
    <div id="table" name="datagrid" style="width: 100%;height: 100%"></div>
</div>

</body>
<script>
    $('#table').datagrid({
        url: '${base}/report/anomaly/anomalyVeh/datagrid',
        sortName: "createTime",
        sortOrder: "desc",
        frozenColumns:[[
            /*{field: 'ck', checkbox: true, width: '20'},*/
            {field: 'licensePlate', title: '车牌号',align:'center',sortable: false},
            {field: 'vin', title: 'VIN',align:'center',sortable: false},
        ]],
        columns: [[
            {field: 'vehTypeName', title: '车辆种类',align:'center',sortable: false},
            {field: 'vehModelName', title: '车辆型号名称',align:'center',sortable: false},
            {field: 'modelNoticeId', title: '车辆公告型号',align:'center',sortable: false},
            {field: 'termPartFirmwareNumber', title: '终端零件号',align:'center',sortable: false},
            {field: 'termBarCode', title: '条形码编码',align:'center',sortable: false},
            {field: 'serialNumber', title: '终端厂商自定义编号',align:'center',sortable: false},
            {field: 'manuUnitName', title: '车辆厂商',align:'center',sortable: false},
            {field: 'useUnitName', title: '运营单位',align:'center',sortable: false},
            {field: 'areaName', title: '上牌城市',align:'center',sortable: false},
            {field: 'firstReg', title: '激活时间',align:'center',sortable: false},
            {field: 'saleTime', title: '销售日期',align:'center',sortable: false},
            {field: 'iccid', title: 'ICCID',align:'center',sortable: false},
            {field: 'reportDate', title: '最近异常时间',align:'center',sortable: false},
            {field: 'speedNumber', title: '车速异常（条）',align:'center',sortable: false},
            {field: 'mileageNumber', title: '里程异常（条）',align:'center',sortable: false},
            {field: 'lngLatNumber', title: '经纬度异常（条）',align:'center',sortable: false},
            {field: 'timeNumber', title: '时间异常（条）',align:'center',sortable: false},
            {field: 'voltageNumber', title: '总电压异常（条）',align:'center',sortable: false},
            {field: 'electricNumber', title: '总电流异常（条）',align:'center',sortable: false},
            {field: 'socNumber', title: 'SOC异常（条）',align:'center',sortable: false},
        ]],
        toolbar: "#toolbar",
        pagination: true,
        nowrap: true,
        rownumbers: true,

    });

    toolbar2Menu("table");

</script>
<script language="javascript">
    $(function(){
        document.getElementById("filetitle").style.display = "none";
        document.getElementById("fileinput").style.display = "none";
        document.getElementById("downLadfile").style.display = "none";

        //初始化条件数据name="adminFlag"
        initSelectChoose();
    });

    //导出按钮事件
    function exportButton(){
        if (!checkTime()) {
            return;
        }
        var file = document.getElementById("file").files[0];
        if(!fileCheck(file)){
            return;
        }
        var urlTemp = "${base}/report/anomaly/anomalyVeh/export";
        exportDatagrid(urlTemp,'form_search','table');
    }

    //查询按钮事件
    function searchButton(){

        if (checkTime()) {
            var val=$('input:radio[name="query.adminFlag"]:checked').val();
            if (val == 0) {
                //请求查询
                searchDatagrid('form_search','table');
            } else {
              //执行导入查询
                importSearchButton();
            }

        }
    }

    //导入查询
    function importSearchButton(){
        if (!checkTime()) {
            return;
        }
        var formData = new FormData();
        var file = document.getElementById("file").files[0];
        if (fileCheck(file)) {
            formData.append("file", file);

            //importType 导入查询标识，用于区分SQL拼接
            formData.append("identity", "importType");
            identity = "importType";
            $.ajax({
                url : "${base}/report/anomaly/anomalyVeh/improtSearch",
                type : 'POST',
                data : formData,
                async : false,
                cache : false,
                contentType : false,
                processData : false,
                success : function(data) {
                    if (data.code == 0) {

                        var searchParames = $('#form_search').serializeObject();
                        searchParames['query.identity'] = "identity";
                        $("#table").datagrid("load", searchParames);

//                        $('#win').window('close');
//                        $.messager.alert('提示','查询成功！');
                    } else {
                        $.messager.alert('提示', data.message);
                    }
                },
                error : function(data) {
                    $.messager.alert('提示','请求系统失败！！');
                }
            });
        }

    }

    //重置按钮事件
    function resetButton(){
        //初始化条件
        initSelectChoose();
        resetDatagrid('form_search','table')
    }

    /*模板下载*/
    function downFile() {
        var downUrl = "${base}/report/common/downLoadModel?moduleName=model&fileName=templateQuery.xls";
        window.open(downUrl);
    }

    /*校验开始时间/结束时间是否合法*/
    function checkTime(){
        //时间校验
        var endTime = $('#endTime').datetimebox("getValue");
        var startTime = $('#startTime').datetimebox("getValue");
        if (endTime != "" && startTime == "") {
            $.messager.alert('提示','请选择开始时间！');
            return false;
        }
        if (endTime == "" && startTime != "") {
            $.messager.alert('提示','请选择结束时间！');
            return false;
        }
        endTime = new Date(endTime);
        startTime = new Date(startTime);
        if (endTime < startTime) {
            $.messager.alert('提示','开始时间必须小于结束时间！');
            return false;
        }
        if (endTime < startTime) {
            $.messager.alert('提示','结束时间必须大于开始时间！');
            return false;
        }
        return true;
    }


    /*初始化下拉选择框*/
    function initSelectChoose() {
        //上牌区域
        $('#areaId').combotree({
            url: '${base}/report/common/queryAreaList',
            onLoadSuccess:function(node, data){
                $('#areaId').combotree('setValue', { id: data[0].id, text: data[0].text });
            }
        });
        //运营单位
        $('#useUnitId').combotree({
            url: '${base}/report/common/queryUnitList',
            onLoadSuccess:function(node, data){
                $('#useUnitId').combotree('setValue', { id: data[0].id, text: data[0].text });
            }
        });
        //车辆车型名称
        $('#vehModelName').combobox({
            url: '${base}/report/common/queryVehModelList',
            valueField: 'id',
            textField: 'text',
            onLoadSuccess:function(){
                var val = $(this).combobox("getData");
                $(this).combobox("select", val[0].text);
                $(this).combobox("setValue", val[0].id);
            }
        });
        //车辆种类
        $('#vehTypeId').combotree({
            url: '${base}/report/common/queryVehTypeList',
            onLoadSuccess:function(node, data){
                $('#vehTypeId').combotree('setValue', { id: data[0].id, text: data[0].text });
            }
        });

        //车辆阶段
        $('#vehStage').combobox({
            url: '${base}/report/common/queryVehStageList',
            valueField: 'id',
            textField: 'text',
            onLoadSuccess:function(){
                var val = $(this).combobox("getData");
                $(this).combobox("select", val[0].text);
                $(this).combobox("setValue", val[0].id);
            }
        });
    }

    /**
     * 检验文件的格式
     * @param file
     */
    function fileCheck(file){
        if (file == undefined || file == null || file == "") {
            $.messager.alert('提示','请选择导入查询文件！');
            return false;
        }
        if (file.size > 10240 * 1024) {
            $.messager.alert('提示','文件大小超出最大为10M限制！');
            return false;
        }
        var fileName = file.name;
        var suffixName = (fileName.substr(fileName.lastIndexOf("."))).toLowerCase();
        if (suffixName != ".xls" && suffixName != ".xlsx") {
            $.messager.alert('提示','上传文件格式不正确，确认文件后缀名为xls、xlsx！');
            return false;
        }
        return true;
    }

    $("#tiaojian").change(function() {
        //$("#daoruchaxun").hide();
        $("#filetitle").hide();
        $("#fileinput").hide();
        $("#downLadfile").hide();
    });

    $("#daoru").change(function() {
        //$("#daoruchaxun").show();
        $("#filetitle").show();
        $("#fileinput").show();
        $("#downLadfile").show();
    });

</script>
</html>