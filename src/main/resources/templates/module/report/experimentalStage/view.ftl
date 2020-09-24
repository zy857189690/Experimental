<!DOCTYPE html>
<html>
<head>
<#include  "../../../inc/meta.ftl">
<#include  "../../../inc/js.ftl">

    <script type="text/javascript">

        $(function(){
            var id=$("#id").val();
            var url = "/experimentManagement/report/experimentalStage/getImgsById?id=" + (id);
            $.ajax({
                url:url,
                method:'post',
                data:id,
                dataType:'json',
                success:function(data){
                    if(data!=null){
                        $.each(data,function(i,url){
                            //拼接图片列表
                            var id = $('#detailImgs li:last').attr('id');
                            id = id.substr(1);
                            id = parseInt(id) + 1;
                            var ids=id;
                            id = 'P'+id;
                            var a_hidden="<li id='"+ id +"'><input type='hidden' id='reportImg' value='"+url+"' name='reportImg'>";
                            var img_html="<img  src='"+url+"'  onclick='showOriginal(this)' original='"+url+"'>";
                            var a_html="<a href='javascript:void(0);' onclick='delespan1("+ids+")'></a>";
                            var li_html="</li>";
                            $('#detailImgs').append(a_hidden+img_html+a_html+li_html);
                        });
                    }
                }
            });
        }
        );

        function cancel() {
            if(window.top.$("div#window_addCompanyType").length>0){
                close_win_affirm($("#id").val(), "addCompanyType");
            }else{
                var id = $("#id").val();
                close_win_affirm(id);
            }
        }

    </script>
</head>
<body class="fbody">
<div style="padding: 10px" class="fcontainer">
    <form id="ff" method="post" enctype="" novalidate >
        <input type="hidden" name="id" id="id" value="${(experimentalStage.id)!-1}">
        <table class="table_edit" border="1">
            <tr>
                <td class="td_label"><label>实验编号:</label></td>
                <td class="td_input">
                    <input type='text' name='reportCode' autocomplete="off" id='reportCode' value="${(experimentalStage.reportCode)!}" class="input-fat" style="height: 26px;width: 178px" readonly/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan"style="top:12px;left: 200px;">*</span>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>报告人:</label></td>
                <td class="td_input">
                    <input type='text' name='reportUserName' autocomplete="off" id='reportUserName' value="${(experimentalStage.reportUserName)!}" class="input-fat" style="height: 26px;width: 178px" readonly/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan"style="top:12px;left: 200px;">*</span>
                </td>
                <td class="td_label"><label>报告时间:</label></td>
                <td class="td_input">
                    <input type='text' name='reportTime' autocomplete="off" id='reportTime' value="${(experimentalStage.reportTime)!}" class="input-fat" style="height: 26px;width: 178px"readonly/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan"style="top:12px;left: 200px;">*</span>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td class="td_label"><label>理论配方:</label></td>
                <td class="td_input">
                    <input type='text' name='theoreticalFormula' autocomplete="off" id='theoreticalFormula' value="${(experimentalStage.theoreticalFormula)!}"  style="height: 26px;width: 800px"readonly/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan">*</span>
                </td>
            </tr>

            <tr>
                <td class="td_label"><label>实际配方:</label></td>
                <td class="td_input">
                    <input type='text' name='actualFormula' autocomplete="off" id='actualFormula' value="${(experimentalStage.actualFormula)!}"  style="height: 26px;width: 800px" readonly/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan">*</span>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>报告内容:</label></td>
                <td class="td_input">
                    <textarea name="reportContent" id="reportContent"  clos="1800" rows="10" style="width: 800px;height: 150px" readonly>${(experimentalStage.reportContent)!}</textarea>
                    <span name="requireTag" class="requrieTag AbleStevenSpan">*</span>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>实验图片上传:</label></td>
                <td class="td_input" id="fileinput">
                    <div class="cp-img" id="logoImgDiv6">
                        <ul id="detailImgs" style="overflow: hidden;">
                            <li style="display:none;" id="P0">
                        </ul>
                        <span id="hiddenss1"></span>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
