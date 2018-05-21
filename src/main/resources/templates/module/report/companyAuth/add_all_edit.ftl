
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<#include "../../../inc/meta.ftl">
<#include  "../../../inc/js.ftl">
<#include  "../../../inc/top.ftl">
    <style type="text/css">
        .td_input a:not(.bg_button) {
            right: 20px !important;
        }
    </style>
    <style type="text/css">
        .mt10 {
            margin-top: 10px;
        }

        .tab_item {
            text-align: right;
            width: 35%;
        }

        .select_item {
            width: 180px;
            height: 22px;
        }

        .sub_title {
            margin: 8px;
            text-align: center;
            font-size: 1.1em;
            font-weight: 600;
            background-color: #F2F2F2;
        }

        i:before{
            content: "*";
            color: red;
            border-collapse: separate;
            font-style: normal;
        }

        i:after {
            content: "：";
            border-collapse: separate;
            font-style: normal;
        }

        .submit_button {
            padding: 5px 30px;
        }

        span {
            font-style: normal;
        }

        .post_form table {
            border-collapse: separate;
            border-spacing: 10px;
        }

        .post_form table td {
            width: 200px;
            word-break: break-all;
        }

        .submit_group {
            margin-bottom: 30px;
            width: 50%;
            text-align: center;
        }
        #post_form img{
            width: 96px;
            height:57px;
        }
    </style>
    <script type="application/javascript">
        function checkSelect(name,value){
            $('[name="'+name+'"]').attr('value',value);
            $('[name="'+name+'"]').attr("disabled",true);
        }

        function deleteFile(){
            $("#fileName").val("");
        }

        function initResult(){
            $('#result_cert_type').val($('[name="ownerCertType"]').val());
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
            obj['enterPic'] = $('#image1').attr("src");
            obj['authPic'] = $('#image2').attr("src");
            obj['pic1'] = $('#image3').attr("src");
            obj['pic2'] = $('#image4').attr("src");
            obj['factPic'] = $('#image5').attr("src");
            return obj;
        }

        function loadImage() {
            $('#enterPic').val($('#image1').attr("src"));
            $('#authPic').val($('#image2').attr("src"));
            $('#pic1').val($('#image3').attr("src"));
            $('#pic2').val($('#image4').attr("src"));
            $('#factPic').val($('#image5').attr("src"));
        }

        //company_all_save
        function save() {
            if (validateInfor($("#image1").attr("src"))){
                $("#image1").parent().nextAll().remove();
                $("#image1").parent().after("<div style='margin:3px;float: left;'><span style='color: red;line-height: 90px '>请上传营业执照扫描照</span></div>");
                // alert("请上传授权书扫描件");
                return false;
            }if (validateInfor($("#image2").attr("src"))){
                $("#image2").parent().nextAll().remove();
                $("#image2").parent().after("<div style='margin:3px;float: left;'><span style='color: red;line-height: 90px '>请上传授权书扫描件</span></div>");
                // alert("请上传授权书扫描件");
                return false;
            }
            if (validateInfor($("#image3").attr("src"))){
                $("#image3").parent().nextAll().remove();
                $("#image3").parent().after("<div style='margin:3px;float: left;'><span style='color: red;line-height: 90px '>请上传证件正面</span></div>");
                // alert("请上传证件正面");
                return false;
            }
            if (validateInfor($("#image4").attr("src"))){
                $("#image4").parent().nextAll().remove();
                $("#image4").parent().after("<div style=' margin:3px;float: left;'><span style='color: red;line-height: 90px '>请上传证件背面</span></div>");
                // alert("请上传证件背面");
                return false;
            }
            if (validateInfor($("#image5").attr("src"))){
                $("#image5").parent().nextAll().remove();
                $("#image5").parent().after("<div style='margin:3px;float: left;'><span style='color: red;line-height: 90px '>请上传手持证件照</span></div>");
                // alert("请上传手持证件照");
                return false;
            }
            //校验
            if ($("#post_form").form('validate')) {
                loadImage();
                $("#post_form").form("submit", {
                    url: "${base}/companyAuth/company_all_save",
                    data:form2Object('post_form'),
                    dataType: "json",
                    success: function (data) {
                        var json = $.parseJSON(data);
                        if (json.code == -1) {
                            alert(json.message);
                        } else {
                            close_win();
                            window.top.auth_result_data = json;
                            module_window("result_import",'${base}/companyAuth/import_result','车辆信息导入结果',650, 500,true,data)
                        }
                        window.top.reload.datagrid('reload')
                    }
                })
            }
        }

        /**
         *
         * @param _urlFlag 1不可修改信息的提交接口
         *                  2.可修改信息的提交接口
         * @returns {boolean}
         */
        function commit_form(_urlFlag){
            if (validateInfor($("#image1").attr("src"))){
                $("#image1").parent().nextAll().remove();
                $("#image1").parent().after("<div style='margin:3px;float: left;'><span style='color: red;line-height: 90px '>请上传营业执照扫描照</span></div>");
                // alert("请上传授权书扫描件");
                return false;
            }if (validateInfor($("#image2").attr("src"))){
                $("#image2").parent().nextAll().remove();
                $("#image2").parent().after("<div style='margin:3px;float: left;'><span style='color: red;line-height: 90px '>请上传授权书扫描件</span></div>");
                // alert("请上传授权书扫描件");
                return false;
            }
            if (validateInfor($("#image3").attr("src"))){
                $("#image3").parent().nextAll().remove();
                $("#image3").parent().after("<div style='margin:3px;float: left;'><span style='color: red;line-height: 90px '>请上传证件正面</span></div>");
                // alert("请上传证件正面");
                return false;
            }
            if (validateInfor($("#image4").attr("src"))){
                $("#image4").parent().nextAll().remove();
                $("#image4").parent().after("<div style=' margin:3px;float: left;'><span style='color: red;line-height: 90px '>请上传证件背面</span></div>");
                // alert("请上传证件背面");
                return false;
            }
            if (validateInfor($("#image5").attr("src"))){
                $("#image5").parent().nextAll().remove();
                $("#image5").parent().after("<div style='margin:3px;float: left;'><span style='color: red;line-height: 90px '>请上传手持证件照</span></div>");
                // alert("请上传手持证件照");
                return false;
            }

            if($("#post_form").form('validate')){
                var url = "";
                if(_urlFlag == 1){
                    url = "${base}/companyAuth/company_all_auth_noCom";
                }else if(_urlFlag == 2){
                    url = "${base}/companyAuth/company_all_auth";
                }else{
                    alert("参数错误，请求失败");
                    return;
                }
                loadImage();
                $("#post_form").form("submit",{
                    url:url,
                    dataType: "json",
                    data:form2Object('post_form'),
                    success:function(data){
                        var json = $.parseJSON(data);
                        if(json.code == -1){
                            alert(json.message);
                        }else{
                            close_win();
                            window.top.auth_result_data = json;
                            module_window("result_import",'${base}/companyAuth/import_result','车辆信息导入结果',650, 500,true,data);
                        }
                        window.top.reload.datagrid('reload')
                    }
                })
            }
        }

        function findCom(){
            module_window('auth_all','${base}/customerUnit/getComInfo?type=3','选择企业', 700, 630)
        }

        //弹窗回调
        function dialogCallBack(row){
            $('#id').textbox().textbox("setValue",row['id']);
            $('#name').textbox().textbox("setValue",row['name']);
            $('#cusReplace').textbox().textbox("setValue",row['cusReplace']);
            $('#comType').val(row['id']);
            $('#comType').val(row['comType']);
            $('#creditCode').textbox().textbox("setValue",row['creditCode']);
            $('#contact').textbox().textbox("setValue",row['contact']);
            $('#sex').val(row['sex']);
            $('#ownerCertType').val(row['ownerCertType']);
            $('#industryType').val(row['industryType']);
            $('#ownerCertId').textbox().textbox("setValue",row['ownerCertId']);
            $('#ownerCertAddr').textbox().textbox("setValue",row['ownerCertAddr']);
            $('#contactInfo').textbox().textbox("setValue",row['contactInfo']);
            $('#ownerAddress').textbox().textbox("setValue",row['ownerAddress']);
            $('#email').textbox().textbox("setValue",row['email']);

            $('#image1').attr('src',row['enterPic']==null?'${base}/images/u505.png':row['enterPic']);
            $('#image2').attr('src',row['authPic']==null?'${base}/images/u505.png':row['authPic']);
            $('#image3').attr('src',row['pic1']==null?'${base}/images/u505.png':row['pic1']);
            $('#image4').attr('src',row['pic2']==null?'${base}/images/u505.png':row['pic2']);
            $('#image5').attr('src',row['factPic']==null?'${base}/images/u505.png':row['factPic']);
        }

        $(function(){
            initResult();
            initValid();
        })

        $("img").on('load', function() {
            $(this).parent().nextAll().remove();
            $(this).off('load')
        });
        function validateInfor(val) {
            if(val == null || val == "" || val == '${base}/images/u505.png'){
                return true;
            }else {
                return false;
            }
        }
    </script>
</head>
<body class="easyui-layout" fit="true">
    <div id="result_dialog"></div>
    <div region="center" style="overflow: hidden">
        <#if is_edit?? && is_edit=='0' >
            <form id="post_form" method="post" enctype="multipart/form-data">
                <input name="id" id="id" type="hidden" value="${(mode.id)!}"/>
                <input name="creditCode" id="creditCode" type="hidden" value="${(mode.creditCode)!}"/>
                <!--图片区域

                      obj['enterPic'] = $('#image1').attr("src");
                        obj['authPic'] = $('#image2').attr("src");
                        obj['pic1'] = $('#image3').attr("src");
                        obj['pic2'] = $('#image4').attr("src");
                        obj['factPic'] = $('#image5').attr("src");

                -->
                <input name="enterPic" id="enterPic" type="hidden"/>
                <input name="authPic" id="authPic" type="hidden"/>
                <input name="pic1" id="pic1" type="hidden"/>
                <input name="pic2" id="pic2" type="hidden"/>
                <input name="factPic" id="factPic" type="hidden"/>

                <div align="center">
                    <div class="auth_info">
                        <table width="90%" class="mt10">
                            <tr>
                                <td class="tab_item sub_title"><span>客户企业信息</span></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>企业名称</span></td>
                                <td>
                                    <span>${(mode.name)!}</span>
                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>企业地址</span></td>
                                <td>
                                    <span>${(mode.cusReplace)!}</span>
                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>企业类型</span></td>
                                <td>
                                    <#if (((mode.comType)!'')=="0")>非公司企业法人</#if>
                                    <#if (((mode.comType)!'')=="1")>有限责任公司</#if>
                                    <#if (((mode.comType)!'')=="2")>股份有限责任公司</#if>
                                    <#if (((mode.comType)!'')=="3")>个体工商户</#if>
                                    <#if (((mode.comType)!'')=="4")>私营独企业</#if>
                                    <#if (((mode.comType)!'')=="5")>私营合伙企业</#if>
                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>行业类型</span></td>
                                <td>
                                <#if (((mode.industryType)!'')=="1")>农、林、牧、渔业</#if>
                                <#if (((mode.industryType)!'')=="2")>采矿业</#if>
                                <#if (((mode.industryType)!'')=="3")>制造业</#if>
                                <#if (((mode.industryType)!'')=="3_01")>烟草制品业</#if>
                                <#if (((mode.industryType)!'')=="3_02")>纺织服装鞋帽制造业</#if>
                                <#if (((mode.industryType)!'')=="3_03")>医药制造业</#if>
                                <#if (((mode.industryType)!'')=="3_04")>通讯设备计算机及其他电子设备制造业</#if>
                                <#if (((mode.industryType)!'')=="3_05")>交通运输设备制造业</#if>
                                <#if (((mode.industryType)!'')=="3_06")>食品制造业</#if>
                                <#if (((mode.industryType)!'')=="3_07")>饮料制造业</#if>
                                <#if (((mode.industryType)!'')=="3_08")>化学原料及化学制品制造业</#if>
                                <#if (((mode.industryType)!'')=="3_09")>电器机械及器材制造业</#if>
                                <#if (((mode.industryType)!'')=="3_10")>其他制造业</#if>
                                <#if (((mode.industryType)!'')=="4")>电力、燃气及水的生产和供应业</#if>
                                <#if (((mode.industryType)!'')=="5")>建筑业</#if>
                                    <#if (((mode.industryType)!'')=="6")>交通运输、仓储和邮政业</#if>
                                    <#if (((mode.industryType)!'')=="7")>信息传输、计算机服务和软件业</#if>
                                    <#if (((mode.industryType)!'')=="7_01")>电信和其他信息传输服务业</#if>
                                    <#if (((mode.industryType)!'')=="7_02")>计算机服务业</#if>
                                    <#if (((mode.industryType)!'')=="7_03")>软件业</#if>
                                    <#if (((mode.industryType)!'')=="8")>批发和零售业</#if>
                                    <#if (((mode.industryType)!'')=="9")>住宿和餐饮业</#if>
                                    <#if (((mode.industryType)!'')=="10")>金融业</#if>
                                    <#if (((mode.industryType)!'')=="10_01")>银行业</#if>
                                    <#if (((mode.industryType)!'')=="10_02")>证券业</#if>
                                    <#if (((mode.industryType)!'')=="10_03")>保险业</#if>
                                    <#if (((mode.industryType)!'')=="10_04")>其他</#if>
                                    <#if (((mode.industryType)!'')=="11")>房产地产</#if>
                                    <#if (((mode.industryType)!'')=="12")>租赁和商务服务业</#if>
                                    <#if (((mode.industryType)!'')=="13")>科学研究、技术服务和地质勘查业</#if>
                                    <#if (((mode.industryType)!'')=="14")>水利、环境和公共设施管理业</#if>
                                    <#if (((mode.industryType)!'')=="15")>居民服务和其他服务业</#if>
                                    <#if (((mode.industryType)!'')=="16")>教育</#if>
                                    <#if (((mode.industryType)!'')=="17")>卫生、社会保障和社会福利业</#if>
                                    <#if (((mode.industryType)!'')=="18")>文化、体育和娱乐业</#if>
                                    <#if (((mode.industryType)!'')=="19")>公共管理和社会组织</#if>
                                    <#if (((mode.industryType)!'')=="19_01")>中国共产党机关</#if>
                                    <#if (((mode.industryType)!'')=="19_02")>国家权力和行政机构</#if>
                                    <#if (((mode.industryType)!'')=="19_03")>公安、法院、检察院和司法机构</#if>
                                    <#if (((mode.industryType)!'')=="19_04")>其他国家机构（军队）</#if>
                                    <#if (((mode.industryType)!'')=="19_05")>人民政协和民主党派</#if>
                                    <#if (((mode.industryType)!'')=="19_06")>群体团体、社会团体和宗教团体</#if>
                                    <#if (((mode.industryType)!'')=="19_07")>基层群众自治组织</#if>
                                    <#if (((mode.industryType)!'')=="20")>国际组织</#if>
                                    <#if (((mode.industryType)!'')=="21")>个人</#if>
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
                                     <img id="image1" src="${(mode.enterPic)!}" name="enterPic" alt="点击上传证件正面图片">
                                 <#else >
                                    <img  id="image1" src="${base}/images/u505.png" name="enterPic" alt="点击上传证件正面图片">
                                 </#if>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>授权书扫描件</span></td>
                                <td>
                                    <div style="width: 100px;height: 60px;float: left">
                                 <#if (mode.authPic)?? &&(mode.authPic)!="" >
                                     <img id="image2" src="${(mode.authPic)!}" name="authPic" alt="点击上传证件正面图片">
                                 <#else >
                                    <img id="image2" src="${base}/images/u505.png" name="authPic" alt="点击上传证件正面图片">
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
                                <td>${(mode.contact)!}</td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>性别</span></td>
                                <td>
                                    <span>
                                        <#if (((mode.sex)!'')=="M")>男</#if>
                                        <#if (((mode.sex)!'')=="F")>女</#if>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>证件类型</span></td>
                                <td>
                                    <span>
                                        <#if (((mode.ownerCertType)!'')=="HKIDCARD")>港澳居民来往内地通行证</#if>
                                        <#if (((mode.ownerCertType)!'')=="IDCARD")>居民身份证</#if>
                                        <#if (((mode.ownerCertType)!'')=="OTHERLICENCE")>其他</#if>
                                        <#if (((mode.ownerCertType)!'')=="PASSPORT")>护照</#if>
                                        <#if (((mode.ownerCertType)!'')=="PLA")>军官证</#if>
                                        <#if (((mode.ownerCertType)!'')=="POLICEPAPER")>警官证</#if>
                                        <#if (((mode.ownerCertType)!'')=="TAIBAOZHENG")>台湾居民来往大陆通行证</#if>
                                        <#if (((mode.ownerCertType)!'')=="UNITCREDITCODE")>统一社会信用代码</#if>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>证件号码</span></td>
                                <td><span>${(mode.ownerCertId)!}</span></td>
                            </tr>
                            <tr>
                                <td class="tab_item"><span>所有人证件地址</span></td>
                                <td>${(mode.ownerCertAddr)!}</td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>证件照片</span></td>
                                <td>
                                    <div style="width: 100px;height: 90px;float: left">
                                        <#if (mode.pic1)?? &&(mode.pic1)!="" >
                                            <img  id="image3" src="${(mode.pic1)!}" name="pic1" alt="点击上传证件正面图片">
                                        <#else >
                                                <img  id="image3" src="${base}/images/u505.png" name="pic1" alt="点击上传证件正面图片">
                                        </#if>
                                    </div>
                                    <div style="text-align: center">
                                        证件正面
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <td class="tab_item"></td>
                                <td>

                                    <div style="width: 100px;height: 90px;float: left;">
                                        <#if (mode.pic2)?? &&(mode.pic2)!="" >
                                            <img  id="image4" src="${(mode.pic2)!}" name="pic2" alt="点击上传证件正面图片">
                                        <#else >
                                            <img  id="image4" src="${base}/images/u505.png" name="pic2" alt="点击上传证件正面图片">
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
                                    <div style="width: 100px;height: 60px;float: left;">
                            <#if (mode.factPic)?? &&(mode.factPic)!="" >
                                <img id="image5" src="${(mode.factPic)!}" name="factPic" alt="点击上传证件正面图片">
                            <#else >
                                    <img id="image5" src="${base}/images/u505.png" name="factPic" alt="点击上传证件正面图片">
                            </#if>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>联系电话</span></td>
                                <td>${(mode.contactInfo)!}</td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>联系地址</span></td>
                                <td>${(mode.ownerAddress)!}</td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>邮箱</span></td>
                                <td><span>${(mode.email)!}</span></td>
                            </tr>
                        </table>
                        <table width="90%" class="mt10">
                            <tr>
                                <td class="tab_item sub_title"><i><span>车辆信息</span></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>添加企业车辆实名认证文件</span></td>
                                <td colspan="2"><input id="fileName" name="fileName" style="width:180px;" type="file"/></td>
                            </tr>
                            <tr>
                                <td class="tab_item"></td>
                                <td colspan="2">说明：一次最多导入200调数据</td>
                            </tr>
                        </table>
                        <div class="mt10 submit_group">
                            <a href="#" id="result"
                               onclick="commit_form(1)"
                               class="easyui-linkbutton submit_button">保存并提交信息</a>
                            <a href="#" onclick="save(1)" class="easyui-linkbutton submit_button">保存</a>
                        </div>
                    </div>
                    <div class="auth_result"></div>
                </div>
            </form>
        <#else >
            <form id="post_form" method="post" enctype="multipart/form-data">
                <input type="file" name="file" class="hide" id="imagefile" onchange="doUpload(this)"/>
                <input name="id" type="hidden" value="${(mode.id)!}"/>

                <input name="enterPic" id="enterPic" type="hidden"/>
                <input name="authPic" id="authPic" type="hidden"/>
                <input name="pic1" id="pic1" type="hidden"/>
                <input name="pic2" id="pic2" type="hidden"/>
                <input name="factPic" id="factPic" type="hidden"/>
                <div align="center">
                    <div class="auth_info">
                        <table width="90%" class="mt10">
                            <tr>
                                <td class="tab_item sub_title"><span>客户企业信息</span></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>企业名称</span></td>
                                <td>
                                <input style="width:180px;" data-options="required:true" validType="standardlength[1,255]" value="${(mode.name)!}"
                                id="name" name="name" type="text" class="easyui-textbox input"/>
                                    <a href="#" onclick="findCom()">&nbsp;&nbsp;选择已有客户企业</a>
                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>企业地址</span></td>
                                <td>
                                    <input style="width:180px;" data-options="required:true" validType="standardlength[1,255]" value="${(mode.cusReplace)!}"
                                           id="cusReplace" name="cusReplace" type="text" class="easyui-textbox input"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>企业类型</span></td>
                                <td>
                                    <select class="select_item" id="comType" name="comType" data-options="required:true">
                                        <option value ="0" selected>非公司企业法人</option>
                                        <option value ="1"<#if (((mode.comType)!'')=="1")>selected</#if>>有限责任公司</option>
                                        <option value ="2"<#if (((mode.comType)!'')=="2")>selected</#if>>股份有限责任公司</option>
                                        <option value ="3"<#if (((mode.comType)!'')=="3")>selected</#if>>个体工商户</option>
                                        <option value ="4"<#if (((mode.comType)!'')=="4")>selected</#if>>私营独资企业</option>
                                        <option value ="5"<#if (((mode.comType)!'')=="5")>selected</#if>>私营合伙企业</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>行业类型</span></td>
                                <td>
                                    <select class="select_item" id="industryType" name="industryType" data-options="required:true">
                                        <option value ="1">1 农、林、牧、渔业</option>
                                        <option value ="2"<#if (((mode.industryType)!'')=="2")>selected</#if>>2 采矿业</option>
                                        <option value ="3"<#if (((mode.industryType)!'')=="3")>selected</#if>>3 制造业</option>
                                        <option value ="3_01"<#if (((mode.industryType)!'')=="3_01")>selected</#if>>3.1 烟草制品业</option>
                                        <option value ="3_02"<#if (((mode.industryType)!'')=="3_02")>selected</#if>>3.2 纺织服装鞋帽制造业</option>
                                        <option value ="3_03"<#if (((mode.industryType)!'')=="3_03")>selected</#if>>3.3 医药制造业</option>
                                        <option value ="3_04"<#if (((mode.industryType)!'')=="3_04")>selected</#if>>3.4 通讯设备计算机及其他电子设备制造业</option>
                                        <option value ="3_05"<#if (((mode.industryType)!'')=="3_05")>selected</#if>>3.5 交通运输设备制造业</option>
                                        <option value ="3_06"<#if (((mode.industryType)!'')=="3_06")>selected</#if>>3.6 食品制造业</option>
                                        <option value ="3_07"<#if (((mode.industryType)!'')=="3_07")>selected</#if>>3.7 饮料制造业</option>
                                        <option value ="3_08"<#if (((mode.industryType)!'')=="3_08")>selected</#if>>3.8 化学原料及化学制品制造业</option>
                                        <option value ="3_09"<#if (((mode.industryType)!'')=="3_09")>selected</#if>>3.9 电器机械及器材制造业</option>
                                        <option value ="3_10"<#if (((mode.industryType)!'')=="3_10")>selected</#if>>3.10 其他制造业</option>
                                        <option value ="4"<#if (((mode.industryType)!'')=="4")>selected</#if>>4 电力、燃气及水的生产和供应业</option>
                                        <option value ="5"<#if (((mode.industryType)!'')=="5")>selected</#if>>5 建筑业</option>
                                        <option value ="6"<#if (((mode.industryType)!'')=="6")>selected</#if>>6 交通运输、仓储和邮政业</option>
                                        <option value ="7"<#if (((mode.industryType)!'')=="7")>selected</#if>>7 信息传输、计算机服务和软件业</option>
                                        <option value ="7_01"<#if (((mode.industryType)!'')=="7_01")>selected</#if>>7.1 电信和其他信息传输服务业</option>
                                        <option value ="7_02"<#if (((mode.industryType)!'')=="7_02")>selected</#if>>7.2 计算机服务业</option>
                                        <option value ="7_03"<#if (((mode.industryType)!'')=="7_03")>selected</#if>>7.3 软件业</option>
                                        <option value ="8"<#if (((mode.industryType)!'')=="8")>selected</#if>>8 批发和零售业</option>
                                        <option value ="9"<#if (((mode.industryType)!'')=="9")>selected</#if>>9 住宿和餐饮业</option>
                                        <option value ="10"<#if (((mode.industryType)!'')=="10")>selected</#if>>10 金融业</option>
                                        <option value ="10_01"<#if (((mode.industryType)!'')=="10_01")>selected</#if>>10.1 银行业</option>
                                        <option value ="10_02"<#if (((mode.industryType)!'')=="10_02")>selected</#if>>10.2 证券业</option>
                                        <option value ="10_03"<#if (((mode.industryType)!'')=="10_03")>selected</#if>>10.3 保险业</option>
                                        <option value ="10_04"<#if (((mode.industryType)!'')=="10_04")>selected</#if>>10.4 其他</option>
                                        <option value ="11"<#if (((mode.industryType)!'')=="11")>selected</#if>>11 房产地产</option>
                                        <option value ="12"<#if (((mode.industryType)!'')=="12")>selected</#if>>12 租赁和商务服务业</option>
                                        <option value ="13"<#if (((mode.industryType)!'')=="13")>selected</#if>>13 科学研究、技术服务和地质勘查业</option>
                                        <option value ="14"<#if (((mode.industryType)!'')=="14")>selected</#if>>14 水利、环境和公共设施管理业</option>
                                        <option value ="15"<#if (((mode.industryType)!'')=="15")>selected</#if>>15 居民服务和其他服务业</option>
                                        <option value ="16"<#if (((mode.industryType)!'')=="16")>selected</#if>>16 教育</option>
                                        <option value ="17"<#if (((mode.industryType)!'')=="17")>selected</#if>>17 卫生、社会保障和社会福利业</option>
                                        <option value ="18"<#if (((mode.industryType)!'')=="18")>selected</#if>>18 文化、体育和娱乐业</option>
                                        <option value ="19"<#if (((mode.industryType)!'')=="19")>selected</#if>>19 公共管理和社会组织</option>
                                        <option value ="19_01"<#if (((mode.industryType)!'')=="19_01")>selected</#if>>19.1 中国共产党机关</option>
                                        <option value ="19_02"<#if (((mode.industryType)!'')=="19_02")>selected</#if>>19.2 国家权力和行政机构</option>
                                        <option value ="19_03"<#if (((mode.industryType)!'')=="19_03")>selected</#if>>19.3 公安、法院、检察院和司法机构</option>
                                        <option value ="19_04"<#if (((mode.industryType)!'')=="19_04")>selected</#if>>19.4 其他国家机构（军队）</option>
                                        <option value ="19_05"<#if (((mode.industryType)!'')=="19_05")>selected</#if>>19.5 人民政协和民主党派</option>
                                        <option value ="19_06"<#if (((mode.industryType)!'')=="19_06")>selected</#if>>19.6 群体团体、社会团体和宗教团体</option>
                                        <option value ="19_07"<#if (((mode.industryType)!'')=="19_07")>selected</#if>>19.7 基层群众自治组织</option>
                                        <option value ="20"<#if (((mode.industryType)!'')=="20")>selected</#if>>20 国际组织</option>
                                        <option value ="21"<#if (((mode.industryType)!'')=="21")>selected</#if>>21 个人</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>统一社会信用代码</span></td>
                                <td>
                                    <input style="width:180px;" data-options="required:true" validType="midlength[18]" value="${(mode.creditCode)!}" id="creditCode" name="creditCode" type="text" class="easyui-textbox input"/>

                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>营业执照扫描照</span></td>
                                <td>
                                    <div style="width: 100px;height: 60px;float: left">
                                             <#if (mode.enterPic)?? &&(mode.enterPic)!="" >
                                                 <img id="image1" style="float:left;" src="${(mode.enterPic)!}" alt="点击上传证件正面图片" onclick="flag=1;document.getElementById('imagefile').click();">
                                             <#else >
                                                <img id="image1" style="float:left;" src="${base}/images/u505.png" alt="点击上传证件正面图片" onclick="flag=1;document.getElementById('imagefile').click();">
                                             </#if>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>授权书扫描件</span></td>
                                <td>
                                    <div style="width: 100px;height: 60px;float: left">
                                             <#if (mode.authPic)?? &&(mode.authPic)!="" >
                                                 <img id="image2" style="float:left;" src="${(mode.authPic)!}" alt="点击上传证件正面图片" onclick="flag=2;document.getElementById('imagefile').click();">
                                             <#else >
                                                <img id="image2" style="float:left;" src="${base}/images/u505.png" alt="点击上传证件正面图片" onclick="flag=2;document.getElementById('imagefile').click();">
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
                                <td>
                                    <input style="width:180px;" data-options="required:true" validType="standardlength[1,255]" value="${(mode.contact)!}"
                                           id="contact" name="contact" type="text" class="easyui-textbox input"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>性别</span></td>
                                <td>
                                    <select class="select_item" id="sex" name="sex" data-options="required:true">
                                        <option value ="M" selected>男</option>
                                        <option value ="F" <#if (((mode.sex)!'')=="F")>selected</#if>>女</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>证件类型</span></td>
                                <td>
                                    <select class="select_item" id="ownerCertType" name="ownerCertType"  data-options="required:true" >
                                        <option value ="IDCARD" selected>居民身份证</option>
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
                                <td>
                                    <input style="width:180px;"  data-options="required:true" validType="ownerCertId[8,30]" value="${(mode.ownerCertId)!}"
                                           id="ownerCertId" name="ownerCertId" type="text" class="easyui-textbox input"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><span>所有人证件地址</span></td>
                                <td>
                                    <input style="width:180px;" value="${(mode.ownerCertAddr)!}" validType="standardlength[3,50]"
                                           id="ownerCertAddr" name="ownerCertAddr" type="text" class="easyui-textbox input"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>证件照面</span></td>
                                <td>
                                    <div style="width: 100px;height: 90px;float: left;margin-left: 5px">
                                        <#if (mode.pic1)?? &&(mode.pic1)!="" >
                                            <img id="image3" style="float:left;" src="${(mode.pic1)!}" alt="点击上传证件正面图片" onclick="flag=3;document.getElementById('imagefile').click();">
                                        <#else >
                                                <img id="image3" style="float:left;" src="${base}/images/u505.png" alt="点击上传证件正面图片" onclick="flag=3;document.getElementById('imagefile').click();">
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

                                    <div style="width: 100px;height: 90px;float: left;margin-left: 5px">
                                            <#if (mode.pic2)?? &&(mode.pic2)!="" >
                                                <img id="image4" style="float:left;" src="${(mode.pic2)!}" alt="点击上传证件正面图片" onclick="flag=4;document.getElementById('imagefile').click();">
                                            <#else >
                                                <img id="image4" style="float:left;" src="${base}/images/u505.png" alt="点击上传证件正面图片" onclick="flag=4;document.getElementById('imagefile').click();">
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
                                    <div style="width: 100px;height: 90px;float: left;">
                                        <#if (mode.factPic)?? &&(mode.factPic)!="" >
                                            <img id="image5" style="float:left;" src="${(mode.factPic)!}" alt="点击上传证件正面图片" onclick="flag=5;document.getElementById('imagefile').click();">
                                        <#else >
                                            <img id="image5" style="float:left;" src="${base}/images/u505.png" alt="点击上传证件正面图片" onclick="flag=5;document.getElementById('imagefile').click();">
                                        </#if>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>联系电话</span></td>
                                <td>
                                    <input style="width:180px;"  data-options="required:true" validType='phoneNum' value="${(mode.contactInfo)!}"
                                           id="contactInfo" name="contactInfo"  type="text" class="easyui-textbox input"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>联系地址</span></td>
                                <td>
                                    <input style="width:180px;" value="${(mode.ownerAddress)!}" validType="standardlength[3,50]"
                                           id="ownerAddress" name="ownerAddress"  type="text" class="easyui-textbox input"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>邮箱</span></td>
                                <td>
                                    <input style="width:180px;"  value="${(mode.email)!}" invalidMessage="请输入正确的邮箱" validType='email'
                                           id="email" name="email" type="text" class="easyui-textbox input"/>
                                </td>
                            </tr>
                        </table>
                        <table width="90%" class="mt10">
                            <tr>
                                <td class="tab_item sub_title"><i><span>车辆信息</span></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="tab_item"><i><span>添加企业车辆实名认证文件</span></td>
                                <td colspan="2"><input id="fileName" name="fileName" style="width:180px;" type="file"/><a href="#" onclick="deleteFile()">&nbsp;&nbsp;删除</a></td>
                            </tr>
                            <tr>
                                <td class="tab_item"></td>
                                <td colspan="2">说明：一次最多导入200调数据</td>
                            </tr>
                        </table>
                        <div class="mt10 submit_group">
                            <a href="#" id="result"
                               onclick="commit_form(2)"
                               class="easyui-linkbutton submit_button">保存并提交信息</a>
                            <a href="#" onclick="save(2)" class="easyui-linkbutton submit_button">保存</a>
                        </div>
                    </div>
                    <div class="auth_result"></div>
                </div>
            </form>
        </#if>

    </div>
<script type="text/javascript">
    $("img").on('load', function() {
        $(this).parent().nextAll().remove();
        $(this).off('load')
    });
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
        $('#imagefile').val('');
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
    $(function(){
        initValid();
    })
</script>
</body>
</html>
