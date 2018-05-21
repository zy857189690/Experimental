
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
<div region="center" style="overflow: hidden;width: 100%;">
    <div id="toolbar" style="padding:5px">
        <a href="#" onclick="add_item()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">新增</a>
        <a href="#" onclick="edit_item()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑</a>
        <a href="#" onclick="del_item()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>
        <a href="#" onclick="moduleOut()" class="easyui-linkbutton">客户企业实名认证</a>
        <a id="a5" href="#" onclick="importVehicle1(1)" class="easyui-linkbutton">客户企业批量实名认证</a>
        <a href="#" onclick="updateModuleDownload()" class="easyui-linkbutton">客户企业车辆绑定</a>
    </div>
    <div id="table" name="datagrid" style="width: 100%;height: 100%"></div>
</div>

<div data-options="region:'north',title:'查询',split:false,collapsable:false" style="width: 100%;height:90px;">
    <div style="width: 100%;border: 1;margin:5 5 5 10 ">
        <form id="form_search" name="form_search" class="sui-form form-inline cg-form">
            <table class="table_search">
                <tr>
                    <td class="td_label">
                            <label>企业名称</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.licensePlate" id="licensePlate" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>企业证件</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.licensePlate" id="licensePlate" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>企业类型</label>
                    </td>
                    <td class="td_input">
                        <select name="query.alarmType" id="alarmType" query_type="eqs" style="height: 30px;width:168px;">
                            <option value="">请选择</option>
                        </select>
                    </td>
                    <td class="td_label">
                        <label>行业类型</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.licensePlate" id="licensePlate" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>企业地址</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.licensePlate" id="licensePlate" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>负责人姓名</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.licensePlate" id="licensePlate" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>证件号:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.licensePlate" id="licensePlate" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>手机号:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.licensePlate" id="licensePlate" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td style="vertical-align: center;text-align: right;border: 1px" class="cg-btnGroup">
                        <a href="#" onclick="search_item()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>                    <a href="#" onclick="reset_common(search_item)" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
<script type="text/javascript">

    function add_item() {
        var title = "新增客户企业";
        var url = "${base}/customerUnit/add";
        openEditWin(url, title);
    }

    function edit_item() {
        var title = "编辑客户企业";
        var url = "${base}/customerUnit/edit";
        openEditWin(url, title);
    }

    function openEditWin(url,title,width,height) {
        var winid = "user";
        if(width==undefined){
            width=530;
            height=550;
        }
        top.my_window(winid, url, title, width, height);

    }
</script>
<script type="text/javascript">
    var pagessort = "uuid";
    var pagesorder = "desc";
    $('#table').datagrid({
        url: '/module-demo/PeopleAuth/datagrid',
        sortName: "entryDate",
        sortOrder: "desc",
        rownumbers:"true",
        frozenColumns: [[
        ]],
        columns: [[
            {field: 'ck', checkbox: true, fitColumns: false},
            {title: '企业名称', field: 'licensePlate',  sortable: "true",align:"center",halign:"center"},
            {title: '企业简称', field: 'licensePlate', sortable: "true",align:"center",halign:"center"},
            {title: '企业类型', field: 'licensePlate',sortable: "true",align:"center",halign:"center"},
            {title: '行业类型', field: 'licensePlate',  sortable: "true",align:"center",halign:"center"},
            {title: '企业证件', field: 'licensePlate', sortable: "true",align:"center",halign:"center"},
            {title: '企业地址', field: 'licensePlate', sortable: "true",align:"center",halign:"center"},
            {title: '负责人姓名', field: 'licensePlate',  sortable: "true",align:"center",halign:"center"},
            {title: '联系电话', field: 'licensePlate', sortable: "true",align:"center",halign:"center"},
            {title: '邮箱', field: 'licensePlate',  sortable: "true",align:"center",halign:"center"},
            {title: '证件类型', field: 'licensePlate',  sortable: "true",align:"center",halign:"center"},
            {title: '证件号码', field: 'licensePlate',  sortable: "true",align:"center",halign:"center"},
            {title: '所有人证件地址', field: 'licensePlate',  sortable: "true",align:"center",halign:"center"},
            {title: '联系地址', field: 'licensePlate',  sortable: "true",align:"center",halign:"center"},
            {title: '操作', field: 'licensePlate',  sortable: "true",align:"center",halign:"center", formatter: function (val, row) {
                    return "<a href=\"#\" onclick=\"showFaultDetail('" + row.id + "')\">查看详情</a>&nbsp;&nbsp;";
                }}
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

</script>
</body>
</html>