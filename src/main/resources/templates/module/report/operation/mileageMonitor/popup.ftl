
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<#include "../../../../inc/meta.ftl">
<#include  "../../../../inc/js.ftl">
    <style type="text/css">
        .td_input a:not(.bg_button) {
            right: 20px !important;
        }
    </style>
    <script language="javascript">


        $(function(){
            $('#jieDuan').combobox({
                url: '${base}/report/common/queryVehStageList',
                valueField: 'id',
                textField: 'text'
            });

        });


    </script>
</head>
<body class="easyui-layout" fit="true" id="fullid">



<div region="center" style="overflow: hidden;width: 100%;">
    <div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 90px">
        <div style="width: 100%;border: 1;margin:5 5 5 10 ">
            <form id="form_search" name="form_search" class="sui-form form-inline cg-form">
                <table class="table_search">
                    <tr>
                        <td class="td_label">
                            <label>车辆阶段</label>
                        </td>
                        <td class="td_input">
                            <!--
                            <select class="input-fat input" name="query.xingShi" id="isOnline" query_type="eqs" style="height: 26px;width:168px;">
                                <option value="">全部</option>
                                <option value="0">待检测</option>
                                <option value="1">待入库</option>
                                <option value="2">入库</option>
                                <option value="3">出厂带销售</option>
                                <option value="4">已销售</option>
                                <option value="5">运营中</option>
                                <option value="6">已报废</option>


                            </select>-->

                            <input type="text"   class="input-fat input" style="width: height: 26px;width:150px;"   id="jieDuan" name="query.jieDuan"  autocomplete="off" >
                        </td>
                    <#--<td class="td_label">-->
                    <#--<label>车辆名称:</label>-->
                    <#--</td>-->
                    <#--<td class="td_input">-->
                    <#--<input type="text"class="input-fat input" style="width: height: 26px;width:150px;"   name="query.cheLiangMing"  autocomplete="off" >-->
                    <#--</td>-->
                        <td class="td_label">
                            <label>总里程（仪表）大于（km）:</label>
                        </td>
                        <td class="td_input">
                            <!--
                            <select class="input-fat input" name="query.xingShi" id="isOnline" query_type="eqs" style="height: 26px;width:168px;">
                            </select>
                            -->
                            <input type="text"class="input-fat input"  style="width: height: 26px;width:150px;" onkeyup="value=value.replace(/[^\d]/g,'')"   name="query.zongLiCheng"  autocomplete="off" >

                        </td>
                        <td class="td_label"  >
                            <label>总有效里程大于（km）:</label>
                        </td>
                        <td class="td_input">
                            <input type="text"class="input-fat input" style="width: height: 26px;width:150px;" onkeyup="value=value.replace(/[^\d]/g,'')"   name="query.zongYouXiao"  autocomplete="off" >
                        </td>
                        <td class="td_label">
                            <label>总轨迹里程大于（km）:</label>
                        </td>
                        <td class="td_input">
                        <#--<input type="text" class="input-fat input" name="query.vin" id="vin" query_type="lis" style="width: height: 26px;width:150px;" required>-->
                            <input type="text"class="input-fat input" style="width: height: 26px;width:150px;"    onkeyup="value=value.replace(/[^\d]/g,'')"   name="query.zongGuiJi"  autocomplete="off" >
                        </td>

                        <td class="td_label">
                            <label>总在线里程大于（km）:</label>
                        </td>
                        <td class="td_input">
                            <input type="text"class="input-fat input" style="width: height: 26px;width:150px;"  onkeyup="value=value.replace(/[^\d]/g,'')"  name="query.zongZaiXian"  autocomplete="off" >
                        </td>
                        <td class="td_label">
                            <label>总核算里程大于（km）:</label>
                        </td>
                        <td class="td_input">
                            <input type="text"class="input-fat input" style="width: height: 26px;width:150px;"  onkeyup="value=value.replace(/[^\d]/g,'')"  name="query.zongHeSuan"  autocomplete="off" >
                        </td>


                        <td style="vertical-align: center;text-align: right;border: 1px" class="cg-btnGroup">
                            <a href="#" onclick="search_item()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
                            <a href="#" onclick="reset_common(search_item)" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>

    <div id="toolbar" style="padding:5px" class="cg-moreBox">

    <@shiro.hasPermission name="/report/demo1/export">
        <a href="#" onclick="exportDatagrid('${base}/report/operation/mileageMonitor/downloadPopup?query.data1='+'${data1}'+'&query.data2='+'${data2}'+'&query.endTime='+'${endTime}'+'&query.cheLiangMing='+'${cheLiangMing}'+'&query.yunYing='+'${yunYing}','form_search','table')" class="easyui-linkbutton"
           data-options="iconCls:'icon-export'" menu="0">导出</a>
    </@shiro.hasPermission>

    </div>
    <div id="table" name="datagrid" style="width: 100%;"></div>
</div>


</body>
<script>

    function search_item(){



        var data=$("#form_search").serializeObject();
        $("#table").datagrid("load", data);
    }

    $('#table').datagrid({
        url: "${base}/report/operation/mileageMonitor/queryPopup?query.data1="+"${data1}"+"&query.data2="+"${data2}"+"&query.endTime="+"${endTime}"+"&query.cheLiangMing="+"${cheLiangMing}"+"&query.yunYing="+"${yunYing}",
        sortName: "createTime",
        sortOrder: "desc",
        rownumbers: true,
        columns: [[
            {field: 'VIN', title: 'VIN'},
            {field: 'chePai', title: '车牌号'},
            {field: 'cheLiangMing', title: '车型名称'},
            {field: 'shangPai', title: '上牌城市'},
            {field: 'yunYing', title: '运营单位'},
            {field: 'jieDuan', title: '车辆阶段'},
            {field: 'luRu', title: '录入时间'},
            {field: 'showCi', title: '首次上线时间'},
            {field: 'zuiHou', title: '最后通讯时间'},
            {field: 'zongLiCheng', title: '总里程（仪表）km'},
            {field: 'zongZaiXian', title: '总在线里程（km）'},
            {field: 'zongGuiJi', title: '总轨迹里程（km）'},
            {field: 'zongYouXiao', title: '总有效里程（km)'},
            {field: 'zongHeSuan', title: '总核算里程（km）'}
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



    }


</script>
</html>