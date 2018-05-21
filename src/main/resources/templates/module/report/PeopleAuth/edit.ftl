<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<#include "../../../inc/meta.ftl">
<#include  "../../../inc/js.ftl">
    <style type="text/css">
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
        .sub_title{
            height: 30px;
            margin: 8px;
            color: #333333;
            text-align: center;
            font-size: 1.5em;
            font-weight: 600;
            background-color: #F2F2F2;
        }
        i:before {
            content: "* ";
            line-height: 30px;overflow-x: ;
            color: red;
            margin-left: 5px;
        }

        .submit_button{
            padding: 5px 30px;
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
        .submit_group{
            width: 100%;
            text-align: center;
        }
        .clearInput{
            margin-left: 156px;
            margin-top:-23px;
            display: block;
            position:relative;
            width: 8px;
        }
        #post_form img{
            width: 96px;
            height:57px;
        }
    </style>
    <script language="javascript">
        var iframe_name = 'm_UpdateAuthFrame';
        $(document).ready(function(){

            $("#hide").click(function(){
                $("#tab1").show();
                $("#tab2").hide();
            });
        });
        function initResultSelect(){
            $("#hide").click(function(){
                $("#tab1").show();
                $("#tab2").hide();
            });
            $("#show").click(function(){
                $("#tab1").hide();
                $("#tab2").show();
            });
        }
        //保存
        function save() {
            if($("#post_form").form('validate')){
                var mainData = form2Object("post_form");
                if(!validImg(mainData)) return;
                $.ajax({
                    type : 'post',
                    url : '${base}/PeopleAuth/updateInformation',
                    data : mainData,
                    success : function(data) {
                        $.messager.alert("提示",data.message,'info',function(){
                            <#--closeCurrentTab('SIM实名认证', '${base}/PeopleAuth/list?flag=0', iframe_name);-->
                            refresh();
                        });
                    }
                });
            }
        }
        function refresh() {
            window.top.renovate.datagrid("load");
            //处理列表刷新
            var tab = window.parent.$('#centerTabs').tabs('getSelected');//获取当前选中tabs
            var index = window.parent.$('#centerTabs').tabs('getTabIndex', tab);//获取当前选中tabs的index
            window.parent.$('#centerTabs').tabs('close', index);//关闭对应index的tabs
            parent.$('#centerTabs').tabs('select', 'SIM卡实名认证')
        }

        /**
         * 关闭当前也签,不传参数只关闭当前也签
         */
        function closeCurrentTab(title, url, id, icon, fullScreen,openNewTab) {

            var tab=window.parent.$('#centerTabs').tabs('getSelected');//获取当前选中tabs
            var index = window.parent.$('#centerTabs').tabs('getTabIndex',tab);//获取当前选中tabs的index
            if(typeof(title) == 'undefined'){
                window.parent.$('#centerTabs').tabs('close',index);//关闭对应index的tabs
                return;
            }
            addNewTab(title, url, id, icon, fullScreen,openNewTab);
            window.top.m_UpdateAuthFrame.$("#tableTabsOn").tabs('select',"个人实名认证");
            window.top.m_UpdateAuthFrame.indextab2.$("#table").datagrid('reload');
            window.parent.$('#centerTabs').tabs('close',index);//关闭对应index的tabs

        }
        //保存并提交
        function commit(_param){
            if($("#post_form").form('validate')){
                var mainData = form2Object("post_form");
                if(!validImg(mainData)) return;
                $.ajax({
                    type : 'post',
                    url : '${base}/PeopleAuth/updatePeopleAuth?param='+_param,
                    data : mainData,
                    success : function(data) {
                        if (data.code == 2){
                            if (_param == "Cover"){
                                return;
                            }
                            $.messager.confirm("操作提示", data.message, function (data) {
                                if (data){
                                    commit("Cover");
                                }
                            });
                        }else{
                            $.messager.alert("提示",data.message,'info',function(){
                                if(data.code==0){
                                    to_reasult_page(data.data);
                                }
                            });
                        }
                    }
                });
            }
        }


        function validImg(formData){
            if (validateInfor(formData.pic1)){
                alert("请上传证件正面");
                return false;
            }
            if (validateInfor(formData.pic2)){
                alert("请上传证件背面");
                return false;
            }
            if (validateInfor(formData.facePic)){
                alert("请上传手持证件照");
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

        function to_reasult_page(result) {
            initResultSelect();
            console.log(result);
            window.top.reload.datagrid("load");
            $("#re_sim").text($('#simCartNumber').val());
            $("#re_iccid").text($('#iccid').val());
            $("#re_vin").text($('#vin').val());
            $("#re_name").text($('#ownerName').val());
            $("#re_own_type").text($("#ownerCertType").find("option:selected").text());
            $("#re_own_num").text($('#ownerCertId').val());
            $("#re_phone").text($('#mobilePhone').val());
            var type = null;
            if(result.authenticationResult = 1){
                type='认证中';
            }else if(result.authenticationResult =2){
                type='认证成功';
            }else if(result.authenticationResult =3){
                type='未通过';
            }
            $('#re_result').text(type);
            $('#re_info').text(result.remarks);
            //禁用input
            $(':input,select').attr("readOnly",true);
            $('select').attr("disabled","disabled");
            $('#post_form img').removeAttr('onclick')
            $('.submit_group').hide();
            $('#post_form a').hide();
            //界面展示
            $("#tab1").hide();
            $("#tab2").show();
            document.getElementById("show").style="";
        }
        //组装form表单数据
        function form2Object(ele){
            var obj = new Object();
            var $ele = $('#'+ele);
            $ele.find(':text,:hidden,select').each(function(){
                var attr = $(this).attr('name');
                if(!attr){
                    return;
                }
                obj[attr] = $(this).val();
            })
            obj.pic1=$("#image1").attr("src");
            obj.pic2=$("#image2").attr("src");
            obj.facePic=$("#image3").attr("src");
            return obj;
        }
        //表单重置
        function formReset()
        {
            $("#post_form").form('clear');
            $('select').prop('selectedIndex', 0);
            $('#post_form img').attr('src','${base}/images/u505.png');
        }

        //查找车辆
        function findvin() {
            var title = "查找车辆";
            var url = "${base}/select/findvin?type=2";
            openEditWin(url, title);
        }
        //查找个人车主
        function findpersonal() {
            var title = "查找个人车主";
            var url = "${base}/select/findpersonal?type=2";
            openEditWin(url,title);
        }
        //打开对话框
        function openEditWin(url,title,width,height) {
            var winid = "user";
            if(width==undefined){
                width=600;
                height=560;
            }
            top.my_window(winid, url, title, width, height);
        }

        var flag = 0;
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
        //弹窗回调
        function dialogCallBack(row) {
            $('#vin').textbox().textbox("setValue", row['vin']);
            $('#serialNumber').textbox().textbox("setValue", row['serial_number']);
            $('#imei').textbox().textbox("setValue",row['imei']);
            $('#simCartNumber').textbox().textbox("setValue",row['sim_card']);
            $('#iccid').textbox().textbox("setValue", row['iccid']);
            $('#imsi').textbox().textbox("setValue", row['imsi']);
        }
        function personalCallBack(row){
            $('#ownerName').textbox().textbox("setValue",row['name']);
            $('#sex').val(row['sex']);
            $('#ownerCertType').val(row['certType']);
            $('#ownerCertId').textbox().textbox("setValue",row['certId']);
            $('#ownerCertAddr').textbox().textbox("setValue",row['certAddr']);
            $('#email').textbox().textbox("setValue",row['email']);
            $('#address').textbox().textbox("setValue",row['address']);
            $('#mobilePhone').textbox().textbox("setValue",row['phone']);
            $('#image1').attr('src',row['pic1']);
            $('#image2').attr('src',row['pic2']);
            $('#image3').attr('src',row['facePic']);

        }
        //加载验证
        initValid();
        //重置
        function reset(){
            $("#post_form").form('clear');
            $('select').prop('selectedIndex', 0);
            $('#post_form img').attr('src','${base}/images/u505.png');
        }
    </script>
</head>
<body>
<div class="easyui-layout" fit="true">
    <div region="center" style="overflow: hidden;width: 50%;" >
        <div align="center">
            <table width="100%" height="30px" border="1" bordercolor="#a0c6e5" style="border-collapse:collapse;">
                <tr>
                    <td id="hide">认证信息</td>
                    <td id="show" style="opacity: 0.2">审核结果</td>
                </tr>
            </table>
        </div>
        <form id="post_form" method="post">
            <input type="file" name="file" class="hide" id="imagefile" onchange="doUpload(this)"/>
            <div align="center"id="tab1">
                <table width="90%" class="mt10">
                    <tr>
                        <td class="tab_item sub_title"><span>车辆信息</span></td>
                        <td><input style="display: none" value="${(mode.id)!}" id="id" name="id" /></td>
                        <td><input style="display: none" value="${(category)!}" id="category" name="category" /></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><i><span>车架号（VIN）</span></td>
                        <td>
                            <input style="width:180px;" value="${(mode.vin)!}" validType="midlength[17]" id="vin" name="vin" type="text" class="easyui-textbox input"  required/><a onclick="findvin()" style="margin-left: 5px;cursor: pointer">查找</a>
                            <a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>车型名称</span></td>
                        <td>
                            <input style="width:180px;" value="${(mode.channelId)!}" id="channelId" name="channelId" type="text" class="easyui-textbox input"/><a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>业务区分</span></td>
                        <td>
                            <input style="width:180px;" value="${(mode.lineNameEn)!}" id="lineNameEn" name="lineNameEn" type="text" class="easyui-textbox input"/><a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a>
                        </td>
                    </tr>
                </table>
                <table width="90%" class="mt10">
                    <tr>
                        <td class="tab_item sub_title"><span>T-BOX信息</span></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><i><span>终端编号</span></td>
                        <td> <input style="width:180px;" value="${(mode.serialNumber)!}" validType="length[1,50]" id="serialNumber" name="serialNumber" type="text" class="easyui-textbox input" required/><a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><i><span>IMEI号</span></td>
                        <td> <input style="width:180px;" value="${(mode.imei)!}" validType="midlength[15]" id="imei" name="imei" type="text" class="easyui-textbox input" required/><a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a></td>
                    </tr>
                </table>
                <table width="90%" class="mt10">
                    <tr>
                        <td class="tab_item sub_title"><span>SIM卡信息</span></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><i><span>移动用户号码（MSISDN）</span></td>
                        <td colspan="2">
                            <input style="width:180px;" value="${(mode.simCartNumber)!}" validType="checksim[9,20]" type="text" id="simCartNumber" name="simCartNumber" class="easyui-textbox input" required/><a href="javascript:void(0);" class="clearInput" onclick="top.clearInputValue(this)">X</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><i><span>ICCID</span></td>
                        <td> <input style="width:180px;" value="${(mode.iccid)!}" validType="checkiccid[20]" id="iccid" name="iccid" type="text" class="easyui-textbox input" required/><a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>国际移动台识别码（IMSI）</span></td>
                        <td> <input style="width:180px;"  value="${(mode.imsi)!}" validType="length[1,15]" id="imsi" name="imsi" type="text" class="easyui-textbox input"/><a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a></td>
                    </tr>
                </table>
                <table width="90%" class="mt10">
                    <tr>
                        <td class="tab_item sub_title"><span>个人车主信息</span></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><i><span>姓名</span></td>
                        <td> <input style="width:180px;" value="${(mode.ownerName)!}" validType="length[1,40]" id="ownerName" name="ownerName" type="text" class="easyui-textbox input" required/><a onclick="findpersonal()" style="margin-left: 5px;cursor: pointer">查找</a><a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><i><span>性别</span></td>
                        <td>
                            <select class="select_item" id="sex" name="sex">
                                <option value ="M">男</option>
                                <option value ="F">女</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><i><span>证件类型</span></td>
                        <td>
                            <select id="ownerCertType" name="ownerCertType" class="select_item">
                                <option value ="IDCARD" <#if (((mode.ownerCertType)!'')=="IDCARD")>selected</#if>>居民身份证</option>
                                <option value ="HKIDCARD" <#if (((mode.ownerCertType)!'')=="HKIDCARD")>selected</#if>>港澳居民来往内地通行证</option>
                                <option value ="OTHERLICENCE" <#if (((mode.ownerCertType)!'')=="OTHERLICENCE")>selected</#if>>其他</option>
                                <option value ="PASSPORT" <#if (((mode.ownerCertType)!'')=="PASSPORT")>selected</#if>>护照</option>
                                <option value ="PLA" <#if (((mode.ownerCertType)!'')=="PLA")>selected</#if>>军官证</option>
                                <option value ="POLICEPAPER" <#if (((mode.ownerCertType)!'')=="POLICEPAPER")>selected</#if>>警官证</option>
                                <option value ="TAIBAOZHENG" <#if (((mode.ownerCertType)!'')=="TAIBAOZHENG")>selected</#if>>台湾居民来往大陆通行证</option>
                                <option value ="UNITCREDITCODE" <#if (((mode.ownerCertType)!'')=="UNITCREDITCODE")>selected</#if>>统一社会信用代码</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><i><span>证件号码</span></td>
                        <td> <input style="width:180px;" value="${(mode.ownerCertId)!}" validType="ownerCertId[8,30]" id="ownerCertId" name="ownerCertId" type="text" class="easyui-textbox input" required/><a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>所有人证件地址</span></td>
                        <td><input style="width:180px;" value="${(mode.ownerCertAddr)!}" validType="length[3,50]" id="ownerCertAddr" name="ownerCertAddr" type="text" class="easyui-textbox input"/><a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>证件照片</span></td>
                        <td><div style="width: 100px;height: 90px;float: left">
                            <div>
                            <#if (mode.pic1)?? &&(mode.pic1)!="" >
                                <img id="image1" src="${(mode.pic1)!}" alt="点击上传证件正面图片" onclick="flag=1;document.getElementById('imagefile').click();" required>
                            <#else >
                                <img id="image1" src="${base}/images/u505.png" alt="点击上传证件正面图片" onclick="flag=1;document.getElementById('imagefile').click();" required>
                            </#if>
                            </div>
                            <div style="text-align: center">
                                证件背面
                            </div>
                        </div>

                            <div style="width: 100px;height: 60px;float: left;margin-left: 15px">
                                <div>
                                <#if (mode.pic2)?? &&(mode.pic2)!="" >
                                    <img id="image2" src="${(mode.pic2)!}" alt="点击上传证件正面图片" onclick="flag=2;document.getElementById('imagefile').click();" required>
                                <#else >
                                    <img id="image2" src="${base}/images/u505.png" alt="点击上传证件正面图片" onclick="flag=2;document.getElementById('imagefile').click();" required>
                                </#if>
                                </div>
                                <div style="text-align: center">
                                    证件背面
                                </div>
                            </div></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>手持证件照</span></td>
                        <td> <div style="width: 100px;height: 90px;float: left;">
                        <#if (mode.facePic)?? &&(mode.facePic)!="" >
                            <img id="image3" src="${(mode.facePic)!}" alt="点击上传证件正面图片" onclick="flag=3;document.getElementById('imagefile').click();" required>
                        <#else >
                            <img id="image3" src="${base}/images/u505.png" alt="点击上传证件正面图片" onclick="flag=3;document.getElementById('imagefile').click();" required>
                        </#if>
                        </div></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><i><span>联系电话</span></td>
                        <td> <input style="width:180px;" value="${(mode.mobilePhone)!}" validType="phoneNum" id="mobilePhone" name="mobilePhone" type="text" class="easyui-textbox input" required/> <a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>联系地址</span></td>
                        <td> <input style="width:180px;" value="${(mode.address)!}" validType="address" id="address" name="address" type="text" class="easyui-textbox input"/><a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>邮箱</span></td>
                        <td> <input style="width:180px;" value="${(mode.email)!}" validType="email" id="email" name="email" type="text" class="easyui-textbox input"/><a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a></td>
                    </tr>
                </table>
                <div class="mt10 submit_group">
                    <a href="#" id="commit" onclick="commit()"  class="easyui-linkbutton submit_button">保存并提交信息</a>
                    <a href="#" id="save" onclick="save()" style="text-decoration:none;margin-left: 10px">保存</a>
                    <a href="#" onclick="reset()" style="text-decoration:none;margin-left: 10px">重置</a>
                </div>
            </div>
            <div align="center" id="tab2" class="hide">
                <table width="90%" class="mt10">
                    <tr>
                        <td class="tab_item" style="font-size: 1.5em;font-weight: 600"><span>认证结果</span></td>
                        <td><span id="re_result"></span></td>
                    </tr>
                    <tr>
                        <td class="tab_item " style="font-size: 1.5em;font-weight: 600"><span>认证信息</span></td>
                        <td><span id="re_info"></span></td>
                    </tr>
                </table>
                <hr>
                <table width="90%" class="mt10">
                    <tr>
                        <td class="tab_item"><span>SIM卡号（MSISDN）</span></td>
                        <td><span id="re_sim"></span></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>ICCID编号</span></td>
                        <td><span id="re_iccid"></span></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>车架号（VIN）</span></td>
                        <td><span id="re_vin"></span></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>姓名</span></td>
                        <td><span id="re_name"></span></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>证件类型</span></td>
                        <td><span id="re_own_type"></span></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>证件号码</span></td>
                        <td><span id="re_own_num"></span></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>联系电话</span></td>
                        <td><span id="re_phone"></span></td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
</body>
</html>