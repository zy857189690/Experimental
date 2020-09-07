
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<#include "../../../../inc/meta.ftl">
<#include "../../../../inc/js.ftl">
    <style type="text/css">
        .td_input a:not(.bg_button) {
            right: 20px !important;
        }
        .table_search tr .td_label {
            text-align: right;
        }

    </style>
    <script language="javascript">
        $(function(){
            $("#endTime").datebox('setValue',getCurentDateStr());
            queryArea();
        });
    </script>
</head>


<div id="report" class="easyui-dialog" title="报表说明" style="width: 710px; height: 400px;display: none"  data-options="modal:true,closed:true">
    <div class="easyui-layout">
        <table class="easyui-datagrid">
            <thead>
            <tr>
                <th data-options="field:'title', width: 200, resizable: true, align: 'left', halign: 'center'">名称</th>
                <th data-options="field:'definition', width: 500, resizable: true, align: 'left', halign: 'center'">定义</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>截止时间</td><td >报表查询截止某一天的历史数据</td>
            </tr>
            <tr>
                <td>行驶区域总里程（Km）</td><td>该车辆在统计在该区域累计行驶总里程（仪表里程）</td>
            </tr>
            <tr>
                <td>行驶区域GPS总里程（km）</td><td>该车辆在统计在该区域累计行驶GPS总里程（仪表里程）</td>
            </tr>
            <tr>
                <td>行驶区域里程占比（%）</td><td>区域行驶总里程/总里程</td>
            </tr>
            <tr>
                <td>车辆阶段</td><td>待检测、待入库、入库、出厂待销售、已销售、运营中、已报废</td>
            </tr>

            </tbody>
        </table>
    </div>
</div>

<body class="easyui-layout" fit="true" id="fullid">
<div region="center" style="overflow: hidden;width: 100%;">
    <div id="toolbar" style="padding:5px" class="cg-moreBox">
        <#--    <a href="#" onclick="exportDatagrid('${base}/report/operation/areaMileage/downloadAreaMonthly','form_search','table')" class="easyui-linkbutton"
               data-options="iconCls:'icon-export'" menu="0">导出</a>-->
            <a href="#" onclick="reportSpecification()" data-options="iconCls:'icon-export'" menu="0" style="float: right;margin-top:6px;margin-right: 100px">列表说明&nbsp;&nbsp;</a>
    </div>

   <div id="table" name="datagrid" style="width: 100%; height: 100%"></div>
</div>
<div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 50px;margin: 10px;">
    <div style="width: 100%;border: 1;margin:5 5 5 10 ">
        <form id="form_search" name="form_search" class="sui-form form-inline cg-form">
            <table class="table_search">
                <tr>
                    <td class="td_label">
                        <label>行驶区域：</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" id="xingShi" style="width:150px;"   name="query.xingShi"  autocomplete="off" >
                    </td>
                    <td class="td_label">
                        <label>截止时间：</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="easyui-datebox" id="endTime" style="width:150px;"  name="query.endTime"  autocomplete="off" data-options="editable:false">
                    </td>
                    <td class="td_label">
                        <label>区域总里程大于（km）：</label>
                    </td>
                    <td class="td_input">
                    <#--<input type="text" class="input-fat input" name="query.vin" id="vin" query_type="lis" style="width: height: 26px;width:150px;" required>-->
                        <input type="text"class="input-fat input" style="width:133px;"   onkeyup="value=value.replace(/[^\d]/g,'')" id="quYuZong"  name="query.quYuZong"  autocomplete="off" >
                    </td>
                    <td class="td_label">
                        <label>车辆阶段：</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" style="width:150px;"   id="jieDuan" name="query.jieDuan"  autocomplete="off" >
                    </td>
                    <td class="td_label" >
                        <label>车牌号：</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" style="width:133px;"   name="query.chePai"  autocomplete="off" >
                    </td>
                    <td class="td_label" >
                        <label>VIN：</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" style="width:133px;"   name="query.VIN"  autocomplete="off" >
                    </td>
                    <td class="td_label"  >
                        <label>车型名称：</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" style="width:133px;"   name="query.cheLiangMing"  autocomplete="off" >
                    </td>
                    <td class="td_label">
                        <label>运营单位：</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" style="width:150px;" id="yunYing"    name="query.yunYing"  autocomplete="off" >
                    </td>
                    <td class="td_label"  >
                        <label>上牌城市：</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" style="width:133px;"   name="query.shangPai"  autocomplete="off" >
                    </td>
                    <td style="vertical-align: center;text-align: right;border: 1px" class="cg-btnGroup">
                        <a href="#" onclick="search_item()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
                        <a href="#" onclick="reset_common(search_item)" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
<script>

    function search_item(){
        var v=$("#quYuZong").val();
        var reg = /^[0-9]+.?[0-9]*$/;
        if(v!=''&&!reg.test(v)){
            alert("区域总里程只能为数字");
            return;
        }
        //var data = searchData();
        var data=$("#form_search").serializeObject();
        $("#table").datagrid("load", data);
    }

    $('#table').datagrid({
        url: 'datagrid',
        sortName: "createTime",
        sortOrder: "desc",
        rownumbers: true,
        columns: [[
            {field: 'shiJian', title: '截止时间', width: 120, align: 'center'},
            {field: 'chePai', title: '车牌号', width: 120, align: 'center'},
            {field: 'VIN', title: 'VIN', width: 180, align: 'center'},
            {field: 'shangPai', title: '上牌城市',  align: 'center'},
            {field: 'xingShi', title: '行驶区域', align: 'center'},
            {field: 'yunYing', title: '运营单位',  align: 'center'},
            {field: 'cheLiangMing', title: '车型名称',  align: 'center'},
            {field: 'quYuZong', title: '行驶区域总里程（Km）',  align: 'center'},
            {field: 'quYuGPS', title: '行驶区域GPS总里程（km）',  align: 'center'},
            {field: 'zhanBi', title: '行驶区域里程占比（%）', align: 'center'},
            {field: 'jieDuan', title: '车辆阶段',  align: 'center'}
        ]],
        toolbar: "#toolbar",
        pagination: true,
        nowrap: true
    });

   toolbar2Menu("table");

</script>
<script language="javascript">

    function getCurentDateStr()
    {
        var day1 = new Date();
         day1.setTime(day1.getTime()-24*60*60*1000);
         var s1 = day1.getFullYear()+"-" + (day1.getMonth()+1) + "-" + day1.getDate();
        return s1;
    }

    /*报表说明弹框*/
    function reportSpecification(){
        $('#report').window("open");
    }



    /**
     * 查看
     */
    function view_item() {
        var title = "增加演示1";
        var url = "/report/demo1/view";
        openViewDataWin('report_demo1',title,url,"600",'600','table');
    }

    /**
     * 编辑
     * @param id
     */
    function edit_item(id) {
        var title = "编辑演示1";
        var url = "/report/demo1/update?id=" + (id);
        openUpdateDataWin('report_demo1',title,url,"600",'600','table');
    }


    /**
     * 编辑
     * @param id
     */
    function del_item() {
        var title = "演示1";
        var url = "/report/demo1/del";
        delRecord(title,url,'table');
    }


</script>
</html>