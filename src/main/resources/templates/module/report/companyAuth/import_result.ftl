
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<#include "../../../inc/meta.ftl">
<#include  "../../../inc/js.ftl">
<#include  "../../../inc/top.ftl">
    <script type="application/javascript">
        function initLoad(data){
            $('#table_com').datagrid('loadData',data)
        }

        function exportResult(){
            window.open('${base}/companyAuth/download_result','_blank');
        }

        $(function () {
            initTable();
            initLoad(window.top.auth_result_data);
        })

        function initTable(){
            $('#table_com').datagrid({
                columns:[[
                    {field:'vin',title:'车架号（VIN）',width:150},
                    {field:'iccid',title:'ICCID',width:120},
                    {field:'result',title:'导入结果',width:80},
                    {field:'message',title:'失败原因',formatter:function(val,row){
                        if(row.code == 0){
                            return '';
                        }
                        return row.message;
                    }}
                ]],
                toolbar:"#toolbar"
            });
        }

    </script>
</head>
    <body  class="easyui-layout" fit="true">
        <div <div region="center" style="overflow: hidden;width: 100%;">
            <div id="toolbar" style="padding:5px">
                <a href="#" onclick="exportResult()" class="easyui-linkbutton">导出</a>
            </div>
            <table id="table_com" class="easyui-datagrid" style="width:100%;height:100%">
        </div>
    </table>
    </body>
</html>






