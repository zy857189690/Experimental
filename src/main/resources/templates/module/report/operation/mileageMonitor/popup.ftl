
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
            initTable();
        });
    </script>
</head>
<body class="easyui-layout" fit="true" id="fullid">

<div id="reportDialog" class="easyui-window" title="报表说明" style="width: 853px; height: 500px;display: none"  data-options="modal:true,closed:true">
    <div class="easyui-layout">
        <table class="easyui-datagrid">
            <thead>
            <tr>
                <th data-options="field:'code'" style="width: 167px">名称</th>
                <th data-options="field:'name'" style="width: 731px">定义</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>首次上线时间</td><td>车辆T-BOX生产下线后首次登入系统的时间；</td>
            </tr>
            <tr>
                <td>最后通讯时间</td><td>报表内容所在月份内该车最后向平台发送实时数据的时间</td>
            </tr>
            <tr>
                <td>总在线里程</td><td>车辆自首次上线起，至报表生成前最后一次上线期间GPS总里程</td>
            </tr>
            <tr>
                <td>总轨迹里程</td><td>车辆总里程大于3万公里</td>
            </tr>
            <tr>
                <td>总有效里程</td><td>车辆自首次上线起，至报表生成前最后一次上线期间所有单日有效里程之和</td>
            </tr>
            <tr>
                <td>最终核算里程</td><td>计算总在线里程和参照里程偏差率 ，小于等于7% 选取总在线里程为最终核算里程，否则选取两个的较小者为最终核算里程</td>
            </tr>


            </tbody>
        </table>
    </div>
</div>

<div region="center" style="overflow: hidden;width: 100%;">
    <div id="toolbar" style="padding:5px" class="cg-moreBox">
    <@shiro.hasPermission name="/report/demo1/export">
        <a href="#" onclick="exportDatagrid('${base}/report/operation/mileageMonitor/downloadPopup?query.data1='+'${data1}'+'&query.data2='+'${data2}'+'&query.endTime='+'${endTime}'+'&query.cheLiangMing='+'${cheLiangMing}'+'&query.yunYing='+'${yunYing}','form_search','table')" class="easyui-linkbutton"
           data-options="iconCls:'icon-export'" menu="0">导出</a>
    </@shiro.hasPermission>

        <a href="#" onclick="openDailog()" data-options="iconCls:'icon-export'" menu="0" style="float: right;margin-top:6px;margin-right: 100px">报表说明</a>
    </div>
    <div id="table" name="datagrid" style="width: 100%; height: 100%;"></div>
</div>

<div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 60px; overflow-y: hidden;">
    <div style="width: 100%;border: 1;margin:5 5 5 10 ">
        <form id="form_search" name="" class="sui-form cg-form">
            <table class="table_search">
                <tr>
                    <td class="td_label">
                        <label>车辆阶段：</label>
                    </td>
                    <td class="td_input">

                        <input type="text"   class="input-fat input" style="width:168px;"   id="jieDuan" name="query.jieDuan"  autocomplete="off" >
                    </td>

                    <td class="td_label">
                        <label>总里程（仪表）大于（km）：</label>
                    </td>
                    <td class="td_input">

                        <input type="text"class="input-fat input"  style="width:150px;" onkeyup="value=value.replace(/[^\d]/g,'')"   name="query.zongLiCheng"  autocomplete="off" >

                    </td>
                    <td class="td_label"  >
                        <label>总有效里程大于（km）：</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" style="width:150px;" onkeyup="value=value.replace(/[^\d]/g,'')"   name="query.zongYouXiao"  autocomplete="off" >
                    </td>
                    <td class="td_label">
                        <label>总轨迹里程大于（km）：</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" style="width:150px;"    onkeyup="value=value.replace(/[^\d]/g,'')"   name="query.zongGuiJi"  autocomplete="off" >
                    </td>

                    <td class="td_label">
                        <label>总在线里程大于（km）：</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" style="width:150px;"  onkeyup="value=value.replace(/[^\d]/g,'')"  name="query.zongZaiXian"  autocomplete="off" >
                    </td>
                    <td class="td_label">
                        <label>总核算里程大于（km）：</label>
                    </td>
                    <td class="td_input">
                        <input type="text"class="input-fat input" style="width:150px;"  onkeyup="value=value.replace(/[^\d]/g,'')"  name="query.zongHeSuan"  autocomplete="off" >
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

</body>
<script>

    function initTable() {
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
    }

    function search_item(){
        var data=$("#form_search").serializeObject();
        $("#table").datagrid("load", data);
    }

    /*报表说明弹框*/
    function openDailog(){
        $('#reportDialog').window("open");
    }

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