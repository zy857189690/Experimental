
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

    <@shiro.hasPermission name="/report/demo1/export">
        <a href="#" onclick="exportDatagrid('${base}/report/operation/mileageMonitor/downloadMileageMonthly','form_search','table')" class="easyui-linkbutton"
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
                        <label>运营单位:</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" style="width: height: 26px;width:150px;" id="yunYing"    name="query.yunYing"  autocomplete="off" >


                    </td>
                    <td class="td_label">
                        <label>车辆名称:</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" style="width: height: 26px;width:150px;"   name="query.cheLiangMing"  autocomplete="off" >
                    </td>
                    <td class="td_label">
                        <label>截止时间</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="easyui-datebox" id="endTime" style="width: height: 26px;width:150px;"  name="query.endTime"  autocomplete="off" data-options="editable:false">
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

    $(function(){

    });

    $('#table').datagrid({
        url: '${base}/report/operation/mileageMonitor/queryMileageMonthly',
        sortName: "createTime",
        sortOrder: "desc",
        rownumbers: true,
        columns: [[
            {field: 'shiJian', title: '截止时间'},
            {field: 'yunYing', title: '运营单位'},
            {field: 'cheLiangMing', title: '车型名称'},
            {field: 'jianKongChe', title: '监控车车辆总数（辆）'},
            {field: 'cheLiangYunYing', title: '本月车辆运营数（辆）'},
            {field: 'a', title: '≥3万公里（辆）',formatter:function(val, row, index){

                if(val==undefined||val==""){
                    return "0";
                }

                 return compile(val,row,index,30000,0,'≥3万公里（辆）');
            } },
            {field: 'b', title: '2~3万公里（辆）',formatter:function(val, row, index){
                if(val==undefined||val==""){
                    return "0";
                }
                return  compile(val,row,index,20000,30000,'2~3万公里（辆）');
            } },
            {field: 'c', title: '1~2万公里（辆）',formatter:function(val, row, index){
                if(val==undefined||val==""){
                    return "0";
                }
                return  compile(val,row,index,10000,20000,'1~2万公里（辆）');
            } },
            {field: 'd', title: '0.05~1万公里（辆）',formatter:function(val, row, index){
                if(val==undefined||val==""){
                    return "0";
                }
                return  compile(val,row,index,500,10000, '0.05~1万公里（辆）');
            } },
            {field: 'e', title: '＜0,05万公里（辆）',formatter:function(val, row, index){
                if(val==undefined||val==""){
                    return "0";
                }
                return  compile(val,row,index,0,500,'＜0,05万公里（辆）');
            } },
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


    function  compile( val, row, index,data1,data2,title){

      //  return  "<span style='color:#00F;text-decoration:underline;cursor:pointer;' onclick='popup("+row.yunYing+","+row.cheLiangMing+","+row.endTime+","+data1+","+data2+")' >"+val+"</span>";
      return   "<a href='#' onclick='popup(\""+row.yunYing+"\",\""+row.cheLiangMing+"\",\""+row.shiJian+"\","+data1+","+data2+",\""+title+"\")'>"+val+"</a>"
    }

    function popup(yunYing,cheLiangMing,endTime,data1,data2,title){

        if(yunYing==undefined||yunYing=='undefined'){
            yunYing='';
        }
        if(cheLiangMing==undefined||cheLiangMing=='undefined'){
            cheLiangMing='';
        }
        if(endTime==undefined||endTime=='undefined'){
            endTime='';
        }


        var url="${base}/report/operation/mileageMonitor/popup?yunYing="+yunYing+"&cheLiangMing="+cheLiangMing+"&endTime="+endTime+"&data1="+data1+"&data2="+data2;


        openEditWin(url,title);

    }

    function openEditWin(url, title) {
        var winid = "pop";
        var width = 1200;
        var height = 550;
        diyWindow(winid, url, title, width, height,false);
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
                window.scrollTo(0,scrollTop);
            }
        });
        win.window('open');
        return win;
    }



</script>
</html>