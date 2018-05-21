
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<<#include "../../../inc/meta.ftl">
<<#include  "../../../inc/js.ftl">
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
                            <label>字典值</label>
                        </td>
                        <td class="td_input">
                            <input type="text"class="input-fat input" style="width: height: 26px;width:150px;"   name="query.dictField"  autocomplete="off" >
                        </td>
                        <td class="td_label">
                            <label>名称值</label>
                        </td>
                        <td class="td_input">
                            <input type="text"class="input-fat input" style="width: height: 26px;width:150px;"   name="query.nameField"  autocomplete="off" >
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
            {field: 'name', title: '名称'},
            {field: 'dictField', title: '字典值'},
            {field: 'nameField', title: '名称值'},
            {field: 'createTime', title: '创建时间'},
            {field: 'createBy', title: '创建人'},
            {field: 'updateTime', title: '更新时间'},
            {field: 'updateBy', title: '更新人'},
        ]],
        toolbar: "#toolbar",
        pagination: true,
        nowrap: true

    });

    toolbar2Menu("table");

</script>
<script language="javascript">
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



</script>
</html>