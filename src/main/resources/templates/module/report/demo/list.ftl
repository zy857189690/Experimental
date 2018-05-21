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
<body class="easyui-layout" fit="true" id="fullid">



<div region="center" style="overflow: hidden;width: 100%;">
    <div id="toolbar" style="padding:5px" class="cg-moreBox">
        <a href="#" onclick="add_item()" class="easyui-linkbutton"
           data-options="iconCls:'icon-add'" menu="0">增加</a>
        <a href="#" onclick="edit_item()" class="easyui-linkbutton"
           data-options="iconCls:'icon-edit'" >编辑</a>
        <a href="#" onclick="del_item()" class="easyui-linkbutton"
           data-options="iconCls:'icon-remove'" >删除</a>


    </div>
    <div id="table" name="datagrid" style="width: 100%;height: 100%"></div>
</div>

<div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 90px">
    <div style="width: 100%;border: 1;margin:5 5 5 10 ">
        <form id="form_search" name="" class="sui-form cg-form">
            <table class="table_search">
                <tr>
                    <td class="td_label">
                        <label>用户名:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" name="query.username" id="username" query_type="lis" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>姓名:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" name="query.realname" id="realname" query_type="lis" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>单位:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" name="deptName" id="deptName" onfocus="top.openSelectDialog(this,'选择单位','/dialog/unit_2.htm',600,620)" onkeyup="value=''" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>                        <input id="unitName" type="hidden" name="query.unit.path" query_type="lis">
                    </td>
                    <td class="td_label">
                        <label>手机号码:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" name="query.mobile" id="mobile" query_type="lis" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>是否有效:</label>
                    </td>
                    <td class="td_input">
                    <#--<select class="select2" data-options="editable:false" name="query.isValid" id="isValid" style="height: 26px;width: 140px" query_type="eq">                    </select>-->                        <input type="text" class="input-fat input" name="deptName" id="deptName" style="width: 150px" onfocus="top.openSelectDialog(this,'选择是否有效','/dialog/isorno.htm', 400, 200)" onkeyup="value=''" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>                        <input id="isValid" type="hidden" name="query.isValid" query_type="eq">
                    </td>
                    <td style="vertical-align: center;text-align: right;border: 1px" class="cg-btnGroup">
                        <a href="#" onclick="search_item()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>                    <a href="#" onclick="reset_common(search_item)" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>

                    </td>
                </tr>


            </table>
        </form>
    </div>

</div>

</body>
<script>
    $('#table').datagrid({
        url: '/report/demo/datagrid',
        sortName: "createTime",
        sortOrder: "desc",
        columns: [[
            {title: '名称', field: 'name', sortable: "true"},
            {title: '字典值', field: 'dictField',  sortable: "true"},
            {title: '名称值', field: 'nameField', sortable: "true"},
            {title: '创建人', field: 'createBy',  sortable: "true"},
            {title: '创建时间', field: 'createTime', sortable: "true"},
            {title: '变更人', field: 'updateBy', fitColumns:false, sortable: "true"},
            {title: '变更时间', field: 'updateTime', fitColumns:false, sortable: "true"},

        ]],
        toolbar: "#toolbar",
        pagination: true,
        nowrap: true

    });

    toolbar2Menu("table");


</script>
</html>