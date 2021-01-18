<!DOCTYPE html>
<html>
<head>
<#include  "../../../inc/js.ftl">

    <script type="text/javascript">
        function save() {
            var formData = new FormData();
            var file = document.getElementById("file").files[0];
            if (fileCheck(file)) {
                formData.append("file", file);
                formData.append("identity", "importType");
                identity = "importType";
                $.ajax({
                    url : "/experimentManagement/report/rawData/importRawDatas",
                    type : 'POST',
                    data : formData,
                    async : false,
                    cache : false,
                    contentType : false,
                    processData : false,
                    success : function(data) {
                        if (data.code == 0) {
                            var searchParames = $('#form_search').serializeObject();
                            searchParames['query.identity'] = "identity";
                            $("#table").datagrid("load", searchParames);
                        } else {
                            $.messager.alert('提示', data.message);
                        }
                    },
                    error : function(data) {
                        $.messager.alert('提示','请求系统失败！！');
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
                        rangelength:[1, 4]
                    },
                    name: {
                        required: true,
                        rangelength:[2, 20]
                    }
                },
                messages : {
                    code: {
                        required: validatew,
                        rangelength: "<span style='color: red; margin-left: 3px;'>*长度为1-4个字符</span>"
                    },
                    name: {
                        required: validatew,
                        rangelength: "<span style='color: red; margin-left: 3px;'>*长度为2-20个字符</span>"
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

        function searchButton() {
                importSearchButton();
        }

        //导入查询弹窗查询事件
        function importSearchButton() {
            var fenceId = $("#id").val();
        /*    var name = $("#name").val();
            var code = $("#code").val();

            var secondaryCoefficient = $("#secondaryCoefficient").val();
            var oneCoefficient = $("#oneCoefficient").val();
            var parameter = $("#parameter").val();
            var secondaryCoefficientAgain = $("#secondaryCoefficientAgain").val();
            var oneCoefficientAgain = $("#oneCoefficientAgain").val();
            var parameterAgain = $("#parameterAgain").val();*/



            var formData = new FormData($("#form_search")[0]);//新建一个类似表单的对象
            var file = document.getElementById("file").files[0];//获取文件对象

                formData.append("file", file);//在表单对象后面插入文件对象,第二个参数是文件对象
/*                formData.append("id", fenceId);
                formData.append("name",name);
                formData.append("code",code);
                formData.append("secondaryCoefficient",secondaryCoefficient);
                formData.append("oneCoefficient",oneCoefficient);
                formData.append("parameter",parameter);
                formData.append("secondaryCoefficientAgain",secondaryCoefficientAgain);
                formData.append("oneCoefficientAgain",oneCoefficientAgain);
                formData.append("parameterAgain",parameterAgain);*/
                $.ajax({
                    url: "importRawDatas",
                    type: 'POST',
                    data: formData,//规定连同请求发送到服务器的数据
                    async: false,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        if (data.flag) {
                            var data = $('#form_search').serializeObject();
                            $('#table').datagrid('reload', data);
                            $.messager.alert('提示', '导入成功！');
                            $("#toolbar").show();
                            $('#table').datagrid('loadData', loadData);
                        } else {
                            $.messager.alert('提示', data.msg);
                        }
                    },
                    error: function (data) {
                        $.messager.alert('提示', '请求系统失败！！');
                    }
                });
        }
    </script>
</head>
<body class="fbody">
<div style="padding: 10px" class="fcontainer">
    <form id="ff" method="post" enctype="" novalidate >
        <input type="hidden" name="id" id="id" value="${(demo1.id)!-1}">
        <table class="table_edit" border="1">
          <#--  <tr>
                <td class="td_label"><label>点样编号:</label></td>
                <td class="td_input">
                    <input type='text' name='code' autocomplete="off" id='code' value="${(demo1.code)!}" placeholder="需要和位置图的点样编号对应" class="input-fat" style="height: 26px;width: 178px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan"style="top:12px;left: 200px;">*</span>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>点样人:</label></td>
                <td class="td_input">
                    <input type='text' name='name' autocomplete="off" id='name' value="${(demo1.name)!}" class="input-fat" style="height: 26px;width: 178px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan"style="top:12px;left: 200px;">*</span>
                </td>
            </tr>-->
            <tr>
                <td class="td_label"  id="filetitle">
                    <label>文件上传:</label>
                </td>
                <td class="td_input" id="fileinput">
                    <input type="file" id="file" style="height: 30px; width: 168px;" name="query.myfile" />
                </td>
            </tr>
           <#-- <tr>
                <td class="td_label"><label>请输入二次拟合公式:</label></td>
                <td class="td_input">
                    <input type='text' name='secondaryCoefficient' autocomplete="off" id='secondaryCoefficient' value="${(demo1.secondaryCoefficient)!}" placeholder="系数"  style="height: 20px;width: 40px"/>
                    <label>x²+</label>
                    <input type='text' name='oneCoefficient' autocomplete="off" id='oneCoefficient' value="${(demo1.oneCoefficient)!}" placeholder="系数"  style="height: 20px;width: 40px"/>
                    <label>x+</label>
                    <input type='text' name='parameter' autocomplete="off" id='parameter' value="${(demo1.parameter)!}" placeholder="系数" style="height: 20px;width: 40px"/>

                    <span name="requireTag" class="requrieTag AbleStevenSpan"style="top:12px;left: 205px;">*</span>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>请输入精确二次拟合公式:</label></td>
                <td class="td_input">
                    <input type='text' name='secondaryCoefficientAgain' autocomplete="off" id='secondaryCoefficientAgain' value="${(demo1.secondaryCoefficientAgain)!}" placeholder="系数"  style="height: 20px;width: 40px"/>
                    <label>x²+</label>
                    <input type='text' name='oneCoefficientAgain' autocomplete="off" id='oneCoefficientAgain' value="${(demo1.oneCoefficientAgain)!}" placeholder="系数" style="height: 20px;width: 40px"/>
                    <label>x+</label>
                    <input type='text' name='parameterAgain' autocomplete="off" id='parameterAgain' value="${(demo1.parameterAgain)!}" placeholder="系数"  style="height: 20px;width: 40px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan"style="top:12px;left: 205px;">*</span>
                </td>
            </tr>-->
        </table>

        <div class="fbox">
            <span class="fbox-left"></span>
            <span>
                    <td colspan="2" style="text-align: right;">
                        <span style="margin-right: 20px">
                            <a href="#" onclick="searchButton()" class="easyui-linkbutton fsave l-btn l-btn-small"
                               data-options="iconCls:'icon-search'">导入</a>
                        <a class="eeasyui-linkbutton fcancel l-btn l-btn-small" href="javascript:void(0)" onclick="cancel()" style="line-height: 25px;">取消</a>
                        </span>
                    </td>
                </span>
        </div>




    </form>
</div>
</body>
</html>
