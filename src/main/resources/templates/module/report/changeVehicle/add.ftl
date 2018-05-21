<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>更换车辆</title>
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
        <input type="hidden" id="termUnitId" name="termUnitId" value="${sysTermModelUnitEntity.id!}"/>
        <input type="hidden" id="state" name="termUnitId" value="${state!}"/>
        <div align="center" style="margin-top: 1px">
            <table class="table_edit" border="0">
                <tr>
                    <td class="td_label" colspan="2" style="text-align: left !important;">
                        更换终端后，旧终端及SIM卡将处于停用状态，可再次激活。确认更换请填写新终端信息
                    </td>
                </tr>

                <#if state == 1 || state == 2><tbody style="display:none"></#if>
                    <tr>
                        <td class="td_label" style="text-align: center !important;"><h3 style="width:100%;background-color: rgba(242, 242, 242, 1);">新T-BOX信息:</h3></td>
                        <td class="td_input"></td>
                    </tr>
                    <tr>
                        <td class="td_label"><label>设备编号:</label></td>
                        <td class="td_input">
                            <input type='text' name='termUnitSerivalNumber' id='termUnitSerivalNumber'
                                   data-options="required:true" value="${sysTermModelUnitEntity.serialNumber!}" class='easyui-textbox'
                                   <#if sysTermModelUnitEntity.serialNumber?? && sysTermModelUnitEntity.serialNumber != ''>readonly</#if> style="width:178px;height: 24px;"/><span class="alert">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_label"><label>IMEI号:</label></td>
                        <td class="td_input">
                            <input type='text' name='imei' id='imei' data-options="required:true"
                                   value="${sysTermModelUnitEntity.imei!}" class='easyui-textbox' style="width:178px;height: 24px;"
                            <#if sysTermModelUnitEntity.imei?? && sysTermModelUnitEntity.imei != ''>readonly</#if> /><span class="alert">*</span>
                        </td>
                    </tr>
                <#if state == 1 || state == 2></tbody></#if>

                <tr>
                    <td class="td_label" style="text-align: center !important;"><h3 style="width:100%;background-color: rgba(242, 242, 242, 1);">新车辆信息:</h3></td>
                    <td class="td_input"></td>
                </tr>
                <tr>
                    <td class="td_label"><label>车架号（VIN）:</label></td>
                    <td class="td_input">
                        <input type='text' name='vin' data-options="required:true" id='vin' value="" class='easyui-textbox' style="width:178px;height: 24px;"/><span class="alert">*</span>
                    </td>
                </tr>
                <tr>
                    <td class="td_label"><label>车辆公告型号:</label></td>
                    <td class="td_input">
                        <input type='text' name='modelNoticeId' id='modelNoticeId' data-options="required:false" value="" class='easyui-textbox' style="width:178px;height: 24px;"/>
                    </td>
                </tr>
                <tr>
                    <td class="td_label"><label>业务区分:</label></td>
                    <td class="td_input">
                        <input type='text' name='imsi' id='imsi' value="" class='easyui-textbox' style="width:178px;height: 24px;"/>
                    </td>
                </tr>

                <#if state == 1 || state == 3><tbody style="display:none"></#if>
                    <tr>
                        <td class="td_label" style="text-align: center !important;"><h3 style="width:100%;background-color: rgba(242, 242, 242, 1);">新SIM卡:</h3></td>
                        <td class="td_input"></td>
                    </tr>
                    <tr>
                        <td class="td_label"><label>移动用户号码（MSISDN）:</label></td>
                        <td class="td_input">
                            <input type='text' name='simCardNumber' id='simCardNumber' data-options="required:true,validType:['simCartNumber']"
                                   value="${(simManagement.sim_cart_number)!}" class='easyui-textbox' style="width:178px;height: 24px;"
                            <#if simManagement.sim_cart_number?? && simManagement.sim_cart_number != ''>readonly</#if> /><span class="alert">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_label"><label>ICCID编号:</label></td>
                        <td class="td_input">
                            <input type='text' name='iccid' id='iccid' data-options="required:true" value="${simManagement.iccid!}"
                                   class='easyui-textbox' style="width:178px;height: 24px;"
                             <#if simManagement.iccid?? && simManagement.iccid != ''>readonly</#if> /><span class="alert">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_label"><label>国际移动台识别码（IMSI）:</label></td>
                        <td class="td_input">
                            <input type='text' name='imsi' id='imsi' data-options="required:false" value="${simManagement.imsi!}" class='easyui-textbox' style="width:178px;height: 24px;"/>
                        </td>
                    </tr>
                <#if state == 1 || state == 3></tbody></#if>

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
                    return /^[0-9]{11}$/.test(value);
                },
                message: "MSISDN格式不正确"
            }
        });

        $("#ff").validate({
            submitHandler:function(form){
                $("#submitButton").attr("disabled", 'disabled');
                $("#ff").form('submit',{
                    url:"${ucenter}/sysTermModel/unit/changeVehicle.html",
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
                        console.log(data);
                        if(data.res){
                            startChangeVehicleInterface(data);
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

        function startChangeVehicleInterface(jsonData){
            var vin = $("#vin").val();
            var orgIccid = jsonData.orgICCID;
            var newIccid = jsonData.newICCID;
            var imsi = $("#imsi").textbox("getValue");
            var msisdn = $("#simCartNumber").textbox("getValue");
            var imei = $("#imei").textbox("getValue");

            $.ajax({
                url:"${base}/report/changeTBox/changeTBox",
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
                        $.messager.alert("提示", "更换T-BOX成功", function(){
                            cancel();
                            window.top.m_sysVehicleFrame.window.$("#table").datagrid('reload');
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