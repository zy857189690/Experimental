
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

        function initSelect() {
            checkSelect('comType','${mode.comType}');
            checkSelect('industryType','${(mode.industryType)!}')
            checkSelect('sex','${mode.sex}')
            checkSelect('ownerCertType','${mode.ownerCertType}')
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
            //组装IMG信息
            return obj;
        }

        //company_all_save
        function save() {
            //校验
            if ($("#post_form").form('validate')) {
                $("#post_form").form("submit", {
                    url: "${base}/companyAuth/company_all_save",
                    dataType: "json",
                    success: function (data) {
                        var json = $.parseJSON(data);
                        if (json.code == -1) {
                            alert(json.message);
                        } else {
                            close_win();
                            module_window("result_import",'${base}/companyAuth/import_result','车辆信息导入结果',650, 500,true,data)
                        }
                    }
                })
            }
        }

        function commit_form(){
            if($("#post_form").form('validate')){
                $("#post_form").form("submit",{
                    url:"${base}/companyAuth/company_all_auth",
                    dataType: "json",
                    success:function(data){
                        var json = $.parseJSON(data);
                        if(json.code == -1){
                            alert(json.message);
                        }else{
                            close_win();
                            module_window("result_import",'${base}/companyAuth/import_result','车辆信息导入结果',650, 500,true,data);
                        }
                    }
                })
            }
        }

        function findCom(){
            module_window('auth_all','${base}/customerUnit/getComInfo?type=3','选择企业', 700, 560)
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

            $('#image1').attr('src',row['enterPic'])
            $('#image2').attr('src',row['authPic'])
            $('#image3').attr('src',row['pic1'])
            $('#image4').attr('src',row['pic2'])
            $('#image5').attr('src',row['factPic'])
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
            initResult();
            initCleanButton();
        })
    </script>
</head>
<body class="easyui-layout" fit="true">
    <div id="result_dialog"></div>
    <div region="center" style="overflow: hidden">
        <form id="post_form" method="post" enctype="multipart/form-data">
            <input name="id" type="hidden" value="${mode.id}"/>
            <div align="center">
                <div class="auth_info">
                    <table width="90%" class="mt10">
                        <tr>
                            <td class="tab_item sub_title"><span>客户企业信息</span></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>企业名称</span><a href="#" onclick="findCom()">&nbsp;&nbsp;选择已有客户企业</a></td>
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
                                     <img id="image1" src="${(mode.enterPic)!}" alt="点击上传证件正面图片">
                                 <#else >
                                    <img id="image1" src="${base}/images/u505.png" alt="点击上传证件正面图片">
                                 </#if>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>授权书扫描件</span></td>
                            <td>
                                <div style="width: 100px;height: 60px;float: left">
                                 <#if (mode.authPic)?? &&(mode.authPic)!="" >
                                     <img id="image2" src="${(mode.authPic)!}" alt="点击上传证件正面图片">
                                 <#else >
                                    <img id="image2" src="${base}/images/u505.png" alt="点击上传证件正面图片">
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
                            <td>${(mode.ownerCertAddr)!}</td>
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>证件照片</span></td>
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
                        </tr>
                        <tr>
                            <td class="tab_item"><i><span>手持证件照</span></td>
                            <td>
                                <div style="width: 100px;height: 60px;float: left;margin-left: 5px">
                            <#if (mode.factPic)?? &&(mode.factPic)!="" >
                                <img id="image3" src="${(mode.factPic)!}" alt="点击上传证件正面图片">
                            <#else >
                                    <img id="image3" src="${base}/images/u505.png" alt="点击上传证件正面图片">
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
                           onclick="commit_form()"
                           class="easyui-linkbutton submit_button">保存并提交信息</a>
                        <a href="#" onclick="save()" class="easyui-linkbutton submit_button">保存</a>
                    </div>
                </div>
                <div class="auth_result"></div>
            </div>
        </form>
    </div>
</body>
</html>
