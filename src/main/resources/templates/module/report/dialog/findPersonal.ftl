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
</head>
<body class="easyui-layout" fit="true">
<div region="center" style="overflow: hidden;width: 100%">
    <div id="toolbar">
    </div>
    <div id="table" name="datagrid" style="width: 100%;height: 100%"></div>
</div>

<div data-options="region:'north',title:'查询',split:false,collapsable:false" style="width: 100%;height:120px;">
    <div style="width: 100%;border: 1;margin:5 5 5 10 ">
        <form id="form_search" name="form_search" class="sui-form form-inline cg-form">
            <table class="table_search">
                <tr>
                    <td class="td_label">
                        <label>姓名</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.name" id="name" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>联系电话</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.phone" id="phone" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                </tr>
                <tr>
                    <td class="td_label">
                        <label>证件号码</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.certId" id="certId" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>联系地址</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.certAddr" id="certAddr" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
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
    //    var pagessort = "uuid";
    //    var pagesorder = "desc";
    $('#table').datagrid({
        url: '${base}/select/datagridPersonal',
        sortName: "entryDate",
        sortOrder: "desc",
        rownumbers:"true",
        frozenColumns: [[
        ]],
        columns: [[
            {title: '姓名', field: 'name',  sortable: "true",align:"center",halign:"center",width:"20%"},
            {title: '联系电话', field: 'phone', sortable: "true",align:"center",halign:"center",width:"20%"},
            {title: '证件号码', field: 'certId', sortable: "true",align:"center",halign:"center",width:"20%"},
            {title: '联系地址', field: 'certAddr', sortable: "true",align:"center",halign:"center",width:"20%"},
            {title: 'serial_number', field: 'address', hidden:'true'},
            {title: 'serial_number', field: 'email', hidden:'true'},
            {title: 'serial_number', field: 'sex', hidden:'true'},
            {title: 'serial_number', field: 'certType', hidden:'true'},
            {title: 'serial_number', field: 'pic1', hidden:'true'},
            {title: 'serial_number', field: 'pic2', hidden:'true'},
            {title: 'serial_number', field: 'face_pic', hidden:'true'},
        ]],
        toolbar: "#toolbar0",
        pagination: true,
        nowrap: true,
        onSortColumn: function (sort, order) {
            pagessort = sort;
            pagesorder = order;
        },
        onClickRow: function (index,row) {
            var type = '${(type)!}';
            if(type == '1'){
                window.top.PeopleAuth_add_iframeFrame.personalCallBack(row);
            }else if(type == '2'){
                window.top.PeopleAuth_edit_iframeFrame.personalCallBack(row);
            }
            window.parent.$("#window_pop").window("close");
        }
    });

</script>
</body>
</html>