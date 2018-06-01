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
                                <input type="text" name="query.sbeginDate" value="2018-01-01" id="sbeginDate" style="height: 30px;width: 168px" class="easyui-datebox" data-options="editable:false"/>
                                <input type="hidden" value="2018-01-01" name="query.beginDate" id="beginDate"/>
                                至
                                <input type="text" name="query.sendDate" value="2018-07-01" id="sendDate" style="height: 30px;width: 168px" class="easyui-datebox" data-options="editable:false"/>
                                <input type="hidden" value="2018-07-01" name="query.endDate" id="endDate"/>
                            </td>
                            <td class="td_label">
                                <label>车辆种类：</label>
                            </td>
                            <td class="td_input">
                                <select id="vehTypeId" name="query.vehTypeId" class="easyui-combobox" style="width:168px;">
                                    <option value="aa">aitem1</option>
                                    <option>bitem2</option>
                                    <option>bitem3</option>
                                    <option>ditem4</option>
                                    <option>eitem5</option>
                                </select>
                            </td>
                            <td class="td_label">
                                <label>车辆型号：</label>
                            </td>
                            <td class="td_input">
                                <select id="vehModelName" name="query.vehModelName" class="easyui-combobox" style="width:168px;">
                                    <option value="aa">aitem1</option>
                                    <option>bitem2</option>
                                    <option>bitem3</option>
                                    <option>ditem4</option>
                                    <option>eitem5</option>
                                </select>
                            </td>
                            <td class="td_label">
                                <label>运营单位：</label>
                            </td>
                            <td class="td_input">
                                <select id="useUnitId" name="query.useUnitId" class="easyui-combobox" style="width:168px;">
                                    <option value="aa">aitem1</option>
                                    <option>bitem2</option>
                                    <option>bitem3</option>
                                    <option>ditem4</option>
                                    <option>eitem5</option>
                                </select>
                            </td>
                            <td class="td_label">
                                <label>上牌区域：</label>
                            </td>
                            <td class="td_input">
                                <#--<select id="areaId" name="query.areaId" class="easyui-combobox" style="width:168px;">-->
                                <#--<select id="areaId" name="query.areaId" class="easyui-combotree" style="width:168px;"-->
                                        <#--data-options="url:'${base}/report/operation/dayStatistics/queryAreaList', required:true">-->
                                <#--</select>-->
                                <input id="areaId" name="query.areaId" />
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
        $('#areaId').combotree({
            url: '${base}/report/common/queryAreaList',
            required:true
        });
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
                    {title: '车辆录入总数（辆）', field: 'dayCount', align:'center', width: '20%', sortable: false},
                    {title: '新增录入车辆数（辆）', field: 'newVehCount', align:'center', width: '20%', sortable: false},
                    {title: '未监控车辆数（辆）', field: 'notOnlineCount', align:'center', width: '20%', sortable: false},
                    {title: '监控比例（%）', field: 'phone', align:'center', width: '18%', sortable: false,  formatter: function(val, row, index){
                        if (undefined != row.dayCount && undefined != row.notOnlineCount && row.dayCount > 0) {
                            return ((parseInt(row.dayCount) - parseInt(row.notOnlineCount)) / parseInt(row.dayCount)).toFixed(2);
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
     * 导出
     * @param id
     */
    function exportExcel(id) {

    }

</script>
</html>