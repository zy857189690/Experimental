
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<<#include "../../../../inc/meta.ftl">
<<#include "../../../../inc/js.ftl">
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
        <@shiro.hasPermission name="/report/demo1/export">
            <a href="#" onclick="exportDatagrid('${base}/report/demo1/export','form_search','table')" class="easyui-linkbutton"
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
                        <label>查询日期</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" style="width: height: 26px;width:150px;" name="query.dictField" autocomplete="off">
                    </td>
                    <td class="td_label">
                        <label>至</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" style="width: height: 26px;width:150px;" name="query.nameField" autocomplete="off">
                    </td>
                    <td class="td_label">
                        <label>运营单位</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" style="width: height: 26px;width:150px;" name="query.nameField" autocomplete="off">
                    </td>
                    <td class="td_label">
                        <label>车牌号</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" style="width: height: 26px;width:150px;" name="query.nameField" autocomplete="off">
                    </td>
                    <td class="td_label">
                        <label>VIN</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" style="width: height: 26px;width:150px;" name="query.nameField" autocomplete="off">
                    </td>
                    <td class="td_label">
                        <label>车辆种类</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" style="width: height: 26px;width:150px;" name="query.nameField" autocomplete="off">
                    </td>
                    <td class="td_label">
                        <label>车辆型号名称</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" style="width: height: 26px;width:150px;" name="query.nameField" autocomplete="off">
                    </td>
                    <td class="td_label">
                        <label>车辆状态</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" style="width: height: 26px;width:150px;" name="query.nameField" autocomplete="off">
                    </td>
                    <td class="td_label">
                        <label>上牌城市</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" style="width: height: 26px;width:150px;" name="query.nameField" autocomplete="off">
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
    $('#table').datagrid({
        url: '${base}/report/demo1/datagrid',
        sortName: "createTime",
        sortOrder: "desc",
        columns: [[
            {field: 'ck', checkbox: true, width: '20'},
            {field: 'name', title: '车牌号',align:'center',sortable: false},
            {field: 'dictField', title: 'VIN',align:'center',sortable: false},
            {field: 'nameField', title: '车辆种类',align:'center',sortable: false},
            {field: 'createTime', title: '车辆型号名称',align:'center',sortable: false},
            {field: 'createBy', title: '车辆公告型号',align:'center',sortable: false},
            {field: 'updateTime', title: '终端零件号',align:'center',sortable: false},
            {field: 'updateBy', title: '条形码编码',align:'center',sortable: false},
            {field: 'updateBy', title: '终端厂商自定义编号',align:'center',sortable: false},
            {field: 'updateBy', title: '车辆厂商',align:'center',sortable: false},
            {field: 'updateBy', title: '运营单位',align:'center',sortable: false},
            {field: 'updateBy', title: '上牌城市',align:'center',sortable: false},
            {field: 'updateBy', title: '激活时间',align:'center',sortable: false},
            {field: 'updateBy', title: '销售日期',align:'center',sortable: false},
            {field: 'updateBy', title: 'ICCID',align:'center',sortable: false},
            {field: 'updateBy', title: 'ICCID',align:'center',sortable: false},
        ]],
        toolbar: "#toolbar",
        pagination: true,
        nowrap: true

    });

    toolbar2Menu("table");

</script>
<script language="javascript">



</script>
</html>