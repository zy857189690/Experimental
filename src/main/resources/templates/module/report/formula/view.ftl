<!DOCTYPE html>
<html>
<head>
<#include  "../../../../inc/meta.ftl">
<#include  "../../../../inc/js.ftl">

</head>
<body class="fbody">
<div style="padding: 10px" class="fcontainer">
    <form id="ff" method="post" enctype="" novalidate>
        <input type="hidden" name="id" id="id" value="${(formula.id)!-1}">
        <table class="table_edit" border="1">
            <tr>
                <td class="td_label"><label>配方编号:</label></td>
                <td class="td_input">
                    <input type='text' name='code' autocomplete="off" id='code' value="${(formula.code)!}"
                           class="input-fat" style="height: 26px;width: 178px" readonly/>
                </td>
                <td class="td_label"><label>配方名称:</label></td>
                <td class="td_input">
                    <input type='text' name='fname' autocomplete="off" id='fname' value="${(formula.fname)!}"
                           class="input-fat" style="height: 26px;width: 178px" readonly/>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>配方创建人:</label></td>
                <td class="td_input">
                    <input type='text' name='fpeople' autocomplete="off" id='fpeople' value="${(formula.fpeople)!}"
                           class="input-fat" style="height: 26px;width: 178px" readonly/>
                </td>
                <td class="td_label"><label>所属项目编号:</label></td>
                <td class="td_input">
                    <input type='text' name='pid' autocomplete="off" id='pid' value="${(formula.pid)!}"
                           class="input-fat" style="height: 26px;width: 178px" readonly/>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label></label></td>
            </tr>
            <tr>
                <td class="td_label"><label></label></td>
            </tr>

            <tr>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname01" id="drugname01"
                           value="${(formula.drugname01)!}" readonly/>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality01' autocomplete="off" id='drugquality01' value="${(formula.drugquality01)!}"
                          style="height: 26px;width: 78px" readonly/>
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname02" id="drugname02"
                           value="${(formula.drugname02)!}" readonly/>

                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality02' autocomplete="off" id='drugquality02' value="${(formula.drugquality02)!}"
                            style="height: 26px;width: 78px" readonly />
                </td>
            </tr>

            <tr>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname03" id="drugname03"
                           value="${(formula.drugname03)!}" /readonly>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality03' autocomplete="off" id='drugquality03' value="${(formula.drugquality03)!}"
                           style="height: 26px;width: 78px" readonly/>
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname04" id="drugname04"
                           value="${(formula.drugname04)!}" readonly/>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality04' autocomplete="off" id='drugquality04' value="${(formula.drugquality04)!}"
                           style="height: 26px;width: 78px" readonly/>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname05" id="drugname05"
                           value="${(formula.drugname05)!}" readonly/>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality05' autocomplete="off" id='drugquality05' value="${(formula.drugquality05)!}"
                           style="height: 26px;width: 78px" readonly/>
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname06" id="drugname06"
                           value="${(formula.drugname06)!}" readonly />

                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality06' autocomplete="off" id='drugquality06' value="${(formula.drugquality06)!}"
                           style="height: 26px;width: 78px" readonly/>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname07" id="drugname07"
                           value="${(formula.drugname07)!}" readonly />
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality07' autocomplete="off" id='drugquality07' value="${(formula.drugquality07)!}"
                           style="height: 26px;width: 78px" readonly/>
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname08" id="drugname08"
                           value="${(formula.drugname08)!}" readonly/>

                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality08' autocomplete="off" id='drugquality08' value="${(formula.drugquality08)!}"
                           style="height: 26px;width: 78px" readonly/>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname09" id="drugname09"
                           value="${(formula.drugname09)!}" readonly/>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality09' autocomplete="off" id='drugquality09' value="${(formula.drugquality09)!}"
                           style="height: 26px;width: 78px" readonly/>
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname10" id="drugname10"
                           value="${(formula.drugname10)!}"readonly/>

                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality10' autocomplete="off" id='drugquality10' value="${(formula.drugquality10)!}"
                           style="height: 26px;width: 78px" readonly/>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname11" id="drugname11"
                           value="${(formula.drugname11)!}"readonly/>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality11' autocomplete="off" id='drugquality11' value="${(formula.drugquality11)!}"
                           style="height: 26px;width: 78px" readonly/>
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname12" id="drugname12"
                           value="${(formula.drugname12)!}"readonly/>

                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality12' autocomplete="off" id='drugquality12' value="${(formula.drugquality12)!}"
                           style="height: 26px;width: 78px"readonly/>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname13" id="drugname13"
                           value="${(formula.drugname13)!}"readonly/>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality13' autocomplete="off" id='drugquality13' value="${(formula.drugquality13)!}"
                           style="height: 26px;width: 78px"readonly/>
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname14" id="drugname14"
                           value="${(formula.drugname14)!}"readonly/>

                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality14' autocomplete="off" id='drugquality14' value="${(formula.drugquality14)!}"
                           style="height: 26px;width: 78px"readonly/>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname15" id="drugname15"
                           value="${(formula.drugname15)!}"readonly/>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality15' autocomplete="off" id='drugquality15' value="${(formula.drugquality15)!}"
                           style="height: 26px;width: 78px"readonly/>
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname16" id="drugname16"
                           value="${(formula.drugname16)!}"readonly/>

                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality16' autocomplete="off" id='drugquality16' value="${(formula.drugquality16)!}"
                           style="height: 26px;width: 78px"readonly/>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname17" id="drugname17"
                           value="${(formula.drugname17)!}"readonly/>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality17' autocomplete="off" id='drugquality17' value="${(formula.drugquality17)!}"
                           style="height: 26px;width: 78px"readonly/>
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname18" id="drugname18"
                           value="${(formula.drugname18)!}"readonly/>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality18' autocomplete="off" id='drugquality18' value="${(formula.drugquality18)!}"
                           style="height: 26px;width: 78px"readonly/>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname19" id="drugname19"
                           value="${(formula.drugname19)!}"readonly/>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality19' autocomplete="off" id='drugquality19' value="${(formula.drugquality19)!}"
                           style="height: 26px;width: 78px"readonly/>
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname20" id="drugname20"
                           value="${(formula.drugname20)!}"readonly/>

                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality20' autocomplete="off" id='drugquality20' value="${(formula.drugquality20)!}"
                           style="height: 26px;width: 78px"readonly/>
                </td>
            </tr>

        </table>

    </form>

</div>

</body>
</html>
