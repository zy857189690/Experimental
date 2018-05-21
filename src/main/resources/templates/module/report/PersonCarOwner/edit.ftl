<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<#include "../../../inc/meta.ftl">
<#include  "../../../inc/js.ftl">
    <style type="text/css">

        #post_form img{
            width: 96px;
            height:57px;
        }

        .mt10{
            margin-top: 10px;
        }
        .tab_item {
            text-align: right;
            width:30%;
        }
        .select_item{
            width: 180px;
            height:22px;
        }
        i:before {
            content: "* ";
            line-height: 30px;overflow-x: ;
            color: red;
            margin-left: 5px;
        }

        span{
            font-style: normal;
        }
        table{
            border-collapse:separate; border-spacing:10px;
        }
        td{
            width:200px;
            word-break:break-all;
        }
        .clearInput{
            margin-left: 156px;
            margin-top:-23px;
            display: block;
            position:relative
        }
    </style>
    <script language="javascript">
        var flag = 0;
        //查找车辆
        function findvin() {
            var title = "查找车辆";
            var url = "/module-demo/select/findvin";
            openEditWin(url, title);
        }
        function findpersonal() {
            var title = "查找个人车主";
            var url = "/module-demo/select/findpersonal";
            openEditWin(url,title);
        }
        function openEditWin(url,title,width,height) {
            var winid = "user";
            if(width==undefined){
                width=600;
                height=560;
            }
            top.my_window(winid, url, title, width, height);
        }

        function save() {
            var formData = {};
            formData.id=$("#id").val(),
            formData.ownerName=$("#ownerName").val(),
            formData.sex=$("#sex").val(),
            formData.pic1=$("#image1").attr("src"),
            formData.pic2=$("#image2").attr("src"),
            formData.facePic=$("#image3").attr("src"),
            formData.ownerCertType=$("#ownerCertType").val(),
            formData.ownerCertId=$("#ownerCertId").val(),
            formData.ownerCertAddr=$("#ownerCertAddr").val(),
            formData.mobilePhone=$("#mobilePhone").val(),
            formData.address=$("#address").val(),
            formData.email=$("#email").val();
            if (!validImages(formData)){
                return;
            }
            $.ajax({
                url : "${base}/personCarOwner/save",
                type : 'POST',
                data : formData,
                beforeSend:function(){
                    if ($("#post_form").form('validate')) {
                        return true
                    }
                    return false;
                },
                success : function(data) {
                    if (data.code == 0){
                        $.messager.alert("提示",data.message,"info",function(){
                            close_win();
                            window.top.m_personCarOwnerFrame.$("#table").datagrid('reload');
                        });
                    }else{
                        alert(data.message);
                    }
                },
                error : function(responseStr) {
                    console.log("error");
                }
            });
        }

        function validImages(formData) {
            if (validateInfor(formData.pic1)){
                $("#image1").parent().nextAll().remove();
                $("#image1").parent().after("<div style='margin:3px;float: left;'><span style='color: red;line-height: 90px '>请上传证件正面</span></div>");
                // alert("请上传证件正面");
                return false;
            }
            if (validateInfor(formData.pic2)){
                $("#image2").parent().nextAll().remove();
                $("#image2").parent().after("<div style=' margin:3px;float: left;'><span style='color: red;line-height: 90px '>请上传证件背面</span></div>");
                // alert("请上传证件背面");
                return false;
            }
            if (validateInfor(formData.facePic)){
                $("#image3").parent().nextAll().remove();
                $("#image3").parent().after("<div style='margin:3px;float: left;'><span style='color: red;line-height: 90px '>请上传手持证件照</span></div>");
                // alert("请上传手持证件照");
                return false;
            }
            return true;
        }

        function validateInfor(val) {
            if(val == null || val == "" || val == '${base}/images/u505.png'){
                return true;
            }else {
                return false;
            }
        }
    </script>
</head>
<body>
<div class="easyui-layout" fit="true">
    <div region="center" style="overflow: hidden;width: 50%;" >
        <form id="post_form" method="post" novalidate enctype="multipart/form-data">
            <input type="file" name="file" class="hide" id="imagefile" onchange="doUpload(this)"/>
            <div align="center"id="tab1">
                <table width="90%" class="mt10">
                    <tr class="hide">
                        <td class="tab_item"><i><span>ID</span></td>
                        <td> <input style="width:180px;" id="id" value="${(sysOwnerPeopleEntity.id)!}"  name="id" type="hidden" class="easyui-textbox input"/>
                        </td>
                    </tr>

                    <tr>
                        <td class="tab_item"><i><span>姓名</span></td>
                        <td> <input style="width:180px;" value="${(sysOwnerPeopleEntity.ownerName)!}"  validType="length[0,255]" id="ownerName" name="ownerName" type="text" data-options="required:true" class="easyui-textbox input"/>
                            <a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><i><span>性别</span></td>
                        <td>
                            <select class="select_item" id="sex" name="sex"  data-options="required:true">
                                <option value="M" selected>男</option>
                                <option value ="F" <#if (((sysOwnerPeopleEntity.sex)!'')=="F")>selected</#if>>女</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><i><span>证件类型</span></td>
                        <td>
                            <select class="select_item" id="ownerCertType" name="ownerCertType"  data-options="required:true">
                                <option value ="IDCARD" selected>居民身份证</option>
                                <option value ="HKIDCARD" <#if (((sysOwnerPeopleEntity.ownerCertType)!'')=="HKIDCARD")>selected</#if>>港澳居民来往内地通行证</option>
                                <option value ="OTHERLICENCE" <#if (((sysOwnerPeopleEntity.ownerCertType)!'')=="OTHERLICENCE")>selected</#if>>其他</option>
                                <option value ="PASSPORT" <#if (((sysOwnerPeopleEntity.ownerCertType)!'')=="PASSPORT")>selected</#if>>护照</option>
                                <option value ="PLA" <#if (((sysOwnerPeopleEntity.ownerCertType)!'')=="PLA")>selected</#if>>军官证</option>
                                <option value ="POLICEPAPER" <#if (((sysOwnerPeopleEntity.ownerCertType)!'')=="POLICEPAPER")>selected</#if>>警官证</option>
                                <option value ="TAIBAOZHENG" <#if (((sysOwnerPeopleEntity.ownerCertType)!'')=="TAIBAOZHENG")>selected</#if>>台湾居民来往大陆通行证</option>
                                <option value ="UNITCREDITCODE" <#if (((sysOwnerPeopleEntity.ownerCertType)!'')=="UNITCREDITCODE")>selected</#if>>统一社会信用代码</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><i><span>证件号码</span></td>
                        <td> <input style="width:180px;" value="${(sysOwnerPeopleEntity.ownerCertId)!}" id="ownerCertId" validType="ownerCertId[8,30]"  name="ownerCertId" type="text"  data-options="required:true"  class="easyui-textbox input"/>
                            <a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>所有人证件地址</span></td>
                        <td>
                            <input style="width:180px;" value="${(sysOwnerPeopleEntity.ownerCertAddr)!}"  validType="length[3,50]" id="ownerCertAddr" name="ownerCertAddr"  type="text" class="easyui-textbox input"/>
                            <a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><i><span>证件照片</span></td>
                        <td>
                            <div style="width: 100px;height: 90px;float: left">
                                <#if (sysOwnerPeopleEntity.pic1)?? &&(sysOwnerPeopleEntity.pic1)!="" >
                                         <img id="image1" src="${(sysOwnerPeopleEntity.pic1)!}"style="float:left;"  alt="点击上传证件正面图片" onclick="flag=1;document.getElementById('imagefile').click();">
                                <#else >
                                        <img id="image1" src="${base}/images/u505.png"style="float:left;"  alt="点击上传证件正面图片" onclick="flag=1;document.getElementById('imagefile').click();">
                                </#if>
                                <div style="text-align: center">
                                    证件正面
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"></td>
                        <td>
                            <div style="width: 100px;height: 60px;float: left;">
                                <#if (sysOwnerPeopleEntity.pic2)?? &&(sysOwnerPeopleEntity.pic2)!="" >
                                    <img id="image2" src="${(sysOwnerPeopleEntity.pic2)!}"style="float:left;"  alt="点击上传证件正面图片" onclick="flag=2;document.getElementById('imagefile').click();">
                                <#else >
                                        <img id="image2" src="${base}/images/u505.png" style="float:left;"  alt="点击上传证件正面图片" onclick="flag=2;document.getElementById('imagefile').click();">
                                </#if>
                                <div style="text-align: center">
                                    证件背面
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><i><span>手持证件照</span></td>
                        <td>
                            <div style="width: 100px;height: 90px;float: left;margin-top: 15px">
                                 <#if (sysOwnerPeopleEntity.facePic)?? &&(sysOwnerPeopleEntity.facePic)!="" >
                                     <img id="image3" src="${(sysOwnerPeopleEntity.facePic)!}"style="float:left;" alt="点击上传证件正面图片" onclick="flag=3;document.getElementById('imagefile').click();">
                                 <#else >
                                    <img id="image3" src="${base}/images/u505.png"style="float:left;" alt="点击上传证件正面图片" onclick="flag=3;document.getElementById('imagefile').click();">
                                 </#if>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><i><span>联系电话</span></td>
                        <td> <input style="width:180px;" value="${(sysOwnerPeopleEntity.mobilePhone)!}" validType='phoneNum' id="mobilePhone" name="mobilePhone"  data-options="required:true" type="text" class="easyui-textbox input"/>
                            <a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>联系地址</span></td>
                        <td> <input style="width:180px;" value="${(sysOwnerPeopleEntity.address)!}" validType="length[3,50]" id="address" name="address"  type="text" class="easyui-textbox input"/>
                            <a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>邮箱</span></td>
                        <td> <input style="width:180px;" invalidMessage="请输入正确的邮箱" validType='email' value="${(sysOwnerPeopleEntity.email)!}" id="email" name="email" type="text" class="easyui-textbox input"/>
                            <a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a></td>
                    </tr>

                    <tr style="text-align: center">
                        <td colspan="2">
                            <a class="easyui-linkbutton fsave"  href="javascript:void(0)" onclick="save()">保存</a>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
</body>

<script type="text/javascript">

    $("img").on('load', function() {
        $(this).parent().nextAll().remove();
        $(this).off('load')
    });

    $(function () {
        initValid();
    })

    function doUpload(obj) {
        var file = obj.files[0];

        if (!/image\/\w+/.test(file.type)){
            alert("文件必须是图片");
            return false;
        }
        var formData = new FormData($("#post_form")[0]);
        $.ajax({
            url:'${base}/personCarOwner/upload',
            type:"post",
            data:formData,
            async:false,
            cache:false,
            contentType:false,
            processData:false,
            success:function (data) {
                if (data.status == 0){
                    if (flag == 1){
                        $("#image1").attr("src", data.url);
                    }else if (flag == 2){
                        $("#image2").attr("src", data.url);
                    }else if (flag ==3){
                        $("#image3").attr("src", data.url);
                    }
                }
                $('#imagefile').val('');
                flag = 0;
                console.log(data);
            },
            error:function (data) {
                console.log(data);
            }
        });
    }
</script>
</html>