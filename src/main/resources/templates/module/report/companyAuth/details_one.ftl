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
        select {
            border: solid 1px #000;
            appearance:none;
            -moz-appearance:none;
            -webkit-appearance:none;
            background:red;
            padding-right: 14px;
        }
        select::-ms-expand { display: none; }
    </style>
    <script language="javascript">
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
    <script type="application/javascript">
       $(function(){
           var showSelect = '${mode.authenticationResult}';
           if(showSelect != 0){
               initResultSelect();
           }
       })
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
                <input value="${mode.id}" required name="id" style="width:180px;"  type="hidden" class="easyui-textbox input"/>
                <div align="center">
                    <table width="90%" class="mt10">
                        <tr>
                            <td class="tab_item sub_title "><span>车辆信息</span></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>车架号（VIN）</span></td>
                           <td><span> <span>${(mode.vin)!}</span></span></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>车型名称</span></td>
                            <td> <span>${(mode.lineNameEn)!}</span></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>业务区分</span></td>
                            <td><span>${(mode.channelId)!}</span></td>
                        </tr>
                    </table>
                    <table width="90%" class="mt10">
                        <tr>
                            <td class="tab_item sub_title"><span>T-BOX信息</span></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>终端编号</span></td>
                            <td><span>${(mode.serialNumber)!}</span></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>IMEI号</span></td>
                            <td><span>${(mode.imei)!}</span></td>
                        </tr>
                    </table>
                    <table width="90%" class="mt10">
                        <tr>
                            <td class="tab_item sub_title"><span>SIM卡信息</span></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>移动用户号码（MSISDN）</span></td>
                            <td><span>${(mode.simCartNumber)!}</span></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>ICCID</span></td>
                            <td><span>${(mode.iccid)!}</span></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>国际移动台识别码（IMSI）</span></td>
                            <td><span>${(mode.imsi)!}</span></td>
                        </tr>
                    </table>
                    <table width="90%" class="mt10">
                        <tr>
                            <td class="tab_item sub_title"><span>客户企业信息</span></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>企业名称</span></td>
                            <td><span>${(mode.name)!}</span></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>企业地址</span></td>
                            <td><span>${(mode.cusReplace)!}</span></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>企业类型</span></td>
                            <td>
                                <span>${(mode.comType)!}</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>行业类型</span></td>
                            <td>
                                <span>${(mode.industryType)!}</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>统一社会信用代码</span></td>
                            <td><span>${(mode.creditCode)!}</span></td>
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
                            <td><span>${(mode.contact)!}</span></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>性别</span></td>
                            <td>
                                <span>${(mode.sex)!}</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>证件类型</span></td>
                            <td>
                                <span>${(mode.ownerCertType)!}</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>证件号码</span></td>
                            <td><span>${(mode.ownerCertId)!}</span></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>所有人证件地址</span></td>
                            <td><span>${(mode.ownerCertAddr)!}</span></td>
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
                            <td><span>${(mode.contactInfo)!}</span></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>联系地址</span></td>
                            <td><span>${(mode.ownerAddress)!}</span></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>邮箱</span></td>
                            <td><span>${(mode.email)!}</span></td>
                        </tr>
                    </table>
                </div>
            </form>
        </div>
        <div id="tab2" class="hide">
            <table width="90%" class="mt10">
                <tr>
                    <td class="tab_item sub_title"><span>认证结果</span></td>
                    <td>
                        <#if mode.authenticationResult == "0">
                            <span>未申请</span>
                        </#if>
                        <#if mode.authenticationResult == "1">
                            <span>认证中</span>
                        </#if>
                        <#if mode.authenticationResult == "2">
                            <span>已通过</span>
                        </#if>
                        <#if mode.authenticationResult == "3">
                            <span>未通过</span>
                        </#if>
                    </td>
                </tr>
                <tr>
                    <td class="tab_item sub_title"><span>认证信息</span></td>
                    <td>${(mode.remarks)!}</td>
                </tr>
            </table>
            <hr>
            <table width="90%" class="mt10">
                <tr>
                    <td class="tab_item"><span>SIM卡号（MSISDN）</span></td>
                    <td><span>${(mode.serialNumber)!}</span></td>
                </tr>
                <tr>
                    <td class="tab_item"><span>ICCID编号</span></td>
                    <td><span>${(mode.iccid)!}</span></td>
                </tr>
                <#--<tr>-->
                    <#--<td class="tab_item"><span>车型名称</span></td>-->
                    <#--<td><span></span></td>-->
                <#--</tr>-->
                <tr>
                    <td class="tab_item"><span>车架号（VIN）</span></td>
                    <td><span>${(mode.vin)!}</span></td>
                </tr>
                <tr>
                    <td class="tab_item"><span>姓名</span></td>
                    <td><span>${(mode.contact)!}</span></td>
                </tr>
                <tr>
                    <td class="tab_item"><span>证件类型</span></td>
                    <td><span id="result_cert_type">${(mode.ownerCertType)!}</span></td>
                </tr>
                <tr>
                    <td class="tab_item"><span>证件号码</span></td>
                    <td><span>${(mode.ownerCertId)!}</span></td>
                </tr>
                <tr>
                    <td class="tab_item"><span>联系电话</span></td>
                    <td><span>${(mode.contactInfo)!}</span></td>
                </tr>
            </table>
        </div>
    </div>
</div>
</body>
</html>