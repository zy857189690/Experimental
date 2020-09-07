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
                    name: {
                        required: true,
                        rangelength:[2, 20]
                    }
                },
                messages : {
                    code: {
                        required: validatew,
                        rangelength: "<span style='color: red; margin-left: 3px;'>*长度为1-40个字符</span>"
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
                    url:"/jiliReport/report/experimentalStage/uploadImgList",//需要链接到服务器地址
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
    <form id="ff" method="post" enctype="" novalidate >
        <input type="hidden" name="id" id="id" value="${(experimentalStage.id)!-1}">
        <table class="table_edit" border="1">
            <tr>
                <td class="td_label"><label>实验编号:</label></td>
                <td class="td_input">
                    <input type='text' name='reportCode' autocomplete="off" id='reportCode' value="${(experimentalStage.reportCode)!}" class="input-fat" style="height: 26px;width: 178px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan"style="top:12px;left: 200px;">*</span>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>报告人:</label></td>
                <td class="td_input">
                    <input type='text' name='reportUserName' autocomplete="off" id='reportUserName' value="${(experimentalStage.reportUserName)!}" class="input-fat" style="height: 26px;width: 178px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan"style="top:12px;left: 200px;">*</span>
                </td>
                <td class="td_label"><label>报告时间:</label></td>
                <td class="td_input">
                    <input type='text' name='reportTime' autocomplete="off" id='reportTime' value="${(experimentalStage.reportTime)!}" class="input-fat" style="height: 26px;width: 178px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan"style="top:12px;left: 200px;">*</span>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td class="td_label"><label>理论配方:</label></td>
                <td class="td_input">
                    <input type='text' name='theoreticalFormula' autocomplete="off" id='theoreticalFormula' value="${(experimentalStage.theoreticalFormula)!}"  style="height: 26px;width: 800px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan">*</span>
                </td>
            </tr>

            <tr>
                <td class="td_label"><label>实际配方:</label></td>
                <td class="td_input">
                    <input type='text' name='actualFormula' autocomplete="off" id='actualFormula' value="${(experimentalStage.actualFormula)!}"  style="height: 26px;width: 800px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan">*</span>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>报告内容:</label></td>
                <td class="td_input">
                    <textarea name="reportContent" id="reportContent"  clos="1800" rows="10" style="width: 800px;height: 150px" >${(experimentalStage.reportContent)!}</textarea>
                    <span name="requireTag" class="requrieTag AbleStevenSpan">*</span>
                </td>
            </tr>
            <tr>
                <td class="td_label"><label>实验图片上传:</label></td>

                <td class="td_input" id="fileinput">
                    <a href="javascript:void(0);" class="btn_addPic">
                        <input type="file" name="file" id="logoFile2" onchange="setImg2(this);" class="selectedLogoImgId"
                               accept="image/jpg,image/jpeg,image/png,image/bmp" multiple/>
                    </a>
                    <br/>
                    <font color="red">图片尺寸：750*300（支持多图批量上传）</font>
                    <div class="cp-img" id="logoImgDiv6">
                        <ul id="detailImgs" style="overflow: hidden;">
                            <li style="display:none;" id="P0">
                        </ul>
                        <span id="hiddenss1"></span>
                    </div>
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
