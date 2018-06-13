
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<#include "../../../../inc/meta.ftl">
<#include  "../../../../inc/js.ftl">
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
    <div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 130px">
        <div style="width: 100%;border: 1;margin:5 5 5 10 ">
            <form id="form_search" name="" class="sui-form cg-form">
                <div style="width: 90%; height: 20px; margin: 10px;">
                    <label>条件查询</label>
                    <input type="radio" name="query.adminFlag" onclick="operationtd(true)"  checked="checked"  value="0" ></input>
                    <label>导入查询</label>
                    <input type="radio" name="query.adminFlag" value="1" onclick="operationtd(false)" ></input>
                </div>
                <table class="table_search" style="height: 90px;">
                    <tr>
                        <td class="td_label">
                            <label>统计日期</label>
                        </td>
                        <td class="td_input">
                            <input id="dd" type="text" class="easyui-datebox" name="query.reportDateStart"  style="height: 30px; width: 168px;" >
                        </td>
                        <td class="td_label" style="text-align: center;">
                            <label>至</label>
                        </td>
                        <td class="td_input">
                            <input id="dd" type="text" class="easyui-datebox"  name="query.reportDateEnd" style="height: 30px; width: 168px;" >
                        </td>

                        <td class="td_label">
                            <label>VIN</label>
                        </td>
                        <td class="td_input">
                            <input type="text" class="input-fat input" name="query.vin"  style="width:150px;" >
                        </td>

                        <td class="td_label">
                            <label>车牌号</label>
                        </td>
                        <td class="td_input">
                            <input type="text" class="input-fat input" name="query.licensePlate"  style="width:150px;" >
                        </td>
                        <td class="td_label">
                            <label>车辆种类</label>
                        </td>
                        <td class="td_input">
                            <input id="vehTypeId"  name="query.vehtype"  style="width: 168px;" >
                        </td>
                        <td class="td_label">
                            <label>车型型号</label>
                        </td>
                        <td class="td_input">
                            <input id="vehModelName" name="query.vehModelNum" style="width: 168px;">
                        </td>
                        <td class="td_label">
                            <label>运营单位</label>
                        </td>
                        <td class="td_input">
                            <input id="useUnitId" name="query.unit" style="width: 168px;">
                        </td>
                        <td class="td_label">
                            <label>上牌区域</label>
                        </td>
                        <td class="td_input">
                            <input id="areaId" name="query.veharea" style="width: 168px;">
                        </td>
                        <td class="td_label">
                            <label>当日有效里程大于（km）</label>
                        </td>
                        <td class="td_input">
                            <input type="text" class="input-fat input" name="query.dayVaildMileage" style="width:150px;">
                        </td>
                        <td class="td_label">
                            <label>当日轨迹里程大于（km）</label>
                        </td>
                        <td class="td_input">
                            <input type="text" class="input-fat input" name="query.dayGpsMileage" style="width:150px;">
                        </td>
                        <td class="td_label">
                            <label>当日在线里程大于（km）</label>
                        </td>
                        <td class="td_input">
                            <input type="text" class="input-fat input" name="query.dayOnlineMileage" style="width:150px;">
                        </td>
                        <td class="td_label" id="fileButton">
                            <label>文件上传</label>
                        </td>
                        <td class="td_input" id="fileShow">
                            <input type="file" id="file" style="height: 26px;width:150px;" name="myfile" />
                            <input type="button" onclick="UpladFile()" value="文件解析" />
                        </td>
                        <td class="td_input" id="fileDown"  >
                            <input type="button" onclick="downFile()" value="导入查询模板下载" />
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
    <div id="toolbar" style="padding:5px" class="cg-moreBox">
       <#-- <@shiro.hasPermission name="/report/demo1/view">
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
             <input type="button" value="导出" onclick="gridList()"  />
        </@shiro.hasPermission>

    </div>
    <div id="table" name="datagrid" style="width: 100%;height: 100%"></div>
</div>


</body>
<script>
    $('#table').datagrid({
        url: '${base}/report/operation/dayMileageCheck/datagrid',
        sortName: "ID",
        sortOrder: "desc",
        columns: [[
            {field: 'ck', checkbox: true,align:'center', width: '20'},
            {field: 'ids', title: '序号',align:'center', width: '90', formatter: function (value, row, index) {
                return index+1;
            }},
            {field: 'vin', title: 'VIN',align:'center', width: '100' },
            {field: 'licensePlate', title: '车牌号',align:'center', width: '100'},
            {field: 'reportDate', title: '统计日期',align:'center', width: '100'},
            {field: 'firstOnlineTime', title: '当日首次上线时间',align:'center', width: '160'},
            {field: 'firstStartMileage', title: '当日开始里程(KM)',align:'center', width: '160'},
            {field: 'lastCommitTime', title: '当日最后通讯时间',align:'center', width: '160'},
            {field: 'lastEndMileage', title: '当日结束里程(KM)',align:'center', width: '160'},
            {field: 'checkDataTotalNum', title: '核查数据总条数(条)',align:'center', width: '160'},
            {field: 'invalidNum', title: '含无效数据条数(条)',align:'center', width: '160'},
            {field: 'abnormalNum', title: '含异常数据条数(条)',align:'center', width: '160'},
            {field: 'dayOnlineMileage', title: '当日上线里程(KM)',align:'center', width: '140'},
            {field: 'deductJumpMileage', title: '总跳变扣除里程(KM)',align:'center', width: '160'},
            {field: 'deductCurrentMileage', title: '总连续电流扣除里程(KM)',align:'center', width: '160'},
            {field: 'dayVaildMileage', title: '当日有效里程(KM)',align:'center', width: '160'},
            {field: 'dayGpsMileage', title: '当日轨迹里程(KM)',align:'center', width: '160'},
            {field: 'vaildGpsDeviation', title: '有效里程和轨迹里程相对误差（百分比）',align:'center', width: '220'},
            {field: 'onlineVaildDeviation', title: '上线里程和有效里程相对误差（百分比）',align:'center', width: '220'},
            {field: 'dayCheckMileage', title: '单日核算里程(KM)',align:'center', width: '160'},
            {field: 'veharea', title: '上牌区域',align:'center', width: '90'},
            {field: 'unit', title: '运营单位',align:'center', width: '90'},
            {field: 'vehModelNum', title: '车辆型号',align:'center', width: '90'},
            {field: 'vehtype', title: '车辆种类',align:'center', width: '90'},
        ]],
        toolbar: "#toolbar",
        pagination: true,
        nowrap: true

    });

//    toolbar2Menu("table");

</script>
<script language="javascript">
    $(function(){

                initSelectChoose();
        $('#fileButton').css("visibility", "hidden");
        $('#fileShow').css("visibility", "hidden");
        $('#fileDown').css("visibility", "hidden");
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

    /***
     * 文件上传
     * @constructor
     */
    function UpladFile() {
        var fileObj = document.getElementById("file").files[0]; // 获取文件对象

        var FileController = "${base}/report/operation/dayMileageCheck/fileMin";                    // 接收上传文件的后台地址

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
                if (data.code == 0) {
                    $.messager.show({
                        title:'文件解析结果',
                        msg:'解析成功.',
                        timeout:2000,
                        showType:'slide'
                    });
                    searchDatagrid('form_search','table')
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
        var downUrl = "${base}/report/operation/dayMileageCheck/downLooadModel?moduleName=model&fileName=templateQuery.xlsx";
        window.open(downUrl);
    }

    /*导出列表*/
    function gridList() {
       var url= '${base}/report/operation/dayMileageCheck/export';
       var formId= 'form_search';
       var gridId=  'table';
       var listId="";

        if (formId == undefined || formId == null) {
            formId = "form_search";
        }
        var myUrl = url;
        var searchParames = $('#' + formId).serializeObject();
        //获取选中行数据
        var rows = $("#" + gridId).datagrid("getSelections");
        if(rows.length <= 0){
            alert("请勾选导出的数据");
            return;
        }
        for(var i=0;i<rows.length;i++){
            listId+="\'"+rows[i].ids+"\',";
        }
        if(rows.length>0){
            listId="("+listId+ "\'\')";

        }
        var rowAll = $("#" + gridId).datagrid("getRows");
        //定义是否是选中导出
        var stutsEx;
        if(rowAll.length == rows.length){
            stutsEx= '';
        }else {
                stutsEx= '1';
        }

        searchParames['query.listId'] = listId;
        searchParames['query.stutsEx'] = stutsEx;
        myUrl += '?exportId=' + new Date().getTime();
        for (var key in searchParames) {
            var value = searchParames[key];
            if (value != "") {
                myUrl += ("&" + key + "=" + value);
            }
        }
        window.open(myUrl, '_blank');
    }


    /**
     * 初始化下拉选择框
     */
    function initSelectChoose() {
        //上牌区域
        $('#areaId').combotree({
            url: '${base}/report/common/queryAreaList'
        });
        //运营单位
        $('#useUnitId').combotree({
            url: '${base}/report/common/queryUnitList'
        });
        //车辆型号
        $('#vehModelName').combobox({
            url: '${base}/report/common/queryVehModelList',
            valueField: 'id',
            textField: 'text'
        });
        //车辆种类
        $('#vehTypeId').combotree({
            url: '${base}/report/common/queryVehTypeList'
        });
    }


    function   operationtd(nub) {
        if(nub){
            $('#fileButton').css("visibility", "hidden");
            $('#fileShow').css("visibility", "hidden");
            $('#fileDown').css("visibility", "hidden");
        }else {
            $('#fileButton').css("visibility", "visible");
            $('#fileShow').css("visibility", "visible");
            $('#fileDown').css("visibility", "visible");
        }

    }
</script>
</html>