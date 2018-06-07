
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<<#include "../../../../inc/meta.ftl">
<<#include  "../../../../inc/js.ftl">
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
    <div id="toolbar" style="padding:5px" class="cg-moreBox">
        <@shiro.hasPermission name="/report/workCondition/vehHistory/export">
            <a href="#" onclick="exportDatagrid('${base}/report/workCondition/vehHistory/export','form_search','table')" class="easyui-linkbutton"
               data-options="iconCls:'icon-export'" menu="0">导出</a>
        </@shiro.hasPermission>

    </div>
    <div id="table" name="datagrid" style="width: 100%;height: 100%"></div>
</div>

<div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 90px">
    <div style="width: 100%;border: 1;margin:5 5 5 10 ">
        <form id="form_search" name="" class="sui-form cg-form">
            <table class="table_search">
                <tr>
                    <td class="td_label">
                        <label>开始时间</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="easyui-datetimebox" id="startTime" style="width: height: 26px;width:150px;" value="${(startTime)!}"  name="query.startTime"  autocomplete="off" data-options="editable:false">
                    </td>
                    <td class="td_label">
                        <label>结束时间</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="easyui-datetimebox" id="endTime" style="width: height: 26px;width:150px;" value="${(endTime)!}" name="query.endTime"  autocomplete="off" data-options="editable:false">
                    </td>
                    <td class="td_label">
                        <label>仪表里程大于</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" style="width: height: 26px;width:150px;"   name="query.gaugesMileage"  autocomplete="off" >
                    </td>
                    <td class="td_label">
                        <label>车牌号</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" style="width: height: 26px;width:150px;"   name="query.licensePlate"  autocomplete="off" >
                    </td>
                    <td class="td_label">
                        <label>VIN</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" style="width: height: 26px;width:150px;"   name="query.vin"  autocomplete="off" >
                    </td>
                    <td class="td_label">
                        <label>车辆种类</label>
                    </td>
                    <td class="td_input">
                        <input type="text" id="vehTypeId" class="input-fat input" style="width: height: 26px;width:150px;"   name="query.vehTypeName"  autocomplete="off" >
                    </td>
                    <td class="td_label">
                        <label>车辆型号名称</label>
                    </td>
                    <td class="td_input">
                        <input id="vehModelName" class="input-fat input" style="width: height: 26px;width:150px;"   name="query.vehModelName"  autocomplete="off" >
                    </td>
                    <td class="td_label">
                        <label>运营单位</label>
                    </td>
                    <td class="td_input">
                        <input id="useUnitId" class="input-fat input" style="width: height: 26px;width:150px;"   name="query.useUnitName"  autocomplete="off" >
                    </td>
                    <td class="td_label">
                        <label>上牌区域</label>
                    </td>
                    <td class="td_input">
                        <input type="text" id="areaId" class="input-fat input" style="width: height: 26px;width:150px;"   name="query.areaName"  autocomplete="off" >
                    </td>
                    <td class="td_label">
                        <label>GPS里程大于</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" style="width: height: 26px;width:150px;"   name="query.gpsTotalMileage"  autocomplete="off" >
                    </td>
                    <td class="td_label">
                        <label>车辆阶段</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" id="vehStage" style="width: height: 26px;width:150px;"   name="query.vehStage"  autocomplete="off" >
                    </td>

                    <td style="vertical-align: center;text-align: right;border: 1px" class="cg-btnGroup">
                        <a href="#" onclick="searchButton()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
                        <a href="#" onclick="resetDatagrid('form_search','table')" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>
                    </td>
                </tr>


            </table>
        </form>
    </div>

</div>

</body>
<script>
    $(function(){
        //初始化条件数据
        initSelectChoose();
    });

    var queryParams = $('#form_search').serializeObject();

   $('#table').datagrid({
        url: '${base}/report/workCondition/vehHistory/datagrid',
        sortName: "createTime",
        sortOrder: "desc",
       queryParams: queryParams,
       frozenColumns:[[
           {field: 'ck', checkbox: true, width: '20'},
           {field: 'reportDate', title: '时间',align:'center',sortable: false},
           {field: 'licensePlate', title: '车牌号',align:'center',sortable: false},
           {field: 'vin', title: 'VIN',align:'center',sortable: false},
       ]],
        columns: [[
            {field: 'vehTypeName', title: '车辆种类',align:'center',sortable: false},
            {field: 'vehModelName', title: '车辆型号名称',align:'center',sortable: false},
            {field: 'modelNoticeId', title: '车辆公告型号',align:'center',sortable: false},
            {field: 'manuUnitName', title: '车辆厂商',align:'center',sortable: false},
            {field: 'useUnitName', title: '车辆阶段',align:'center',sortable: false,formatter: function(value,row,index){
                return "-";
            }},
            {field: 'useUnitName', title: '运营单位',align:'center',sortable: false},
            {field: 'areaName', title: '上牌区域',align:'center',sortable: false},
            {field: 'firstReg', title: '激活时间',align:'center',sortable: false},
            {field: 'saleTime', title: '销售日期',align:'center',sortable: false},
            {field: 'lastCommunicationTime', title: '最后通讯时间',align:'center',sortable: false},
            {field: 'lastCanValidTime', title: '有效CAN数据最后上传时间',align:'center',sortable: false},
            {field: 'lastChargeTime', title: '最后一次充电时间',align:'center',sortable: false},
            {field: 'chargeDischargeState', title: '充放电状态',align:'center',sortable: false},
            {field: 'gpsTotalMileage', title: 'GPS总里程(km)',align:'center',sortable: false},
            {field: 'gaugesMileage', title: '仪表里程(km)',align:'center',sortable: false},
            {field: 'totalVoltage', title: '总电压(V)',align:'center',sortable: false},
            {field: 'totalCurrent', title: '总电流(A)',align:'center',sortable: false},
            {field: 'speed', title: '车速(km/h)',align:'center',sortable: false},
            {field: 'soc', title: 'SOC(%)',align:'center',sortable: false},
            {field: 'location', title: '地理位置',align:'center',sortable: false},
            {field: 'termPartFirmwareNumber', title: '终端零件号',align:'center',sortable: false},
            {field: 'termBarCode', title: '条形码编码',align:'center',sortable: false},
            {field: 'serialNumber', title: '终端厂商自定义编号',align:'center',sortable: false},
            {field: 'iccid', title: 'ICCID',align:'center',sortable: false},
        ]],
        toolbar: "#toolbar",
        pagination: true,
        nowrap: true

    });

    toolbar2Menu("table");

</script>
<script language="javascript">

    /*查询事件*/
    function searchButton(){

        //时间校验
        var endTime = $('#endTime').datetimebox("getValue");
        var startTime = $('#startTime').datetimebox("getValue");
        endTime = new Date(endTime);
        startTime = new Date(startTime);
        if (endTime < startTime) {
            $.messager.alert('提示','开始时间必须小于结束时间！');
            return;
        }
        if (endTime < startTime) {
            $.messager.alert('提示','结束时间必须大于开始时间！');
            return;
        }
        var startTimeFormat = startTime.Format("yyyy-MM-dd");
        var endTimeFormate = endTime.Format("yyyy-MM-dd");
        debugger;
        var days = (new Date(endTimeFormate).getTime() - new Date(startTimeFormat).getTime()) / 86400000;
        if (days > 6){
            $.messager.alert('提示','选择开始时间与结束时间间隔最大为七天！');
            return;
        }

        //请求查询
        searchDatagrid('form_search','table');
    }

    /**
     * 初始化下拉选择框
     */
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

</script>
</html>