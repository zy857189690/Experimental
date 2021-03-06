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
            <a href="#" onclick="view_item()" class="easyui-linkbutton"
               data-options="iconCls:'icon-view'" menu="0">查看</a>
        <a href="#" onclick="add_item()" class="easyui-linkbutton"
           data-options="iconCls:'icon-add'" menu="0">增加位置图</a>
        <a href="#" onclick="edit_item()" class="easyui-linkbutton"
           data-options="iconCls:'icon-edit'" >编辑</a>
        <a href="#" onclick="import_item()" class="easyui-linkbutton"
           data-options="iconCls:'icon-remove'" >导入位置图</a>
          <#--&lt;#&ndash;  <a href="#" onclick="exportDatagrid('${base}/report/demo1/export','form_search','table')" class="easyui-linkbutton"
               data-options="iconCls:'icon-export'" menu="0">导出</a>-->
    </div>
    <div id="table" name="datagrid" style="width: 100%;height: 100%"></div>
</div>

<div data-options="region:'north',title:'位置图管理',split:true,collapsable:true" style="width: 100%;height: 190px">
    <div style="width: 100%;border: 1;margin:5 5 5 10 ">
        <form id="form_search" name="" class="sui-form cg-form">
            <table class="table_search">
                <tr>
                        <td class="td_label">
                            <label>点样编号</label>
                        </td>
                      <td class="td_input">
                            <input type="text"class="input-fat input" style="width: height: 26px;width:150px;"   name="query.code"  autocomplete="off" >
                        </td>
                <#--      <td class="td_label">
                        <label>名称值</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" style="width: height: 26px;width:150px;"   name="query.nameField"  autocomplete="off" >
                    </td>-->

                    <td style="vertical-align: center;text-align: right;border: 1px" class="cg-btnGroup">
                        <a href="#" onclick="search_item()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>

</body>
<script>
    $('#table').datagrid({
        url: '/experimentManagement/report/demo1/datagrid',
        sortName: "createTime",
        sortOrder: "desc",
        singleSelect: true,
        checkOnSelect: false, //此属性必须设置为 false10
        columns: [[
            {field: 'ck', checkbox: true, width: '20'},
            {field: 'code', title: '点样编号'},
            {field: 'name', title: '点样人'},
            {field: 'createTime', title: '点样时间'},
          /* {field: 'createBy', title: '创建人'},
            {field: 'updateTime', title: '更新时间'},
            {field: 'updateBy', title: '更新人'},*/
        ]],
        toolbar: "#toolbar",
        pagination: true,
        nowrap: true

    });

  toolbar2Menu("table");

</script>
<script language="javascript">


    function search_item() {
        var data = searchData();
        $("#table").datagrid("load",data);

    }
    /**
     * 增加
     */
    function add_item() {

        var title = "添加";
        var url = "/experimentManagement/report/demo1/edit.html?id=-1";
        openEditWin(url, title);
    }
    function openEditWin(url, title) {
        var winid = "pop";
        var width = 1230;
        var height = 620;
        diyWindow(winid, url, title, width, height,false);
    }
    /**
     * 查看
     */
    function view_item(id) {
        if ('' == id || id == undefined) {
            var row = $("#table").datagrid("getSelections");
            if (row != null && row.length == 1) {
                id = row[0].id;
            } else if(row == null || row.length == 0) {
                alert("请选择一条记录！");
                return;
            } else {
                alert("请选择单条记录！");
                return;
            }
        }
        var title = "详情";
        var url = "/experimentManagement/report/demo1/view.html?id=" + (id);
        openEditWin(url, title);
    }

    /**
     * 编辑
     * @param id
     */
    function edit_item(id) {

        if ('' == id || id == undefined) {
            var row = $("#table").datagrid("getSelections");
            if (row != null && row.length == 1) {
                id = row[0].id;
            } else if(row == null || row.length == 0) {
                alert("请选择一条记录！");
                return;
            } else {
                alert("请选择单条记录！");
                return;
            }
        }
        var title = "编辑";
        var url = "/experimentManagement/report/demo1/edit.html?id=" + (id);
        openEditWin(url, title);
    }


    /**
     * 导入
     * @param id
     */
    function import_item() {
        var title = "导入位置图";
        var url = "/experimentManagement/report/demo1/imports.html";
        openEditWin(url, title);
    }

    function diyWindow(winid,url,title,width,height,maximizable){
        if(!url) return;
        if(!width) width = 300;
        if(!height) height = 300;
        var html = "<div id=\"window_" + winid + "\" style=\"padding:0px;\">"
                +"<iframe src='" + url + "' frameborder='0' id='"+winid+"' name='"+winid+"' marginheight='0' style='width:100%;height:95%;' marginwidth='0' scrolling='auto'></iframe>"
                +"</div>";
        var win = window.top.$(html).appendTo(window.top.document.body);
        win.window({
            title : title,
            width : width,
            modal : true,
            shadow : false,
            closed : true,
            minimizable : false,
            collapsible : false,
            maximizable : maximizable,
            height : height,
            draggable : true,
            zIndex : 999,
            inline : true,
            onClose : function() {
                window.setTimeout(function() {
                    window.top.$(win).window('destroy', false);
                }, 0);
                //window.scrollTo(0,scrollTop);
            }
        });
        win.window('open');
        return win;
    }

</script>
</html>