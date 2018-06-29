<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <#include "../../../../inc/meta.ftl">
    <#include "../../../../inc/js.ftl">
    <script>
            $(function (){
                var bodyClass = $("body").attr("class");
                if(bodyClass!=undefined && bodyClass.indexOf("easyui-layout")>=0){
                    var panel = $("body").layout("panel","north");
                    if(panel[0]){
                        var centerPanel = $("body").layout("panel","center");
                        var options = panel.panel("options");
                        var optionsCenter = centerPanel.panel("options");
                        var title = options.title;
                        if(title!=undefined && title=="查询"){
                            var oldHeight = options.height;
                            var oldCenterHeight = optionsCenter.height;
                            var afterCenterHeight = oldCenterHeight-(120-oldHeight);
                            var tdNum = panel.find('.table_search td').length;
                            panel.panel("resize",{
                                height: (tdNum>9?2:1)*50 + 75
                            });
                            centerPanel.panel("resize",{
                                height:afterCenterHeight
                            });

                            $("body").layout("resize",{
                                height: $("body").length
                            });
                        }
                    }
                }
            });
        </script>
    <style type="text/css">
        .td_input a:not(.bg_button) {
            right: 20px !important;
        }
    </style>
    <script language="javascript">
    </script>
</head>
<body class="easyui-layout" fit="true" id="fullid">
<div id="report" class="easyui-window" title="列表说明" style="width:853px; height:600px; display: none;" data-options="modal:true,closed:true">
    <div class="easyui-layout">
        <table class="easyui-datagrid">
            <thead>
            <tr>
                <th data-options="field:'code', width: 200, align: 'left', halign: 'center'">名称</th>
                <th data-options="field:'name', width: 650, align: 'left', halign: 'center'">定义</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>速度异常</td><td>1、车速有效性异常：
                <br />
                1）车速为空，或，上传无效值或异常值，及0xFE或0xFF；
                注：仅实时数据判断，自动唤醒不判断；
                <br />
                2、车速数值异常：
                <br />
                1）车速超出有效值范围，速度＞200km/h或＜0km/h；</td>
            </tr>
            <tr>
                <td>仪表里程异常</td><td>1、仪表里程有效性异常
                <br />
                1）仪表里程为空，或，上传无效值或异常值，及0xFE或0xFF；
                注：包含自动唤醒场景下上传的数据；
                <br />
                2、仪表里程数值异常
                <br />
                1）超出有效值范围：里程值大于等于100万的数值；
                <br />
                2）里程跳变：连续两帧数据，后一帧里程—前一帧里程大于2km；
                <br />
                注：包含自动唤醒场景下上传的数据；</td>
            </tr>
            <tr>
                <td>经/纬度异常</td><td>1、经纬度有效性异常：
                经度或纬度为空，或，上传无效值或异常值，及0xFE或0xFF；
                <br />
                2、经纬度数值异常
                <br />
                1）超出范围：经度∈（73,135），纬度∈（4.53）;
                注：包含自动唤醒情况下上传的经纬度数值；</td>
            </tr>
            <tr>
                <td>时间异常</td><td>1、时间有效性异常：
                终端上传时间为空，或，上传无效值或异常值，及0xFE或0xFF；
                <br />
                2、时间数值异常：
                未校正时间：与系统接收时间误差在±10min计为时间异常；
                包含自动唤醒场景下上传的时间；</td>
            </tr>
            <tr>
                <td>总电压异常</td><td>1、总电压有效性异常：
                总电压为空，或，上传无效值或异常值，及0xFE或0xFF；
                <br />
                2、总电压数值异常
                总电压∈（0,1000]</td>
            </tr>
            <tr>
                <td>总电流异常</td><td>1、总电流有效性异常：
                总电流为空，或，上传无效值或异常值，及0xFE或0xFF；
                <br />
                2、总电流数值异常：
                <br />
                1）当电流≥5A时，连续3帧相同；
                <br />
                2）总电流＞20A；</td>
            </tr>
            <tr>
                <td>SOC异常</td><td>1、SOC有效性异常：
                总电压为空，或，上传无效值或异常值，及0xFE或0xFF；
                注：排除自动唤醒情况下上传的数据；
                <br />
                2、SOC数值异常：
                <br />
                1）SOC>100%，或SOC<0；</td>
            </tr>
            <#--<tr>-->
                <#--<td>地理位置</td><td>生成快照时的地理位置，GPS数值转译后的实际地理名称</td>-->
            <#--</tr>-->
            <#--<tr>-->
                <#--<td>最后通讯时间</td><td>车辆在生成快照前，最后与平台通讯的时间，含自动唤醒</td>-->
            <#--</tr>-->
            <#--<tr>-->
                <#--<td>有效CAN数据最后上传时间</td><td>CAN数据有效性仅作车速、里程、总电压、总电流、GPS经纬度、SOC值、时间有效性的判断； <br /> 上述字段均不为空，有效范围内</td>-->
            <#--</tr>-->
            <#--<tr>-->
                <#--<td>最后一次充电时间</td><td>是最后一次上传充电状态的时间（包含停车充电或充电完成状态的时间）</td>-->
            <#--</tr>-->
            <#--<tr>-->
                <#--<td>充放电状态</td><td>32960协议里的状态：停车充电、行驶充电、未充电、充电完成、异常、无效</td>-->
            <#--</tr>-->
            </tbody>
        </table>
    </div>
</div>

<div id="recordExplanPopup" class="easyui-window" title="列表说明" style="width:853px;height:350px; display: none;" data-options="modal:true,closed:true">
    <div class="easyui-layout">
        <table class="easyui-datagrid">
            <thead>
            <tr>
                <th data-options="field:'code',align: 'left', halign: 'center'" style="width: 20%">名称</th>
                <th data-options="field:'name',align: 'left', halign: 'center'" style="width: 80%">定义</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>异常数据上传时间</td><td>异常开始产生的时间
                <br/>
                1、计算每一帧异常数据，若连续3条异常方标记为开始，那么取触发成功的第一条数据；
                <br/>
                2、系统采集数据的时间</td>
            </tr>
            <tr>
                <td>异常发生地理位置</td><td>异常开始发生的地理位置；
                <br/>
                显示异常开始时上报的地理位置；如果GPS异常，取异常开始前一帧的正常位置</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<div id="exceptionRecord" class="easyui-window" title="车速异常记录详情" style="width:853px;height:550px" data-options="modal:true,closed:true">
    <div style="width: 90%; height: 30px; margin-top: 20px; margin-left: 10px">
        <div style="height: 100%; width: 150px; float: left;"><label>VIN：</label><label id="vin"></label></div>
        <div style="height: 100%; width: 150px; float: left; margin-left: 50px;"><label>车牌号：</label><label id="licensePlate"></label></div>
        <input type="hidden" id="vid" name="vid" value="" />
        <#--<label>VIN:</label><label id="vin"></label><label>车牌号:</label><label id="licensePlate"></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label>车辆公告型号:</label><label id="modelNoticeId"></label></div>-->
    </div>
    <div><input type="text" style="display: none" id="typeId"/></div>
    <div style="margin-bottom: 5px;">
        <a href="#" onclick="exceptionExport()" class="easyui-linkbutton" data-options="iconCls:'icon-export'" style="margin-left: 10px; width: 65px;">
            导出
        </a>
        <a href="#" id="reportExplan" onclick="reportExplan()" data-options="iconCls:'icon-export'" menu="0" style="float: right;margin-top:6px;margin-right: 20px">列表说明</a>
    </div>
    <div style="width: auto;height: 415px;">
        <#--<div id="recordToolbar" style="padding:5px" class="cg-moreBox">-->
            <#--<a href="#" class="easyui-linkbutton" onclick="exceptionExport()"  data-options="iconCls:'icon-export'" menu="0">导出</a>-->
        <#--</div>-->
        <div id="recordTable" name="datagrid" style="width: 100%;height: 100%"></div>
    </div>
</div>
<div region="center" style="overflow: hidden;width: 100%;">
    <div id="toolbar" style="padding:5px" class="cg-moreBox">
    <@shiro.hasPermission name="/report/anomaly/anomalyVeh/export">
        <a href="#" onclick="exportButton()" class="easyui-linkbutton"
           data-options="iconCls:'icon-export'" menu="0">导出</a>
    </@shiro.hasPermission>
    <a href="#" onclick="reportSpecification()" data-options="iconCls:'icon-export'" menu="0" style="float: right;margin-top:6px;margin-right: 100px">列表说明</a>
    </div>
    <div id="table" name="datagrid" style="width: 100%; height: 100%"></div>
</div>

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
                        <label>文件上传:</label>
                    </td>
                    <td class="td_input" id="fileinput">
                        <input type="file" id="file" style="height: 30px; width: 168px;" name="query.myfile" />
                    </td>
                    <td class="td_label" style="text-align: right">
                        <label>查询日期:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" id="startTime" class="easyui-datetimebox" value="${(startTime)!}" style="width: height: 26px;width:170px;" name="query.startTime" autocomplete="off">
                    </td>
                    <td class="td_label" style="text-align: center">
                        <label>至:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" id="endTime" class="easyui-datetimebox" value="${(endTime)!}" style="width: height: 26px;width:170px;" name="query.endTime" autocomplete="off">
                    </td>
                    <td class="td_label" style="text-align: right">
                        <label>运营单位:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" id="useUnitId" class="input-fat input" style="width: height: 26px;width:150px;" name="query.useUnitName" autocomplete="off">
                    </td>
                    <td class="td_label" style="text-align: right">
                        <label>车牌号:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" style="width: height: 26px;width:150px;" name="query.licensePlate" autocomplete="off">
                    </td>
                    <td class="td_label" style="text-align: right">
                        <label>VIN:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" style="width: height: 26px;width:150px;" name="query.vin" autocomplete="off">
                    </td>
                    <td class="td_label" style="text-align: right">
                        <label>车辆种类:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" id="vehTypeId" class="input-fat input" style="width: height: 26px;width:150px;" name="query.vehTypeName" autocomplete="off">
                    </td>
                    <td class="td_label" style="text-align: right">
                        <label>车辆型号名称:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" id="vehModelName" class="input-fat input" style="width: height: 26px;width:150px;" name="query.vehModelName" autocomplete="off">
                    </td>
                    <td class="td_label" style="text-align: right">
                        <label>车辆阶段:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" id="vehStage" class="input-fat input" editable="false" style="width: height: 26px;width:150px;" name="query.vehStage" autocomplete="off">
                    </td>
                    <td class="td_label" style="text-align: right">
                        <label>上牌城市:</label>
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
</body>
<script>
    var searchBeginTime = "${(startTime)!}";
    var searchEndTime = "${(endTime)!}";
    //序列化搜索条件
    var queryParams = $('#form_search').serializeObject();

    //重置使用参数对象(暂时存储初次加载的数据，用于重置事件)
    var resetQueryParams = queryParams;
    $('#table').datagrid({
        url: '${base}/report/anomaly/anomalyVeh/datagrid',
        queryParams: queryParams,
        sortName: "createTime",
        sortOrder: "desc",
        frozenColumns:[[
            /*{field: 'ck', checkbox: true, width: '20'},*/
            {field: 'licensePlate', title: '车牌号',align:'center',hlign:'center',sortable: false},
            {field: 'vin', title: 'VIN',align:'center',hlign:'center',sortable: false},
        ]],
        columns: [[
            {field: 'vehTypeName', title: '车辆种类',align:'center',hlign:'center',sortable: false},
            {field: 'vehModelName', title: '车辆型号名称',align:'center',hlign:'center',sortable: false},
            {field: 'modelNoticeId', title: '车辆公告型号',align:'center',hlign:'center',sortable: false},
            {field: 'termPartFirmwareNumber', title: '终端零件号',align:'center',hlign:'center',sortable: false},
            {field: 'termBarCode', title: '条形码编码',align:'center',hlign:'center',sortable: false},
            {field: 'serialNumber', title: '终端厂商自定义编号',align:'center',hlign:'center',sortable: false},
            {field: 'manuUnitName', title: '车辆厂商',align:'center',hlign:'center',sortable: false},
            {field: 'useUnitName', title: '运营单位',align:'center',hlign:'center',sortable: false},
            {field: 'areaName', title: '上牌城市',align:'center',hlign:'center',sortable: false},
            {field: 'firstReg', title: '激活时间',align:'center',hlign:'center',sortable: false},
            {field: 'saleTime', title: '销售日期',align:'center',hlign:'center',sortable: false},
            {field: 'iccid', title: 'ICCID',align:'center',hlign:'center',sortable: false},
            {field: 'reportDate', title: '最近异常时间',align:'center',hlign:'center',sortable: false},
            {field: 'speedNumber', title: '车速异常（条）',align:'center',hlign:'center',sortable: false,formatter:function(value,row,index){
                    if (value == null || value == undefined){
                            value = 0;
                        }
                        return '<a href="#" onclick="speedClick(\''+row.vin+'\',\''+row.licensePlate+'\',\''+row.modelNoticeId+'\',1,\''+row.vid+'\')">'+value+'</a>'
                    }},
            {field: 'mileageNumber', title: '里程异常（条）',align:'center',hlign:'center',sortable: false,formatter:function(value,row,index){
                    if (value == null || value == undefined){
                            value = 0;
                        }
                        return '<a href="#" onclick="speedClick(\''+row.vin+'\',\''+row.licensePlate+'\',\''+row.modelNoticeId+'\',2,\''+row.vid+'\')">'+value+'</a>'
                    }},
            {field: 'lngLatNumber', title: '经纬度异常（条）',align:'center',hlign:'center',sortable: false,formatter:function(value,row,index){
                    if (value == null || value == undefined){
                            value = 0;
                        }
                        return '<a href="#" onclick="speedClick(\''+row.vin+'\',\''+row.licensePlate+'\',\''+row.modelNoticeId+'\',3,\''+row.vid+'\')">'+value+'</a>'
                    }},
            {field: 'timeNumber', title: '时间异常（条）',align:'center',hlign:'center',sortable: false,formatter:function(value,row,index){
                    if (value == null || value == undefined){
                            value = 0;
                        }
                        return '<a href="#" onclick="speedClick(\''+row.vin+'\',\''+row.licensePlate+'\',\''+row.modelNoticeId+'\',4,\''+row.vid+'\')">'+value+'</a>'
                    }},
            {field: 'voltageNumber', title: '总电压异常（条）',align:'center',hlign:'center',sortable: false,formatter:function(value,row,index){
                    if (value == null || value == undefined){
                            value = 0;
                        }
                        return '<a href="#" onclick="speedClick(\''+row.vin+'\',\''+row.licensePlate+'\',\''+row.modelNoticeId+'\',5,\''+row.vid+'\')">'+value+'</a>'
                    }},
            {field: 'electricNumber', title: '总电流异常（条）',align:'center',hlign:'center',sortable: false,formatter:function(value,row,index){
                    if (value == null || value == undefined){
                          value = 0;
                      }
                      return '<a href="#" onclick="speedClick(\''+row.vin+'\',\''+row.licensePlate+'\',\''+row.modelNoticeId+'\',6,\''+row.vid+'\')">'+value+'</a>'
                  }},
            {field: 'socNumber', title: 'SOC异常（条）',align:'center',hlign:'center',sortable: false,formatter:function(value,row,index){
                    if (value == null || value == undefined){
                            value = 0;
                        }
                        return '<a href="#" onclick="speedClick(\''+row.vin+'\',\''+row.licensePlate+'\',\''+row.modelNoticeId+'\',7,\''+row.vid+'\')">'+value+'</a>'
                    }},
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
        var val=$('input:radio[name="query.adminFlag"]:checked').val();
        var file = document.getElementById("file").files[0];
        if(val != 0 && !fileCheck(file)){
            return;
        }
        var urlTemp = "${base}/report/anomaly/anomalyVeh/export";
        exportDatagrid(urlTemp,'form_search','table');
    }

    //查询按钮事件
    function searchButton(){
        if (checkTime()) {
            searchBeginTime = $("#startTime").datetimebox("getValue");
            searchEndTime = $("#endTime").datetimebox("getValue");
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

    //异常记录详情列表说明
    function reportExplan(){
        $("#recordExplanPopup").window("open");
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
        var startTimeTemp = "${startTime}";
        var endTimeTemp = "${endTime}";
        $("#startTime").datetimebox("setValue",startTimeTemp);
        $("#endTime").datetimebox("setValue",endTimeTemp);
        searchBeginTime = $("#startTime").datetimebox("getValue");
        searchEndTime = $("#endTime").datetimebox("getValue");
        //初始化条件
        initSelectChoose();
        $("input[name='query.vin']").val("");
        $("input[name='query.licensePlate']").val("");
        $('#table').datagrid("load", resetQueryParams);
    }

    /*模板下载*/
    function downFile() {
        var downUrl = "${base}/report/common/downLoadModel?moduleName=model&fileName=templateQuery.xls";
        window.open(downUrl);
    }

    /*报表说明弹框*/
    function reportSpecification(){
        $('#report').window("open");
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
            url: '${base}/report/common/queryAreaList'
            // onLoadSuccess:function(node, data){
            //     $('#areaId').combotree('setValue', { id: data[0].id, text: data[0].text });
            // }
            // editable:true
        });
        //运营单位
        $('#useUnitId').combotree({
            url: '${base}/report/common/queryUnitList'
            // onLoadSuccess:function(node, data){
            //     $('#useUnitId').combotree('setValue', { id: data[0].id, text: data[0].text });
            // }
            // editable:true
        });
        //车辆车型名称
        $('#vehModelName').combobox({
            url: '${base}/report/common/queryVehModelList',
            valueField: 'id',
            textField: 'text'
            // onLoadSuccess:function(){
            //     var val = $(this).combobox("getData");
            //     $(this).combobox("select", val[0].text);
            //     $(this).combobox("setValue", val[0].id);
            // }
        });
        //车辆种类
        $('#vehTypeId').combotree({
            url: '${base}/report/common/queryVehTypeList'
            // onLoadSuccess:function(node, data){
            //     $('#vehTypeId').combotree('setValue', { id: data[0].id, text: data[0].text });
            // }
            // editable:true
        });

        //车辆阶段
        $('#vehStage').combobox({
            url: '${base}/report/common/queryVehStageList',
            valueField: 'id',
            textField: 'text',
            // onLoadSuccess:function(){
            //     var val = $(this).combobox("getData");
            //     $(this).combobox("select", val[0].text);
            //     $(this).combobox("setValue", val[0].id);
            // }
            editable:true
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

    //弹出框事件
    function speedClick(vin,licensePlate,modelNoticeId,type,vid){

        //1：速度，2：里程，3：经纬度，4：时间，5：电压，6：电流，7： soc
        var titleName = "异常记录详情";
        if (type == 1) {
            titleName = "车速异常记录详情";
        }else if (type == 2) {
            titleName = "仪表里程异常记录详情";
        }else if (type == 3){
            titleName = "经纬度异常记录详情";
        }else if (type == 4) {
            titleName = "时间异常记录详情";
        }else if (type == 5){
            titleName = "电压异常记录详情";
        }else if (type == 6) {
            titleName = "电流异常记录详情";
        }else if (type ==7) {
            titleName = "SOC异常记录详情";
        }

        if (modelNoticeId == null || modelNoticeId == undefined) {
            modelNoticeId = "";
        }
        if (vin == null || vin == undefined) {
            vin = "";
        }
        if (vid == null || vid == undefined) {
            vid = "";
        }
        if (licensePlate == null || licensePlate == undefined) {
            licensePlate = "";
        }

        $("#licensePlate").text(licensePlate);
        $("#vin").text(vin);
        $("#vid").text(vid);
        $("#modelNoticeId").text(modelNoticeId);
        $("#typeId").val(type);
        $("#exceptionRecord").attr("title",titleName)
        $("#exceptionRecord").window("open");

        //开始时间、结束时间
        var endTime = $('#endTime').datetimebox("getValue");
        var startTime = $('#startTime').datetimebox("getValue");

        //测试数据
//        vid = '0a4a76a0-62d7-4764-b1ac-447763919981';
//        type = "2";

        var queryParams = {};
        queryParams['vin'] = vin;
        queryParams['type'] = type;
        queryParams["startTime"] = startTime;
        queryParams["endTime"] = endTime;
        queryParams['vid'] = vid;

        recordTable(queryParams);
    }

   function recordTable(queryParams){
       $("#recordTable").datagrid({
           url: '${base}/report/anomaly/anomalyVeh/recordDatagrid',
           queryParams: queryParams,
           sortName: "createTime",
           sortOrder: "desc",
           columns: [[
               {field: 'reportDate', title: '异常数据上传时间',align:'center',sortable: false},
               {field: 'location', title: '异常发生开始位置',align:'center',sortable: false},
           ]],
           pagination: false,
           nowrap: true,
           rownumbers: true,
       });
   }

    //异常详情导出
    function exceptionExport() {
        var vin = $("#vin").text();
        var licensePlate = $("#licensePlate").text();
        var type = $("#typeId").val();
        var myUrl = "${base}/report/anomaly/anomalyVeh/exceptionExport";
        var searchParames = $("#form_search").serializeObject();
//        var vid = '0a4a76a0-62d7-4764-b1ac-447763919981';
        var vid = $("#vid").text();
        searchParames['vid'] = vid;
        searchParames['vin'] = vin;
        searchParames["type"] = type;
        searchParames['licensePlate'] = licensePlate;
        searchParames['startTime'] = searchBeginTime;
        searchParames['endTime'] = searchEndTime;
        myUrl += '?exportId=' + new Date().getTime();
        for (var key in searchParames) {
            var value = searchParames[key];
            if (value != "") {
                myUrl += ("&" + key + "=" + value);
            }
        }
        window.open(myUrl, '_blank');
    }
</script>
</html>