<!DOCTYPE html>
<html>
<head>
<#include "../../../inc/meta.ftl">
<#include  "../../../inc/js.ftl">

    <script type="text/javascript">
        //查找车辆
        function findvin() {
            var title = "查找车辆";
            var url = "${base}/select/findvin?type=5";
            openModuleEditWin(url, title,"m_findvin_", 600, 560);
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
        //保存
        function save(_param){
            if($("#post_form").form('validate')){
                var mainData = form2Object("post_form");
                $.ajax({
                    type : 'post',
                    url : '${base}/PeopleAuth/savePersonalBinding?param='+_param,
                    data : mainData,
                    success : function(data) {
                        if (data.code == 2){
                            if (_param == "Cover"){
                                return;
                            }
                            $.messager.confirm("操作提示", data.message, function (data) {
                                if (data) {
                                    save("Cover");
                                }
                            });
                        }else if(data.code == 0){
                            $.messager.alert("操作提示",data.message,'info',function(){
                                // close_win();
                                // window.top.m_PeopleAuthFrame.window.$("#table").datagrid('reload');
                                close_win();
                                var title = "SIM卡实名认证";
                                var url = '${base}/PeopleAuth/list?flag=0';
                                var iframe_name = 'm_PeopleAuth';
                                if(!window.parent.$('#centerTabs').tabs('exists',title)){
                                    addNewTab(title, url, iframe_name);
                                    var frm = document.getElementById('m_PeopleAuthFrame');
                                    $(frm).load(function(){                             //  等iframe加载完毕
                                        window.top.m_PeopleAuthFrame.$("#tableTabsOn").tabs('select',"个人实名认证");
                                    });
                                }else{
                                    addNewTab(title, url, iframe_name);
                                    window.top.m_PeopleAuthFrame.$("#tableTabsOn").tabs('select',"个人实名认证");
                                    window.top.m_PeopleAuthFrame.indextab.$("#table").datagrid('reload');
                                }
                                return;
                            });
                        }else{
                            alert(data.message);
                        }

                    }
                });
            }
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
            return obj;
        }

        function dialogCallBack(row){

            $('#vin').textbox().textbox("setValue",row['vin']);
            $('#serialNumber').textbox().textbox("setValue",row['serial_number']);
            $('#imei').textbox().textbox("setValue",row['imei']);
            $('#simCartNumber').textbox().textbox("setValue",row['sim_card']);
            $('#iccid').textbox().textbox("setValue",row['iccid']);
            $('#imsi').textbox().textbox("setValue",row['imsi']);

        }

        function vinCallBack(row){
            $('#vin').textbox().textbox("setValue", row['vin']);
            $('#serialNumber').textbox().textbox("setValue", row['serial_number']);
            $('#imei').textbox().textbox("setValue",row['imei']);
            $('#simCartNumber').textbox().textbox("setValue",row['sim_card']);
            $('#iccid').textbox().textbox("setValue", row['iccid']);
            $('#imsi').textbox().textbox("setValue", row['imsi']);
        }

        initValid();
    </script>
    <link href="${base}/style/edit.css" type="text/css">
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
            margin: 188px;
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
        .clearInput{
            margin-left: 156px;
            margin-top:-23px;
            display: block;
            position:relative;
            width: 8px;
        }
    </style>
</head>
<body>
<div class="easyui-layout" fit="true">
    <form id="post_form" method="post">
        <div align="center">
            <table width="90%" class="mt10">
                <tr>
                    <td class="tab_item sub_title"><span>车辆信息</span></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="tab_item"><i><span>车架号（VIN）</span></td>
                    <td>
                        <input style="width:180px;" id="vin" name="vin" validType="midlength[17]" type="text" class="easyui-textbox input"/><a onclick="findvin()" style="margin-left: 5px;cursor: pointer">查找</a>
                        <a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a>
                    </td>
                </tr>
                <tr>
                    <td class="tab_item"><span>车型名称</span></td>
                    <td>
                        <input style="width:180px;" value="${(enterpriseAuth.channelId)!}" id="channelId" name="channelId"  type="text" class="easyui-textbox input"/><a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a>
                    </td>
                </tr>
                <tr>
                    <td class="tab_item"><span>业务区分</span></td>
                    <td> <input style="width:180px;" value="${(enterpriseAuth.lineNameEn)!}" id="lineNameEn" name="lineNameEn" type="text" class="easyui-textbox input"/><a href="javascript:void(0);"  class=" clearInput" onclick="clearInputVal(this)">X</a></td>
                </tr>
            </table>
            <table width="90%" class="mt10">
                <tr>
                    <td class="tab_item sub_title"><span>T-BOX信息</span></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="tab_item"><i><span>终端编号</span></td>
                    <td> <input style="width:180px;" validType="length[1,50]" id="serialNumber" name="serialNumber" type="text" class="easyui-textbox input" required/><a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a></td>
                </tr>
                <tr>
                    <td class="tab_item"><i><span>IMEI号</span></td>
                    <td> <input style="width:180px;" validType="midlength[15]" id="imei" name="imei" type="text" class="easyui-textbox input" required/><a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a></td>
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
                        <input style="width:180px;" type="text" validType="checksim[9,20]" id="simCartNumber" name="simCartNumber" class="easyui-textbox input" required/><a href="javascript:void(0);"  class="clearInput" onclick="top.clearInputValue(this)">X</a>
                    </td>
                </tr>
                <tr>
                    <td class="tab_item"><i><span>ICCID</span></td>
                    <td> <input style="width:180px;" id="iccid" validType="checkiccid[20]" name="iccid" type="text" class="easyui-textbox input" required/><a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a></td>
                </tr>
                <tr>
                    <td class="tab_item"><span>国际移动台识别码（IMSI）</span></td>
                    <td> <input style="width:180px;"  id="imsi" name="imsi" validType="length[1,15]" type="text" class="easyui-textbox input"/><a href="javascript:void(0);" class=" clearInput" onclick="clearInputVal(this)">X</a></td>
                </tr>
                <tr>
                    <#--<td class="tab_item"><i><span>姓名</span></td>-->
                    <td> <input style="display: none" id="ownerName" name="ownerName" value="${(mode.ownerName)!}" /></td>
                </tr>
                <tr>
                    <#--<td class="tab_item"><i><span>性别</span></td>-->
                    <td><input style="display: none" id="sex" name="sex" value="${(mode.sex)!}" /></td>
                </tr>
                <tr>
                    <#--<td class="tab_item"><i><span>证件类型</span></td>-->
                    <td><input style="display: none" id="ownerCertType" name="ownerCertType" value="${(mode.ownerCertType)!}" /></td>
                </tr>
                <tr>
                   <#--<td class="tab_item"><i><span>证件号码</span></td>-->
                    <td><input style="display: none"  id="ownerCertId" name="ownerCertId" value="${(mode.ownerCertId)!}" /></td>
                </tr>
                <tr>
                    <#--<td class="tab_item"><span>所有人证件地址</span></td>-->
                    <td><input style="display: none"  id="ownerCertAddr" name="ownerCertAddr" value="${(mode.ownerCertAddr)!}"/></td>
                </tr>
                <tr>
                   <#--<td class="tab_item"><i><span>证件照片</span></td>-->
                    <td><input style="display: none"   id="PIC1" name="PIC1" type="file" value="${(mode.PIC1)!}"/>
                        <input style="display: none"  id="PIC2" name="PIC2" type="file" value="${(mode.PIC2)!}"/></td>
                </tr>
                <tr>
                    <#--<td class="tab_item"><i><span>手持证件照</span></td>-->
                    <td><input style="display: none" id="facePic" name="facePic" type="file" value="${(mode.facePic)!}"/></td>
                </tr>
                <tr>
                    <#--<td class="tab_item"><i><span>联系电话</span></td>-->
                    <td><input style="display: none" mobile_phoneid="mobilePhone" name="mobilePhone" value="${(mode.mobilePhone)!}"/></td>
                </tr>
                <tr>
                    <#--<td class="tab_item"><span>联系地址</span></td>-->
                    <td><input style="display: none"  type="text"/></td>
                </tr>
                <tr>
                    <#--<td class="tab_item"><span>邮箱</span></td>-->
                    <td><input style="display: none"  id="email" name="email" value="${(mode.email)!}"/></td>
                </tr>
            </table>
            <div class="mt10">
                <a href="#" onclick="save()"  class="easyui-linkbutton submit_button">提交</a>
            </div>
        </div>
    </form>
</div>
</body>
</html>
