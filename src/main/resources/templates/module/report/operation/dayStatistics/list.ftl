<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <#include "../../../../inc/meta.ftl">
    <#include "../../../../inc/js.ftl">
    <title>车辆运行统计</title>
    <style type="text/css">
        .td_input a:not(.bg_button) {
            right: 20px !important;
        }
        .cg-form {
            padding: 10px 6px;
            border-bottom: 1px solid #caccce;
        }
        .tabs-panels .panel-body>div:first-child {
            border-bottom: 1px solid #caccce;
        }
        .tabs-panels {
            border-bottom: none;
        }
    </style>
</head>
<body class="easyui-layout" fit="true">
<div region="center" style="overflow: hidden; width: 100%;">
    <div id="tt" class="easyui-tabs" style="width: 100%; height: 100%;">
        <div id="monitoringDiv" title="车辆监控情况统计" style="display: none;" >
            <div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 50px">
                <div style="width: 100%;border: 1;margin:5 5 5 10 ">
                    <form id="form_search1" name="" class="sui-form cg-form">
                        <input type="hidden" id="tabId" name="query.tabId" value="monitoring" />
                        <input type="hidden" id="excelName" name="query.excelName" value="exportMonitoring" />
                        <input type="hidden" id="funcName" name="query.funcName" value="queryMonitoringTable" />
                        <input type="hidden" id="excelTitle" name="query.excelTitle" value="车辆监控情况统计" />
                        <span>查询时间：</span>
                        <input type="text" name="query.beginDate" value="${beginDate!}" id="beginDate" style="height: 30px; width: 168px" class="easyui-datebox" data-options="editable:false"/>
                        &nbsp;&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" name="query.endDate" value="${endDate!}" id="endDate" style="height: 30px;width: 168px" class="easyui-datebox" data-options="editable:false"/>
                        <a href="#" onclick="loadMonitoringTable()" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="margin-left: 20px;">查询</a>
                        <a href="#" onclick="resetSearch('monitoring')" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>
                    </form>
                </div>
            </div>
            <div region="center" style="overflow: hidden; width: 100%; height: calc(100vh - 80px);">
                <div id="monitoringToolbar" class="cg-moreBox" style="padding:5px">
                    <a href="#" onclick="exportDatagrid('${base}/report/operation/dayStatistics/export','form_search1', 'monitoringTable')" class="easyui-linkbutton" data-options="iconCls:'icon-export'">
                        导出
                    </a>
                    <a href="#" onclick="openExplainDialog('monitoring')" style="float: right; margin-right: 120px; margin-top: 5px;">列表说明</a>
                </div>
                <div id="monitoringTable" name="monitoringTable" style="width: 100%; height: 100%"></div>
            </div>
        </div>
        <div id="activeDiv" title="车辆活跃情况统计" style="overflow: auto; display: none;">
            <div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 50px">
                <div style="width: 100%;border: 1;margin:5 5 5 10 ">
                    <form id="form_search2" name="" class="sui-form cg-form">
                        <input type="hidden" id="tabId" name="query.tabId" value="active" />
                        <input type="hidden" id="excelName" name="query.excelName" value="exportActive" />
                        <input type="hidden" id="funcName" name="query.funcName" value="queryActiveTable" />
                        <input type="hidden" id="excelTitle" name="query.excelTitle" value="车辆活跃情况统计" />
                        <span>查询时间：</span>
                        <input type="text" name="query.beginDate" value="${beginDate!}" id="beginDate" style="height: 30px; width: 168px" class="easyui-datebox" data-options="editable:false"/>
                        &nbsp;&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" name="query.endDate" value="${endDate!}" id="endDate" style="height: 30px;width: 168px" class="easyui-datebox" data-options="editable:false"/>
                        <a href="#" onclick="loadActiveTable()" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="margin-left: 20px;">查询</a>
                        <a href="#" onclick="resetSearch('active')" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>
                    </form>
                </div>
            </div>
            <div region="center" style="overflow: hidden; width: 100%;height: calc(100vh - 80px);">
                <div id="activeToolbar" class="cg-moreBox" style="padding:5px">
                    <a href="#" onclick="exportDatagrid('${base}/report/operation/dayStatistics/export','form_search2', 'activeTable')" class="easyui-linkbutton" data-options="iconCls:'icon-export'">
                        导出
                    </a>
                    <a href="#" onclick="openExplainDialog('active')" style="float: right; margin-right: 120px; margin-top: 5px;">列表说明</a>
                </div>
                <div id="activeTable" name="activeTable" style="width: 100%;height: 100%"></div>
            </div>
        </div>
        <div id="idleDiv" title="车辆闲置情况统计" style="display: none;">
            <div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 175px">
                <div style="width: 100%; height: 30px;">
                    <span style="margin-left: 10px;"><b>车辆闲置情况统计</b></span>
                    <a href="javascript:void(0)" onclick="$('#idleConditionDialg').dialog('open');" style="margin-left: 200px; margin-top: 10px;">设置闲置车辆统计条件</a>
                </div>
                <div style="width: 100%; height: 30px;">
                    <div id="idleTileMessage" style="margin-left: 10px;">
                        闲置车辆统计总：-年-月-日 ~ -年-月-日，长期闲置车辆数-辆，展车辆总数比例为-%
                    </div>
                </div>
                <div style="width: 100%; height: 30px;">
                    <span style="margin-left: 10px;"><b>闲置车辆详情</b></span>
                </div>
                <div style="width: 100%;border: 1;margin:5 5 5 10 ">
                    <form id="form_search3" name="" class="sui-form cg-form">
                        <input type="hidden" id="tabId" name="query.tabId" value="idle" />
                        <input type="hidden" id="excelName" name="query.excelName" value="exportIdle" />
                        <input type="hidden" id="funcName" name="query.funcName" value="queryIdleTable" />
                        <input type="hidden" id="excelTitle" name="query.excelTitle" value="车辆闲置情况统计" />
                        <input type="hidden" id="idleBeginDate" name="query.beginDate" />
                        <input type="hidden" id="idleEndDate" name="query.endDate" />
                        <input type="hidden" id="idleMileageValue" name="query.idleMileageValue" />
                        <table class="table_search">
                            <tr>
                                <td class="td_label" style="text-align: right;">
                                    <label>车牌号：</label>
                                </td>
                                <td class="td_input">
                                    <input type="text" name="query.idlePlate" id="idlePlate" class="input-fat input" style="width:150px;" />
                                </td>
                                <td class="td_label" style="text-align: right;">
                                    <label>VIN码：</label>
                                </td>
                                <td class="td_input">
                                    <input type="text" name="query.idleVIN" id="idleVIN" class="input-fat input" style="width:150px;" />
                                </td>
                                <td class="td_label" style="text-align: right;">
                                    <label>里程大于：</label>
                                </td>
                                <td class="td_input">
                                    <input type="text" name="query.idleMileage" id="idleMileage" class="input-fat input" style="width:150px;"
                                           onkeyup="value=value.replace(/[^\d]/g,'')" placeholder="请输入公里数（km）"/>
                                </td>
                                <td class="td_label" style="text-align: right;">
                                    <label>车辆阶段：</label>
                                </td>
                                <td class="td_input">
                                    <input id="idleVehStage" name="query.idleVehStage" style="width: 168px;"/>
                                </td>
                                <td class="td_label" style="text-align: right;">
                                    <label>运营单位：</label>
                                </td>
                                <td class="td_input">
                                    <input id="idleUseUnitId" name="query.idleUseUnitId" style="width: 168px;"/>
                                </td>
                                <td class="td_label" style="text-align: right;">
                                    <label>上牌城市：</label>
                                </td>
                                <td class="td_input">
                                    <input id="idleAreaId" name="query.idleAreaId" style="width: 168px;"/>
                                </td>
                                <td class="td_label" style="text-align: right;">
                                    <label>车辆种类：</label>
                                </td>
                                <td class="td_input">
                                    <input id="idleVehTypeId" name="query.idleVehTypeId" style="width: 168px;"/>
                                </td>
                                <td class="td_label" style="text-align: right;">
                                    <label>车辆公告型号：</label>
                                </td>
                                <td class="td_input">
                                    <input id="idleModelNoticeId" name="query.idleModelNoticeId" style="width: 168px;"/>
                                </td>
                                <td style="vertical-align: center;text-align: right;border: 1px" class="cg-btnGroup">
                                <#--<a href="#" onclick="search_item()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>                   -->
                                <#--<a href="#" onclick="reset_common(search_item)" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>-->
                                    <a href="#" onclick="loadIdleTable()" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="margin-left: 20px;">查询</a>
                                    <a href="#" onclick="resetSearch('idle')" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
            <div region="center" style="overflow: hidden; width: 100%;height: calc(100vh - 204px);">
                <div id="idleToolbar" class="cg-moreBox" style="padding:5px">
                    <a href="#" onclick="exportDatagrid('${base}/report/operation/dayStatistics/export','form_search3', 'idleTable')" class="easyui-linkbutton" data-options="iconCls:'icon-export'">
                        导出
                    </a>
                    <a href="#" onclick="openExplainDialog('idle')" style="float: right; margin-right: 120px; margin-top: 5px;">列表说明</a>
                </div>
                <div id="idleTable" name="idleTable" style="width: 100%;height: 100%"></div>
            </div>
        </div>
        <div id="travelDiv" title="车辆行驶情况统计" style="display: none;">
            <div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 50px">
                <div style="width: 100%;border: 1;margin:5 5 5 10 ">
                    <form id="form_search4" name="" class="sui-form cg-form">
                        <input type="hidden" id="tabId" name="query.tabId" value="travel" />
                        <input type="hidden" id="excelName" name="query.excelName" value="exportTravel" />
                        <input type="hidden" id="funcName" name="query.funcName" value="queryTravelTable" />
                        <input type="hidden" id="excelTitle" name="query.excelTitle" value="车辆行驶情况统计" />
                        <span>查询时间：</span>
                        <input type="text" name="query.beginDate" value="${beginDate!}" id="beginDate" style="height: 30px; width: 168px" class="easyui-datebox" data-options="editable:false"/>
                        &nbsp;&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" name="query.endDate" value="${endDate!}" id="endDate" style="height: 30px;width: 168px" class="easyui-datebox" data-options="editable:false"/>
                        <a href="#" onclick="loadTravelTable()" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="margin-left: 20px;">查询</a>
                        <a href="#" onclick="resetSearch('travel')" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>
                    </form>
                </div>
            </div>
            <div region="center" style="overflow: hidden; width: 100%;height: calc(100vh - 80px);">
                <div id="travelToolbar" class="cg-moreBox" style="padding:5px">
                    <a href="#" onclick="exportDatagrid('${base}/report/operation/dayStatistics/export','form_search4', 'travelTable')" class="easyui-linkbutton" data-options="iconCls:'icon-export'">
                        导出
                    </a>
                    <a href="#" onclick="openExplainDialog('travel')" style="float: right; margin-right: 120px; margin-top: 5px;">列表说明</a>
                </div>
                <div id="travelTable" name="travelTable" style="width: 100%;height: 100%"></div>
            </div>
        </div>
        <div id="electricityDiv" title="充耗电情况统计" style="display: none;">
            <div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 50px">
                <div style="width: 100%;border: 1;margin:5 5 5 10 ">
                    <form id="form_search5" name="" class="sui-form cg-form">
                        <input type="hidden" id="tabId" name="query.tabId" value="electricity" />
                        <input type="hidden" id="excelName" name="query.excelName" value="exportElectricity" />
                        <input type="hidden" id="funcName" name="query.funcName" value="queryElectricityTable" />
                        <input type="hidden" id="excelTitle" name="query.excelTitle" value="充耗电情况统计" />
                        <span>查询时间：</span>
                        <input type="text" name="query.beginDate" value="${beginDate!}" id="beginDate" style="height: 30px; width: 168px" class="easyui-datebox" data-options="editable:false"/>
                        &nbsp;&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" name="query.endDate" value="${endDate!}" id="endDate" style="height: 30px;width: 168px" class="easyui-datebox" data-options="editable:false"/>
                        <a href="#" onclick="loadElectricityTable()" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="margin-left: 20px;">查询</a>
                        <a href="#" onclick="resetSearch('electricity')" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>
                    </form>
                </div>
            </div>
            <div region="center" style="overflow: hidden; width: 100%;height: calc(100vh - 80px);">
                <div id="electricityToolbar" class="cg-moreBox" style="padding:5px">
                    <a href="#" onclick="exportDatagrid('${base}/report/operation/dayStatistics/export','form_search5', 'electricityTable')" class="easyui-linkbutton" data-options="iconCls:'icon-export'">
                        导出
                    </a>
                    <a href="#" onclick="openExplainDialog('electricity')" style="float: right; margin-right: 120px; margin-top: 5px;">列表说明</a>
                </div>
                <div id="electricityTable" name="electricityTable" style="width: 100%;height: 100%"></div>
            </div>
        </div>
    </div>
</div>
<#--相关车辆详情弹出框-->
<div id="vehListDialg" class="easyui-dialog" title="车辆列表" style="width: 1020px; height: 495px;"
     data-options="iconCls:'',closed: true, resizable:false, modal:true">
    <div class="easyui-layout" style="width: 100%; height: 100%;">
        <div class="easyui-panel" title="" style="height: 70px;">
            <div style="width: 90%; height: 30px; margin-top: 20px; margin-left: 20px">
                <form id="vehListDialogForm">
                    <span>车辆阶段：</span>
                    <input id="diaVehStage" name="query.diaVehStage" style="width: 150px;"/>
                    <span style="margin-left: 20px;">车辆公告型号：</span>
                    <input type="text" id="diaModelNaticeId" name="query.diaModelNaticeId" class="easyui-textbox" style="width: 150px;" />
                    <input type="hidden" id="tabId" name="query.tabId" value="dialog" />
                    <input type="hidden" id="excelName" name="query.excelName" value="exportDialog" />
                    <input type="hidden" id="funcName" name="query.funcName" value="" />
                    <input type="hidden" id="excelTitle" name="query.excelTitle" value="" />
                    <input type="hidden" id="searchType" name="query.searchType" value="" />
                    <input type="hidden" id="reportDate" name="query.reportDate" value="" />
                    <a href="#" onclick="searchByDialog()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
                    <#--<a href="#" onclick="exportDatagrid('${base}/report/operation/dayStatistics/export','vehListDialogForm', 'diaSearchTable')" class="easyui-linkbutton" style="text-align: right;">&nbsp;&nbsp;&nbsp;导出&nbsp;&nbsp;&nbsp;</a>-->
                </form>
            </div>
        </div>
        <div class="easyui-panel" title="" style="height:380px;">
            <div id="vehListDialgToolbar" class="cg-moreBox" style="padding:5px">
                <a href="#" onclick="exportDatagrid('${base}/report/operation/dayStatistics/export','vehListDialogForm', 'diaSearchTable')" class="easyui-linkbutton" data-options="iconCls:'icon-export'" style="margin-left: 10px;">
                    导出
                </a>
            </div>
            <div id="diaSearchTable" name="diaSearchTable" style="width: 100%;height: 100%"></div>
        </div>
    </div>
</div>
</body>
<script language="javascript">
    var defaultBeginDate = "${beginDate!}";
    var defaultEndDate = "${endDate!}";
    var monitoringTable;//车辆监控情况统计表格
    var activeTable;//车辆活跃情况统计表格
    var idleTable;//车辆闲置情况统计表格
    var travelTable;//车辆行驶情况统计表格
    var electricityTable;//充耗电情况统计表格
    var diaSearchTable;//弹出框表格
    var currentTabPageId = "monitoring";//当前展示的tab页id
    var idleMileageValue = "";//闲置车辆统计条件-闲置里程阈值
    var idleBeginDate = "";//闲置车辆统计条件-统计开始时间
    var idleEndDate = "";//闲置车辆统计条件-统计结束时间

    $(function() {
        $('#tt').tabs({
            onSelect: function(title, index) {
                if (index == 0) {
                    currentTabPageId = "monitoring";
                    loadMonitoringTable();
                } else if (index == 1) {
                    currentTabPageId = "active";
                    loadActiveTable();
                } else if (index == 2) {
                    //loadIdleTable();
                    currentTabPageId = "idle";
                    searchIdleByMileageValue();
                } else if (index == 3) {
                    currentTabPageId = "travel";
                    loadTravelTable();
                } else if (index == 4) {
                    currentTabPageId = "electricity";
                    loadElectricityTable();
                }
            }
        });
        initSelectChoose();
        loadMonitoringTable();
    });

    /**
     * 初始化车辆监控情况统计表格
     **/
    function loadMonitoringTable() {

        if (!checkBeginAndEndDate("form_search1")) {
            return;
        }
        if (null != monitoringTable && undefined != monitoringTable) {
            $('#monitoringTable').datagrid("load", $("#form_search1").serializeObject());
        } else {
            monitoringTable = $('#monitoringTable').datagrid({
                url: '${base}/report/operation/dayStatistics/queryMonitoringTable',
                queryParams: $("#form_search1").serializeObject(),
                sortName: "",
                sortOrder: "",
                columns: [[
                    {title: '日期', field: 'reportDate', align: 'center', width: '20%', sortable: false},
                    {title: '车辆录入总数（辆）', field: 'dayCount', align: 'center', width: '20%', sortable: false, formatter: function(val, row, index){
                        if (undefined != val && parseInt(val) > 0) {
                            return "<a href='javascript:void(0);' onclick=\"showVehListByDialog('dayCount', '车辆录入总数（辆）', '" + row.reportDate + "')\">" + val + "</a>";
                        }
                        return val;
                    }},
                    {title: '新增录入车辆数（辆）', field: 'newVehCount', align: 'center', width: '20%', sortable: false, formatter: function(val, row, index){
                        if (undefined != val && parseInt(val) > 0) {
                            return "<a href='javascript:void(0);' onclick=\"showVehListByDialog('newVehCount', '新增录入车辆数（辆）', '" + row.reportDate + "')\">" + val + "</a>";
                        }
                        return val;
                    }},
                    {title: '通讯异常车辆数（辆）', field: 'notOnlineCount', align: 'center', width: '20%', sortable: false, formatter: function(val, row, index){
                        if (undefined != val && parseInt(val) > 0) {
                            return "<a href='javascript:void(0);' onclick=\"showVehListByDialog('notOnlineCount', '通讯异常车辆数（辆）', '" + row.reportDate + "')\">" + val + "</a>";
                        }
                        return val;
                    }},
                    {title: '正常监控车辆比例（%）', field: 'ratio', align: 'center', width: '20%', sortable: false, formatter: function(val, row, index){
                        if (undefined != row.dayCount && undefined != row.notOnlineCount && row.dayCount > 0) {
                            return ((parseInt(row.dayCount) - parseInt(row.notOnlineCount)) * 100 / parseInt(row.dayCount)).toFixed(2);
                        }
                        return "-";
                    }},
                ]],
                toolbar:"#monitoringToolbar",
                pagination: true,
                nowrap: true,
                rownumbers: true
            });
            toolbar2Menu("monitoringTable");
        }
    }

    /**
     * 初始化车辆活跃情况统计表格
     **/
    function loadActiveTable() {
        if (!checkBeginAndEndDate("form_search2")) {
            return;
        }
        var data = $("#form_search2").serializeObject();
        if (null != activeTable && undefined != activeTable) {
            $('#activeTable').datagrid("load", data);
        } else {
            activeTable = $('#activeTable').datagrid({
                url: '${base}/report/operation/dayStatistics/queryActiveTable',
                queryParams: data,
                sortName: "",
                sortOrder: "",
                columns: [[
                    {title: '日期', field: 'reportDate', align: 'center', width: '15%', sortable: false},
                    {title: '车辆录入总数', field: 'dayCount', align: 'center', width: '15%', sortable: false},
                    {title: '当天活跃车辆总数', field: 'dayActiveCount', align: 'center', width: '15%', sortable: false, formatter: function(val, row, index){
                        if (undefined != val && val > 0) {
                            return "<a href='javascript:void(0);' onclick=\"showVehListByDialog('dayActiveCount', '当天活跃车辆总数', '" + row.reportDate + "')\">" + val + "</a>";
                        }
                        return val;
                    }},
                    {title: '活跃率（%）', field: 'activeRate', align: 'center', width: '10%', sortable: false, formatter: function(val, row, index){
                        if (undefined != row.dayActiveCount && undefined != row.dayCount && row.dayCount > 0) {
                            return ((row.dayActiveCount / row.dayCount) * 100).toFixed(2);
                        }
                        return "-";
                    }},
                    {title: '里程异常数（辆）', field: 'abnormalVehCount', align: 'center', width: '15%', sortable: false, formatter: function(val, row, index){
                        if (undefined != val && parseInt(val) > 0) {
                            return "<a href='javascript:void(0);' onclick=\"showVehListByDialog('abnormalVehCount', '里程异常数（辆）', '" + row.reportDate + "')\">" + val + "</a>";
                        }
                        return val;
                    }},
                    {title: '里程异常比例（%）', field: 'abnormalRate', align: 'center', width: '15%', sortable: false, formatter: function(val, row, index){
                        if (undefined != row.abnormalVehCount && undefined != row.dayCount && row.dayCount > 0) {
                            return ((row.abnormalVehCount / row.dayCount) * 100).toFixed(2);
                        }
                        return "-";
                    }},
                    {title: '单车日均活跃时间', field: 'activeTime', align: 'center', width: '15%', sortable: false, formatter: function(val, row, index){
                        if (undefined != row.activeTimeCount && undefined != row.dayActiveCount && row.dayActiveCount > 0) {
                            return (row.activeTimeCount / row.dayActiveCount).toFixed(2);
                        }
                        return "-";
                    }}
                ]],
                toolbar:"#activeToolbar",
                pagination: true,
                nowrap: true,
                rownumbers: true
            });
            toolbar2Menu("activeTable");
        }
    }

    /**
     * 初始化车辆闲置情况统计表格
     **/
    function loadIdleTable() {
        $("#idleBeginDate").val(idleBeginDate);
        $("#idleEndDate").val(idleEndDate);
        $("#idleMileageValue").val(idleMileageValue);
        var modelVal = $("#idleModelNoticeId").combobox('getText');
        var modelId = $("#idleModelNoticeId").combobox('getValue');
        if (modelVal != "" && modelId == "") {
            $.messager.alert("提示", "请选择正确的车辆公告型号！");
            return;
        }
        var data = $("#form_search3").serializeObject();
        if (null != idleTable && undefined != idleTable) {
            $('#idleTable').datagrid("load", data);
        } else {
            idleTable = $('#idleTable').datagrid({
                url: '${base}/report/operation/dayStatistics/queryIdleTable',
                queryParams: data,
                sortName: "",
                sortOrder: "",
                frozenColumns:[[
                    {title: 'VIN', field: 'vin', align: 'center', width: 150, sortable: false, halign: 'center'},
                    {title: '车牌号', field: 'plate', align: 'center', width: 150, sortable: false, halign: 'center'},
                ]],
                columns: [[
                    {title: '上牌城市', field: 'areaName', align: 'center', width: 150, sortable: false, halign: 'center'},
                    {title: '车辆种类', field: 'vehTypeName', align: 'center', width: 150, sortable: false, halign: 'center'},
                    {title: '运营单位', field: 'useUnitName', align: 'center', width: 150, sortable: false, halign: 'center'},
                    {title: '车辆公告型号', field: 'modelNoticeId', align: 'center', width: 150, sortable: false, halign: 'center'},
                    {title: '车辆阶段', field: 'vehStage', align: 'center', width: 140, sortable: false, halign: 'center'},
                    {title: '录入时间', field: 'entryDate', align: 'center', width: 150, sortable: false, halign: 'center'},
                    {title: '闲置里程（km）', field: 'xzlc', align: 'center', width: 150, sortable: false, halign: 'center'},
                    {title: '最后通讯时间', field: 'lastCommitTime', align: 'center', width: 150, sortable: false, halign: 'center'},
                    {title: '最后通讯里程', field: 'lastEndMileage', align: 'center', width: 150, sortable: false, halign: 'center'}
                ]],
                toolbar:"#idleToolbar",
                pagination: true,
                nowrap: true,
                rownumbers: true
            });
            toolbar2Menu("idleTable");
        }
    }

    /**
     * 闲置车辆统计条件设置查询
     **/
    function searchIdleByMileageValue() {
        if (!checkBeginAndEndDate("idleConditionDialg")) {
            return;
        }
        idleMileageValue = $("#idleConditionDialg #idleMileageValue").val();
        if (idleMileageValue == "") {
            $.messager.alert("提示", "闲置里程阈值不可为空！");
            return;
        }
        idleBeginDate = $("#idleConditionDialg #beginDate").datebox('getValue');
        idleEndDate = $("#idleConditionDialg #endDate").datebox('getValue');
        var data = {};
        data['query.beginDate'] = idleBeginDate;
        data['query.endDate'] = idleEndDate;
        data['query.idleMileageValue'] = idleMileageValue;
        $.ajax({
            url: '${base}/report/operation/dayStatistics/queryIdleByMileageValue',
            type: "post",
            data: data,
            dataType: 'json',
            success: function(data) {
                var html = "闲置车辆统计总述：";
                var bd = idleBeginDate.split("-");
                html += bd[0] + "年" + bd[1] + "月" + bd[2] + "日 ~ ";
                var ed = idleEndDate.split("-");
                html += ed[0] + "年" + ed[1] + "月" + ed[2] + "日，";
                html += "长期闲置车辆数";
                var idleVehNum = "-";
                var ratio = "-";
                if (null != data && undefined != data.idleVehNum && undefined != data.vehCount) {
                    idleVehNum = data.idleVehNum;
                    var vehCount = data.vehCount;
                    if (idleVehNum != "" && vehCount != "" && vehCount > 0) {
                        ratio = ((idleVehNum / vehCount) * 100).toFixed(2);
                    }
                    loadIdleTable();
                    $('#idleConditionDialg').dialog('close');
                    //$.messager.alert("提示", "闲置车辆统计条件设置成功！");
                } else {
                    $.messager.alert("提示", "闲置车辆统计条件设置失败，请刷新后重试！");
                }
                html += idleVehNum + "辆，占车辆总数比例为" + ratio + "%";
                $("#idleTileMessage").html(html);
            }
        });
    }

    /**
     * 初始化车辆行驶情况统计表格
     **/
    function loadTravelTable() {
        if (!checkBeginAndEndDate("form_search4")) {
            return;
        }
        var data = $("#form_search4").serializeObject()
        if (null != travelTable && undefined != travelTable) {
            $('#travelTable').datagrid("load", data);
        } else {
            travelTable = $('#travelTable').datagrid({
                url: '${base}/report/operation/dayStatistics/queryTravelTable',
                queryParams: data,
                sortName: "",
                sortOrder: "",
                columns: [[
                    {title: '日期', field: 'reportDate', align: 'center', width: '20%', sortable: false},
                    {title: '日总行驶时间（h）', field: 'dayTravelTime', align: 'center', width: '15%', sortable: false, formatter: function(val, row, index){
                        if (undefined != val && val > 0) {
                            return val.toFixed(2);
                        }
                        return val;
                    }},
                    {title: '单车平均行驶时间', field: 'vehAverageTime', align: 'center', width: '15%', sortable: false, formatter: function(val, row, index){
                        if (undefined != row.dayTravelTime && undefined != row.vehOnlineCount && parseInt(row.vehOnlineCount) > 0) {
                            return (row.dayTravelTime / row.vehOnlineCount).toFixed(2);
                        }
                        return "-";
                    }},
                    {title: '单车平均行驶里程', field: 'vehAverageMileage', align: 'center', width: '15%', sortable: false, formatter: function(val, row, index){
                        if (undefined != row.zlc && undefined != row.vehOnlineCount && parseInt(row.vehOnlineCount) > 0) {
                            return (row.zlc / row.vehOnlineCount).toFixed(2);
                        }
                        return "-";
                    }},
                    {title: '单次充电最大里程（Km）', field: 'onceChargeMaxMileage', align: 'center', width: '20%', sortable: false},
                    {title: '日平均车速（km/h）', field: 'dayAverageSpeed', align: 'center', width: '15%', sortable: false, formatter: function(val, row, index){
                        if (undefined != row.zlc && undefined != row.dayTravelTime && parseInt(row.dayTravelTime) > 0) {
                            return (row.zlc / row.dayTravelTime).toFixed(2);
                        }
                        return "-";
                    }}
                ]],
                toolbar:"#travelToolbar",
                pagination: true,
                nowrap: true,
                rownumbers: true
            });
            toolbar2Menu("travelTable");
        }
    }

    /**
     * 初始化充耗电情况统计表格
     **/
    function loadElectricityTable() {
        if (!checkBeginAndEndDate("form_search5")) {
            return;
        }
        var data = $("#form_search5").serializeObject();
        if (null != electricityTable && undefined != electricityTable) {
            $('#electricityTable').datagrid("load", data);
        } else {
            electricityTable = $('#electricityTable').datagrid({
                url: '${base}/report/operation/dayStatistics/queryElectricityTable',
                queryParams: data,
                sortName: "",
                sortOrder: "",
                columns: [[
                    {title: '日期', field: 'reportDate', width: 150, align: 'center', sortable: false},
                    {title: '充电车辆总数', field: 'chargeVehCount', width: 150, align: 'center', sortable: false, formatter: function(val, row, index){
                        if (undefined != val && val > 0) {
                            return "<a href='javascript:void(0);' onclick=\"showVehListByDialog('chargeVehCount', '充电车辆总数', '" + row.reportDate + "')\">" + val + "</a>";
                        }
                        return val;
                    }},
                    {title: '充电总次数', field: 'chargeCount', width: 150, align: 'center', sortable: false},
                    {title: '快充次数（次）', field: 'fastChargeCount', width: 150, align: 'center', sortable: false, formatter: function(val, row, index){
                        return "-";
                    }},
                    {title: '慢充次数（次）', field: 'slowChargeCount', width: 150, align: 'center', sortable: false, formatter: function(val, row, index){
                        return "-";
                    }},
                    {title: '充电总时长（h）', field: 'chargeTime', width: 150, align: 'center', sortable: false, formatter: function(val, row, index){
                        if (undefined != val) {
                            return val.toFixed(2);
                        }
                        return "-";
                    }},
                    {title: '快充时长（h）', field: 'faseChargeTime', width: 150, align: 'center', sortable: false, formatter: function(val, row, index){
                        return "-";
                    }},
                    {title: '慢充时长（h）', field: 'slowChargeTime', width: 150, align: 'center', sortable: false, formatter: function(val, row, index){
                        return "-";
                    }},
                    {title: '单车平均充电次数', field: 'vehAveCharge', width: 150, align: 'center', sortable: false, formatter: function(val, row, index){
                        if (undefined != row.chargeCount && undefined != row.chargeVehCount && parseInt(row.chargeVehCount) > 0) {
                            return (row.chargeCount / row.chargeVehCount).toFixed(2);
                        }
                        return "-";
                    }},
                    {title: '单车平均快充次数', field: 'vehAveFastCharge', width: 150, align: 'center', sortable: false, formatter: function(val, row, index){
                        return "-";
                    }},
                    {title: '单车平均慢充次数', field: 'vehAveSlowCharge', width: 150, align: 'center', sortable: false, formatter: function(val, row, index){
                        return "-";
                    }},
                    {title: '单次充电平均时长', field: 'vehAveChargeTime', width: 150, align: 'center', sortable: false, formatter: function(val, row, index){
                        if (undefined != row.chargeTime && undefined != row.chargeCount && parseInt(row.chargeCount) > 0) {
                            return (row.chargeTime / row.chargeCount).toFixed(2);
                        }
                        return "-";
                    }},
                    {title: '单车平均快充时长', field: 'vehAveFastChargeTime', width: 150, align: 'center', sortable: false, formatter: function(val, row, index){
                        return "-";
                    }},
                    {title: '单车平均慢充时长', field: 'vehAveSlowChargeTime', width: 150, align: 'center', sortable: false, formatter: function(val, row, index){
                        return "-";
                    }},
                    {title: '最长充电时间（h）', field: 'longestChargeTime', width: 150, align: 'center', sortable: false},
                    {title: '累计耗电量', field: 'electricityTotal', width: 150, align: 'center', sortable: false, formatter: function(val, row, index){
                        return "-";
                    }},
                    {title: '平均单车耗电量', field: 'aveVehElectricity', width: 150, align: 'center', sortable: false, formatter: function(val, row, index){
                        return "-";
                    }},
                    {title: '累计充电量', field: 'chargeTotal', width: 150, align: 'center', sortable: false, formatter: function(val, row, index){
                        return "-";
                    }}
                ]],
                toolbar:"#electricityToolbar",
                pagination: true,
                nowrap: true,
                rownumbers: true
            });
            toolbar2Menu("electricityTable");
        }
    }

    /**
     * 弹框展示相关车辆列表
     **/
    function showVehListByDialog(val, title, reportDate) {
        $('#vehListDialg').dialog({title: title});
        var data = {};
        data['query.reportDate'] = reportDate;
        data['query.searchType'] = val;
        data['query.diaVehStage'] = $("#diaVehStage").combobox('getValue');
        data['query.diaModelNaticeId'] = $("#diaModelNaticeId").textbox('getValue');
        //弹出框导出参数赋值
        $("#vehListDialogForm #searchType").val(val);
        $("#vehListDialogForm #reportDate").val(reportDate);
        $("#vehListDialogForm #excelTitle").val(title);
        loadDialogTable(data);
        $("#vehListDialg").dialog("open");
    }

    /**
     * 弹出框查询
     **/
    function searchByDialog() {
        var data = {};
        data['query.reportDate'] = $("#vehListDialogForm #reportDate").val();
        data['query.searchType'] = $("#vehListDialogForm #searchType").val();
        data['query.diaVehStage'] = $("#diaVehStage").combobox('getValue');
        data['query.diaModelNaticeId'] = $("#diaModelNaticeId").textbox('getValue');
        loadDialogTable(data);
    }

    /**
     * 查询车辆详情弹出框表格
     **/
    function loadDialogTable(data) {
        if (null != diaSearchTable && undefined != diaSearchTable) {
            $('#diaSearchTable').datagrid('loadData', { total: 0, rows: [] });
            $('#diaSearchTable').datagrid("load", data);
        } else {
            diaSearchTable = $('#diaSearchTable').datagrid({
                url: '${base}/report/operation/dayStatistics/queryDialogSearchTable',
                queryParams: data,
                sortName: "",
                sortOrder: "",
                columns: [[
                    {title: 'VIN', field: 'vin', width: 150, sortable: false, align: 'center', halign: 'center'},
                    {title: '车牌号', field: 'plate', width: 150, sortable: false, align: 'center', halign: 'center'},
                    {title: '上牌城市', field: 'areaName', width: 150, sortable: false, align: 'center', halign: 'center'},
                    {title: '车型公告型号', field: 'modelNoticeId', width: 150, sortable: false, align: 'center', halign: 'center'},
                    {title: '车辆阶段', field: 'vehStage', width: 150, sortable: false, align: 'center', halign: 'center'},
                    {title: '录入时间', field: 'entryDate', width: 150, sortable: false, align: 'center', halign: 'center'},
                    {title: '最后通讯时间', field: 'updateTime', width: 150, sortable: false, align: 'center', halign: 'center'}
                ]],
                toolbar:"#vehListDialgToolbar",
                pagination: true,
                nowrap: true,
                rownumbers: true
            });
            toolbar2Menu("diaSearchTable");
        }
    }

    /**
     * 切换tab页
     **/
    function cutTabPage(tabId) {
        console.log(tabId);
        //loadTable(tabId);
    }

    /**
     * 重置查询条件、表格
     **/
    function resetSearch(tabId) {
        if (tabId == "idle") {
            $("#" + tabId + "Div #idlePlate").val("");
            $("#" + tabId + "Div #idleVIN").val("");
            $("#" + tabId + "Div #idleMileage").val("");
            $("#form_search3").form("reset");
        } else {
            $("#" + tabId + "Div #beginDate").datebox('setValue', defaultBeginDate);
            $("#" + tabId + "Div #endDate").datebox('setValue', defaultEndDate);
        }
//        loadTable(tabId);
    }

    /**
     * 调用tab表格查询
     **/
    function loadTable(tabId) {
        if (tabId == "monitoring") {
            loadMonitoringTable();
        } else if (tabId == "active") {
            loadActiveTable();
        } else if (tabId == "travel") {
            loadTravelTable();
        } else if (tabId == "idle") {
            //loadIdleTable();
            searchIdleByMileageValue();
        } else if (tabId == "electricity") {
            loadElectricityTable();
        }
    }

    /**
     * 校验查询时间
     **/
    function checkBeginAndEndDate(formId) {
        var beginDate = $("#" + formId + " #beginDate").datebox('getValue');
        var endDate = $("#" + formId + " #endDate").datebox('getValue');
        if (beginDate == "" || endDate == "") {
            $.messager.alert("提示", "查询开始时间与截止时间不可为空！");
            return false;
        }
        var beginTime = new Date(beginDate).getTime();
        var endTime = new Date(endDate).getTime();
        if (beginTime > endTime) {
            $.messager.alert("提示", "查询开始时间不可大于截止时间！");
            return false;
        }
        var days = Math.floor((endTime - beginTime) / (24 * 3600 * 1000));
        if (days > 31) {
            $.messager.alert("提示", "查询开始时间与截止时间相差不可大于30天！");
            return false;
        }
        return true;
    }

    /**
     * 初始化下拉选择框
     */
    function initSelectChoose() {
        //车辆阶段
        $('#diaVehStage, #idleVehStage').combobox({
            url: '${base}/report/common/queryVehStageList',
            valueField: 'id',
            textField: 'text'
        });
        //车辆型号
        $('#idleModelNoticeId').combobox({
            url: '${base}/report/common/queryVehModelList',
            valueField: 'id',
            textField: 'modelNoticeId'
        });
        //上牌城市
        $('#idleAreaId').combotree({
            url: '${base}/report/common/queryAreaList'
        });
        //运营单位
        $('#idleUseUnitId').combotree({
            url: '${base}/report/common/queryUnitList'
        });
        //车辆种类
        $('#idleVehTypeId').combotree({
            url: '${base}/report/common/queryVehTypeList'
        });
    }

    /**
     * 打开列表说明弹出框
     * @param id
     */
    function openExplainDialog(id) {
        $("#" + id + "ExplainDialg").dialog('open');
    }
</script>

<#--设置闲置车辆统计条件弹出框-->
<div id="idleConditionDialg" class="easyui-dialog" title="闲置车辆统计条件" style="width: 550px; height: 240px;"
     data-options="iconCls:'',closed: true, resizable:false, modal:true">
    <table style="width: 530; height: 220; margin: 10px;">
        <tr>
            <td style="text-align: right; width: 100px; height: 50px;">统计时间：</td>
            <td>
                <input type="text" name="query.beginDate" value="${idleBeginDate!}" id="beginDate" style="height: 30px; width: 168px" class="easyui-datebox" data-options="editable:false"/>
                &nbsp;&nbsp;至&nbsp;&nbsp;
                <input type="text" name="query.endDate" value="${idleEndDate!}" id="endDate" style="height: 30px;width: 168px" class="easyui-datebox" data-options="editable:false"/>
            </td>
        </tr>
        <tr>
            <td style="text-align: right; width: 100px; height: 50px;">闲置里程阈值：</td>
            <td>
                <input type="text" name="query.idleMileageValue" id="idleMileageValue" value="100" class="input-fat input" style="height: 26px; width:365px;" />
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center; height: 50px;">
                <a href="#" onclick="searchIdleByMileageValue()" class="easyui-linkbutton">保存并查询</a>
            </td>
        </tr>
    </table>
</div>
<#--车辆监控情况统计说明弹出框-->
<div id="monitoringExplainDialg" class="easyui-dialog" title="车辆监控情况统计列表说明" style="width: 750px; height: 315px;"
     data-options="iconCls:'',closed: true, resizable:false, modal:true">
    <table class="easyui-datagrid">
        <thead>
            <tr>
                <th data-options="field:'title', width: 200, resizable: true, align: 'left', halign: 'center'">名称</th>
                <th data-options="field:'definition', width: 550, resizable: true, align: 'left', halign: 'center'">定义</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>车辆录入总数（辆）</td>
                <td>统计时段内，平台内已录入的车辆总数；车辆列表内车辆总数</td>
            </tr>
            <tr>
                <td>新增录入车辆数</td>
                <td>当日增加的车辆数目</td>
            </tr>
            <tr>
                <td>通讯异常车辆数（辆）</td>
                <td>与平台失去通讯时间大于24h;录入车辆数-可监控车辆数</td>
            </tr>
            <tr>
                <td>正常监控比例（%）</td>
                <td>（车辆录入总数-通讯异常车辆数）/车辆录入总数</td>
            </tr>
        </tbody>
    </table>
</div>
<#--车辆活跃情况统计说明弹出框-->
<div id="activeExplainDialg" class="easyui-dialog" title="车辆活跃情况统计列表说明" style="width: 750px; height: 315px;"
     data-options="iconCls:'',closed: true, resizable:false, modal:true">
    <table class="easyui-datagrid">
        <thead>
            <tr>
                <th data-options="field:'title', width: 200, resizable: true, align: 'left', halign: 'center'">名称</th>
                <th data-options="field:'definition', width: 550, resizable: true, align: 'left', halign: 'center'">定义</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>当天活跃车辆总数</td>
                <td>车辆上线又是实时数据上传的车辆，非自动唤醒的上线车辆数，排除自动唤醒车辆，自动唤醒判断：<br/>如上传了整车数据中的电池总电流和总电压，则视为非自动唤醒。</td>
            </tr>
            <tr>
                <td>活跃率</td>
                <td>当天活跃车辆总数/车辆录入总数</td>
            </tr>
            <tr>
                <td>里程异常车辆数（辆）</td>
                <td>里程异常车辆数（当天单车的里程无效数据包占比超过5%视为里程异常车辆）</td>
            </tr>
            <tr>
                <td>里程异常比例(%)</td>
                <td>当天里程异常车辆数/车辆录入总数</td>
            </tr>
            <tr>
                <td>单车日均活跃时间</td>
                <td>日活跃总时间/活跃车辆数</td>
            </tr>
        </tbody>
    </table>
</div>
<#--车辆闲置情况统计说明弹出框-->
<div id="idleExplainDialg" class="easyui-dialog" title="车辆闲置情况统计列表说明" style="width: 750px; height: 315px;"
     data-options="iconCls:'',closed: true, resizable:false, modal:true">
    <table class="easyui-datagrid">
        <thead>
            <tr>
                <th data-options="field:'title', width: 200, resizable: true, align: 'left', halign: 'center'">名称</th>
                <th data-options="field:'definition', width: 550, resizable: true, align: 'left', halign: 'center'">定义</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>长期闲置车辆</td>
                <td>查询日期范围内车辆累计里程小于闲置里程阈值</td>
            </tr>
            <tr>
                <td>长期闲置车辆比率（%）</td>
                <td>长期闲置车辆数/可监控车辆数</td>
            </tr>
        </tbody>
    </table>
</div>
<#--车辆行驶情况统计说明弹出框-->
<div id="travelExplainDialg" class="easyui-dialog" title="车辆行驶情况统计列表说明" style="width: 800px; height: 315px;"
     data-options="iconCls:'',closed: true, resizable:false, modal:true">
    <table class="easyui-datagrid">
        <thead>
            <tr>
                <th data-options="field:'title', width: 200, resizable: true, align: 'left', halign: 'center'">名称</th>
                <th data-options="field:'definition', width: 600, resizable: true, align: 'left', halign: 'center'">定义</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>日总行驶时间(h)</td>
                <td>所有车辆行驶总时间</td>
            </tr>
            <tr>
                <td>单车平均行驶时间</td>
                <td>日行驶总时间 / 上线车辆数</td>
            </tr>
            <tr>
                <td>单车平均行驶里程</td>
                <td>总里程 / 上线车辆数</td>
            </tr>
            <tr>
                <td>单次充电最大里程</td>
                <td>
                    比较每两次充电之间的行驶里程，得出单次充电最大行驶里程；<br />
                    两次充电之间算一次，0点到当天第一次充电开始记为一次，最后一次充电结束到当天<br />23:59:59计为一次；<br />
                    若当天（00:00：00~23:59：59）未充电，计算当天累计行驶里程，记为一次；<br />
                    若当天只充一次电，0点到充电开始，记为一次；充电结束到当天24点记为一次
                </td>
            </tr>
            <tr>
                <td>日平均车速</td>
                <td>日总里程/日总行驶时间</td>
            </tr>
        </tbody>
    </table>
</div>
<#--充耗电情况统计说明弹出框-->
<div id="electricityExplainDialg" class="easyui-dialog" title="充耗电情况统计列表说明" style="width: 750px; height: 415px;"
     data-options="iconCls:'',closed: true, resizable:false, modal:true">
    <table class="easyui-datagrid">
        <thead>
        <tr>
            <th data-options="field:'title', width: 200, resizable: true, align: 'left', halign: 'center'">名称</th>
            <th data-options="field:'definition', width: 550, resizable: true, align: 'left', halign: 'center'">定义</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>累计耗电量</td>
            <td>
                总电量-剩余电量;<br/>
                整车上传电量数据为剩余电量;<br/>
                “累计耗电量”根据TBOX上传的动力电池放电累积能量得;
            </td>
        </tr>
        <tr>
            <td>平均单车耗电量</td>
            <td>总耗电量 / 上线车辆数</td>
        </tr>
        <tr>
            <td>累计充电量</td>
            <td>该数据为TBOX上传得（根据TBOX上传的动力电池充电累积能量得）</td>
        </tr>
        <tr>
            <td>充电车辆总数</td>
            <td>当天里程异常车辆数/车辆录入总数</td>
        </tr>
        <tr>
            <td>充电总次数</td>
            <td>“充电总次数”、“充电总时长”、“单车平均充电次数”、<br/>“单车平均充电时长”、<br/>
                “最长充电时间”均区分快充、慢充，即都分开统计。<br/>
                （可根据TBOX上传的快充连接状态，快充继电器控制命令，慢充电子锁状态、<br/>慢充继电器控制命令进行区分）</td>
        </tr>
        <tr>
            <td>充电总时长</td>
            <td></td>
        </tr>
        <tr>
            <td>单车平均充电次数</td>
            <td>充电次数 / 充电车辆数</td>
        </tr>
        <tr>
            <td>单次充电平均时长</td>
            <td>所有车辆当天充电总时长 / 当天充电的次数</td>
        </tr>
        <tr>
            <td>最长充电时间(h)</td>
            <td></td>
        </tr>
        </tbody>
    </table>
</div>
</html>