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
            width: 40%;
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
</head>
<body>
<div class="easyui-layout" fit="true">
    <div region="center" style="overflow: hidden;width: 50%">
        <div id="tab1">
            <form id="post_form" method="post">
                <div align="center">
                    <table width="90%" class="mt10">
                        <tr>
                            <td class="tab_item sub_title"><span>客户企业信息</span></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>企业名称</span></td>
                            <td> <input style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>企业地址</span></td>
                            <td> <input style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>企业类型</span></td>
                            <td>
                                <select class="select_item">
                                    <option value ="0">非公司企业法人</option>
                                    <option value ="1">有限责任公司</option>
                                    <option value ="1">股份有限责任公司</option>
                                    <option value ="1">个体工商户</option>
                                    <option value ="1">私营独企业</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>行业类型</span></td>
                            <td>
                                <select class="select_item">
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
                            <td class="tab_item"><i><span>企业证件</span></td>
                            <td> <input style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>营业执照扫描照</span></td>
                            <td>
                                <div>
                                    <div><input style="width:180px;" type="file"/></div>
                                    <div style="width:180px;" align="center"><span>营业执照扫描照</span></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>授权书扫描件</span></td>
                            <td>
                                <div>
                                    <div><input style="width:180px;" type="file"/></div>
                                    <div style="width:180px;" align="center"><span>授权书扫描件</span></div>
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
                            <td> <input style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>性别</span></td>
                            <td>
                                <select class="select_item">
                                    <option value ="1">男</option>
                                    <option value ="2">女</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>证件号码</span></td>
                            <td> <input style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>所有人证件地址</span></td>
                            <td> <input style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>证件正面</span></td>
                            <td>
                                <div style="width:180px;float: left">
                                    <div><input style="width:180px;" type="file"/></div>
                                    <div style="width:180px;text-align: center"><span>证件照正面</span></div>
                                </div>
                                <div style="width: 180px;float: left;margin-left: 10px">
                                    <div><input style="width:180px;" type="file"/></div>
                                    <div style="width:180px;text-align: center"><span>证件照反面</span></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>手持证件照</span></td>
                            <td>
                                <div>
                                    <div><input style="width:180px;" type="file"/></div>
                                    <div style="width:180px;" align="center"><span>手持证件照</span></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>联系电话</span></td>
                            <td> <input style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>联系地址</span></td>
                            <td> <input style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><span>邮箱</span></td>
                            <td> <input style="width:180px;"  type="text" class="easyui-textbox input"/></td>
                        </tr>
                    </table>
                </div>
                <div class="mt10 submit_group">
                    <a href="#" onclick="save()"  class="easyui-linkbutton submit_button">保存</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>