<!DOCTYPE html>
<html>
<head>
<#include  "../../../inc/meta.ftl">
<#include  "../../../inc/js.ftl">

    <script type="text/javascript">
        function save() {
            var flag = $("#ff").form('validate');
            var imgs = [];
            $("input[name='reportImg']").each(function (j, item) {
                imgs.push(item.value)
                //imgs.append(item.value)
                console.log("方法二：" + item.id + ':' + item.value);
            });
            console.log(imgs)
            if (flag) {
                $.ajax({
                    url: 'save',
                    method: 'post',
                    data: $("#ff").serialize(),
                    dataType: 'json',
                    success: function (data) {
                        $.messager.alert("提示", data.msg, "info", function () {
                            if (data.flag) {
                                if (window.top.$("div#window_addCompanyType").length > 0) {
                                    close_win("addCompanyType");
                                } else {
                                    close_win();
                                    window.top.m_sysUnitTypeFrame.window.$("#table").datagrid('reload');
                                }

                            }
                        });
                    },
                    error: function () {
                    }
                });
            }
        }

        function cancel() {
            if (window.top.$("div#window_addCompanyType").length > 0) {
                close_win_affirm($("#id").val(), "addCompanyType");
            } else {
                var id = $("#id").val();
                close_win_affirm(id);
            }
        }


        $(function () {
            //1、获取ID，判断操作为新增还是编辑，其中-1为新增，其他的编辑
            var id = $("#id").val();

            $("#ff").validate({
                onfocusout: function (element) {
                    var boo = $(element).valid();
                    if (boo) {
                        $(element).parent().find(".error").each(function (i) {
                            if (i > 0) {
                                $(this).remove();
                            }
                        });
                    }

                },
                rules: {
                    code: {
                        required: true,
                        rangelength: [1, 40]
                    },
                    fpeople: {
                        required: true,
                        rangelength: [1, 40]
                    },
                    pid: {
                        required: true,
                        rangelength: [1, 40]
                    },
                    fname: {
                        required: true,
                        rangelength: [1, 40]
                    }
                },
                messages: {
                    code: {
                        required: validatew,
                        rangelength: "<span style='color: red; margin-left: 3px;'>*长度为1-40个字符</span>"
                    },
                    fpeople: {
                        required: validatew,
                        rangelength: "<span style='color: red; margin-left: 3px;'>*长度为1-40个字符</span>"
                    }
                    ,
                    pid: {
                        required: validatew,
                        rangelength: "<span style='color: red; margin-left: 3px;'>*长度为1-40个字符</span>"
                    }
                    ,
                    fname: {
                        required: validatew,
                        rangelength: "<span style='color: red; margin-left: 3px;'>*长度为1-40个字符</span>"
                    }
                },
                showErrors: function (errorMap, errorList) {

                    for (var obj in errorMap) {
                        $('#' + obj).parent().find(".AbleStevenSpan:first").css("display", "none");
                        this.defaultShowErrors();

                        $('#' + obj).parent().find(".error").each(function (i) {
                            if (i > 1) {
                                $(this).remove();
                            }
                        });

                        $("#" + obj).parent().find('label:first').removeAttr("for");
                    }

                },
                submitHandler: function (form) {
                    save();
                    return false;
                }
            });
        });


    </script>
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
                           class="input-fat" style="height: 26px;width: 178px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 200px;">*</span>
                </td>
                <td class="td_label"><label>配方名称:</label></td>
                <td class="td_input">
                    <input type='text' name='fname' autocomplete="off" id='fname' value="${(formula.fname)!}"
                           class="input-fat" style="height: 26px;width: 178px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 200px;">*</span>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>配方创建人:</label></td>
                <td class="td_input">
                    <input type='text' name='fpeople' autocomplete="off" id='fpeople' value="${(formula.fpeople)!}"
                           class="input-fat" style="height: 26px;width: 178px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 200px;">*</span>
                </td>
                <td class="td_label"><label>所属项目编号:</label></td>
                <td class="td_input">
                    <input type='text' name='pid' autocomplete="off" id='pid' value="${(formula.pid)!}"
                           class="input-fat" style="height: 26px;width: 178px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 200px;">*</span>
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
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname01)!}">
                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality01' autocomplete="off" id='drugquality01' value="${(formula.drugquality01)!}"
                          style="height: 26px;width: 78px"/>
                    <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname02" id="drugname02"
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname02)!}">

                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality02' autocomplete="off" id='drugquality02' value="${(formula.drugquality02)!}"
                            style="height: 26px;width: 78px"/>
                    <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
            </tr>

            <tr>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname03" id="drugname03"
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname03)!}">
                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality03' autocomplete="off" id='drugquality03' value="${(formula.drugquality03)!}"
                           style="height: 26px;width: 78px"/>
                <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname04" id="drugname04"
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname04)!}">

                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality04' autocomplete="off" id='drugquality04' value="${(formula.drugquality04)!}"
                           style="height: 26px;width: 78px"/>
                <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname05" id="drugname05"
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname05)!}">
                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality05' autocomplete="off" id='drugquality05' value="${(formula.drugquality05)!}"
                           style="height: 26px;width: 78px"/>
                <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname06" id="drugname06"
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname06)!}">

                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality06' autocomplete="off" id='drugquality06' value="${(formula.drugquality06)!}"
                           style="height: 26px;width: 78px"/>
                <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname07" id="drugname07"
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname07)!}">
                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality07' autocomplete="off" id='drugquality07' value="${(formula.drugquality07)!}"
                           style="height: 26px;width: 78px"/>
                <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname08" id="drugname08"
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname08)!}">

                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality08' autocomplete="off" id='drugquality08' value="${(formula.drugquality08)!}"
                           style="height: 26px;width: 78px"/>
                <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname09" id="drugname09"
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname09)!}">
                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality09' autocomplete="off" id='drugquality09' value="${(formula.drugquality09)!}"
                           style="height: 26px;width: 78px"/>
                <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname10" id="drugname10"
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname10)!}">

                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality10' autocomplete="off" id='drugquality10' value="${(formula.drugquality10)!}"
                           style="height: 26px;width: 78px"/>
                <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname11" id="drugname11"
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname11)!}">
                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality11' autocomplete="off" id='drugquality11' value="${(formula.drugquality11)!}"
                           style="height: 26px;width: 78px"/>
                <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname12" id="drugname12"
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname12)!}">

                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality12' autocomplete="off" id='drugquality12' value="${(formula.drugquality12)!}"
                           style="height: 26px;width: 78px"/>
                <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname13" id="drugname13"
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname13)!}">
                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality13' autocomplete="off" id='drugquality13' value="${(formula.drugquality13)!}"
                           style="height: 26px;width: 78px"/>
                <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname14" id="drugname14"
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname14)!}">

                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality14' autocomplete="off" id='drugquality14' value="${(formula.drugquality14)!}"
                           style="height: 26px;width: 78px"/>
                <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname15" id="drugname15"
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname15)!}">
                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality15' autocomplete="off" id='drugquality15' value="${(formula.drugquality15)!}"
                           style="height: 26px;width: 78px"/>
                <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname16" id="drugname16"
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname16)!}">

                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality16' autocomplete="off" id='drugquality16' value="${(formula.drugquality16)!}"
                           style="height: 26px;width: 78px"/>
                <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname17" id="drugname17"
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname17)!}">
                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality17' autocomplete="off" id='drugquality17' value="${(formula.drugquality17)!}"
                           style="height: 26px;width: 78px"/>
                <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname18" id="drugname18"
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname18)!}">

                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality18' autocomplete="off" id='drugquality18' value="${(formula.drugquality18)!}"
                           style="height: 26px;width: 78px"/>
                <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname19" id="drugname19"
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname19)!}">
                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality19' autocomplete="off" id='drugquality19' value="${(formula.drugquality19)!}"
                           style="height: 26px;width: 78px"/>
                <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
                <td class="td_label"><label>药品名称：</label></td>
                <td class="td_input">
                    <input type="text" class="input-fat input" name="drugname20" id="drugname20"
                           onfocus="top.openSelectDialog(this,'选择药品','/experimentManagement/dialog/dosage.htm', 550, 620)"
                           onkeyup="value=''"
                           value="${(formula.drugname20)!}">

                    <a href="javascript:void(0);" style="top:8px;left: 230px;" class="clear" onclick="top.clearInputValue(this)">X</a>
                </td>
                <td class="td_label"><label>质量：</label></td>
                <td class="td_input">
                    <input type='text' name='drugquality20' autocomplete="off" id='drugquality20' value="${(formula.drugquality20)!}"
                           style="height: 26px;width: 78px"/>
                <#--<span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 100px;">*</span>-->
                </td>
            </tr>

        </table>




        <div class="fbox">
            <span class="fbox-left"></span>
            <span>
                    <td colspan="2" style="text-align: right;">
                        <span style="margin-right: 20px">
                        <input class="easyui-linkbutton fsave l-btn l-btn-small" type="submit" value="提交">
                        <a class="eeasyui-linkbutton fcancel l-btn l-btn-small" href="javascript:void(0)"
                           onclick="cancel()" style="line-height: 25px;">取消</a>
                        </span>
                    </td>
                </span>
        </div>
    </form>

</div>

</body>
</html>
