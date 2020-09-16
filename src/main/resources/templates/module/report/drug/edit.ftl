<!DOCTYPE html>
<html>
<head>
<#include  "../../../../inc/meta.ftl">
<#include  "../../../../inc/js.ftl">

    <script type="text/javascript">
        function save() {
            var flag=$("#ff").form('validate');
            var imgs=[];
            $("input[name='reportImg']").each(function(j,item){
                imgs.push(item.value)
                //imgs.append(item.value)
                console.log("方法二："+item.id+':'+item.value);
            });
            console.log(imgs)
            if(flag){
                $.ajax({
                    url:'save',
                    method:'post',
                    data:$("#ff").serialize(),
                    dataType:'json',
                    success:function(data){
                        $.messager.alert("提示", data.msg, "info", function () {
                            if (data.flag) {
                                if(window.top.$("div#window_addCompanyType").length > 0){
                                    close_win("addCompanyType");
                                }else{
                                    close_win();
                                    window.top.m_sysUnitTypeFrame.window.$("#table").datagrid('reload');
                                }

                            }
                        });
                    },
                    error:function(){
                    }
                });
            }
        }
        function cancel() {
            if(window.top.$("div#window_addCompanyType").length>0){
                close_win_affirm($("#id").val(), "addCompanyType");
            }else{
                var id = $("#id").val();
                close_win_affirm(id);
            }
        }



        $(function () {
            //1、获取ID，判断操作为新增还是编辑，其中-1为新增，其他的编辑
            var id = $("#id").val();

            $("#ff").validate({
                onfocusout:function(element) {
                    var boo = $(element).valid();
                    if(boo) {
                        $(element).parent().find(".error").each(function(i){
                            if(i > 0) {
                                $(this).remove();
                            }
                        });
                    }

                },
                rules : {
                    code : {
                        required: true,
                        rangelength:[1, 40]
                    },
                    dname: {
                        required: true,
                        rangelength:[1, 40]
                    },
                    dgauge: {
                        required: true,
                        rangelength:[1, 40]
                    },
                    dmolecular: {
                        required: true,
                        rangelength:[1, 40]
                    }
                },
                messages : {
                    code: {
                        required: validatew,
                        rangelength: "<span style='color: red; margin-left: 3px;'>*长度为1-40个字符</span>"
                    },
                    dname: {
                        required: validatew,
                        rangelength: "<span style='color: red; margin-left: 3px;'>*长度为1-40个字符</span>"
                    }
                    ,
                    dgauge: {
                        required: validatew,
                        rangelength: "<span style='color: red; margin-left: 3px;'>*长度为1-40个字符</span>"
                    }
                    ,
                    dmolecular: {
                        required: validatew,
                        rangelength: "<span style='color: red; margin-left: 3px;'>*长度为1-40个字符</span>"
                    }
                },
                showErrors: function(errorMap, errorList) {

                    for(var obj in errorMap) {
                        $('#' + obj).parent().find(".AbleStevenSpan:first").css("display", "none");
                        this.defaultShowErrors();

                        $('#' + obj).parent().find(".error").each(function(i) {
                            if(i > 1) {
                                $(this).remove();
                            }
                        });

                        $("#" + obj).parent().find('label:first').removeAttr("for");
                    }

                },
                submitHandler:function(form){
                    console.log($("div#window_addCompanyType").length);
                    save();
                    return false;
                }
            });
        });




    </script>
</head>
<body class="fbody">
<div style="padding: 10px" class="fcontainer">
    <form id="ff" method="post" enctype="" novalidate >
        <input type="hidden" name="id" id="id" value="${(experimentalStage.id)!-1}">
        <table class="table_edit" border="1">
            <tr>
                <td class="td_label"><label>物料编号:</label></td>
                <td class="td_input">
                    <input type='text' name='code' autocomplete="off" id='code' value="${(drug.code)!}" class="input-fat" style="height: 26px;width: 178px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan"style="top:12px;left: 200px;">*</span>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>药品名称:</label></td>
                <td class="td_input">
                    <input type='text' name='dname' autocomplete="off" id='dname' value="${(drug.dname)!}" class="input-fat" style="height: 26px;width: 178px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan"style="top:12px;left: 200px;">*</span>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>规格:</label></td>
                <td class="td_input">
                    <input type='text' name='dgauge' autocomplete="off" id='dgauge' value="${(drug.dgauge)!}" class="input-fat" style="height: 26px;width: 178px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan"style="top:12px;left: 200px;">*</span>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>分子量:</label></td>
                <td class="td_input">
                    <input type='text' name='dmolecular' autocomplete="off" id='dmolecular' value="${(drug.dmolecular)!}" class="input-fat" style="height: 26px;width: 178px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan"style="top:12px;left: 200px;">*</span>
                </td>
            </tr>
        </table>
        <div class="fbox">
            <span class="fbox-left"></span>
            <span>
                    <td colspan="2" style="text-align: right;">
                        <span style="margin-right: 20px">
                        <input class="easyui-linkbutton fsave l-btn l-btn-small" type="submit" value="提交">
                        <a class="eeasyui-linkbutton fcancel l-btn l-btn-small" href="javascript:void(0)" onclick="cancel()" style="line-height: 25px;">取消</a>
                        </span>
                    </td>
                </span>
        </div>
    </form>
</div>
</body>
</html>
