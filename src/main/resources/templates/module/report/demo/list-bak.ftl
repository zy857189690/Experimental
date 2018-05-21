<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<#include "../../../inc/meta.ftl">
<#include  "../../../inc/js.ftl">

    <script language="javascript">
        function add_item() {
            var title = "添加";
            var url = "${cdn}/sysUser/edit.html?id=-1";
            openEditWin(url, title);
        }

        function edit_item(id) {
            if ('' == id || id == undefined) {
                var row = $("#table").datagrid("getSelected");
                if (row != null) {
                    id = row.id;
                } else {
                    alert("请选单条记录！");
                    return;
                }
            }
            var title = "编辑";
            var url = "${cdn}/sysUser/edit.html?id=" + (id);
            openEditWin(url, title);

        }
        var copyUnit;
        var copyUserName;
        function copyUserP() {
            var row = $("#table").datagrid("getSelected");
            if (row != null) {
                id = row.id;
            } else {
                layer.alert("请选择用户！");
                return;
            }
            var title = "复制用户权限";
            var url = "${cdn}/sysUser/copyUserPower.html?id=" + (id);
            openEditDig(url, title,"400px","240px");
        }
        function roles(id){
            if ('' == id || id == undefined) {
                var row = $("#table").datagrid("getSelected");
                if (row != null) {
                    id = row.id;
                } else {
                    alert("请选择用户！");
                    return;
                }
            }
            var title = "角色";
            var url = "${cdn}/sysUser/roles.html?id=" + (id);
            openEditWin(url, title,550,420);
        }

        function assignVehs(id){
            if ('' == id || id == undefined) {
                var row = $("#table").datagrid("getSelected");
                if (row != null) {
                    id = row.id;
                } else {
                    alert("请选择用户！");
                    return;
                }
            }
            var title = "分配车辆";
            var url = "${cdn}/sysUser/assignVehs.html?id=" + (id);
            openEditWin(url, title,"100%","100%");
        }



        function assignGroups(id){
            if ('' == id || id == undefined) {
                var row = $("#table").datagrid("getSelected");
                if (row != null) {
                    id = row.id;
                } else {
                    alert("请选择用户！");
                    return;
                }
            }
            var title = "分配车组";
            var url = "${cdn}/sysUser/assignGroup.html?id=" + (id);
            openEditWin(url, title,"100%","100%");
        }


        function assignRoles() {
            var row = $("#table").datagrid("getSelected");
            if (row != null) {
                id = row.id;
            } else {
                layer.alert("请选择用户！");
                return;
            }
            var title = "用户"+row.username+"已分角色";
            var url = "${cdn}/sysUser/assignRoles.html?id=" + (id);
            openEditDig(url, title,"400px","400px");
        }


        function resetPassword(id){
            var action = "${cdn}/sysUser/resetPassword.html";
            var rows = $("#table").datagrid("getSelections");
            if (rows != null && rows.length != 0) {
                var ids = "";
                for (var i = 0; i < rows.length; i++) {
                    ids += rows[i].id;
                    if (i != (rows.length - 1))
                        ids += ","
                }
                resetDPword(action, "用户", ids, callback_del)
            }
            else {
                alert("请选择记录！");
                return;
            }
        }




        //////////////////////////////////////////删除操作///////////////////////////////
        function del_item(id) {
            var action = "${cdn}/sysUser/del.html";
            var rows = $("#table").datagrid("getSelections");
            if (rows != null && rows.length != 0) {
                var ids = "";
                for (var i = 0; i < rows.length; i++) {
                    ids += rows[i].id;
                    if (i != (rows.length - 1))
                        ids += ","
                }
                del_common(action, "用户", ids, callback_del)
            }
            else {
                alert("请选择记录！");
                return;
            }

        }
        //删除的回调函数
        function callback_del() {
            $("#table").datagrid("reload");
        }
        //////////////////////////////////////结束删除//////////////////////////////////

        //查询
        //通过配置查询控件的query_type
        // 字符串类型，查询请用lis，精准查询eqs,时间段查询bewteen
        // 整型查询使用&eq(等于),&gt(大于),&lt(小于)，&ne不等于
        function search_item() {
            var data = searchData();
            log(data);
            //时间段,不适合通用查询，需自行处理
            //data['queryDate&bewteen'] = start_date|end_date;

            $("#table").datagrid("load",data);

        }

        function openEditWin(url, title,width,height) {
            var winid = "user";
            if(width==undefined){
                width = 800;
                height=400;
            }
//            top.showContentDialog(winid, url, title, width, height);
            top.my_window(winid, url, title, width, height);

        }
        function openEditDig(url, title,width,height) {
            var winid = "user";
            if(width==undefined){
                width = 800;
                height=400;
            }
            top.showContentDialog(winid, url, title, width, height);
//            top.my_window(winid, url, title, width, height);

        }
        $(function(){
            /*$("#isValid").select2({
                multiple: false,   //是否可以选择多个内容，以多个标签的形式展示
                allowClear: false, //是否允许直接X掉你选择的内容
                placeholder:'请选择',//占位提示文字
                data: [{id:'',text:''},{id:'1',text:'是'},{id:'0',text:'否'}]
            });*/
        });
    </script>
</head>
<body class="easyui-layout" fit="true" id="fullid">
<#--<div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 80px">-->
<div data-options="region:'east',title:'查询',split:true,collapsable:true,footer:'#ft'" style="width: 285px;">
    <div style="width: 100%;border: 1;margin:5 5 5 10 ">
        <form id="form_search" class="sui-form">
            <table class="table_search">
                <tr>
                    <td style="width: 30%; padding-left: 5px;"><span class="add-on" style="width: 78px">名称：</span></td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" name="query.name" id="name" style="width: height: 26px;width:150px;"
                               required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                </tr>
                <tr>
                    <td style="width: 30%; padding-left: 5px;"><span class="add-on" style="width: 78px">字典值：</span></td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" name="query.dictField" id="dictField" style="width: height: 26px;width:150px;"
                               required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                </tr>


            </table>
            <div id="ft" style="padding:5px;">
                <div style="float: right">
                    <a href="#" onclick="search_item()" class="easyui-linkbutton" class="easyui-linkbutton"
                       data-options="iconCls:'icon-search'">查询</a>
                    <a href="#" onclick="reset_common(search_item)" class="easyui-linkbutton"
                       class="easyui-linkbutton"
                       data-options="iconCls:'icon-reset'">重置</a>
                </div>
            </div>
        </form>
    </div>
</div>

<div region="center" style="overflow: hidden;width: 100%;" >
    <div id="toolbar" style="padding:5px">
        <a href="#" onclick="add_item()" class="easyui-linkbutton"
           data-options="iconCls:'icon-add'" menu="0">增加</a>
        <a href="#" onclick="edit_item()" class="easyui-linkbutton"
           data-options="iconCls:'icon-edit'" >编辑</a>
        <a href="#" onclick="del_item()" class="easyui-linkbutton"
           data-options="iconCls:'icon-remove'" >删除</a>


    </div>
    <div id="table" name="datagrid" style="width: 100%;height: 100%"></div>
</div>
<#--<div id="menu" class="easyui-menu" style="width:120px;display: none;">-->
<#--<div onclick="add()" iconCls="icon-add">增加</div>-->
<#--<div onclick="alert('sss')" iconCls="icon-remove">删除</div>-->
<#--<div onclick="edit('');" iconCls="icon-edit">编辑</div>-->
<#--</div>-->
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
    //

</script>
</html>