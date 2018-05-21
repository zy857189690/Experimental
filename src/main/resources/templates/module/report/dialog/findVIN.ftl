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
</head>
<body class="easyui-layout" fit="true">
<div region="center" style="overflow: hidden;width: 100%;">
    <div id="toolbar">
    </div>
    <div id="table" name="datagrid" style="width: 100%;height: 100%"></div>
</div>

<div data-options="region:'north',title:'查询',split:false,collapsable:false" style="width: 100%;height:90px;">
    <div style="width: 100%;border: 1;margin:5 5 5 10 ">
        <form id="form_search" name="form_search" class="sui-form form-inline cg-form">
            <table class="table_search">
                <tr>
                    <td class="td_label">
                        <label>VIN</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.vin" id="vin" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>车辆公告型号</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.vehModeNo" id="vehModeNo" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
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

<script type="text/javascript">
//    var pagessort = "uuid";
//    var pagesorder = "desc";
    $('#table').datagrid({
        url: '${base}/select/datagridVIN',
        rownumbers:"true",
        frozenColumns: [[
        ]],
        columns: [[
            {title: 'VIN', field: 'vin',  sortable: "true",align:"center",halign:"center",width:"40%"},
            {title: '车辆公告型号', field: 'vehModeNo', sortable: "true",align:"center",halign:"center",width:"40%"},
            {title: 'serial_number', field: 'serial_number', hidden:'true'},
            {title: 'imei', field: 'imei', hidden:'true'},
            {title: 'sim_card', field: 'sim_card', hidden:'true'},
            {title: 'iccid', field: 'iccid', hidden:'true'},
            {title: 'imsi', field: 'imsi', hidden:'true'},
        ]],
        toolbar: "#toolbar0",
        pagination: true,
        nowrap: true,
        onSortColumn: function (sort, order) {
            pagessort = sort;
            pagesorder = order;
        },
        onClickRow: function (index,row) {
                var type = '${(type)!}';
                if(type == '1'){
                    window.top.PeopleAuth_add_iframeFrame.dialogCallBack(row);
                }else if((type == '2')){
                    window.top.PeopleAuth_edit_iframeFrame.dialogCallBack(row);
                }else if(type == '3'){
                    window.top.companyAuth_frameFrame.vinCallBack(row);
                    window.top.window.$("#window_m_findvin_").window("close");
                    return;
                }else if(type == '4'){
                    window.top.companyAuth_frame_editFrame.vinCallBack(row);
                }else if(type == '5'){
                    window.top.personalVehicleBinding_frameFrame.vinCallBack(row);
                    window.top.window.$("#window_m_findvin_").window("close");
                    return;
                }else if(type == '6'){
                    window.top.companyAuth_bind_frameFrame.vinCallBack(row);
                    window.top.window.$("#window_m_findvin_").window("close");
                    return;
                }
                window.parent.$("#window_pop").window("close");
            }
    });

</script>
</body>
</html>