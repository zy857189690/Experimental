<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>更换T-BOX</title>
    <style>
        .table_edit{
            border: none !important;
        }
        .td_input{
            border: none !important;
        }
        .td_label{
            border: none !important;
            text-align: right !important;
        }
        .alert{
            color: red;
        }
    </style>
</head>
<body class="body">
<div style="padding: 10px">
    <form id="ff" method="post" novalidate>
        <input type="hidden" id="vin" name="vin" value="${(vin)!}" />
        <input type="hidden" id="sign" name="sign" value="${(sign)!}" />
        <div align="center" style="margin-top: 1px">
            <table class="table_edit" border="0">
                <tr>
                    <td class="td_label" colspan="2" style="text-align: left !important;">
                        更换终端后，旧终端及SIM卡将处于停用状态，可再次激活。如继续更换，请填写新终端信息
                    </td>
                </tr>
                <tr>
                    <td class="td_label" style="text-align: center !important;"><h3 style="width:100%;background-color: rgba(242, 242, 242, 1);">新SIM卡:</h3></td>
                    <td class="td_input"></td>
                </tr>
                <tr>
                    <td class="td_label"><label>移动用户号码（MSISDN）:</label></td>
                    <td class="td_input">
                        <input type='text' name='simCartNumber' id='simCartNumber' class='easyui-textbox' value=""
                               data-options="required:true, validType:['simCartNumber']" style="width:178px;height: 24px;"/><span class="alert">*</span>
                    </td>
                </tr>
                <tr>
                    <td class="td_label"><label>ICCID编号:</label></td>
                    <td class="td_input">
                        <input type='text' name='iccid' id='iccid' value="" class='easyui-textbox'
                               data-options="required:true, validType:['iccid']" style="width:178px;height: 24px;"/><span class="alert">*</span>
                    </td>
                </tr>
                <tr>
                    <td class="td_label"><label>国际移动台识别码（IMSI）:</label></td>
                    <td class="td_input">
                        <input type='text' name='imsi' id='imsi' value="" class='easyui-textbox'
                               data-options="validType:['imsi']" style="width:178px;height: 24px;"/>
                    </td>
                </tr>
                <tr>
                    <td class="td_label" style="text-align: center !important;"><h3 style="width:100%;background-color: rgba(242, 242, 242, 1);">新T-BOX信息:</h3></td>
                    <td class="td_input"></td>
                </tr>
                <tr>
                    <td class="td_label"><label>设备编号:</label></td>
                    <td class="td_input">
                        <input type='text' name='termUnitSerivalNumber' id='termUnitSerivalNumber' value="" class='easyui-textbox'
                               data-options="required:true, validType:['length[1,50]']" style="width:178px;height: 24px;"/><span class="alert">*</span>
                    </td>
                </tr>
                <tr>
                    <td class="td_label"><label>IMEI号:</label></td>
                    <td class="td_input">
                        <input type='text' name='imei' id='imei' value="" class='easyui-textbox'
                               data-options="required:true, validType:['imei']" style="width:178px;height: 24px;"/><span class="alert">*</span>
                    </td>
                </tr>

                <tr>
                    <td colspan="4" style="text-align: center;line-height: 40px;line-height: 46px;">
                        <span style="margin-right: 20px">
                            <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" style="width:122px" href="javascript:void(0)"
                               id="submitButton" onclick="$('#ff').submit();">确认更换终端</a>
                         </span>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</div>
<#include "../../../inc/js.ftl">
<script>
    $(function(){
        $.extend($.fn.validatebox.defaults.rules, {
            //手机号码
            simCartNumber: {
                validator: function (value, param) {
                    return /^[0-9]{9,20}$/.test(value);
                },
                message: "MSISDN格式不正确"
            },
            iccid: {
                validator: function (value, param) {
                    return /^[0-9]{19,20}$/.test(value);
                },
                message: "ICCID格式不正确"
            },
            imsi: {
                validator: function (value, param) {
                    return /^[0-9]{0,15}$/.test(value);
                },
                message: "IMSI格式不正确"
            },
            termUnitSerivalNumber: {
                validator: function (value, param) {
                    return /^[0-9a-zA-Z]{0,50}$/.test(value);
                },
                message: "终端编号格式不正确"
            },
            imei: {
                validator: function (value, param) {
                    return /^[0-9a-zA-Z]{15}$/.test(value);
                },
                message: "IMEI格式不正确"
            }
        });

        $("#ff").validate({
            submitHandler:function(form){
                $("#submitButton").attr("disabled", 'disabled');
                $("#ff").form('submit',{
                    url:"${ucenter}/sysVehicle/changeTBox.html",
                    onSubmit: function(){
                        //校验
                        if($(this).form('validate')){
                            return true;
                        }else{
                            $("#submitButton").removeAttr("disabled");
                            return false;
                        }
                        return ;
                    },
                    success:function(data){
                        data = eval('(' + data + ')');
                        if(data.res){
                            startChangeTBoxInterface(data);
                            // cancel();
                            // window.top.m_sysVehicleFrame.window.$("#table").datagrid('reload');
                        }else{
                            $.messager.alert("提示",data.msg,"info",function(){
                                $("#submitButton").removeAttr("disabled");
                            });
                        }
                    }
                });
                return false;
            }
        });

        function startChangeTBoxInterface(jsonData){
            var vin = $("#vin").val();
            var sign = $('#sign').val();
            var orgIccid = jsonData.orgICCID;
            var newIccid = jsonData.newICCID;
            var imsi = $("#imsi").textbox("getValue");
            var msisdn = $("#simCartNumber").textbox("getValue");
            var imei = $("#imei").textbox("getValue");

            $.ajax({
                url:"${base}/changeTBox/changeTBox",
                type:"POST",
                data:{
                    vin:vin,
                    oldiccid:orgIccid,
                    newiccid:newIccid,
                    imsi:imsi,
                    msisdn:msisdn,
                    imei:imei
                },
                dataType: "json",
                success:function(data){
                    if(data.res){
                        debugger;
                        $.messager.alert("提示", "更换T-BOX成功","info",function(){
                            close_win();
                            if(sign == "enterprise"){
                                //刷新企业实名认证列表数据
                                window.top.m_PeopleAuthFrame.window.indextab2.window.$("#table").datagrid('reload');
                            }else {
                                //刷新个人实名认证列表数据
                                window.top.m_PeopleAuthFrame.window.indextab.window.$("#table").datagrid('reload');
                            }
                        });
                    }else{
                        $.messager.alert("提示", data.msg);
                    }
                }
            });
        }
    });
</script>
</body>
</html>