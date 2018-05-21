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
    </style>
</head>
<body>
<div class="easyui-layout" fit="true">
    <div region="center" style="overflow: hidden;width: 50%;" >
        <form id="post_form" method="post" novalidate>
            <div align="center"id="tab1">
                <table width="90%" class="mt10">
                    <tr>
                        <td class="tab_item"><span>姓名:</span></td>
                        <td>
                            <span>${(sysOwnerPeopleEntity.ownerName)!}</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>性别:</span></td>
                        <td>
                            <span>
                                <#if (((sysOwnerPeopleEntity.sex)!'')=="M")>男</#if>
                                <#if (((sysOwnerPeopleEntity.sex)!'')=="F")>女</#if>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>证件类型:</span></td>
                        <td>
                            <span>
                                <#if (((sysOwnerPeopleEntity.ownerCertType)!'')=="HKIDCARD")>港澳居民来往内地通行证</#if>
                                <#if (((sysOwnerPeopleEntity.ownerCertType)!'')=="IDCARD")>居民身份证</#if>
                                <#if (((sysOwnerPeopleEntity.ownerCertType)!'')=="OTHERLICENCE")>其他</#if>
                                <#if (((sysOwnerPeopleEntity.ownerCertType)!'')=="PASSPORT")>护照</#if>
                                <#if (((sysOwnerPeopleEntity.ownerCertType)!'')=="PLA")>军官证</#if>
                                <#if (((sysOwnerPeopleEntity.ownerCertType)!'')=="POLICEPAPER")>警官证</#if>
                                <#if (((sysOwnerPeopleEntity.ownerCertType)!'')=="TAIBAOZHENG")>台湾居民来往大陆通行证</#if>
                                <#if (((sysOwnerPeopleEntity.ownerCertType)!'')=="UNITCREDITCODE")>统一社会信用代码</#if>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>证件号码:</span></td>
                        <td>
                            <span>${(sysOwnerPeopleEntity.ownerCertId)!}</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>所有人证件地址:</span></td>
                        <td>
                            <span>${(sysOwnerPeopleEntity.ownerCertAddr)!}</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>证件照片:</span></td>
                        <td>
                            <div style="width: 100px;height: 90px;float: left">
                                <#if (sysOwnerPeopleEntity.pic1)?? &&(sysOwnerPeopleEntity.pic1)!="" >
                                    <img id="image1" src="${(sysOwnerPeopleEntity.pic1)!}" alt="点击上传证件正面图片">
                                <#else >
                                        <img id="image1" src="${base}/images/u505.png" alt="点击上传证件正面图片">
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
                            <div style="width: 100px;height: 90px;float: left;">
                                <#if (sysOwnerPeopleEntity.pic2)?? &&(sysOwnerPeopleEntity.pic2)!="" >
                                    <img id="image2" src="${(sysOwnerPeopleEntity.pic2)!}" alt="点击上传证件正面图片">
                                <#else >
                                    <img id="image2" src="${base}/images/u505.png" alt="点击上传证件正面图片">
                                </#if>

                                <div style="text-align: center">
                                    证件背面
                                </div>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td class="tab_item"><span>手持证件照:</span></td>
                        <td>
                            <div style="width: 100px;height: 60px;float: left;margin-left: 5px">
                            <#if (sysOwnerPeopleEntity.facePic)?? &&(sysOwnerPeopleEntity.facePic)!="" >
                                <img id="image3" src="${(sysOwnerPeopleEntity.facePic)!}" alt="点击上传证件正面图片">
                            <#else >
                                    <img id="image3" src="${base}/images/u505.png" alt="点击上传证件正面图片">
                            </#if>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>联系电话:</span></td>
                        <td>
                            <span>${(sysOwnerPeopleEntity.mobilePhone)!}</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>联系地址:</span></td>
                        <td>
                            <span>${(sysOwnerPeopleEntity.address)!}</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab_item"><span>邮箱:</span></td>
                        <td>
                            <span>${(sysOwnerPeopleEntity.email)!}</span>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
</body>
</html>