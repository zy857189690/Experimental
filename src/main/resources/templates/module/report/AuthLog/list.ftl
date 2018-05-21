
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<#include "../../../inc/meta.ftl">
<#include  "../../../inc/js.ftl">
    <style type="text/css">
        .td_input a:not(.bg_button) {
            right: 20px !important;
        }
    </style>
    <script language="javascript">
    </script>
</head>
<body class="easyui-layout" fit="true">
<div region="center" style="overflow: hidden;width: 100%;">
    <div id="toolbar" style="padding:5px">
        <a href="#" onclick="exportDatagrid('${base}/AuthLog/export','form_search','table')" class="easyui-linkbutton">导出</a>
    </div>
    <div id="table" name="datagrid" style="width: 100%;height: 100%"></div>
</div>

<div data-options="region:'north',title:'查询',split:false,collapsable:false" style="width: 100%;height:90px;">
    <div style="width: 100%;border: 1;margin:5 5 5 10 ">
        <form id="form_search" name="form_search" class="sui-form form-inline cg-form">
            <table class="table_search">
                <tr>
                    <td class="td_label">
                        <label>模块:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.module_name" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>操作人:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.oper" style="width: height: 26px;width:150px;" class="input-fat input" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>开始时间:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" id="startTime" name="query.startTime" class="input-fat input" style="width: height: 26px;width:150px;" onfocus="WdatePicker({isShowClear:false, dateFmt:'yyyy-MM-dd HH:mm:ss'})" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>结束时间:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" id="endTime" name="query.endTime" class="input-fat input" style="width: height: 26px;width:150px;" onfocus="WdatePicker({isShowClear:false, dateFmt:'yyyy-MM-dd HH:mm:ss'})" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
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

<script type="text/javascript">
    var pagessort = "uuid";
    var pagesorder = "desc";
    $('#table').datagrid({
        url: '${base}/AuthLog/datagrid',
        sortName: "time",
        sortOrder: "desc",
        rownumbers:"true",
        frozenColumns: [[
        ]],
        columns: [[
            {field: 'ck', checkbox: true, fitColumns: false},
            {title: '操作模块', field: 'module_name',sortable: "true",align:"center",halign:"center"},
            {title: '操作时间', field: 'time', sortable: "true",align:"center",halign:"center", formatter:formatDateTime},
            {title: '操作人', field: 'oper', sortable: "true",align:"center",halign:"center"},
            {title: 'IP', field: 'ip', sortable: "true",align:"center",halign:"center"},
            {title: '耗时', field: 'times',sortable: "true",align:"center",halign:"center", formatter:function(val,row,index){
                if(isObj(val)){
                    return val+"ms"
                }
            }},
            {title: '操作类型', field: 'action',  sortable: "true",align:"center",halign:"center"},
            {title: '操作结果', field: 'result', sortable: "true",align:"center",halign:"center"},
            {title: '变更内容', field: 'change_info', sortable: "true",align:"center",halign:"center"}
        ]],
        toolbar: "#toolbar",
        pagination: true,
        nowrap: true,
        onSortColumn: function (sort, order) {
            pagessort = sort;
            pagesorder = order;
        },
        onDblClickRow: function (rowIndex, row) {
            // queryCarMess(row.id);
        },
        onLoadSuccess:function(data){
            afterLoading();
            // buttonShow(index);

        }
    });
    toolbar2Menu("table");
</script>
</body>
</html>