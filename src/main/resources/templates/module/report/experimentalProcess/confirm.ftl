<!DOCTYPE html>
<html>
<head>
<#include  "../../../inc/meta.ftl">
<#include  "../../../inc/js.ftl">

    <script type="text/javascript">
        function save() {
            var flag=$("#ff").form('validate');

            if(flag){
                $.ajax({
                    url:'/experimentManagement/report/experimentalProcess/confirm',
                    method:'post',
                    data:$("#ff").serialize(),
                    dataType:'json',
                    success:function(data){
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

        /*$(function() {
            var id = $("#id").val();
            if (id != '-1') {
            var url = "getImgsById?id=" + (id);
            $.ajax({
                url: url,
                method: 'post',
                data: id,
                dataType: 'json',
                success: function (data) {
                    if (data != null) {
                        $.each(data, function (i, url) {
                            //拼接图片列表
                            var id = $('#detailImgs li:last').attr('id');
                            id = id.substr(1);
                            id = parseInt(id) + 1;
                            var ids = id;
                            id = 'P' + id;
                            var a_hidden = "<li id='" + id + "'><input type='hidden' id='reportImg' value='" + url + "' name='reportImg'>";
                            var img_html = "<img  src='" + url + "'  onclick='showOriginal(this)' original='" + url + "'>";
                            var a_html = "<a href='javascript:void(0);' onclick='delespan1(" + ids + ")'>删除</a>";
                            var li_html = "</li>";
                            $('#detailImgs').append(a_hidden + img_html + a_html + li_html);
                        });
                    }
                }
            });
        }
                }
        );*/

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
                    experimentalName: {
                        required: true,
                        rangelength:[1, 40]
                    }
                },
                messages : {
                    code: {
                        required: validatew,
                        rangelength: "<span style='color: red; margin-left: 3px;'>*长度为1-40个字符</span>"
                    },
                    experimentalName: {
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


        function setImg2(obj){//用于进行图片上传，返回地址
            var f=$(obj).val();
            if(f == null || f ==undefined || f == ''){
                return false;
            }else if(!/\.(?:png|jpg|bmp|gif|PNG|JPG|BMP|GIF)$/.test(f))
            {
                alertLayel("类型必须是图片(.png|jpg|bmp|gif|PNG|JPG|BMP|GIF)");
                $(obj).val('');
                return false;
            }else{
                //批量上传图片
                $.ajaxFileUpload({
                    url:"/experimentManagement/report/experimentalProcess/uploadImgList",//需要链接到服务器地址
                    secureuri:false,
                    fileElementId:"logoFile2",//文件选择框的id属性  ,//文件选择框的id属性
                    dataType: 'json',   //json
                    contentType: false,    //不可缺
                    processData: false,    //不可缺
                    success: function (data){
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
                                var a_html="<a href='javascript:void(0);' onclick='delespan1("+ids+")'>删除</a>";
                                var li_html="</li>";
                                $('#detailImgs').append(a_hidden+img_html+a_html+li_html);
                            });
                        }else{
                            alertLayel("上传失败");
                            $("#url").val("");
                            $(obj).val('');
                        }
                    },
                    error:function(XMLHttpRequest, textStatus, errorThrown){
                        alertLayel("上传失败，请检查网络后重试");
                        $("#url").val("");
                        $(obj).val('');
                    }
                });
            }
        }
        function delespan1(id){
            $('#P'+id).remove();
        }

        /* CKEDITOR.replace( 'reportContent' );*/
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
        <div class="fbox">
            <span class="fbox-left"></span>
            <span>
                    <td colspan="2" style="text-align: right;">
                        <span style="margin-right: 20px">
                        <input class="easyui-linkbutton fsave l-btn l-btn-small" type="submit" value="确认复核">
                        <a class="eeasyui-linkbutton fcancel l-btn l-btn-small" href="javascript:void(0)" onclick="cancel()" style="line-height: 25px;">取消</a>
                        </span>
                    </td>
                </span>
        </div>
    </form>
</div>
</body>
</html>
