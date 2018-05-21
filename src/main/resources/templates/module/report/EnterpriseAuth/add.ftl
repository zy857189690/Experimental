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
    </style>
    <script language="javascript">
        $(document).ready(function(){
            $("#hide").click(function(){
                $("#tab1").show();
                $("#tab2").hide();
            });
            $("#show").click(function(){
                $("#tab1").hide();
                $("#tab2").show();
            });
        });
        function findvin() {
            var title = "查找车辆";
            var url = "${base}/select/findvin";
            openEditWin(url, title);
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
            return obj;
        }

        function save() {
            //校验
            if($("#post_form").form('validate')){
                var mainData = form2Object("post_form");

                $.ajax({
                    type : 'post',
                    processData: false,
                    url : '${base}/companyAuth/company_temp_save',
                    data : mainData,
                    success : function(data) {
                        alert(data.message)
                        if(data.code == -1){
                        }else{
                        }
                    }
                });
            }
        }
        function commit() {
            //校验
            if($("#post_form").form('validate')){
                var mainData = form2Object("post_form");

                $.ajax({
                    type : 'post',
                    url : '${base}/companyAuth/company_auth',
                    data : mainData,
                    success : function(data) {
                        alert(data.message)
                        if(data.code == -1){
                        }else{
                        }
                    }
                });
            }
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

                <div align="center">
                    <table width="90%" class="mt10">
                        <tr>
                            <td class="tab_item sub_title"><span>车辆信息</span></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>车架号（VIN）</span></td>
                            <td> <input required name="vin" style="width:180px;" value="${(enterpriseAuth.vin)!}"  type="text" class="easyui-textbox input"/><a href="#" onclick="findvin()">&nbsp;&nbsp;查找</a></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>车型名称</span></td>
                            <td> <input name="carTypeName" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>业务区分</span></td>
                            <td> <input name="type" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                    </table>
                    <table width="90%" class="mt10">
                        <tr>
                            <td class="tab_item sub_title"><span>T-BOX信息</span></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>终端编号</span></td>
                            <td> <input required name="serialNumber"  value="${(enterpriseAuth.serialNumber)!}" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>IMEI号</span></td>
                            <td> <input required name="imei"  value="${(enterpriseAuth.imei)!}" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                    </table>
                    <table width="90%" class="mt10">
                        <tr>
                            <td class="tab_item sub_title"><span>SIM卡信息</span></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>移动用户号码（MSISDN）</span></td>
                            <td colspan="2"> <input required  value="${(enterpriseAuth.simCartNumber)!}" name="simCartNumber" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>ICCID</span></td>
                            <td> <input required name="iccid" style="width:180px;" value="${(enterpriseAuth.iccid)!}"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>国际移动台识别码（IMSI）</span></td>
                            <td> <input name="imsi" value="${(enterpriseAuth.imsi)!}" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                    </table>
                    <table width="90%" class="mt10">
                        <tr>
                            <td class="tab_item sub_title"><span>客户企业信息</span></td>
                            <input type="hidden" id="id" name="id" value="${(SysCustomerUnitEntity.id)!}"/>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>企业名称</span></td>
                            <td> <input required name="name" value="${(sysCustomerUnitEntity.name)!}" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>企业地址</span></td>
                            <td> <input required name="cusReplace" style="width:180px;"  value="${(sysCustomerUnitEntity.cusReplace)!}"   type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>企业类型</span></td>
                            <td>
                                <select name="comType" class="select_item">
                                    <option value ="0" selected>非公司企业法人</option>
                                    <option value ="1"<#if (((SysCustomerUnitEntity.comType)!'')=="1")>selected</#if>>有限责任公司</option>
                                    <option value ="2"<#if (((SysCustomerUnitEntity.comType)!'')=="2")>selected</#if>>股份有限责任公司</option>
                                    <option value ="3"<#if (((SysCustomerUnitEntity.comType)!'')=="3")>selected</#if>>个体工商户</option>
                                    <option value ="4"<#if (((SysCustomerUnitEntity.comType)!'')=="4")>selected</#if>>私营独资企业</option>
                                    <option value ="5"<#if (((SysCustomerUnitEntity.comType)!'')=="5")>selected</#if>>私营合伙企业</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>行业类型</span></td>
                            <td>
                                <select name="industryType" class="select_item">
                                    <option value ="1">1 农、林、牧、渔业</option>
                                    <option value ="2"<#if (((SysCustomerUnitEntity.industryType)!'')=="2")>selected</#if>>2 采矿业</option>
                                    <option value ="3"<#if (((SysCustomerUnitEntity.industryType)!'')=="3")>selected</#if>>3 制造业</option>
                                    <option value ="3_01"<#if (((SysCustomerUnitEntity.industryType)!'')=="3_01")>selected</#if>>3.1 烟草制品业</option>
                                    <option value ="3_02"<#if (((SysCustomerUnitEntity.industryType)!'')=="3_02")>selected</#if>>3.2 纺织服装鞋帽制造业</option>
                                    <option value ="3_03"<#if (((SysCustomerUnitEntity.industryType)!'')=="3_03")>selected</#if>>3.3 医药制造业</option>
                                    <option value ="3_04"<#if (((SysCustomerUnitEntity.industryType)!'')=="3_04")>selected</#if>>3.4 通讯设备计算机及其他电子设备制造业</option>
                                    <option value ="3_05"<#if (((SysCustomerUnitEntity.industryType)!'')=="3_05")>selected</#if>>3.5 交通运输设备制造业</option>
                                    <option value ="3_06"<#if (((SysCustomerUnitEntity.industryType)!'')=="3_06")>selected</#if>>3.6 食品制造业</option>
                                    <option value ="3_07"<#if (((SysCustomerUnitEntity.industryType)!'')=="3_07")>selected</#if>>3.7 饮料制造业</option>
                                    <option value ="3_08"<#if (((SysCustomerUnitEntity.industryType)!'')=="3_08")>selected</#if>>3.8 化学原料及化学制品制造业</option>
                                    <option value ="3_09"<#if (((SysCustomerUnitEntity.industryType)!'')=="3_09")>selected</#if>>3.9 电器机械及器材制造业</option>
                                    <option value ="3_10"<#if (((SysCustomerUnitEntity.industryType)!'')=="3_10")>selected</#if>>3.10 其他制造业</option>
                                    <option value ="4"<#if (((SysCustomerUnitEntity.industryType)!'')=="4")>selected</#if>>4 电力、燃气及水的生产和供应业</option>
                                    <option value ="5"<#if (((SysCustomerUnitEntity.industryType)!'')=="5")>selected</#if>>5 建筑业</option>
                                    <option value ="6"<#if (((SysCustomerUnitEntity.industryType)!'')=="6")>selected</#if>>6 交通运输、仓储和邮政业</option>
                                    <option value ="7"<#if (((SysCustomerUnitEntity.industryType)!'')=="7")>selected</#if>>7 信息传输、计算机服务和软件业</option>
                                    <option value ="7_01"<#if (((SysCustomerUnitEntity.industryType)!'')=="7_01")>selected</#if>>7.1 电信和其他信息传输服务业</option>
                                    <option value ="7_02"<#if (((SysCustomerUnitEntity.industryType)!'')=="7_02")>selected</#if>>7.2 计算机服务业</option>
                                    <option value ="7_03"<#if (((SysCustomerUnitEntity.industryType)!'')=="7_03")>selected</#if>>7.3 软件业</option>
                                    <option value ="8"<#if (((SysCustomerUnitEntity.industryType)!'')=="8")>selected</#if>>8 批发和零售业</option>
                                    <option value ="9"<#if (((SysCustomerUnitEntity.industryType)!'')=="9")>selected</#if>>9 住宿和餐饮业</option>
                                    <option value ="10"<#if (((SysCustomerUnitEntity.industryType)!'')=="10")>selected</#if>>10 金融业</option>
                                    <option value ="10_01"<#if (((SysCustomerUnitEntity.industryType)!'')=="10_01")>selected</#if>>10.1 银行业</option>
                                    <option value ="10_02"<#if (((SysCustomerUnitEntity.industryType)!'')=="10_02")>selected</#if>>10.2 证券业</option>
                                    <option value ="10_03"<#if (((SysCustomerUnitEntity.industryType)!'')=="10_03")>selected</#if>>10.3 保险业</option>
                                    <option value ="10_04"<#if (((SysCustomerUnitEntity.industryType)!'')=="10_04")>selected</#if>>10.4 其他</option>
                                    <option value ="11"<#if (((SysCustomerUnitEntity.industryType)!'')=="11")>selected</#if>>11 房产地产</option>
                                    <option value ="12"<#if (((SysCustomerUnitEntity.industryType)!'')=="12")>selected</#if>>12 租赁和商务服务业</option>
                                    <option value ="13"<#if (((SysCustomerUnitEntity.industryType)!'')=="13")>selected</#if>>13 科学研究、技术服务和地质勘查业</option>
                                    <option value ="14"<#if (((SysCustomerUnitEntity.industryType)!'')=="14")>selected</#if>>14 水利、环境和公共设施管理业</option>
                                    <option value ="15"<#if (((SysCustomerUnitEntity.industryType)!'')=="15")>selected</#if>>15 居民服务和其他服务业</option>
                                    <option value ="16"<#if (((SysCustomerUnitEntity.industryType)!'')=="16")>selected</#if>>16 教育</option>
                                    <option value ="17"<#if (((SysCustomerUnitEntity.industryType)!'')=="17")>selected</#if>>17 卫生、社会保障和社会福利业</option>
                                    <option value ="18"<#if (((SysCustomerUnitEntity.industryType)!'')=="18")>selected</#if>>18 文化、体育和娱乐业</option>
                                    <option value ="19"<#if (((SysCustomerUnitEntity.industryType)!'')=="19")>selected</#if>>19 公共管理和社会组织</option>
                                    <option value ="19_01"<#if (((SysCustomerUnitEntity.industryType)!'')=="19_01")>selected</#if>>19.1 中国共产党机关</option>
                                    <option value ="19_02"<#if (((SysCustomerUnitEntity.industryType)!'')=="19_02")>selected</#if>>19.2 国家权力和行政机构</option>
                                    <option value ="19_03"<#if (((SysCustomerUnitEntity.industryType)!'')=="19_03")>selected</#if>>19.3 公安、法院、检察院和司法机构</option>
                                    <option value ="19_04"<#if (((SysCustomerUnitEntity.industryType)!'')=="19_04")>selected</#if>>19.4 其他国家机构（军队）</option>
                                    <option value ="19_05"<#if (((SysCustomerUnitEntity.industryType)!'')=="19_05")>selected</#if>>19.5 人民政协和民主党派</option>
                                    <option value ="19_06"<#if (((SysCustomerUnitEntity.industryType)!'')=="19_06")>selected</#if>>19.6 群体团体、社会团体和宗教团体</option>
                                    <option value ="19_07"<#if (((SysCustomerUnitEntity.industryType)!'')=="19_07")>selected</#if>>19.7 基层群众自治组织</option>
                                    <option value ="20"<#if (((SysCustomerUnitEntity.industryType)!'')=="20")>selected</#if>>20 国际组织</option>
                                    <option value ="21"<#if (((SysCustomerUnitEntity.industryType)!'')=="21")>selected</#if>>21 个人</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>统一社会信用代码</span></td>
                            <td> <input required name="creditCode"   value="${(sysCustomerUnitEntity.creditCode)!}" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>营业执照扫描照</span></td>
                            <td>
                                <div style="width: 100px;height: 60px;float: left">
                                 <#if (sysCustomerUnitEntity.enterPic)?? &&(sysCustomerUnitEntity.enterPic)!="" >
                                     <img id="image1" src="${(sysCustomerUnitEntity.enterPic)!}" alt="点击上传证件正面图片" onclick="flag=1;document.getElementById('imagefile').click();">
                                 <#else >
                                    <img id="image1" src="${base}/images/u505.png" alt="点击上传证件正面图片" onclick="flag=1;document.getElementById('imagefile').click();">
                                 </#if>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>授权书扫描件</span></td>
                            <td>
                                <div style="width: 100px;height: 60px;float: left">
                                 <#if (sysCustomerUnitEntity.authPic)?? &&(sysCustomerUnitEntity.authPic)!="" >
                                     <img id="image2" src="${(sysCustomerUnitEntity.authPic)!}" alt="点击上传证件正面图片" onclick="flag=2;document.getElementById('imagefile').click();">
                                 <#else >
                                    <img id="image2" src="${base}/images/u505.png" alt="点击上传证件正面图片" onclick="flag=2;document.getElementById('imagefile').click();">
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
                            <td> <input required name="contact"   value="${(sysCustomerUnitEntity.contact)!}" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>性别</span></td>
                            <td>
                                <select name="sex" class="select_item">
                                    <option value="M" <#if (((sysCustomerUnitEntity.sex)!'')=="M" || ((sysCustomerUnitEntity.sex)!'F')!="M")>selected</#if>>男</option>
                                    <option value ="F" <#if (((sysCustomerUnitEntity.sex)!'')=="F")>selected</#if>>女</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>证件类型</span></td>
                            <td>
                                <select name="ownerCertType" class="select_item">
                                    <option value ="HKIDCARD" selected>港澳居民来往内地通行证</option>
                                    <option value ="IDCARD" <#if (((SysCustomerUnitEntity.ownerCertType)!'')=="IDCARD")>selected</#if>>居民身份证</option>
                                    <option value ="OTHERLICENCE" <#if (((SysCustomerUnitEntity.ownerCertType)!'')=="OTHERLICENCE")>selected</#if>>其他</option>
                                    <option value ="PASSPORT" <#if (((SysCustomerUnitEntity.ownerCertType)!'')=="PASSPORT")>selected</#if>>护照</option>
                                    <option value ="PLA" <#if (((SysCustomerUnitEntity.ownerCertType)!'')=="PLA")>selected</#if>>军官证</option>
                                    <option value ="POLICEPAPER" <#if (((SysCustomerUnitEntity.ownerCertType)!'')=="POLICEPAPER")>selected</#if>>警官证</option>
                                    <option value ="TAIBAOZHENG" <#if (((SysCustomerUnitEntity.ownerCertType)!'')=="TAIBAOZHENG")>selected</#if>>台湾居民来往大陆通行证</option>
                                    <option value ="UNITCREDITCODE" <#if (((SysCustomerUnitEntity.ownerCertType)!'')=="UNITCREDITCODE")>selected</#if>>统一社会信用代码</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>证件号码</span></td>
                            <td> <input required name="ownerCertId"  value="${(sysCustomerUnitEntity.ownerCertId)!}" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>所有人证件地址</span></td>
                            <td> <input name="ownerCertAddr"  value="${(sysCustomerUnitEntity.ownerCertAddr)!}"  style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>证件正面</span></td>
                            <td>
                                <div style="width: 100px;height: 60px;float: left">
                                 <#if (sysCustomerUnitEntity.pic1)?? &&(sysCustomerUnitEntity.pic1)!="" >
                                     <img id="image3" src="${(sysCustomerUnitEntity.pic1)!}" alt="点击上传证件正面图片" onclick="flag=3;document.getElementById('imagefile').click();">
                                 <#else >
                                    <img id="image3" src="${base}/images/u505.png" alt="点击上传证件正面图片" onclick="flag=3;document.getElementById('imagefile').click();">
                                 </#if>
                                </div>
                                <div style="width: 100px;height: 60px;float: left">
                                 <#if (sysCustomerUnitEntity.pic2)?? &&(sysCustomerUnitEntity.pic2)!="" >
                                     <img id="image4" src="${(sysCustomerUnitEntity.pic2)!}" alt="点击上传证件正面图片" onclick="flag=4;document.getElementById('imagefile').click();">
                                 <#else >
                                    <img id="image4" src="${base}/images/u505.png" alt="点击上传证件正面图片" onclick="flag=4;document.getElementById('imagefile').click();">
                                 </#if>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>手持证件照</span></td>
                            <td>
                                <div style="width: 100px;height: 60px;float: left">
                                 <#if (sysCustomerUnitEntity.factPic)?? &&(sysCustomerUnitEntity.factPic)!="" >
                                     <img id="image5" src="${(sysCustomerUnitEntity.factPic)!}" alt="点击上传证件正面图片" onclick="flag=5;document.getElementById('imagefile').click();">
                                 <#else >
                                    <img id="image5" src="${base}/images/u505.png" alt="点击上传证件正面图片" onclick="flag=5;document.getElementById('imagefile').click();">
                                 </#if>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>联系电话</span></td>
                            <td> <input required name="contactInfo"  value="${(sysCustomerUnitEntity.contactInfo)!}" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>联系地址</span></td>
                            <td> <input name="ownerAddress"  value="${(sysCustomerUnitEntity.ownerAddress)!}" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>邮箱</span></td>
                            <td> <input name="email"  value="${(sysCustomerUnitEntity.email)!}" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                    </table>
                </div>
                <div class="mt10 submit_group">
                    <a href="#" onclick="commit()"  class="easyui-linkbutton submit_button">保存并提交信息</a>
                    <a href="#" onclick="save()"  class="easyui-linkbutton submit_button">保存</a>
                </div>
            </form>
        </div>
        <div id="tab2" class="hide">
            <table width="90%" class="mt10">
                <tr>
                    <td class="tab_item sub_title"><span>认证结果</span></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="tab_item sub_title"><span>认证信息</span></td>
                    <td></td>
                </tr>
            </table>
            <hr>
            <table width="90%" class="mt10">
                <tr>
                    <td class="tab_item"><span>SIM卡号（MSISDN）</span></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="tab_item"><span>ICCID编号</span></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="tab_item"><span>车型名称</span></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="tab_item"><span>车架号（VIN）</span></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="tab_item"><span>姓名</span></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="tab_item"><span>证件类型</span></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="tab_item"><span>证件号码</span></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="tab_item"><span>证件号码</span></td>
                    <td></td>
                </tr>
            </table>
        </div>
    </div>
</div>
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
            url:'${base}/sysCustomerUnit/common/upload',
            type:"post",
            data:formData,
            async:false,
            cache:false,
            contentType:false,
            processData:false,
            success:function (data) {
                data = JSON.parse(data);
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

</script>
</body>
</html>