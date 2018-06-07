
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<<#include "../../../../inc/meta.ftl">
<<#include  "../../../../inc/js.ftl">
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
       <#-- <@shiro.hasPermission name="/report/demo1/view">
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
        </@shiro.hasPermission>-->
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
                        <label>条件查询</label>
                    </td>
                    <td class="td_input">
                        <input type="radio" name="adminFlag" data-options="selected:true" value="0" style="width: height: 26px;width:100px;" ></input>

                    </td>
                    <td class="td_label">
                        <label>导入查询</label>
                    </td>
                    <td class="td_input">
                        <input type="radio" name="adminFlag" value="1"  style="width: height: 26px;width:100px;"></input>
                     </td>
                </tr>
                <tr>
                        <td class="td_label">
                            <label>统计日期</label>
                        </td>
                        <td class="td_input">
                            <input id="dd" type="text" class="easyui-datebox" style="width: height: 26px;width:100px;" required="required">
                         </td>
                    <td class="td_label">
                        <label>至</label>
                    </td>
                    <td class="td_input">
                              <input id="dd" type="text" class="easyui-datebox" style="width: height: 26px;width:100px;"  required="required">
                        </td>

                    <td class="td_label">
                            <label>VIN</label>
                        </td>
                        <td class="td_input">
                            <input type="text"class="input-fat input" style="width: height: 26px;width:100px;"   name="query.dictField"  autocomplete="off" >
                        </td>

                    <td class="td_label">
                            <label>车牌号</label>
                        </td>
                        <td class="td_input">
                            <input type="text"class="input-fat input" style="width: height: 26px;width:100px;"   name="query.dictField"  autocomplete="off" >
                        </td>
                    <td class="td_label">
                            <label>车辆种类</label>
                        </td>
                        <td class="td_input">
                            <input type="text"class="input-fat input" style="width: height: 26px;width:100px;"   name="query.dictField"  autocomplete="off" >
                        </td>
                    <td class="td_label">
                            <label>运营单位</label>
                        </td>
                        <td class="td_input">
                            <input type="text"class="input-fat input" style="width: height: 26px;width:100px;"   name="query.dictField"  autocomplete="off" >
                        </td>
                    <td class="td_label">
                            <label>上牌区域</label>
                        </td>
                        <td class="td_input">
                            <input type="text"class="input-fat input" style="width: height: 26px;width:100px;"   name="query.dictField"  autocomplete="off" >
                        </td>
                    <td class="td_label">
                            <label>当日有效里程大于（km）</label>
                        </td>
                        <td class="td_input">
                            <input type="text"class="input-fat input" style="width: height: 26px;width:100px;"   name="query.dictField"  autocomplete="off" >
                        </td>
                    <td class="td_label">
                            <label>当日轨迹里程大于（km）</label>
                        </td>
                        <td class="td_input">
                            <input type="text"class="input-fat input" style="width: height: 26px;width:100px;"   name="query.dictField"  autocomplete="off" >
                        </td>
                    <td class="td_label">
                            <label>当日在线里程大于（km）</label>
                        </td>
                        <td class="td_input">
                            <input type="text"class="input-fat input" style="width: height: 26px;width:100px;"   name="query.dictField"  autocomplete="off" >
                        </td>
                        <td class="td_label">
                            <label>文件上传</label>
                        </td>
                        <td class="td_input">
                            <input type="file" id="file" style="width: height: 26px;width:100px;" name="myfile" />
                            <input type="button" onclick="UpladFile()" value="文件解析" />
                        </td>

                        <td class="td_input">
                            <input type="button" onclick="downFile()" value="导入查询模板下载" />
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
        url: '${base}/report/operation/dayMileageCheck/datagrid',
        sortName: "ID",
        sortOrder: "desc",
        columns: [[
            {field: 'ck', checkbox: true, width: '20'},
            {field: 'id', title: '序号', width: '90'},
            {field: 'id', title: 'id', width: '20'},
            {field: 'id', title: 'VIN', width:  90 },
            {field: 'id', title: '车牌号', width: '90'},
            {field: 'id', title: '统计日期', width: '90'},
            {field: 'id', title: '当日首次上线时间', width: '90'},
            {field: 'id', title: '当日开始里程(KM)', width: '90'},
            {field: 'id', title: '当日最后通讯时间', width: '90'},
            {field: 'id', title: '当日结束里程(KM)', width: '90'},
            {field: 'id', title: '核查数据总条数(条)', width: '90'},
            {field: 'id', title: '含无效数据条数(条)', width: '90'},
            {field: 'id', title: '含异常数据条数(条)', width: '90'},
            {field: 'id', title: '当日上线里程(KM)', width: '90'},
            {field: 'id', title: '总跳变扣除里程(KM)', width: '90'},
            {field: 'id', title: '总连续电流扣除里程(KM)', width: '90'},
            {field: 'id', title: '当日有效里程(KM)', width: '90'},
            {field: 'id', title: '当日轨迹里程(KM)', width: '90'},
            {field: 'id', title: '有效里程和轨迹里程相对误差（百分比）', width: '90'},
            {field: 'id', title: '上线里程和有效里程相对误差（百分比）', width: '90'},
            {field: 'id', title: '单日核算里程(KM)', width: '90'},
            {field: 'id', title: '上牌区域', width: '90'},
            {field: 'id', title: '运营单位', width: '90'},
            {field: 'id', title: '车辆型号', width: '90'},
            {field: 'id', title: '车辆种类', width: '90'},
        ]],
        toolbar: "#toolbar",
        pagination: true,
        nowrap: true

    });

//    toolbar2Menu("table");

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

    /***
     * 文件上传
     * @constructor
     */
    function UpladFile() {
        var fileObj = document.getElementById("file").files[0]; // 获取文件对象

        var FileController = "${base}/report/operation/dayMileageCheck/fileMin";                    // 接收上传文件的后台地址

        // FormData 对象

        var form = new FormData();

        form.append("author", "hooyes");                        // 可以增加表单数据

        form.append("file", fileObj);                           // 文件对象
        // XMLHttpRequest 对象

        var xhr = new XMLHttpRequest();

        xhr.open("post", FileController, true);

        xhr.onload = function (data) {

        };
        xhr.send(form);
        xhr.onreadystatechange =function(){
            if (xhr.readyState == 4){
                 // alert(xhr.responseText);
                  var data =  eval("("+xhr.responseText+")");
                alert(data.code)
                if (data.code == 0) {
                    $.messager.show({
                        title:'文件解析结果',
                        msg:'解析成功.',
                        timeout:2000,
                        showType:'slide'
                    });
                } else {
                    $.messager.show({
                        title:'文件解析结果',
                        msg:'解析失败.',
                        timeout:2000,
                        showType:'slide'
                    });
                }
            }
        }

    }

    /*模板下载*/
    function downFile() {
        var downUrl = "${base}/report/operation/dayMileageCheck/downLooadModel?moduleName=model&fileName=templateQuery.xlsx";
        window.open(downUrl);
    }
</script>
</html>