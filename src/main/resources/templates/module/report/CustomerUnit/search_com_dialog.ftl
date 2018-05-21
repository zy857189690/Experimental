
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<#include "../../../inc/meta.ftl">
<#include  "../../../inc/js.ftl">
<#include  "../../../inc/top.ftl">
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 70px">
    <div style="width: 100%;">
        <form id="form_search" class="">
            <table class="table_search">
                <tr>
                    <td class="td_label">
                        <label>企业名称：</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat" name="query.name" id="name" style="width: 80px;">
                    </td>
                    <td class="td_label">
                        <label>统一社会信用代码：</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat" name="query.creditCode" id="creditCode" style="width: 80px;">
                    </td>

                    <td class="td_label">
                        <label>企业地址：</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat" name="query.cusReplace" id="cusReplace" style="width: 80px;">
                    </td>

                    <td style="vertical-align: center;text-align: right;border: 1px">
                        <a href="#" onclick="search_item()" class="easyui-linkbutton" class="easyui-linkbutton"
                           data-options="iconCls:'icon-search'">查询</a>
                        <a href="#" onclick="reset_common()" class="easyui-linkbutton"
                           class="easyui-linkbutton"
                           data-options="iconCls:'icon-reset'">重置</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
<div region="center" style="overflow: hidden;width: 100%;">
    <div id="searchTable" name="datagrid" style="width: 100%;height: 100%"></div>
</div>
</body>
</html>

<script type="application/javascript">
    //弹出框弹出后回调
    function initLoad(data){
    }
    $('#searchTable').datagrid({
        url: '${base}/customerUnit/datagrid',
        sortName: "createTime",
        sortOrder: "desc",
        columns: [[
            {title: '企业名称', field: 'name', width: "180", sortable: "true"},
            {title: '统一社会信用代码', field: 'creditCode', width: "180", sortable: "true"},
            {title: '企业地址', field: 'cusReplace', width: "200", sortable: "true"}
        ]],
        toolbar: "#toolbar",
        pagination: true,
        nowrap: false,
        rownumbers:true,
        onLoadSuccess:function (data) {
            afterLoading();
        },
        onClickRow: function (index,row) {
            var type = '${(type)!}';
            if(type == '3'){
                window.top.real_auth_allFrame.dialogCallBack(row);
                window.top.$("#window_auth_all").window("close");
                return;
            }
            if(type == '1'){
                window.top.companyAuth_frameFrame.dialogCallBack(row);
            }else{
                window.top.companyAuth_frame_editFrame.dialogCallBack(row);
            }
            window.parent.$("#window_pop").window("close");
        }
    });

    function form2Object(ele){
        var obj = new Object();
        var $ele = $('#'+ele);
        $ele.find(':text,:hidden,select').each(function(){
            var attr = $(this).attr('name');
            if(!attr){
                return;
            }
            obj[attr] = $(this).val();
        })
        return obj;
    }

    function search_item(){
        $("#searchTable").datagrid("load",form2Object('form_search'));
    }

    function reset_common(){
        $("#name").val('');
        $("#creditCode").val('');
        $("#cusReplace").val('');
        $("#searchTable").datagrid("load",form2Object('form_search'));
    }
</script>

