<!DOCTYPE html>
<html>
<head>
    <#include  "../../../inc/meta.ftl">
    <#include  "../../../inc/js.ftl">

    <script type="text/javascript">
        function save() {
            var flag = $("#ff").form('validate');
            if (flag) {
                $.ajax({
                    url: '/experimentManagement/report/demo1/save',
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
                                    window.top.m_Frame.window.$("#table").datagrid('reload');
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
            //2、初始化组件,比如初始化combotree,combogrid之类的
            //3、编辑
            if (id != '-1') {
//                $("#code").textbox("readonly", true);
                //$("#name").textbox("readonly", true);
                // $("#code").attr("readonly", true);
            }
            //4、新增
            else {
            }
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
                    name: {
                        required: true,
                        rangelength: [2, 20]
                    }
                },
                messages: {
                    code: {
                        required: validatew,
                        rangelength: "<span style='color: red; margin-left: 3px;'>*长度为1-40个字符</span>"
                    },
                    name: {
                        required: validatew,
                        rangelength: "<span style='color: red; margin-left: 3px;'>*长度为2-20个字符</span>"
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
    <form id="ff" method="post" enctype="" novalidate>
        <input type="hidden" name="id" id="id" value="${(demo1.id)!-1}">
        <table class="table_edit" border="1">
            <tr>
                <td class="td_label"><label>点样编号:</label></td>
                <td class="td_input">
                    <input type='text' name='code' autocomplete="off" id='code' value="${(demo1.code)!}"
                           class="input-fat" style="height: 26px;width: 178px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 200px;">*</span>
                </td>
                <td class="td_label"><label>点样人:</label></td>
                <td class="td_input">
                    <input type='text' name='name' autocomplete="off" id='name' value="${(demo1.name)!}"
                           class="input-fat" style="height: 26px;width: 178px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan" style="top:12px;left: 200px;">*</span>
                </td>
            </tr>

        </table>
        <table>
            <tr>

                <td class="td_input">
                    <input type='text' name='hno01' autocomplete="off" id='hno01' value="pbs"
                           style="height: 26px;width: 50px ;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno02' autocomplete="off" id='hno02' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno03' autocomplete="off" id='hno03' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno04' autocomplete="off" id='hno04' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno05' autocomplete="off" id='hno05' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno06' autocomplete="off" id='hno06' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno07' autocomplete="off" id='hno07' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno08' autocomplete="off" id='hno08' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno09' autocomplete="off" id='hno09' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno10' autocomplete="off" id='hno10' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno11' autocomplete="off" id='hno11' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno12' autocomplete="off" id='hno12' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
            </tr>
            <tr>

                <td class="td_input">
                    <input type='text' name='hno13' autocomplete="off" id='hno13' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno14' autocomplete="off" id='hno14' value="200"
                           style="height: 26px;width: 50px" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno15' autocomplete="off" id='hno15' value="100"
                           style="height: 26px;width: 50px" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno16' autocomplete="off" id='hno16' value="50"
                           style="height: 26px;width: 50px" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno17' autocomplete="off" id='hno17' value="20"
                           style="height: 26px;width: 50px" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno18' autocomplete="off" id='hno18' value="10"
                           style="height: 26px;width: 50px" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno19' autocomplete="off" id='hno19' value="5"
                           style="height: 26px;width: 50px" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno20' autocomplete="off" id='hno20' value="2"
                           style="height: 26px;width: 50px" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno21' autocomplete="off" id='hno21' value="1"
                           style="height: 26px;width: 50px" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno22' autocomplete="off" id='hno22' value="0"
                           style="height: 26px;width: 50px" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno23' autocomplete="off" id='hno23' value="pbs"
                           style="height: 26px;width: 50px" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno24' autocomplete="off" id='hno24' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>

            </tr>

            <tr>

                <td class="td_input">
                    <input type='text' name='hno25' autocomplete="off" id='hno25' value="pbs"
                           style="height: 26px;width: 50px ;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno26' autocomplete="off" id='hno26' value="${(demo1.hno26)!}"
                           style="height: 26px;width: 50px" />
                </td>
                <td class="td_input">
                    <input type='text' name='hno27' autocomplete="off" id='hno27' value="${(demo1.hno27)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno28' autocomplete="off" id='hno28' value="${(demo1.hno28)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno29' autocomplete="off" id='hno29' value="${(demo1.hno29)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno30' autocomplete="off" id='hno30' value="${(demo1.hno30)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno31' autocomplete="off" id='hno31' value="${(demo1.hno31)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno32' autocomplete="off" id='hno32' value="${(demo1.hno32)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno33' autocomplete="off" id='hno33' value="${(demo1.hno33)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno34' autocomplete="off" id='hno34' value="${(demo1.hno34)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno35' autocomplete="off" id='hno35' value="${(demo1.hno35)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno36' autocomplete="off" id='hno36' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
            </tr>


            <tr>

                <td class="td_input">
                    <input type='text' name='hno37' autocomplete="off" id='hno37' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno38' autocomplete="off" id='hno38' value="${(demo1.hno38)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno39' autocomplete="off" id='hno39' value="${(demo1.hno39)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno40' autocomplete="off" id='hno40' value="${(demo1.hno40)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno41' autocomplete="off" id='hno41' value="${(demo1.hno41)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno42' autocomplete="off" id='hno42' value="${(demo1.hno42)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno43' autocomplete="off" id='hno43' value="${(demo1.hno43)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno44' autocomplete="off" id='hno44' value="${(demo1.hno44)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno45' autocomplete="off" id='hno45' value="${(demo1.hno45)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno46' autocomplete="off" id='hno46' value="${(demo1.hno46)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno47' autocomplete="off" id='hno47' value="${(demo1.hno47)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno48' autocomplete="off" id='hno48' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
            </tr>
            <tr>

                <td class="td_input">
                    <input type='text' name='hno49' autocomplete="off" id='hno49' value="pbs"
                           style="height: 26px;width: 50px ;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno50' autocomplete="off" id='hno50' value="${(demo1.hno50)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno51' autocomplete="off" id='hno51' value="${(demo1.hno51)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno52' autocomplete="off" id='hno52' value="${(demo1.hno52)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno53' autocomplete="off" id='hno53' value="${(demo1.hno53)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno54' autocomplete="off" id='hno54' value="${(demo1.hno54)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno55' autocomplete="off" id='hno55' value="${(demo1.hno55)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno56' autocomplete="off" id='hno56' value="${(demo1.hno56)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno57' autocomplete="off" id='hno57' value="${(demo1.hno57)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno58' autocomplete="off" id='hno58' value="${(demo1.hno58)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno59' autocomplete="off" id='hno59' value="${(demo1.hno59)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hn60' autocomplete="off" id='hno60' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
            </tr>
            <tr>

                <td class="td_input">
                    <input type='text' name='hno61' autocomplete="off" id='hno61' value="pbs"
                           style="height: 26px;width: 50px ;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno62' autocomplete="off" id='hno62' value="${(demo1.hno62)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno63' autocomplete="off" id='hno63' value="${(demo1.hno63)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno64' autocomplete="off" id='hno64' value="${(demo1.hno64)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno65' autocomplete="off" id='hno65' value="${(demo1.hno65)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno66' autocomplete="off" id='hno66' value="${(demo1.hno66)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno67' autocomplete="off" id='hno67' value="${(demo1.hno67)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno68' autocomplete="off" id='hno68' value="${(demo1.hno68)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno69' autocomplete="off" id='hno69' value="${(demo1.hno69)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno70' autocomplete="off" id='hno70' value="${(demo1.hno70)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno71' autocomplete="off" id='hno71' value="${(demo1.hno71)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno72' autocomplete="off" id='hno72' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
            </tr>
            <tr>

                <td class="td_input">
                    <input type='text' name='hno73' autocomplete="off" id='hno73' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno74' autocomplete="off" id='hno74' value="${(demo1.hno74)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno75' autocomplete="off" id='hno75' value="${(demo1.hno75)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno76' autocomplete="off" id='hno76' value="${(demo1.hno76)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno77' autocomplete="off" id='hno77' value="${(demo1.hno77)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno78' autocomplete="off" id='hno78' value="${(demo1.hno78)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno79' autocomplete="off" id='hno79' value="${(demo1.hno79)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno80' autocomplete="off" id='hno80' value="${(demo1.hno80)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno81' autocomplete="off" id='hno81' value="${(demo1.hno81)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno82' autocomplete="off" id='hno82' value="${(demo1.hno82)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno83' autocomplete="off" id='hno83' value="${(demo1.hno83)!}"
                           style="height: 26px;width: 50px"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno84' autocomplete="off" id='hno84' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
            </tr>

            <tr>

                <td class="td_input">
                    <input type='text' name='hno85' autocomplete="off" id='hno85' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno86' autocomplete="off" id='hno86' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno87' autocomplete="off" id='hno87' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno88' autocomplete="off" id='hno88' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno89' autocomplete="off" id='hno89' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno90' autocomplete="off" id='hno90' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly"/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno91' autocomplete="off" id='hno91' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno92' autocomplete="off" id='hno92' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno93' autocomplete="off" id='hno93' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno94' autocomplete="off" id='hno94' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno95' autocomplete="off" id='hno95' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno96' autocomplete="off" id='hno96' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
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
