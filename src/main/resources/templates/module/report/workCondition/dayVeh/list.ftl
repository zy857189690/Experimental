
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
<div id="win" class="easyui-window" title="导入查询" style="width:400px;height:200px;top:105px;" data-options="modal:true,closed:true">
    <div id="cc" class="easyui-layout">
        <label>导入查询文件</label>
        <input type="file" id="file" style="width:100px;" name="query.myfile" />
        <a href="#" onclick="importSearchButton()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
    </div>
</div>



<div region="center" style="overflow: hidden;width: 100%;">
    <div id="toolbar" style="padding:5px" class="cg-moreBox">
        <#--<@shiro.hasPermission name="/report/demo1/view">
            <a href="#" onclick="view_item()" class="easyui-linkbutton"
               data-options="iconCls:'icon-view'" menu="0">查看</a>
        </@shiro.hasPermission>
        <@shiro.hasPermission name="/report/demo1/add">
        <a href="#" onclick="add_item()" class="easyui-linkbutton"
           data-options="iconCls:'icon-add'" menu="0">增加</a>
        </@shiro.hasPermission>
        <@shiro.hasPermission name="/report/demo1/update">
        <a href="#" onclick="edit_item()" class="easyui-linkbutton"
           data-options="iconCls:'icon-edit'" >编辑</a>
        </@shiro.hasPermission>
        <@shiro.hasPermission name="/report/demo1/del">
        <a href="#" onclick="del_item()" class="easyui-linkbutton"
           data-options="iconCls:'icon-remove'" >删除</a>
        </@shiro.hasPermission>-->
        <@shiro.hasPermission name="/report/demo1/export">
            <a href="#" onclick="exportData()" class="easyui-linkbutton"
               data-options="iconCls:'icon-export'" menu="0">导出</a>
        </@shiro.hasPermission>

    </div>
    <div id="table" name="datagrid" style="width: 100%;height: 100%"></div>
</div>

<div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 120px">
    <div style="width: 100%;border: 1;margin:5 5 5 10 ">
        <form id="form_search" name="" class="sui-form cg-form">
            <table class="table_search">
                <!--
                <tr>
                    <td class="td_lable">
                        <label>条件查询</label>
                    </td>
                    <td class="td_input">
                        <input type="radio" name="adminFlag" data-option="selected:true" value="0" style="width: height:26px;width: 100px;"></input>
                    </td>
                    <td class="td_lable">
                        <label>导入查询</label>
                    </td>
                    <td>
                        <input type="radio" name="adminFlag" value="1"  style="width: height: 26px;width:100px;"></input>
                    </td>
                </tr>
                -->
                <tr>
                    <td class="td_label">
                        <label>查询时间</label>
                    </td>
                    <td class="td_input">
                        <input type="text" name="query.startTime" id="startTime" style="height: 26px; width: 100px" value="${(startTime)!}" class="easyui-datebox" autocomplete="off" data-options="editable:false"/>
                    </td>

                    <td class="td_label">
                        <label>至</label>
                    </td>
                    <td class="td_input">
                        <input type="text" name="query.endTime" id="endTime" style="height: 26px;width: 100px" value="${(endTime)!}" class="easyui-datebox" autocomplete="off" data-options="editable:false"/>
                    </td>

                    <td class="td_label">
                        <label>车牌号</label>
                    </td>
                    <td class="td_input">
                        <input id="licensePlate" type="text"class="input-fat input" style="width: height: 26px;width:100px;"   name="query.licensePlate"  autocomplete="off" >
                    </td>

                    <td class="td_label">
                        <label>VIN</label>
                    </td>

                    <td class="td_input">
                        <input id="vin" type="text"class="input-fat input" style="width: height: 26px;width:100px;"   name="query.vin"  autocomplete="off" >
                    </td>
                    <td class="td_label">
                        <label>车辆种类</label>
                    </td>
                    <td class="td_input">
                        <input id="vehTypeId" name="query.vehTypeId" style="width: 170px;" />
                    </td>

                    <td class="td_label">
                        <label>车型型号</label>
                    </td>
                    <td class="td_input">
                        <input id="vehModelName" name="query.vehModelName" style="width: 170px;" />
                    </td>

                    <td class="td_label">
                        <label>运营单位</label>
                    </td>
                    <td class="td_input">
                        <input id="useUintId" name="query.useUintId" style="width: 170px;" />
                    </td>

                    <td class="td_label">
                        <label>上牌区域</label>
                    </td>
                    <td class="td_input">
                        <input id="sysDivisionId" name="query.sysDivisionId" style="width: 170px;" />
                    </td>

                    <td style="vertical-align: center;text-align: right;border: 1px" class="cg-btnGroup">
                        <a href="#" onclick="searchButton()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
                        <a href="#" onclick="resetButton()" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>

                        <a href="#" onclick="importSeach()" data-options="iconCls:'icon-reset'">导入查询</a>
                        <a href="#" onclick="downFile()" data-options="iconCls:'icon-reset'">导入查询模板下载</a>
                        <!--
                        <a href="#" onclick="resetDatagrid('form_search','table')" data-options="iconCls:'icon-reset'">导入查询</a>
                        <a href="#" onclick="resetDatagrid('form_search','table')" data-options="iconCls:'icon-reset'">导入查询模板下载</a>
                        -->
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

    //序列化搜索条件
    var queryParams = $('#form_search').serializeObject();

    //重置使用参数对象(暂时存储初次加载的数据，用于重置事件)
    var resetQueryParams = queryParams;

    //重置
    function resetButton(){
        identity = "";
        var startTimeTemp = "${startTime}";
        var endTimeTemp = "${endTime}";
        $("#startTime").datebox("setValue",startTimeTemp);
        $("#endTime").datebox("setValue",endTimeTemp);
        //初始化条件
        initSelectChoose();
        $('#table').datagrid("load", resetQueryParams);
    }
    <#--$('#table').datagrid({-->
        <#--url: '${base}/report/demo1/datagrid',-->
        <#--sortName: "createTime",-->
        <#--sortOrder: "desc",-->
        <#--columns: [[-->
            <#--{field: 'ck', checkbox: true, width: '20'},-->
            <#--{field: 'name', title: '名称'},-->
            <#--{field: 'dictField', title: '字典值'},-->
            <#--{field: 'nameField', title: '名称值'},-->
            <#--{field: 'createTime', title: '创建时间'},-->
            <#--{field: 'createBy', title: '创建人'},-->
            <#--{field: 'updateTime', title: '更新时间'},-->
            <#--{field: 'updateBy', title: '更新人'},-->
        <#--]],-->
        <#--toolbar: "#toolbar",-->
        <#--pagination: true,-->
        <#--nowrap: true-->

    <#--});-->

    $('#table').datagrid({
        url:'${base}/report/workCondition/dayVeh/datagrid',
        sortName: "lastCommunTime",
        sortOrder: "desc",
        queryParams: queryParams,
        columns:[[
            //{field: 'ck', checkbox: true, width: '20'},
            {field:'number',title:'序号',align:'center',
                formatter:function(value,row,index){
                    if(value == null){
                        return index+1;
                    }
                }},
            {field:'reportDate',title:'日期',align:'center'},
            {field:'licensePlate',title:'车牌号',align:'center'},
            {field:'vin',title:'VIN',align:'center'},
            {field:'vehTypeId',title:'车辆种类',align:'center'},
            {field:'vehModelName',title:'车型型号',align:'center'},
            {field:'modelNoticeId',title:'公告号',align:'center'},
            {field:'termPartFirmwareNumbers',title:'终端零件号',align:'center'},
            {field:'termBarCode',title:'条形码编码',align:'center'},
            {field:'termVendorCode',title:'终端厂商自定义编号',align:'center'},
            {field:'manuUnitId',title:'车辆厂商',align:'center'},
            {field:'useUintId',title:'运营单位',align:'center'},
            {field:'sysDivisionId',title:'上牌区域',align:'center'},
            {field:'entryDate',title:'激活时间',align:'center'},
            {field:'saleTime',title:'销售日期',align:'center'},
            {field:'dailyActiveTotalTime',title:'日活跃总时间（h）',align:'center'},
            {field:'runTimeSum',title:'日总行驶时间（h）',align:'center'},
            {field:'runTimes',title:'日行驶次数',align:'center'},
            {field:'runKm',title:'日总行驶里程（km）',align:'center'},
            {field:'runKmMax',title:'单次运行最大里程（km）',align:'center'},
            {field:'lastMeterMileage',title:'总里程',align:'center'},
            {field:'lastGpsMileage',title:'GPS总里程',align:'center',
                formatter:function(value,row,index){
                    if(value == null){
                        return "-";
                    }
                }},
            {field:'chargeConsume',title:'当日累计耗电量（kw.h）',align:'center',
                formatter:function(value,row,index){
                    if(value == null){
                        return "-";
                    }
                }},
            {field:'chargeCon100km',title:'实际百公里耗电量',align:'center',
                formatter:function(value,row,index){
                    if(value == null){
                        return "-";
                    }
                }},
            {field:'statedCharge_con100km',title:'百公里额定耗电量',align:'center',
                formatter:function(value,row,index){
                    if(value == null){
                        return "-";
                    }
                }},
            {field:'chargeSconsumeMax',title:'单次充电后最大耗电量（kw.h）',align:'center',
                formatter:function(value,row,index){
                    if(value == null){
                        return "-";
                    }
                }},
            {field:'chargeTimes',title:'充电总次数',align:'center'},
            {field:'fastTimes',title:'快充次数',align:'center',
                formatter:function(value,row,index){
                    if(value == null){
                        return "-";
                    }
                }},
            {field:'lowTimes',title:'慢充次数',align:'center',
                formatter:function(value,row,index){
                    if(value == null){
                        return "-";
                    }
                }},
            {field:'chargeTimeSum',title:'充电总时长',align:'center'},
            {field:'chargeTimeMax',title:'单次最长充电时间（h）',align:'center'},
            {field:'singleChargeMaxMileage',title:'单次充电最大行驶里程',align:'center'},
            {field:'runSpeedMax',title:'日最高速度（km/h）',align:'center'},
            {field:'runSpeedAvg',title:'日平均速度（km/h）',align:'center'},
            {field:'lastCommunTime',title:'数据最后上传时间',align:'center'},
        ]],
        toolbar:"#toolbar",
        pagination:true,
        nowrap:true
    });

    toolbar2Menu("table");

</script>
<script language="javascript" charset=”utf-8″>

    var identity = ""
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
        if (days > 30){
            $.messager.alert('提示','选择开始时间与结束时间间隔最大为30天！');
            return false;
        }
        return true;
    }

    /*查询事件*/
    function searchButton(){
        identity = "";
        if (checkTime()) {
            //请求查询
            searchDatagrid('form_search','table');
        }
    }

    /**
     * 增加
     */
    function add_item() {
        var title = "增加演示1";
        var url = "${base}/report/demo1/add";
        openAddDataWin('report_demo1',title,url,"600",'600','table');
    }
    /**
     * 查看
     */
    function view_item() {
        var title = "增加演示1";
        var url = "${base}/report/demo1/view";
        openViewDataWin('report_demo1',title,url,"600",'600','table');
    }
    /**
     * 编辑
     * @param id
     */
    function edit_item(id) {
        var title = "编辑演示1";
        var url = "${base}/report/demo1/update?id=" + (id);
        openUpdateDataWin('report_demo1',title,url,"600",'600','table');
    }
    /**
     * 编辑
     * @param id
     */
    function del_item() {
        var title = "演示1";
        var url = "${base}/report/demo1/del";
        delRecord(title,url,'table');
    }


    /**
     * 初始化下拉选择框
     */
    function initSelectChoose() {
        //上牌区域
        $('#sysDivisionId').combotree({
            url: '${base}/report/workCondition/dayVeh/queryAreaList'
        });
        //运营单位
        $('#useUintId').combotree({
            url: '${base}/report/workCondition/dayVeh/queryUnitList'
        });
        //车辆型号
        $('#vehModelName').combobox({
            url: '${base}/report/workCondition/dayVeh/queryVehModelList',
            valueField: 'id',
            textField: 'text'
        });
        //车辆种类
        $('#vehTypeId').combotree({
            url: '${base}/report/workCondition/dayVeh/queryVehTypeList'
        });
    }


    /***
     * 文件解析
     * @constructor
     */
    function UpladFile() {
        var fileObj = document.getElementById("file").files[0]; // 获取文件对象

        var FileController = "${base}/report/workCondition/dayVeh/fileMin";                    // 接收上传文件的后台地址

        // FormData 对象

        var form = new FormData();

        form.append("author", "hooyes");                        // 可以增加表单数据

        form.append("file", fileObj);                           // 文件对象
        // XMLHttpRequest 对象

        var xhr = new XMLHttpRequest();

        xhr.open("post", FileController, true);

        xhr.onload = function (data) {

        };
        xhr.send(form);
        xhr.onreadystatechange =function(){
            if (xhr.readyState == 4){
                // alert(xhr.responseText);
                var data =  eval("("+xhr.responseText+")");
                alert(data.code)
                if (data.code == 0) {
                    $.messager.show({
                        title:'文件解析结果',
                        msg:'解析成功.',
                        timeout:2000,
                        showType:'slide'
                    });
                } else {
                    $.messager.show({
                        title:'文件解析结果',
                        msg:'解析失败.',
                        timeout:2000,
                        showType:'slide'
                    });
                }
            }
        }

    }

    /*模板下载*/
    function downFile() {
        var downUrl = "${base}/report/workCondition/dayVeh/downLooadModel?moduleName=model&fileName=templateQuery.xlsx";
        window.open(downUrl);
    }

    //导入查询弹窗口
    function importSeach(){
        $('#win').window('open');
    }

    //导入查询弹窗查询事件
    function importSearchButton(){
        if (!checkTime()) {
            return;
        }
        var formData = new FormData($( "#form_search" )[0]);//新建一个类似表单的对象
        var file = document.getElementById("file").files[0];//获取文件对象
        if (fileCheck(file)) {
            formData.append("file",file);//在表单对象后面插入文件对象,第二个参数是文件对象

            //importType 导入查询标识，用于区分SQL拼接
            formData.append("identity", "importType");
            identity = "importType";
            $.ajax({
                url : "${base}/report/workCondition/dayVeh/improtSearch",
                type : 'POST',
                data : formData,//规定连同请求发送到服务器的数据
                async : false,
                cache : false,
                contentType : false,
                processData : false,
                success : function(data) {
                    if (data.code == 0) {//‘0’代表调用成功执行方法
                        var loadData = data.message.length == 0 ? {} :$.parseJSON(data.message);//controller查询到的数据返回给loadDate，通过datagrid加载显示在页面
                        $('#table').datagrid('loadData', loadData);
                        $('#win').window('close');
                        $.messager.alert('提示','查询成功！');
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


    /*导出功能*/
    function exportData() {
        //校验开始结束时间是否合法
        if (!checkTime()) {
            return;
        }

        //普通的导出
        if (identity == "") {
            exportDatagrid('${base}/report/workCondition/dayVeh/export', 'form_search', 'table');
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
                xhh.response
                xhh.open("post", "${base}/report/workCondition/dayVeh/importExport");
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
                        link.download = "单车日报表-" + dataStr + suf;
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

</script>
</html>