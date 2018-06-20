
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
        .td_label text-align: right;
    </style>
</head>
<body class="easyui-layout" fit="true" id="fullid">
<div id="win" class="easyui-window" title="导入查询" style="width:400px;height:200px;top:105px;" data-options="modal:true,closed:true">
    <div id="cc" class="easyui-layout">
        <label>导入查询文件</label>
        <input type="file" id="file" style="width:100px;" name="query.myfile" />
        <a href="#" onclick="importSearchButton()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">导入查询</a>
    </div>
</div>

<div id="report" class="easyui-window" title="报表说明" style="width: 853px; height: 500px;display: none"  data-options="modal:true,closed:true">
    <div class="easyui-layout">
        <table class="easyui-datagrid">
            <thead>
            <tr>
                <th data-options="field:'code'" style="width: 167px">名称</th>
                <th data-options="field:'name'" style="width: 731px">定义</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>车辆阶段</td><td>待检测、待入库、入库、出厂待销售、已销售、运营中、已报废</td>
            </tr>
            <tr>
                <td>仪表里程</td><td>最后一帧上传的里程数据</td>
            </tr>
            <tr>
                <td>车辆状态</td><td>32960协议里的状态：启动、熄火、其他、异常、无效</td>
            </tr>
            <tr>
                <td>总电压</td><td>生成快照时的上传数据</td>
            </tr>
            <tr>
                <td>总电流</td><td>生成快照时的上传数据</td>
            </tr>
            <tr>
                <td>车速</td><td>生成快照时的上传数据，显示实际上传数值，车速数值为空的则该字段为空</td>
            </tr>
            <tr>
                <td>SOC</td><td>生成快照时的上传数据</td>
            </tr>
            <tr>
                <td>地理位置</td><td>生成快照时的地理位置，GPS数值转译后的实际地理名称</td>
            </tr>
            <tr>
                <td>最后通讯时间</td><td>车辆在生成快照前，最后与平台通讯的时间，含自动唤醒</td>
            </tr>
            <tr>
                <td>有效CAN数据最后上传时间</td><td>CAN数据有效性仅作车速、里程、总电压、总电流、GPS经纬度、SOC值、时间有效性的判断；  上述字段均不为空，有效范围内</td>
            </tr>
            <tr>
                <td>最后一次充电时间</td><td>是最后一次上传充电状态的时间（包含停车充电或充电完成状态的时间）</td>
            </tr>
            <tr>
                <td>充放电状态</td><td>32960协议里的状态：停车充电、行驶充电、未充电、充电完成、异常、无效</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<div region="center" style="overflow: hidden;width: 100%;">
    <div id="toolbar" style="padding:5px" class="cg-moreBox">
        <@shiro.hasPermission name="/report/workCondition/vehHistory/export">
            <a href="#" onclick="exportData()" class="easyui-linkbutton"
               data-options="iconCls:'icon-export'" menu="0">导出</a>
        </@shiro.hasPermission>
        <a href="#" onclick="reportSpecification()" data-options="iconCls:'icon-export'" menu="0" style="float: right;margin-top:6px;margin-right: 100px">报表说明</a>
    </div>
    <div id="table" name="datagrid" style="width: 100%; height: 100%;"></div>
</div>
<div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 120px">
    <div style="width: 100%;border: 1;margin:5 5 5 10 ">
        <form id="form_search" name="" class="sui-form cg-form">
            <div style="width: 90%; height: 20px; margin: 10px;">
                <label>条件查询</label>
                <input type="radio" id="tiaojian" name="adminFlag" checked="checked" data-option="selected:true" value="0"></input>
                <label>导入查询</label>
                <input type="radio" id="daoru" name="adminFlag" value="1"></input>
            </div>
            <table class="table_search" style="height: 90px;">
                <tr>
                    <td class="td_label" style="text-align: right;"  id="filetitle">
                        <label>导入文件</label>
                    </td>
                    <td class="td_input" id="fileinput">
                        <input type="file" id="file" style="height: 30px;width:140px;" name="query.myfile" />
                    </td>
                    <td class="td_label" style="text-align: right;">
                        <label>开始时间</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="easyui-datetimebox" id="startTime" style="height: 30px;width:150px;" value="${(startTime)!}"  name="query.startTime"    data-options="editable:false">
                    </td>
                    <td class="td_label" style="text-align: right;">
                        <label>结束时间</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="easyui-datetimebox" id="endTime" style="height: 30px;width:150px;" value="${(endTime)!}" name="query.endTime"   data-options="editable:false">
                    </td>
                    <td class="td_label" style="text-align: right;">
                        <label>仪表里程大于</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" style="width:125px;"   name="query.gaugesMileage"   >
                    </td>
                    <td class="td_label" style="text-align: right;">
                        <label>车牌号</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" style="width:125px;"   name="query.licensePlate"   >
                    </td>
                    <td class="td_label" style="text-align: right;">
                        <label>VIN</label>
                    </td>
                    <td class="td_input" style="text-align: right;">
                        <input type="text"class="input-fat input" style="width:125px;"   name="query.vin"   >
                    </td>
                    <td class="td_label" style="text-align: right;">
                        <label>车辆种类</label>
                    </td>
                    <td class="td_input">
                        <input type="text" id="vehTypeId" class="input-fat input" style="width:150px;"   name="query.vehTypeName"   >
                    </td>
                    <td class="td_label" style="text-align: right;">
                        <label>车辆型号名称</label>
                    </td>
                    <td class="td_input">
                        <input id="vehModelName" class="input-fat input" style="width:150px;"   name="query.vehModelName"   >
                    </td>
                    <td class="td_label" style="text-align: right;">
                        <label>运营单位</label>
                    </td>
                    <td class="td_input">
                        <input id="useUnitId" class="input-fat input" style="width:150px;"   name="query.useUnitName"   >
                    </td>
                    <td class="td_label" style="text-align: right;">
                        <label>上牌区域</label>
                    </td>
                    <td class="td_input">
                        <input type="text" id="areaId" class="input-fat input" style="width:150px;"   name="query.areaName"   >
                    </td>
                <#--<td class="td_label">-->
                <#--<label>GPS里程大于</label>-->
                <#--</td>-->
                <#--<td class="td_input">-->
                <#--<input type="text"class="input-fat input" style="width: width:150px;"   name="query.gpsTotalMileage"   >-->
                <#--</td>-->
                    <td class="td_label" style="text-align: right;">
                        <label>车辆阶段</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" id="vehStage" style="width:150px;"   name="query.vehStage"   >
                    </td>

                    <td style="vertical-align: center;text-align: right;border: 1px" class="cg-btnGroup">
                        <a href="#" onclick="searchButton()"  class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
                        <a href="#" onclick="resetButton()" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>
                    <#--<a href="#" id="daoruchaxun" onclick="importSeach()" data-options="iconCls:'icon-reset'">导入查询</a>-->
                        <a href="#" onclick="downFile()" id = "downLadfile" data-options="iconCls:'icon-reset'">导入查询模板下载</a>
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
        document.getElementById("filetitle").style.display = "none";
        document.getElementById("fileinput").style.display = "none";
        document.getElementById("downLadfile").style.display = "none";
        //是否隐藏
        aHidden();
    });

    //隐藏导入查询
    function aHidden(){
       // document.getElementById("daoruchaxun").style.display = "none";
    }

    //序列化搜索条件
    var queryParams = $('#form_search').serializeObject();

    //重置使用参数对象(暂时存储初次加载的数据，用于重置事件)
    var resetQueryParams = queryParams;

    //重置
    function resetButton(){
        identity = "";
    var startTimeTemp = "${startTime}";
    var endTimeTemp = "${endTime}";
        $("#startTime").datetimebox("setValue",startTimeTemp);
        $("#endTime").datetimebox("setValue",endTimeTemp);
        $("input[name='query.vin']").val("");
        $("input[name='query.licensePlate']").val("");
        $("input[name='query.gaugesMileage']").val("");
        //初始化条件
        initSelectChoose();
        $('#table').datagrid("load", resetQueryParams);
    }

   $('#table').datagrid({
        url: '${base}/report/workCondition/vehHistory/datagrid',
        sortName: "createTime",
        sortOrder: "desc",
       queryParams: queryParams,
       frozenColumns:[[
           /*{field: 'ck', checkbox: true, width: '20'},*/
           {field: 'reportDate', title: '时间',align:'center',sortable: false},
           {field: 'licensePlate', title: '车牌号',align:'center',sortable: false},
           {field: 'vin', title: 'VIN',align:'center',sortable: false},
       ]],
        columns: [[
            {field: 'vehTypeName', title: '车辆种类',align:'center',sortable: false},
            {field: 'vehModelName', title: '车辆型号名称',align:'center',sortable: false},
            {field: 'modelNoticeId', title: '车辆公告型号',align:'center',sortable: false},
            {field: 'manuUnitName', title: '车辆厂商',align:'center',sortable: false},
            {field: 'registerstatus', title: '车辆阶段',align:'center',sortable: false},
            {field: 'vehStateName', title: '车辆状态',align:'center',sortable: false},
            {field: 'useUnitName', title: '运营单位',align:'center',sortable: false},
            {field: 'areaName', title: '上牌区域',align:'center',sortable: false},
            {field: 'firstReg', title: '激活时间',align:'center',sortable: false},
            {field: 'saleTime', title: '销售日期',align:'center',sortable: false},
            {field: 'lastCommunicationTime', title: '最后通讯时间',align:'center',sortable: false},
            {field: 'lastCanValidTime', title: '有效CAN数据最后上传时间',align:'center',sortable: false},
            {field: 'lastChargeTime', title: '最后一次充电时间',align:'center',sortable: false},
            {field: 'chargeDischargeStateName', title: '充放电状态',align:'center',sortable: false},
            {field: 'gaugesMileage', title: '仪表里程(km)',align:'center',sortable: false},
            {field: 'totalVoltage', title: '总电压(V)',align:'center',sortable: false},
            {field: 'totalCurrent', title: '总电流(A)',align:'center',sortable: false},
            {field: 'speed', title: '车速(km/h)',align:'center',sortable: false},
            {field: 'soc', title: 'SOC(%)',align:'center',sortable: false},
            {field: 'location', title: '地理位置',align:'center',sortable: false},
            {field: 'termPartFirmwareNumber', title: '终端零件号',align:'center',sortable: false},
            {field: 'termBarCode', title: '条形码编码',align:'center',sortable: false},
            {field: 'serialNumber', title: '终端厂商自定义编号',align:'center',sortable: false},
            {field: 'iccid', title: 'ICCID',align:'left',sortable: false,width: '90'},
        ]],
        toolbar: "#toolbar",
        pagination: true,
        rownumbers: true,
        nowrap: true
    });

    toolbar2Menu("table");
    $("#table").datagrid({

        onRowContextMenu: function (e, rowIndex, rowData) { //右键时触发事件
            e.preventDefault(); //阻止浏览器捕获右键事件
            $(this).datagrid("clearSelections"); //取消所有选中项
            $(this).datagrid("selectRow", rowIndex); //根据索引选中该行
            $('#contextMenu_jygl').menu('show', {
                left: e.pageX,//在鼠标点击处显示菜单
                top: e.pageY
            });
            e.preventDefault();  //阻止浏览器自带的右键菜单弹出
        },

    })
</script>
<script language="javascript" charset=”utf-8″>


    //标记导出功能是普通导出(值为"")，还是导入查询后的导出功能(值为"importType")
    var identity = "";

    /*校验开始时间/结束时间是否合法*/
    function checkTime(){
        //时间校验
        var endTime = $('#endTime').datetimebox("getValue");
        var startTime = $('#startTime').datetimebox("getValue");
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
        var startTimeFormat = startTime.Format("yyyy-MM-dd");
        var endTimeFormate = endTime.Format("yyyy-MM-dd");
        var days = (new Date(endTimeFormate).getTime() - new Date(startTimeFormat).getTime()) / 86400000;
        if (days > 6){
            $.messager.alert('提示','选择开始时间与结束时间间隔最大为七天！');
            return false;
        }
        return true;
    }

    /*查询事件*/
    function searchButton(){

        var val=$('input:radio[id="daoru"]:checked').val();

        //var valaaa=$('input:radio[id="daoru"]:checked').val();
        if(val == 1){
            importSearchButton();
        }else {
            identity = "";
            if (checkTime()) {
                //请求查询
                searchDatagrid('form_search','table');
            }
        }



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

    /*导入查询弹窗口*/
    function importSeach(){
        $('#win').window('open');
    }

    /*导入查询弹窗查询事件*/
    function importSearchButton(){
        if (!checkTime()) {
            return;
        }
        var formData = new FormData();
        var file = document.getElementById("file").files[0];
        if (fileCheck(file)) {
            formData.append("file",file);

            //importType 导入查询标识，用于区分SQL拼接
            formData.append("identity", "importType");
            identity = "importType";
            $.ajax({
                url : "${base}/report/workCondition/vehHistory/improtSearch",
                type : 'POST',
                data : formData,
                async : false,
                cache : false,
                contentType : false,
                processData : false,
                success : function(data) {
                    if (data.code == 0) {

                        var searchParames = $('#form_search').serializeObject();
                        debugger;
                        searchParames['query.identity'] = "identity";
                        $("#table").datagrid("load", searchParames);

                        $('#win').window('close');
//                        $.messager.alert('提示','查询成功！');
                    } else {
                        $.messager.alert('提示',data.message);
                    }
                },
                error : function(data) {
                    $.messager.alert('提示','请求系统失败！！');
                }
            });
        }
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

    /*模板下载*/
    function downFile() {
        var downUrl = "${base}/report/common/downLoadModel?moduleName=model&fileName=templateQuery.xls";
        window.open(downUrl);
    }

    /*报表说明弹框*/
    function reportSpecification(){
        $('#report').window("open");
    }

    /*导出功能*/
    function exportData() {
        //校验开始结束时间是否合法
        if (!checkTime()) {
            return;
        }

        //普通的导出
        if (identity == "") {
            exportDatagrid('${base}/report/workCondition/vehHistory/export', 'form_search', 'table');
        }
        //导入查询后的导出
        if (identity == "importType") {
            var xhh = new XMLHttpRequest();
            var formData = new FormData($("#form_search")[0]);
            var file = document.getElementById("file").files[0];

            if (fileCheck(file)) {
                formData.append("file", file);
                //importType 导入查询标识，用于区分SQL拼接
                formData.append("identity", "importType");
                xhh.open("post", "${base}/report/workCondition/vehHistory/importExport");
                xhh.responseType = 'blob';
                xhh.onreadystatechange = function () {
                    if (xhh.readyState === 4 && xhh.status === 200) {
                        var name = xhh.getResponseHeader("Content-disposition");
                        var contentType = xhh.getResponseHeader("Content-type");
                        console.log("name:" + name + "==" + contentType);
                        var dataStr = new Date().Format("yyyyMMddhhmmss");
                        var filename = name.substring(20, name.length);
                        var blob = new Blob([xhh.response], {type: 'text/xls'});
                        var csvUrl = URL.createObjectURL(blob);
                        var link = document.createElement('a');
                        link.href = csvUrl;
                        var suf = checkSuffixes(contentType);
                        link.download = "车辆历史状态报表-" + dataStr + suf;
                        link.click();
                    }
                };
                xhh.send(formData);
            }
        }
    }

    /**
     * 判断文件后缀名
     * @param suffixesName
     * @returns {*}
     */
    function checkSuffixes(suffixesName) {
        if (suffixesName.indexOf("zip") > 0) {
            return ".zip";
        }
        if (suffixesName.indexOf("x-excel") > 0) {
            return ".xls";
        }
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