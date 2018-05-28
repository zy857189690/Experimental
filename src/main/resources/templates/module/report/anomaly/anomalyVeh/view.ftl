<!DOCTYPE html>
<html>
<head>
<#include "../../../../inc/meta.ftl">
<#include "../../../../inc/js.ftl">
    <link href="${cdn}/style/edit.css" type="text/css">
</head>
<body>
<div style="padding: 10px">
    <form id="ff" method="post" novalidate>
        <!--开发人员需自己编辑以下不通用的字段显示-->
        <div align="center" style="margin-top: 1px">
            <table class="table_edit" border="1">
                    <tr>
                        <td class="td_label"><label>名称:</label></td>
                        <td class="td_input">
                            <input type='text' name='name' autocomplete="off" id='name' value="${(obj.name)!}" class="input-fat" style="height: 26px;width: 178px" readonly/>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_label"><label>字典值:</label></td>
                        <td class="td_input">
                            <input type='text' name='dictField' autocomplete="off" id='dictField' value="${(obj.dictField)!}" class="input-fat" style="height: 26px;width: 178px" readonly/>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_label"><label>名称值:</label></td>
                        <td class="td_input">
                            <input type='text' name='nameField' autocomplete="off" id='nameField' value="${(obj.nameField)!}" class="input-fat" style="height: 26px;width: 178px" readonly/>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_label"><label>创建时间:</label></td>
                        <td class="td_input">
                            <input type='text' name='createTime' autocomplete="off" id='createTime' value="${(obj.createTime)!}" class="input-fat" style="height: 26px;width: 178px" readonly/>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_label"><label>创建人:</label></td>
                        <td class="td_input">
                            <input type='text' name='createBy' autocomplete="off" id='createBy' value="${(obj.createBy)!}" class="input-fat" style="height: 26px;width: 178px" readonly/>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_label"><label>更新时间:</label></td>
                        <td class="td_input">
                            <input type='text' name='updateTime' autocomplete="off" id='updateTime' value="${(obj.updateTime)!}" class="input-fat" style="height: 26px;width: 178px" readonly/>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_label"><label>更新人:</label></td>
                        <td class="td_input">
                            <input type='text' name='updateBy' autocomplete="off" id='updateBy' value="${(obj.updateBy)!}" class="input-fat" style="height: 26px;width: 178px" readonly/>
                        </td>
                    </tr>
            </table>
        </div>
    </form>
</div>
</body>
</html>
