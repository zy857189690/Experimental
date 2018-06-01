<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <<#include "../../../../inc/meta.ftl">
    <<#include "../../../../inc/js.ftl">
    <style type="text/css">
        .td_input a:not(.bg_button) {
            right: 20px !important;
        }
    </style>
</head>
<body>
<div id="tt" class="easyui-tabs" style="width: 99%; height: 950px; margin: 10px;">
    <div title="车辆监控情况统计" data-options="iconCls:'icon-reload'" style="padding: 20px; display: none;" >
        <div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 90px">
            <div style="width: 100%;border: 1;margin:5 5 5 10 ">
                <form id="form_search" name="" class="sui-form cg-form">
                    <table class="table_search">
                        <tr>
                            <td class="td_label">
                                <label>查询时间：</label>
                            </td>
                            <td class="td_input">
                                <input type="text" name="query.sbeginDate" value="2018-01-01" id="sbeginDate" style="height: 30px; width: 168px" class="easyui-datebox" data-options="editable:false"/>
                                <input type="hidden" value="2018-01-01" name="query.beginDate" id="beginDate"/>
                                至
                                <input type="text" name="query.sendDate" value="2018-07-01" id="sendDate" style="height: 30px;width: 168px" class="easyui-datebox" data-options="editable:false"/>
                                <input type="hidden" value="2018-07-01" name="query.endDate" id="endDate"/>
                            </td>
                            <td class="td_label">
                                <label>车辆种类：</label>
                            </td>
                            <td class="td_input">
                                <input id="vehTypeId" name="query.vehTypeId" style="width: 170px;" />
                            </td>
                            <td class="td_label">
                                <label>车辆型号：</label>
                            </td>
                            <td class="td_input">
                                <input id="vehModelName" name="query.vehModelName" style="width: 170px;" />
                            </td>
                            <td class="td_label">
                                <label>运营单位：</label>
                            </td>
                            <td class="td_input">
                                <input id="useUnitId" name="query.useUnitId" style="width: 170px;"/>
                            </td>
                            <td class="td_label">
                                <label>上牌区域：</label>
                            </td>
                            <td class="td_input">
                                <input id="areaId" name="query.areaId" style="width: 170px;"/>
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
        <div region="center" style="overflow: hidden; width: 100%; height: 500px;">
            <div id="toolbar" style="padding:5px">
                <a href="#" onclick="exportExcel('monitoring')" class="easyui-linkbutton">&nbsp;&nbsp;导出&nbsp;&nbsp;</a>
            </div>
            <div id="monitoringTable" name="monitoringTable" style="width: 100%;height: 100%"></div>
        </div>
    </div>
    <div title="车辆活跃情况统计" data-options="iconCls:'icon-reload',closable:true" style="overflow: auto; padding: 20px; display: none;">
        车辆活跃情况统计
    </div>
    <div title="车辆行驶情况统计" data-options="iconCls:'icon-reload',closable:true" style="padding: 20px; display: none;">
        车辆行驶情况统计
    </div>
    <div title="车辆闲置情况统计" data-options="iconCls:'icon-reload',closable:true" style="padding: 20px; display: none;">
        车辆闲置情况统计
    </div>
    <div title="充耗电情况统计" data-options="iconCls:'icon-reload',closable:true" style="padding: 20px; display: none;">
        充耗电情况统计
    </div>
</div>
</body>
<script language="javascript">
    var monitoringTable;//车辆监控情况统计表格

    $(function(){

        initSelectChoose();
        loadMonitoringTable({});
    });
    /**
     * 初始化车辆监控情况统计表格
     **/
    function loadMonitoringTable(data) {
        if (null != monitoringTable && undefined != monitoringTable) {
            $('#monitoringTable').datagrid("load", data);
        } else {
            monitoringTable = $('#monitoringTable').datagrid({
                url: '${base}/report/operation/dayStatistics/queryMonitoringTable',
//                queryParams: $("#form_search").serializeObject(),
                sortName: "",
                sortOrder: "",
                columns: [[
                    {title: '日期', field: 'reportDate', align:'center', width: '20%', sortable: false},
                    {title: '车辆录入总数（辆）', field: 'dayCount', align:'center', width: '20%', sortable: false, formatter: function(val, row, index){
                        if (undefined != val && parseInt(val) > 0) {
                            return "<a href='javascript:void(0);' onclick='showVehListByDialog()'>" + val + "</a>";
                        }
                        return val;
                    }},
                    {title: '新增录入车辆数（辆）', field: 'newVehCount', align:'center', width: '20%', sortable: false, formatter: function(val, row, index){
                        if (undefined != val && parseInt(val) > 0) {
                            return "<a href='javascript:void(0);' onclick='showVehListByDialog()'>" + val + "</a>";
                        }
                        return val;
                    }},
                    {title: '通讯异常车辆数（辆）', field: 'notOnlineCount', align:'center', width: '20%', sortable: false, formatter: function(val, row, index){
                        if (undefined != val && parseInt(val) > 0) {
                            return "<a href='javascript:void(0);' onclick='showVehListByDialog()'>" + val + "</a>";
                        }
                        return val;
                    }},
                    {title: '正常监控车辆比例（%）', field: 'phone', align:'center', width: '18%', sortable: false, formatter: function(val, row, index){
                        if (undefined != row.dayCount && undefined != row.notOnlineCount && row.dayCount > 0) {
                            return ((parseInt(row.dayCount) - parseInt(row.notOnlineCount)) / parseInt(row.dayCount)).toFixed(2) + "%";
                        }
                        return "-";
                    }},
                ]],
                pagination: true,
                nowrap: true,
                rownumbers: true
            });
        }
    }

    /**
     * 弹框展示相关车辆列表
     **/
    function showVehListByDialog() {

    }

    /**
     * 导出
     * @param id
     */
    function exportExcel(id) {

    }

    /**
     * 初始化下拉选择框
     */
    function initSelectChoose() {
        //上牌区域
        $('#areaId').combotree({
            url: '${base}/report/common/queryAreaList'
        });
        //运营单位
        $('#useUnitId').combotree({
            url: '${base}/report/common/queryUnitList'
        });
        //车辆型号
        $('#vehModelName').combobox({
            url: '${base}/report/common/queryVehModelList',
            valueField: 'id',
            textField: 'text'
        });
        //车辆种类
        $('#vehTypeId').combotree({
            url: '${base}/report/common/queryVehTypeList'
        });
    }

</script>
</html>