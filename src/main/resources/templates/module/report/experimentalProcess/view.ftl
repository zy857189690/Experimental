<!DOCTYPE html>
<html>
<head>
<#include  "../../../inc/meta.ftl">
<#include  "../../../inc/js.ftl">
    <style type=text/css >
        .td_label2 {
            min-width: 800px !important;
            text-align: left;
            padding-left: 250px;
        }
    </style>

    <script type="text/javascript">


        function cancel() {
            if (window.top.$("div#window_addCompanyType").length > 0) {
                close_win_affirm($("#id").val(), "addCompanyType");
            } else {
                var id = $("#id").val();
                close_win_affirm(id);
            }
        }


    </script>
</head>
<body class="fbody">
<div style="padding: 10px" class="fcontainer">
    <form id="ff" method="post" enctype="" novalidate>
        <input type="hidden" name="id" id="id" value="${(experimentalProcess.id)!-1}">
        <table class="table_edit" border="1">
            <tr>
                <td class="td_label"><label>实验编号:</label></td>
                <td class="td_input">
                    <input type='text' name='code' autocomplete="off" id='code' value="${(experimentalProcess.code)!}"
                           class="input-fat" style="height: 26px;width: 178px" readonly/>
                </td>
                <td class="td_label"><label>实验名称:</label></td>
                <td class="td_input">
                    <input type='text' name='experimentalName' autocomplete="off" id='experimentalName'
                           value="${(experimentalProcess.experimentalName)!}" class="input-fat"
                           style="height: 26px;width: 178px" readonly/>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>实验创建人:</label></td>
                <td class="td_input">
                    <input type='text' name='experimenter' autocomplete="off" id='experimenter'
                           value="${(experimentalProcess.experimenter)!}" class="input-fat"
                           style="height: 26px;width: 178px" readonly/>
                </td>
                <td class="td_label"><label>实验所属项目编号:</label></td>
                <td class="td_input">
                    <input type='text' name='pid' autocomplete="off" id='pid' value="${(experimentalProcess.pid)!}"
                           class="input-fat" style="height: 26px;width: 178px" readonly/>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>实验配方:</label></td>
                <td class="td_input">
                    <input type='text' name='formulaName' autocomplete="off" id='formulaName'
                           value="${(experimentalProcess.formulaName)!}" class="input-fat"
                           style="height: 26px;width: 178px" readonly/>
                </td>
            </tr>
        </table>
        <table style="padding-left: 95px">
            <tr>
                <td>
                <label>实验配方详情:</label></td>
            </tr>
            <tr>
                <td>
                    <label>${(formula.drugname01)!} ${(formula.flag01)!} ${(formula.drugquality01)!} </label>&nbsp;
                    <label>${(formula.drugname02)!} ${(formula.flag02)!}${(formula.drugquality02)!} </label>&nbsp;
                    <label>${(formula.drugname03)!} ${(formula.flag03)!}${(formula.drugquality03)!} </label>&nbsp;
                    <label>${(formula.drugname04)!} ${(formula.flag04)!}${(formula.drugquality04)!} </label>&nbsp;
                    <label>${(formula.drugname05)!} ${(formula.flag05)!}${(formula.drugquality05)!} </label>&nbsp;
                    <label>${(formula.drugname06)!} ${(formula.flag06)!}${(formula.drugquality06)!} </label>&nbsp;
                    <label>${(formula.drugname07)!} ${(formula.flag07)!}${(formula.drugquality07)!} </label>&nbsp;
                    <label>${(formula.drugname08)!} ${(formula.flag08)!}${(formula.drugquality08)!} </label>&nbsp;
                    <label>${(formula.drugname09)!} ${(formula.flag09)!}${(formula.drugquality09)!} </label>&nbsp;
                    <label>${(formula.drugname10)!} ${(formula.flag10)!}${(formula.drugquality10)!} </label>
                </td>
            </tr>
            <tr>
                <td>
                    <label>${(formula.drugname11)!} ${(formula.flag11)!} ${(formula.drugquality11)!} </label>&nbsp;
                    <label>${(formula.drugname12)!} ${(formula.flag12)!}${(formula.drugquality12)!} </label>&nbsp;
                    <label>${(formula.drugname13)!} ${(formula.flag13)!}${(formula.drugquality13)!} </label>&nbsp;
                    <label>${(formula.drugname14)!} ${(formula.flag14)!}${(formula.drugquality14)!} </label>&nbsp;
                    <label>${(formula.drugname15)!} ${(formula.flag15)!}${(formula.drugquality15)!} </label>&nbsp;
                    <label>${(formula.drugname16)!} ${(formula.flag16)!}${(formula.drugquality16)!} </label>&nbsp;
                    <label>${(formula.drugname17)!} ${(formula.flag17)!}${(formula.drugquality17)!} </label>&nbsp;
                    <label>${(formula.drugname18)!} ${(formula.flag18)!}${(formula.drugquality18)!} </label>&nbsp;
                    <label>${(formula.drugname19)!} ${(formula.flag19)!}${(formula.drugquality19)!} </label>&nbsp;
                    <label>${(formula.drugname20)!} ${(formula.flag20)!}${(formula.drugquality20)!} </label>
                </td>
            </tr>

        </table>
        <table>
            <tr>
                <td class="td_label"><label>实验方案:</label></td>
                <td class="td_input">
                    <textarea name="experimentalScheme" id="experimentalScheme" clos="1800" rows="10"
                              style="width: 800px;height: 100px"
                              readonly>${(experimentalProcess.experimentalScheme)!}</textarea>
                </td>
            </tr>

            <tr>
                <td class="td_label"><label>实验过程:</label></td>
                <td class="td_input">
                    <textarea name="procedures" id="procedures" clos="1800" rows="10" style="width: 800px;height: 100px"
                              readonly>${(experimentalProcess.procedures)!}</textarea>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>实验观察/结果:</label></td>
                <td class="td_input">
                    <textarea name="result" id="result" clos="1800" rows="10" style="width: 800px;height: 100px"
                              readonly>${(experimentalProcess.result)!}</textarea>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>结果分析(及下一步实验计划):</label></td>
                <td class="td_input">
                    <textarea name="analysis" id="analysis" clos="1800" rows="10" style="width: 800px;height: 100px"
                              readonly>${(experimentalProcess.analysis)!}</textarea>
                </td>
            </tr>
        </table>

    </form>
</div>
</body>
</html>
