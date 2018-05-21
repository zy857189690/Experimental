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
        .mt10{
            margin-top: 10px;
        }
        .tab_item {
            text-align: right;
            width: 35%;
        }
        .sub_title{
            margin: 8px;
            text-align: center;
            font-size: 1.1em;
            font-weight: 600;
            background-color: #F2F2F2;
        }
        i:before {
            content: "* ";
            line-height: 30px;overflow-x: ;
            color: red;
            margin-left: 5px;
        }

        i:after{
            content: "  ";
        }
        .submit_button{
            padding: 5px 30px;
        }
        span{
            font-style: normal;
        }
        .page_row{
            margin-top: 10px;
            width: 90%;
        }
    </style>
    <script type="application/javascript">
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
        $(function(){
            $('input').textbox().textbox('addClearBtn', 'icon-clear');
            $('.textbox').css('width',"160px");
        })

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

        //绑定
        function save(_flag) {
            <#--alert("绑定成功");-->
            <#--//$.messager.alert("提示", "绑定成功", "info", function () {-->
            <#--close_win();-->
            <#--addTabFun("客户企业实名认证详情","${base}/companyAuth/company_all_info?id=de4c8ff6a6bc4e2fb89c2617958d1aa8","companyAuth_frame_info",true);-->
            <#--return;-->
            //});
            //校验
            if($("#post_form").form('validate')){
                var mainData = form2Object("post_form");
                $.ajax({
                    type : 'post',
                    url : '${base}/companyAuth/company_bind_car',
                    data : mainData,
                    success : function(data) {
                        if(data.code == -1){
                            alert(data.message)
                        }else{
                            if (_flag == 1){
                                if (typeof (data.data) != undefined){
                                    close_win();
                                    addTabFun("客户企业实名认证详情","${base}/companyAuth/company_all_info?id="+data.data.id,"companyAuth_frame_info",true);
                                    return;
                                }
                            }
                            alert(data.message);
                            close_win();
                            window.top.reload.datagrid('reload')
                        }
                    }
                });
            }
        }

        $(function(){
            initValid();
        })
    </script>
    <script type="application/javascript">
        //添加tab
        function addTabFun(title, url, id,openNewTab, icon, fullScreen) {
            if ($.trim(url) != "") {
                if (window.parent.parent.$('#centerTabs').tabs('exists', title)&&(openNewTab==null||openNewTab==undefined||openNewTab==false)) {
                    window.parent.parent.$('#centerTabs').tabs('select', title);
                    return;
                }
                var frameName = id + "Frame";
                var fm = $('<iframe/>', {
                    "scrolling": "yes",
                    "frameborder": "0",
                    "src": "#",
                    "width": "100%",
                    "height": "99%",
                    "allowfullscreen": "",
                    "mozallowfullscreen": "",
                    "webkitallowfullscreen": "",
                    "name": id + "Frame"
                });
                window.parent.parent.$('#centerTabs').tabs('add', {
                    title: title,
                    content: fm,
                    iconCls: icon,
                    closable: true,
                    tools: [{
                        iconCls: 'icon-mini-refresh',
                        handler: function () {
                            fm.attr('src', url);
                        },
                    },
                    ]
                });
                fm.attr('src', url);
                if (fullScreen != undefined && fullScreen==1) {
                    var el = $("iframe[name='" + frameName + "']")[0];
                    if (el != null) {
                        launchFullscreen(el);
                    }
                }
            }
        }

        function findvin() {
            var title = "查找车辆";
            //type用于标记回调的页面
            var url = "${base}/select/findvin?type=6";
            //openEditWin(url, title);
            openModuleEditWin(url, title, 'm_findvin_');

        }

        function vinCallBack(row){
            $('#vin').textbox().textbox("setValue", row['vin']);
            $('#serialNumber').textbox().textbox("setValue", row['serial_number']);
            $('#imei').textbox().textbox("setValue",row['imei']);
            $('#simCartNumber').textbox().textbox("setValue",row['sim_card']);
            $('#iccid').textbox().textbox("setValue", row['iccid']);
            $('#imsi').textbox().textbox("setValue", row['imsi']);
        }
        </script>
</head>
<body class="easyui-layout" fit="true">
<form id="post_form" method="post">
    <input name="id" type="hidden" value="${(authentication_id)!}"/>
    <div align="center">
        <table width="90%" class="mt10">
            <tr>
                <td class="tab_item sub_title"><span>SIM卡信息</span></td>
                <td></td>
            </tr>
            <tr>
                <td class="tab_item"><i><span>移动用户号（MSISDN）</span></td>
                <td> <input required name="simCartNumber" id="simCartNumber" validType="checksim[9,20]" style="width:180px;" type="text" /></td>
            </tr>
            <tr>
                <td class="tab_item"><i><span>ICCID编号</span></td>
                <td> <input required name="iccid" style="width:180px;" id="iccid" validType="checkiccid[20]" type="text" class="easyui-textbox input"/></td>
            </tr>
            <tr>
                <td class="tab_item"><span>国际移动台识别码（IMSI）</span></td>
                <td> <input style="width:180px;" id="imsi" name="imsi" validType="length[0,15]"  tyape="text" class="easyui-textbox input"/></td>
            </tr>
        </table>
        <table width="90%" class="mt10">
            <tr>
                <td class="tab_item sub_title"><span>车辆信息</span></td>
                <td></td>
            </tr>
            <tr>
                <td class="tab_item"><i><span>车架号（VIN）</span></td>
                <td> <input required name="vin" id="vin" style="width:180px;" validType="midlength[17]"   type="text" class="easyui-textbox input"/><a href="#" onclick="findvin()">&nbsp;&nbsp;查找</a></td>
            </tr>
            <tr>
                <td class="tab_item"><i><span>品牌编码</span></td>
                <td>Geely</td>
            </tr>
            <tr>
                <td class="tab_item"><span>车型名称</span></td>
                <td> <input name="lineNameEn" style="width:180px;" type="text" class="easyui-textbox input"/></td>
            </tr>
            <tr>
                <td class="tab_item"><span>业务区分</span></td>
                <td> <input name="channelId" style="width:180px;"  type="text" class="easyui-textbox input"/></td>
            </tr>
        </table>
        <table width="90%" class="mt10">
            <tr>
                <td class="tab_item sub_title"><span>T-BOX信息</span></td>
                <td></td>
            </tr>
            <tr>
                <td class="tab_item"><i><span>终端编号</span></td>
                <td> <input name="serialNumber" id="serialNumber" validType="length[1,50]" required style="width:180px;"  type="text" class="easyui-textbox input"/></td>
            </tr>
            <tr>
                <td class="tab_item"><i><span>IMEI号</span></td>
                <td> <input name="imei" id="imei" required style="width:180px;" validType="midlength[15]"  type="text" class="easyui-textbox input"/></td>
            </tr>
        </table>
        <div class="mt10">
            <#if (flag)?? && (flag)=="enterprise">
                <a href="#" onclick="save(1)"  class="easyui-linkbutton submit_button">提交</a>
            <#else >
                <a href="#" onclick="save()"  class="easyui-linkbutton submit_button">提交</a>
            </#if>

        </div>
        <div class="mt10">
            <div class="page_row">
                <span>说明：提交信息成功后，该车辆及SIM卡信息将进入实名认证阶段，认证通过将会短信通知该负责人</span>
            </div>
        </div>
    </div>
</form>
</body>
</html>
