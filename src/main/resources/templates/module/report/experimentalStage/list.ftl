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
        <#--<a href="#" onclick="add_item()" class="easyui-linkbutton"
           data-options="iconCls:'icon-add'" menu="0">添加实验准备阶段报告</a>-->
        <a href="#" onclick="edit_item()" class="easyui-linkbutton"
           data-options="iconCls:'icon-edit'" >添加载药量</a>
    </div>
    <div id="table" name="datagrid" style="width: 100%;height: 100%"></div>
</div>

<div data-options="region:'north',title:'实验原始数据管理',split:true,collapsable:true" style="width: 100%;height: 190px">
    <div style="width: 100%;border: 1;margin:5 5 5 10 ">
        <form id="form_search" name="" class="sui-form cg-form">
            <table class="table_search">
                <tr>
                    <td class="td_label">
                        <label>原始数据查询编号</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" style="width: height: 26px;width:150px;"   name="query.code"  autocomplete="off" >
                    </td>
                </tr>
                </tr>
                <td class="td_label">
                    <label>送检时间筛选</label>
                </td>

                <td class="td_input">
                    <input type="text" class="input-fat input"  placeholder="年/月/日" onfocus="WdatePicker({isShowClear:false, dateFmt:'yyyy-MM-dd'})" name="query.startTime" id="startTime" query_type="lis" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label" >
                    <label style="margin-left:15px">至:</label>
                </td>
                <td class="td_input">
                    <input type="text" class="input-fat input"  placeholder="年/月/日" onfocus="WdatePicker({isShowClear:false, dateFmt:'yyyy-MM-dd'})" name="query.endTime" id="endTime" query_type="lis" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>

                <td style="vertical-align: center;text-align: right;border: 1px" class="cg-btnGroup">
                    <a href="#" onclick="search_item()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
                </td>
                </tr>
                </tr>
                <td class="td_label">
                    <label>请选择数据排序方式</label>
                </td>
                <td class="td_input" colspan="8">
                    <select class="select2" data-options="editable:false" name="query.flag" id="flag" style="height: 26px; width: 135px" query_type="eq" formatter:formatBoolean >
                        <option value="ex_no">默认排序（实验编号进行排序）</option>
                        <option value="start_time">实验开始时间进行排序</option>
                        <option value="update_time">最后更新时间进行排序</option>
                    </select>
                </td>

                </tr>
            </table>
        </form>
    </div>
</div>

</body>
<script>
    var sortOrder = $("#flag").val();
    $('#table').datagrid({
        url: '/experimentManagement/report/experimentalStage/datagrid',
        sortName: sortOrder,
        sortOrder: "desc",
        singleSelect: true,
        checkOnSelect: false, //此属性必须设置为 false10
        columns: [[
            {field: 'ck', checkbox: true, width: '20'},
            {field: 'exNo', title: '实验编号'},
            {field: 'startTime', title: '实验开始时间'},
            {field: 'updateTime', title: '最后更新时间'},
            {field: 'status', title: '实验状态',formatter:function(value,row,index){
                    if(isObj(value)){
                        if(value==0){
                            return '正在进行';
                        }else if(value==1){
                            return "结束";
                        }else {
                            return "未知";
                        }
                    }
                }}

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
        var title = "添加实验报告";
        var url = "/experimentManagement/report/experimentalStage/edit.html?id=-1";
        openEditWin(url, title);
    }
    function openEditWin(url, title,width,height) {
        var winid = "pop";

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
        var url = "/experimentManagement/report/experimentalStage/view.html?id=" + (id);
        var width = 1230;
        var height = 620;
        openEditWin(url, title,width,height);
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
        var title = "载药量添加";
        var url = "/experimentManagement/report/experimentalStage/edit.html?id=" + (id);
        var width = 620;
        var height = 320;
        openEditWin(url, title,width,height);
    }


    /**
     * 导入
     * @param id
     */
    function import_item() {
        var title = "导入位置图";
        var url = "/experimentManagement/report/experimentalStage/imports.html";
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