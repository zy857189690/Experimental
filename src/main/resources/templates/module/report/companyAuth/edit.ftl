<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<#include "../../../inc/meta.ftl">
<#include  "../../../inc/js.ftl">
<#include  "../../../inc/top.ftl">
    <style type="text/css">
        .mt10{
            margin-top: 10px;
        }
        .tab_item {
            text-align: right;
            width: 15%;
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
            line-height: 30px;
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
            width: 50%;
            text-align: center;
        }
        #post_form img{
            width: 96px;
            height:57px;
        }
    </style>
    <script language="javascript">
        function findvin() {
            var title = "查找车辆";
            var url = "${base}/select/findvin?type=4";
            openEditWin(url, title);
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
    </script>
    <script type="application/javascript">

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
            //组装IMG信息
            obj['enterPic'] = $('#image1').attr("src");
            obj['authPic'] = $('#image2').attr("src");
            obj['pic1'] = $('#image3').attr("src");
            obj['pic2'] = $('#image4').attr("src");
            obj['factPic'] = $('#image5').attr("src");
            return obj;
        }

        function commit(other) {
            var mainData = form2Object("post_form");
            if(!validImg(mainData)) return;
            //校验
            if($("#post_form").form('validate')){
                if(other == 'cover'){
                    mainData['cover'] = 'true';
                }
                $.ajax({
                    type : 'post',
                    url : '${base}/companyAuth/company_auth',
                    data : mainData,
                    success : function(data) {
                        if(data.code == 2){
                            $.messager.confirm("提示",data.message,function(flag){
                                if(flag){
                                    commit(null,'cover');
                                }
                            })
                            return;
                        }
                        if(data.code == -1){
                            alert(data.message);
                        }else{
                            //跳转至认证结果页面
                            to_reasult_page(data.entity);
                        }
                    }
                });
            }
        }

        function to_reasult_page(entity) {
            initResultSelect();
            $("#re_sim").text($('#simCartNumber').val());
            $("#re_iccid").text($('#iccid').val());
            $("#re_vin").text($('#vin').val());
            $("#re_name").text($('#contact').val());
            $("#re_own_type").text($("#ownerCertType").find("option:selected").text());
            $("#re_own_num").text($('#ownerCertId').val());
            $("#re_lineName").text($('#lineNameEn').val());
            var type = null;
            if(entity.authenticationResult == '1'){
                type='认证中';
            }else if(entity.authenticationResult == '2'){
                type='认证成功';
            }else if(entity.authenticationResult == '3'){
                type='未通过';
            }
            $('#re_result').text(type);
            $('#re_info').text(entity.remarks);
            //禁用input
            $(':input,select').attr("readOnly",true);
            $('select').attr("disabled","disabled");
            $('#post_form img').removeAttr('onclick')
            $('.submit_group').hide();
            $('#post_form a').hide();
            //界面展示
            $("#tab1").hide();
            $("#tab2").show();
        }

        function save(){
            var mainData = form2Object("post_form");
            if(!validImg(mainData)) return;
            if(!$("#post_form").form('validate')) return;
            $.ajax({
                type : 'post',
                url : '${base}/companyAuth/company_temp_update',
                data : mainData,
                success : function(data) {
                    if(data.code == -1){
                        alert(data.message)
                    }else{
                        alert(data.message)
                        refresh();
                    }
                }
            });
        }

        function tabsClose(){
            var tab=window.parent.$('#centerTabs').tabs('getSelected');//获取当前选中tabs
            var index = window.parent.$('#centerTabs').tabs('getTabIndex',tab);//获取当前选中tabs的index
            window.parent.$('#centerTabs').tabs('close',index);//关闭对应index的tabs
            window.top.m_PeopleAuthFrame.indextab2.$("#table").datagrid('reload')
        }

        function initSelect() {
            checkSelect('comType','${(mode.comType)!}');
            checkSelect('industryType','${(mode.industryType)!}')
            checkSelect('sex','${(mode.sex)!}')
            checkSelect('ownerCertType','${(mode.ownerCertType)!}')
        }

        function checkSelect(name,value){
            $('#'+name).val(value);
        }

        function initCleanButton() {
            $.extend($.fn.textbox.methods, {
                addClearBtn: function (jq, iconCls) {

                    var opts = jq.textbox('options');
                    opts.icons = opts.icons || [];

                    opts.icons.unshift({
                        iconCls: iconCls,
                        handler: function (e) {
                            $(e.data.target).textbox('clear').textbox('textbox').focus();
                            $(this).css('visibility', 'hidden');
                        }
                    });
                    return jq.each(function () {
                        var t = $(this);
                        t.textbox();
                        if (!t.textbox('getText')) {
                            t.textbox('getIcon', 0).css('visibility', 'hidden');
                        }
                        t.textbox('textbox').bind('keyup', function () {
                            var icon = t.textbox('getIcon', 0);
                            if ($(this).val()) {
                                icon.css('visibility', 'visible');
                            } else {
                                icon.css('visibility', 'hidden');
                            }
                        });
                    });
                }
            });
            $('input:not(.hide)').textbox().textbox('addClearBtn', 'icon-clear');
            $('.textbox').css('width',"160px");
        }

        $(function(){
            initSelect();
            initValid();
            initCleanButton();
        })

        function refresh() {
            window.top.reload.datagrid("load");
            //处理列表刷新
            var tab = window.parent.$('#centerTabs').tabs('getSelected');//获取当前选中tabs
            var index = window.parent.$('#centerTabs').tabs('getTabIndex', tab);//获取当前选中tabs的index
            window.parent.$('#centerTabs').tabs('close', index);//关闭对应index的tabs
            parent.$('#centerTabs').tabs('select', 'SIM实名认证')
        }

        function validImg(formData){
            if (validateInfor(formData.enterPic)){
                alert("请上传营业执照扫描照");
                return false;
            }if (validateInfor(formData.authPic)){
                alert("请上传授权书扫描件");
                return false;
            }
            if (validateInfor(formData.pic1)){
                alert("请上传证件正面");
                return false;
            }
            if (validateInfor(formData.pic2)){
                alert("请上传证件背面");
                return false;
            }
            if (validateInfor(formData.factPic)){
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
    </script>
    <script type="application/javascript">
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
    </script>
</head>
<body>
<div class="easyui-layout" fit="true">
    <div region="center" style="overflow: hidden;width: 50%">
        <div align="center">
            <table width="90%" class="mt10">
                <tr>
                    <td><span><button id="hide">认证信息</button></span></td>
                    <td><span><button id="show">审核结果</button></span></td>
                </tr>
            </table>
        </div>
        <div id="tab1">
            <form id="post_form" method="post">
                <!--file必须放在第一位-->
                <input type="file" name="file" class="hide" id="imagefile" onchange="doUpload(this)"/>
                <input value="${mode.id}" required name="id" style="width:180px;"  type="hidden" class="hide"/>
                <input value="${mode.id}" required name="currentDataId" style="width:180px;"  type="hidden" class="hide"/>
                <input value="${mode.authenticationResult}" required name="authenticationResult" style="width:180px;"  type="hidden" class="hide"/>
                <div align="center">
                    <table width="90%" class="mt10">
                        <tr>
                            <td class="tab_item sub_title"><span>车辆信息</span></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>车架号（VIN）</span></td>
                            <td> <input value="${(mode.vin)!}" data-options="required:true" validType="midlength[17]"  id="vin" name="vin" style="width:180px;"  type="text" class="easyui-textbox input"/><a href="#" onclick="findvin()">&nbsp;&nbsp;查找</a></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>车型名称</span></td>
                            <td> <input id="lineNameEn" value="${(mode.lineNameEn)!}" style="width:180px;" type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>业务区分</span></td>
                            <td> <input id="channelId" value="${(mode.channelId)!}" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                    </table>
                    <table width="90%" class="mt10">
                        <tr>
                            <td class="tab_item sub_title"><span>T-BOX信息</span></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>终端编号</span></td>
                            <td> <input required value="${(mode.serialNumber)!}" id="serialNumber" validType="length[1,50]" name="serialNumber" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>IMEI号</span></td>
                            <td> <input required value="${(mode.imei)!}" id="imei" name="imei" validType="midlength[15]" style="width:180px;" type="text" class="easyui-textbox input"/></td>
                        </tr>
                    </table>
                    <table width="90%" class="mt10">
                        <tr>
                            <td class="tab_item sub_title"><span>SIM卡信息</span></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>移动用户号码（MSISDN）</span></td>
                            <td colspan="2"> <input value="${(mode.simCartNumber)!}" id="simCartNumber" validType="checksim[9, 20]" required name="simCartNumber" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>ICCID</span></td>
                            <td> <input required value="${(mode.iccid)!}" id="iccid" name="iccid" validType="checkiccid[20]" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>国际移动台识别码（IMSI）</span></td>
                            <td> <input id="imsi" value="${(mode.imsi)!}" name="imsi" style="width:180px;" validType="length[0,15]"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                    </table>
                    <table width="90%" class="mt10">
                        <tr>
                            <td class="tab_item sub_title"><span>客户企业信息</span></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>企业名称</span></td>
                            <td> <input required value="${(mode.name)!}"  id="name" name="name" validType="length[1,255]" value="${(sysCustomerUnitEntity.name)!}" style="width:180px;"  type="text" class="easyui-textbox input"/><a href="#" onclick="findCom()">&nbsp;&nbsp;查找</a></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>企业地址</span></td>
                            <td> <input required value="${(mode.cusReplace)!}" id="cusReplace" name="cusReplace" validType="length[1,255]" style="width:180px;"  value="${(sysCustomerUnitEntity.cusReplace)!}"   type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>企业类型</span></td>
                            <td>
                                <select id="comType" name="comType" class="select_item">
                                    <option value ="0">非公司企业法人</option>
                                    <option value ="1">有限责任公司</option>
                                    <option value ="2">股份有限责任公司</option>
                                    <option value ="3">个体工商户</option>
                                    <option value ="4">私营独企业</option>
                                    <option value ="5">私营合伙企业</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>行业类型</span></td>
                            <td>
                                <select id="industryType" name="industryType" class="select_item">
                                    <option value ="1">1 农、林、牧、渔业</option>
                                    <option value ="2">2 采矿业</option>
                                    <option value ="3">3 制造业</option>
                                    <option value ="3_01">3.1 烟草制品业</option>
                                    <option value ="3_02">3.2 纺织服装鞋帽制造业</option>
                                    <option value ="3_03">3.3 医药制造业</option>
                                    <option value ="3_04">3.4 通讯设备计算机及其他电子设备制造业</option>
                                    <option value ="3_05">3.5 交通运输设备制造业</option>
                                    <option value ="3_06">3.6 食品制造业</option>
                                    <option value ="3_07">3.7 饮料制造业</option>
                                    <option value ="3_08">3.8 化学原料及化学制品制造业</option>
                                    <option value ="3_09">3.9 电器机械及器材制造业</option>
                                    <option value ="3_010">3.10 其他制造业</option>
                                    <option value ="4">4 电力、燃气及水的生产和供应业</option>
                                    <option value ="5">5 建筑业</option>
                                    <option value ="6">6 交通运输、仓储和邮政业</option>
                                    <option value ="7">7 信息传输、计算机服务和软件业</option>
                                    <option value ="7_01">7.1 电信和其他信息传输服务业</option>
                                    <option value ="7_02">7.2 计算机服务业</option>
                                    <option value ="7_03">7.3 软件业</option>
                                    <option value ="8">8 批发和零售业</option>
                                    <option value ="9">9 住宿和餐饮业</option>
                                    <option value ="10">10 金融业</option>
                                    <option value ="10_01">10.1 银行业</option>
                                    <option value ="10_02">10.2 证券业</option>
                                    <option value ="10_03">10.3 保险业</option>
                                    <option value ="10_04">10.4 其他</option>
                                    <option value ="11">11 房产地产</option>
                                    <option value ="12">12 租赁和商务服务业</option>
                                    <option value ="13">13 科学研究、技术服务和地质勘查业</option>
                                    <option value ="14">14 水利、环境和公共设施管理业</option>
                                    <option value ="15">15 居民服务和其他服务业</option>
                                    <option value ="16">16 教育</option>
                                    <option value ="17">17 卫生、社会保障和社会福利业</option>
                                    <option value ="18">18 文化、体育和娱乐业</option>
                                    <option value ="19">19 公共管理和社会组织</option>
                                    <option value ="19_01">19.1 中国共产党机关</option>
                                    <option value ="19_02">19.2 国家权力和行政机构</option>
                                    <option value ="19_03">19.3 公安、法院、检察院和司法机构</option>
                                    <option value ="19_04">19.4 其他国家机构（军队）</option>
                                    <option value ="19_05">19.5 人民政协和民主党派</option>
                                    <option value ="19_06">19.6 群体团体、社会团体和宗教团体</option>
                                    <option value ="19_07">19.7 基层群众自治组织</option>
                                    <option value ="20">20 国际组织</option>
                                    <option value ="21">21 个人</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>统一社会信用代码</span></td>
                            <td> <input value="${(mode.creditCode)!}" validType="midlength[18]" required id="creditCode" name="creditCode" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>营业执照扫描照</span></td>
                            <td>
                                <div style="width: 100px;height: 60px;float: left">
                                <#if (mode.enterPic)?? &&(mode.enterPic)!="" >
                                    <img id="image1" id="enterPic" src="${(mode.enterPic)!}" alt="点击上传证件正面图片" onclick="flag=1;document.getElementById('imagefile').click();">
                                <#else >
                                    <img id="image1" id="enterPic" src="${base}/images/u505.png" alt="点击上传证件正面图片" onclick="flag=1;document.getElementById('imagefile').click();">
                                </#if>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>授权书扫描件</span></td>
                            <td>
                                <div style="width: 100px;height: 60px;float: left">
                                <#if (mode.authPic)?? &&(mode.authPic)!="" >
                                    <img id="image2" id="authPic" src="${(mode.authPic)!}" alt="点击上传证件正面图片" onclick="flag=2;document.getElementById('imagefile').click();">
                                <#else >
                                    <img id="image2" id="authPic" src="${base}/images/u505.png" alt="点击上传证件正面图片" onclick="flag=2;document.getElementById('imagefile').click();">
                                </#if>
                                </div>
                            </td>
                        </tr>
                    </table>

                    <table width="90%" class="mt10">
                        <tr>
                            <td class="tab_item sub_title"><span>客户企业负责人</span></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>负责人姓名</span></td>
                            <td> <input value="${(mode.contact)!}" validType="length[1,255]" required id="contact" name="contact" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>性别</span></td>
                            <td>
                                <select id="sex" name="sex" class="select_item">
                                    <option value ="M">男</option>
                                    <option value ="F">女</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>证件类型</span></td>
                            <td>
                                <select id="ownerCertType" name="ownerCertType" class="select_item">
                                    <option value ="HKIDCARD">港澳居民来往内地通行证</option>
                                    <option value ="IDCARD">居民身份证</option>
                                    <option value ="OTHERLICENCE">其他</option>
                                    <option value ="PASSPORT">护照</option>
                                    <option value ="PLA">军官证</option>
                                    <option value ="POLICEPAPER">警官证</option>
                                    <option value ="TAIBAOZHENG">台湾居民来往大陆通行证</option>
                                    <option value ="UNITCREDITCODE">统一社会信用代码</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>证件号码</span></td>
                            <td> <input value="${(mode.ownerCertId)!}" validType="length[8,40]" required id="ownerCertId" name="ownerCertId" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>所有人证件地址</span></td>
                            <td> <input value="${(mode.ownerCertAddr)!}" validType="length[3,50]" id="ownerCertAddr" name="ownerCertAddr" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>证件照片</span></td>
                            <td>
                                <div style="width: 100px;height: 60px;float: left">
                                <#if (mode.pic1)?? &&(mode.pic1)!="" >
                                    <img id="image3" id="pic1" src="${(mode.pic1)!}" alt="点击上传证件正面图片" onclick="flag=3;document.getElementById('imagefile').click();">
                                <#else >
                                    <img id="image3" id="pic1" src="${base}/images/u505.png" alt="点击上传证件正面图片" onclick="flag=3;document.getElementById('imagefile').click();">
                                </#if>
                                </div>
                                <div style="width: 100px;height: 60px;float: left">
                                <#if (mode.pic2)?? &&(mode.pic2)!="" >
                                    <img id="image4" id="pic2" src="${(mode.pic2)!}" alt="点击上传证件正面图片" onclick="flag=4;document.getElementById('imagefile').click();">
                                <#else >
                                    <img id="image4" id="pic2" src="${base}/images/u505.png" alt="点击上传证件正面图片" onclick="flag=4;document.getElementById('imagefile').click();">
                                </#if>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>手持证件照</span></td>
                            <td>
                                <div style="width: 100px;height: 60px;float: left">
                                <#if (mode.factPic)?? &&(mode.factPic)!="" >
                                    <img id="image5" id="factPic" src="${(mode.factPic)!}" alt="点击上传证件正面图片" onclick="flag=5;document.getElementById('imagefile').click();">
                                <#else >
                                    <img id="image5" id="factPic" src="${base}/images/u505.png" alt="点击上传证件正面图片" onclick="flag=5;document.getElementById('imagefile').click();">
                                </#if>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>联系电话</span></td>
                            <td> <input value="${(mode.contactInfo)!}" validType="phoneNum" required id="contactInfo" name="contactInfo" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>联系地址</span></td>
                            <td> <input value="${(mode.ownerAddress)!}" id="ownerAddress" name="ownerAddress" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>邮箱</span></td>
                            <td> <input value="${(mode.email)!}" validType="email" id="email" name="email" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                    </table>
                </div>
                <div class="mt10 submit_group">
                    <a href="#" onclick="commit()"  class="easyui-linkbutton submit_button">保存并提交信息</a>
                    <a href="#" onclick="save()"  style="text-decoration:none;margin-left: 10px">保存</a>
                    <a href="#" onclick="reset()" style="text-decoration:none;margin-left: 10px">重置</a>
                </div>
            </form>
        </div>
        <div id="tab2" class="hide">
            <table width="90%" class="mt10">
                <tr>
                    <td class="tab_item sub_title"><span>认证结果</span></td>
                    <td><span id="re_result"></span></td>
                </tr>
                <tr>
                    <td class="tab_item sub_title"><span>认证信息</span></td>
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
                    <td class="tab_item"><span>车型名称</span></td>
                    <td><span id="re_lineName"></span></td>
                </tr>
                <tr>
                    <td class="tab_item"><span>车架号（VIN）</span></td>
                    <td><span id="re_vin"></span></td>
                </tr>
                <tr>
                    <td class="tab_item"><span>企业负责人姓名</span></td>
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
            </table>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    /**
     * flag=0默认
     * 1营业执照扫描照
     * 2授权书扫描件
     * 3证件正面
     * 4证件背面
     * 5手持证件照
     * @type {number}
     */
    var flag=0;

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
//                data = JSON.parse(data);
                if (data.status == 0){
                    if (flag == 1){
                        $("#image1").attr("src", data.url);
                    }else if (flag == 2){
                        $("#image2").attr("src", data.url);
                    }else if (flag == 3){
                        $("#image3").attr("src", data.url);
                    }else if (flag == 4){
                        $("#image4").attr("src", data.url);
                    }else if (flag == 5){
                        $("#image5").attr("src", data.url);
                    }
                }else{
                    alert("文件过大");
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
    function dialogCallBack(row){
        $('#id').textbox().textbox("setValue",row['id']);
        $('#name').textbox().textbox("setValue",row['name']);
        $('#cusReplace').textbox().textbox("setValue",row['cusReplace']);
        $('#comType').val(row['comType']);
        $('#creditCode').textbox().textbox("setValue",row['creditCode']);
        $('#contact').textbox().textbox("setValue",row['contact']);
        $('#sex').val(row['sex']);
        $('#industryType').val(row['industryType']);
        $('#ownerCertType').val(row['ownerCertType']);
        $('#ownerCertId').textbox().textbox("setValue",row['ownerCertId']);
        $('#ownerCertAddr').textbox().textbox("setValue",row['ownerCertAddr']);
        $('#contactInfo').textbox().textbox("setValue",row['contactInfo']);
        $('#ownerAddress').textbox().textbox("setValue",row['ownerAddress']);
        $('#email').textbox().textbox("setValue",row['email']);

        $('#image1').attr('src',row['enterPic'])
        $('#image2').attr('src',row['authPic'])
        $('#image3').attr('src',row['pic1'])
        $('#image4').attr('src',row['pic2'])
        $('#image5').attr('src',row['factPic'])

    }

    function findCom(){
        top.my_window('user','${base}/customerUnit/getComInfo?type=2','选择企业', 700, 560)
    }

    function vinCallBack(row){
        $('#vin').textbox().textbox("setValue", row['vin']);
        $('#serialNumber').textbox().textbox("setValue", row['serial_number']);
        $('#imei').textbox().textbox("setValue",row['imei']);
        $('#simCartNumber').textbox().textbox("setValue",row['sim_card']);
        $('#iccid').textbox().textbox("setValue", row['iccid']);
        $('#imsi').textbox().textbox("setValue", row['imsi']);
    }

    function reset(){
        $("#post_form").form('clear');
        $('select').prop('selectedIndex', 0);
        $('#post_form img').attr('src','${base}/images/u505.png');
    }


</script>
</html>