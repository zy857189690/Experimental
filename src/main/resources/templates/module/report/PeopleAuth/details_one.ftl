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
    </style>
    <script language="javascript">
        //两个div切换
        $(document).ready(function(){
            if(${(mode.authenticationResult)!}==0){
                $("#tab1").show();
                $("#tab2").hide();
                document.getElementById("show").style.color="#BEBEBE";
            }else{
                $("#hide").click(function(){
                    $("#tab1").show();
                    $("#tab2").hide();
                });
                $("#show").click(function(){
                    $("#tab1").hide();
                    $("#tab2").show();
                });
            }
        });
    </script>
</head>
<body>
<div class="easyui-layout" fit="true">
    <div region="center" style="overflow: hidden;width: 50%;" >
        <div align="center">
            <table width="100%" height="30px" border="1" bordercolor="#a0c6e5" style="border-collapse:collapse;">
                <tr>
                    <td id="hide">认证信息</td>
                    <td id="show">审核结果</td>
                </tr>
            </table>
        </div>
        <form id="post_form" method="post">
            <div align="center"id="tab1">
                <table width="90%" class="mt10">
                    <tr>
                        <td class="tab_item sub_title"><span>车辆信息</span></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>车架号(VIN):</span></td>
                        <td><span>${(mode.vin)!}</span></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>车型名称:</span></td>
                        <td><span>${(mode.channelId)!}</span></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>业务区分:</span></td>
                        <td><span>${(mode.lineNameEn)!}</span></td>
                    </tr>
                </table>
                <table width="90%" class="mt10">
                    <tr>
                        <td class="tab_item sub_title"><span>T-BOX信息</span></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>终端编号:</span></td>
                        <td><span>${(mode.serialNumber)!}</span></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>IMEI号:</span></td>
                        <td> <span>${(mode.imei)!}</span></td>
                    </tr>
                </table>
                <table width="90%" class="mt10">
                    <tr>
                        <td class="tab_item sub_title"><span>SIM卡信息</span></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>移动用户号码(MSISDN):</span></td>
                        <td>
                            <span>${(mode.simCartNumber)!}</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>ICCID:</span></td>
                        <td><span>${(mode.iccid)!}</span></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>国际移动台识别码（IMSI）:</span></td>
                        <td> <span>${(mode.imsi)!}</span></td>
                    </tr>
                </table>
                <table width="90%" class="mt10">
                    <tr>
                        <td class="tab_item sub_title"><span>个人车主信息</span></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>姓名:</span></td>
                        <td> <span>${(mode.ownerName)!}</span></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>性别:</span></td>
                        <td>
                            <span>
                            <#if (mode.sex)="M">
                                男
                            <#else >
                                女
                            </#if>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>证件类型:</span></td>
                        <td>
                            <#if (mode.ownerCertType)="IDCARD">
                                居民身份证
                            <#elseif ((mode.ownerCertType)="HKIDCARD")>
                                港澳居民来往内地通行证
                            <#elseif ((mode.ownerCertType)="PASSPORT")>
                                护照
                            <#elseif ((mode.ownerCertType)="PLA")>
                                军官证
                            <#elseif ((mode.ownerCertType)="POLICEPAPER")>
                                警官证
                            <#elseif ((mode.ownerCertType)="TAIBAOZHENG")>
                                台湾居民来往大陆通行证
                            <#elseif ((mode.ownerCertType)="UNITCREDITCODE")>
                                统一社会信用代码
                            <#elseif ((mode.ownerCertType)="OTHERLICENCE")>
                                其他
                            </#if>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>证件号码:</span></td>
                        <td> <span>${(mode.ownerCertId)!}</span></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>所有人证件地址:</span></td>
                        <td><span>${(mode.ownerCertAddr)!}</span></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>证件照片:</span></td>
                        <td>
                            <div style="width: 100px;height: 90px;float: left">
                                <div>
                                <#if (mode.pic1)?? &&(mode.pic1)!="" >
                                    <img id="image1" src="${(mode.pic1)!}" alt="点击上传证件正面图片">
                                <#else >
                                    <img id="image1" src="${base}/images/u505.png" alt="点击上传证件正面图片">
                                </#if>
                                </div>
                                <div style="text-align: center">
                                    证件正面
                                </div>
                            </div>

                            <div style="width: 100px;height: 90px;float: left;margin-left: 10px">
                                <div>
                                <#if (mode.pic2)?? &&(mode.pic2)!="" >
                                    <img id="image1" src="${(mode.pic2)!}" alt="点击上传证件正面图片">
                                <#else >
                                    <img id="image1" src="${base}/images/u505.png" alt="点击上传证件正面图片">
                                </#if>
                                </div>
                                <div style="text-align: center">
                                    证件背面
                                </div>
                            </div>
                        </td>
                    <tr>
                        <td class="tab_item"><span>手持证件照:</span></td>
                        <td>
                            <div style="width: 100px;height: 60px;float: left;margin-bottom: 5px">
                            <#if (mode.facePic)?? &&(mode.facePic)!="">
                                <img id="image3" src="${(mode.facePic)!}" alt="点击上传证件正面图片">
                            <#else >
                                <img id="image3" src="${base}/images/u505.png" alt="点击上传证件正面图片">
                            </#if>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>联系电话:</span></td>
                        <td> <span>${(mode.mobilePhone)!}</span></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>联系地址:</span></td>
                        <td>${(mode.address)!}</td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>邮箱:</span></td>
                        <td> <span> ${(mode.email)!} </span></td>
                    </tr>
                </table>
            </div>
            <div align="center" id="tab2" style="display: none">
                <table width="90%" class="mt10">
                    <tr>
                        <td class="tab_item" style="font-size: 1.5em;font-weight: 600"><span>认证结果:</span></td>
                        <td>
                            <span>  <#if (mode.authenticationResult)="0">
                                未申请
                            <#elseif ((mode.authenticationResult)="1")>
                                认证中
                            <#elseif ((mode.authenticationResult)="2")>
                                已通过
                            <#elseif ((mode.authenticationResult)="3")>
                                未通过
                            </#if>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item " style="font-size: 1.5em;font-weight: 600"><span>认证信息:</span></td>
                        <td><span> ${(mode.remarks)!} </span></td>
                    </tr>
                </table>
                <hr>
                <table width="90%" class="mt10">
                    <tr>
                        <td class="tab_item"><span>SIM卡号(MSISDN):</span></td>
                        <td><span>${(mode.simCartNumber)!}</span></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>ICCID编号:</span></td>
                        <td><span>${(mode.iccid)!}</span></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>车架号(VIN):</span></td>
                        <td><span>${(mode.vin)!}</span></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>姓名:</span></td>
                        <td><span>${(mode.ownerName)!}</span></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>证件类型:</span></td>
                        <td>   <#if (mode.ownerCertType)="IDCARD">
                            居民身份证
                        <#elseif (mode.ownerCertType)="HKIDCARD">
                            港澳居民来往内地通行证
                        <#elseif (mode.ownerCertType)="PASSPORT">
                            护照
                        <#elseif (mode.ownerCertType)="PLA">
                            军官证
                        <#elseif ((mode.ownerCertType)="POLICEPAPER")>
                            警官证
                        <#elseif ((mode.ownerCertType)="TAIBAOZHENG")>
                            台湾居民来往大陆通行证
                        <#elseif ((mode.ownerCertType)="UNITCREDITCODE")>
                            统一社会信用代码
                        <#elseif ((mode.ownerCertType)="OTHERLICENCE")>
                            其他
                        </#if></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>证件号码:</span></td>
                        <td> <span>${(mode.ownerCertId)!}</span></td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>联系电话:</span></td>
                        <td><span>${(mode.mobilePhone)!}</span></td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
</body>
</html>