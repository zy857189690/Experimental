
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
        <@shiro.hasPermission name="/report/demo1/view">
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
        </@shiro.hasPermission>
        <@shiro.hasPermission name="/report/demo1/export">
            <a href="#" onclick="exportDatagrid('${base}/report/workCondition/dayVeh/export','form_search','table')" class="easyui-linkbutton"
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
                        <label>查询时间</label>
                    </td>
                    <td class="td_input">
                        <input type="text" name="query.sbeginDate" id="sbeginDate" style="height: 30px; width: 168px" class="easyui-datebox" data-options="editable:false"/>
                    </td>

                    <td class="td_label">
                        <label>至</label>
                    </td>
                    <td class="td_input">
                        <input type="text" name="query.sendDate" id="sendDate" style="height: 30px;width: 168px" class="easyui-datebox" data-options="editable:false"/>
                    </td>

                    <td class="td_label">
                        <label>车牌号</label>
                    </td>
                    <td class="td_input">
                        <input id="licensePlate" type="text"class="input-fat input" style="width: height: 26px;width:150px;"   name="query.licensePlate"  autocomplete="off" >
                    </td>

                    <td class="td_label">
                        <label>VIN</label>
                    </td>
                    <td class="td_input">
                        <input id="vin" type="text"class="input-fat input" style="width: height: 26px;width:150px;"   name="query.vin"  autocomplete="off" >
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

                    <td class="td_label">
                        <label>文件上传</label>
                    </td>
                    <td class="td_input">
                        <input type="file" id="file" name="myfile" />
                        <input type="button" onclick="UpladFile()" value="上传" />
                    </td>

                    <td style="vertical-align: center;text-align: right;border: 1px" class="cg-btnGroup">
                        <a href="#" onclick="searchDatagrid('form_search','table')" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
                        <a href="#" onclick="resetDatagrid('form_search','table')" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>
                    </td>
                </tr>


            </table>
        </form>
    </div>

</div>

</body>
<script>
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
        columns:[[
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
<script language="javascript">
    $(function(){

        initSelectChoose();
    });
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
     * 文件上传
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
</script>
</html>