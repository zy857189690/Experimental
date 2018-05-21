
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
    <script type="application/javascript">
        //添加tab
        function addTabFun(title, url, id,openNewTab, icon, fullScreen) {
            var tab=window.parent.parent.$('#centerTabs').tabs('getSelected');//获取当前选中tabs
            var index = window.parent.parent.$('#centerTabs').tabs('getTabIndex',tab);
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
                    "name": id + "Frame",
                    "openindex":index
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

        //查询
        function search_item(){
            $("#table").datagrid("load",form2Object('form_search'));
        }

        function add_item(){
            if (window.top.$('#centerTabs').tabs('exists', '客户企业实名认证')){
                $.messager.confirm('提示', '当前页签已打开，并存在编辑信息，关闭后信息将丢失，是否确认关闭？', function (r) {
                    if(r){
                        window.top.$('#centerTabs').tabs('close', '客户企业实名认证');
                        addTabFun("客户企业实名认证","${base}/companyAuth/company_new","companyAuth_frame");
                    }else{
                        return;
                    }
                })
            }else {
                addTabFun("客户企业实名认证","${base}/companyAuth/company_new","companyAuth_frame");
            }
        }

        function edit(){
            //不使用页面数据，已服务器数据为主
            var length = $('#table').datagrid('getSelections').length;
            if(length > 1 || length == 0){
                $.messager.alert("提示",'请选择一条数据',"info");
                return;
            }
            var rows = $('#table').datagrid('getSelected');
            if(rows.AUTHENTICATION_RESULT == 1 || rows.AUTHENTICATION_RESULT == 2){
                $.messager.alert("提示",'只可编辑未申请或未通过的数据',"info");
                return;
            }
            if (window.parent.parent.$('#centerTabs').tabs('exists', "客户企业实名认证编辑")){
                $.messager.confirm('提示', '当前页签已打开，并存在编辑信息，关闭后信息将丢失，是否确认关闭？', function (r) {
                    if(r){
                        window.parent.parent.$('#centerTabs').tabs('close',"客户企业实名认证编辑")
                        addTabFun("客户企业实名认证编辑","${base}/companyAuth/company_edit?id="+rows.id+"&AUTHENTICATION_RESULT="+rows.AUTHENTICATION_RESULT,"companyAuth_frame_edit");
                    }else{
                        return;
                    }
                })
            }else {
                addTabFun("客户企业实名认证编辑","${base}/companyAuth/company_edit?id="+rows.id+"&AUTHENTICATION_RESULT="+rows.AUTHENTICATION_RESULT,"companyAuth_frame_edit");
            }
        }

        function editById(id) {
            $.ajax({
                type : 'post',
                url : '${base}/companyAuth/company_auth_no_company?id='+id,
                success : function(data) {
                    alert(data.message);
                    if(data.code = 1){
                        $("#table").datagrid("load",form2Object('form_search'));
                    }
                }
            });
        }

        function toInfo(id){
            addTabFun("客户企业实名认证详情","${base}/companyAuth/company_all_info?id="+id,"companyAuth_frame_info",true);
        }

        //company_bind_car
        function bindCar(){
            //不使用页面数据，已服务器数据为主
            var length = $('#table').datagrid('getSelections').length;
            if(length > 1 || length == 0){
                $.messager.alert("提示",'请选择一条数据',"info");
                return;
            }
            var rows = $('#table').datagrid('getSelected');
            if(rows.AUTHENTICATION_RESULT == 0){
                if(window.parent.parent.$('#centerTabs').tabs('exists', "客户企业实名认证")){
                    $.messager.confirm('提示', '当前页签已打开，并存在编辑信息，关闭后信息将丢失，是否确认关闭？', function (r) {
                        if(r){
                            window.parent.parent.$('#centerTabs').tabs('close',"客户企业实名认证")
                            addTabFun("客户企业实名认证","${base}/companyAuth/company_new?flag=no_real_customer&id="+rows.id,"companyAuth_frame");
                        }else{
                            return;
                        }
                    })
                    return;
                }
                addTabFun("客户企业实名认证","${base}/companyAuth/company_new?flag=no_real_customer&id="+rows.id,"companyAuth_frame");
                return;
            }
            if(rows.AUTHENTICATION_RESULT != 2){
                //认证未成功
                if(window.parent.parent.$('#centerTabs').tabs('exists', "客户企业实名认证")){
                    $.messager.confirm('提示', '当前页签已打开，并存在编辑信息，关闭后信息将丢失，是否确认关闭？', function (r) {
                        if(r){
                            window.parent.parent.$('#centerTabs').tabs('close',"客户企业实名认证")
                            addTabFun("客户企业实名认证","${base}/companyAuth/add_company_new?flag=customer&id="+rows.AUTHENTICATION_ID,"companyAuth_frame");
                        }else{
                            return;
                        }
                    })
                    return;
                }
                addTabFun("客户企业实名认证","${base}/companyAuth/add_company_new?flag=customer&id="+rows.AUTHENTICATION_ID,"companyAuth_frame");
            }
            openModuleEditWin('${base}/companyAuth/company_to_bind_car?authenticationId='+rows.AUTHENTICATION_ID,'车辆绑定','companyAuth_bind_frame', 600, 530)
        }

        //批量实名认证
        function mostAuth(){
            module_window('real_auth_all','${base}/companyAuth/company_all','企业批量实名认证', 650, 600)
        }

        function refreshRealName(){
            $.ajax({
                type : 'get',
                url : '${base}/companyAuth/refresh',
                success : function(data) {
                    $("#table").datagrid("load",form2Object('form_search'));
                }
            });
        }

        function downloadTemp(){
            window.open("${base}/base/download_temp/import",'_blank');
        }

        $(function(){
            window.top.reload = $("#table");
        })

        function changeTBox(){
            var vin;
            var row = $("#table").datagrid("getSelections");
            if (row != null) {
                if (row.length == 0){
                    alert("请选择车辆！");
                    return;
                }
                if (row.length > 1) {
                    alert("请选定一辆车！");
                    return;
                }

                vin = row[0].VIN;
            } else {
                alert("请选定车辆！");
                return;
            }

            $.ajax({
                url:'${ucenter}/sysVehicle/isCanChange.html',
                type:'POST',
                data:{vin:vin},
                dataType:'json',
                async: false,
                success:function(res){
                    if(res.res){
                        var title = "更换T-BOX";
                        var url = "${base}/changeTBox/add?vin=" + vin +"&sign=enterprise" ;
                        my_window("changeTBox", url, title, 470, 430);
                    }else{
                        $.messager.alert("提示", "该条数据未通过实名认证，不能更换T-BOX");
                    }
                }
            });

        }

        //company_auth_no_company
        function companyAuthNoCompany(cover){
            var length = $('#table').datagrid('getSelections').length;
            if(length > 1 || length == 0){
                $.messager.alert("提示",'请选择一条数据',"info");
                return;
            }
            var rows = $('#table').datagrid('getSelected');
            if(rows.AUTHENTICATION_RESULT != 0){
                $.messager.alert("提示",'只可选择未提交的数据',"info");
                return;
            }
            var object =new Object();
            object['id']=rows.id;
            if(cover != undefined){
                object['cover'] = cover;
            }
            $.ajax({
                type : 'post',
                url : '${base}/companyAuth/company_auth_no_company',
                data:object,
                success : function(data) {
                    if(data.code == 2){
                        $.messager.confirm("提示",data.message,function(flag){
                            if(flag){
                                companyAuthNoCompany('cover');
                            }
                        })
                        return;
                    }else if(data.code == 1){
                        $("#table").datagrid("load",form2Object('form_search'));
                    }
                    alert(data.message);
                }
            });
        }

        function companyAuthNoCompanyById(id,cover){
            var object =new Object();
            object['id']=id;
            if(cover == 'cover'){
                object['cover'] = cover;
            }
            $.ajax({
                type : 'post',
                url : '${base}/companyAuth/company_auth_no_company',
                data:object,
                success : function(data) {
                    if(data.code == 2){
                        $.messager.confirm("提示",data.message,function(flag){
                            if(flag){
                                companyAuthNoCompany(id,'cover');
                            }
                        })
                        return;
                    }else if(data.code == 1){
                        $("#table").datagrid("load",form2Object('form_search'));
                    }
                    alert(data.message);
                }
            });
        }

    </script>
</head>
<body class="easyui-layout" fit="true">
<div region="center" style="overflow: hidden;width: 100%;">
    <div id="toolbar" style="padding:5px">
        <a href="#" onclick="add_item()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">客户企业实名认证</a>
        <a href="#" id="auth_all" onclick="mostAuth()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">客户企业批量实名认证</a>
        <a href="#" id="auth_one" onclick="bindCar()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">客户企业车辆绑定</a>
        <a href="#" onclick="changeTBox()" class="easyui-linkbutton">更换T-BOX</a>
        <a id="a5" href="#" onclick="edit()" class="easyui-linkbutton">编辑</a>
        <a href="#" onclick="companyAuthNoCompany()" class="easyui-linkbutton">提交</a>
        <a href="#" onclick="refreshRealName()">刷新</a>
        <a href="#" onclick="downloadTemp()">批量实名认证导入模板下载</a>
        <a href="#" onclick="exportDatagrid('${base}/companyAuth/export','form_search','table')">导出</a>
    </div>
    <div id="table" name="datagrid" style="width: 100%;height: 100%"></div>
</div>

<div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 90px">
    <div style="width: 100%;border: 1;margin:5 5 5 10 ">
        <form id="form_search" name="form_search" class="sui-form form-inline cg-form">
            <table class="table_search">
                <tr>
                    <td class="td_label">
                        <label>移动用户号码</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="eqs" name="query.SIM_CART_NUMBER" id="SIM_CART_NUMBER" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>ICCID</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="eqs" name="query.ICCID" id="ICCID" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>认证结果</label>
                    </td>
                    <td class="td_input">
                        <select name="query.AUTHENTICATION_RESULT" id="AUTHENTICATION_RESULT" query_type="eqs" style="height: 30px;width:168px;">
                            <option value="-1">全部</option>
                            <option value="0">未申请</option>
                            <option value="1">认证中</option>
                            <option value="2">已通过</option>
                            <option value="3">未通过</option>
                        </select>
                    </td>
                    <td class="td_label">
                        <label>VIN</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.VIN" id="VIN" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>终端编号</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.SERIAL_NUMBER" id="SERIAL_NUMBER" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>企业负责人</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.CONTACT" id="CONTACT" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>证件号:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.OWNER_CERT_ID" id="OWNER_CERT_ID" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>手机号:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.CONTACT_INFO" id="CONTACT_INFO" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>企业名称:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.NAME" id="NAME" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td style="vertical-align: center;text-align: right;border: 1px" class="cg-btnGroup">
                        <a href="#" onclick="search_item()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>                    <a href="#" onclick="reset_common(search_item)" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>

<script type="text/javascript">
    var pagessort = "uuid";
    var pagesorder = "desc";
    $('#table').datagrid({
        url: '${base}/companyAuth/datagrid',
        fitColumns:true,//宽度自适应
        columns: [[
            {field: 'ck', checkbox: true, fitColumns: false},
            {title: '移动用户号码', field: 'SIM_CART_NUMBER', align:"center",halign:"center"},
            {title: 'ICCID', field: 'ICCID',align:"center",halign:"center"},
            {title: '认证结果', field: 'AUTHENTICATION_RESULT',sortable: "true",align:"center",halign:"center", formatter: function (val, row) {
                if(val == 0){
                    return '<span>未申请</span>';
                }
                if(val == 1){
                    return '<span>认证中</span>';
                }
                if(val == 2){
                    return '<span>已通过</span>';
                }
                if(val == 3){
                    return '<span>未通过</span>';
                }
            }
            },
            {title: 'VIN', field: 'VIN', align:"center",halign:"center"},
            {title: '终端编号', field: 'SERIAL_NUMBER',align:"center",halign:"center"},
            {title: '企业名称', field: 'NAME', align: "center", halign: "center"},
            {title: '统一社会信用代码', field: 'CREDIT_CODE', align: "center", halign: "center"},
            {title: '企业负责人姓名', field: 'CONTACT', align: "center", halign: "center"},
            {title: '证件号', field: 'OWNER_CERT_ID', align: "center", halign: "center"},
            {title: '手机号', field: 'CONTACT_INFO', align: "center", halign: "center"},
            {title: '备注', field: 'REMARKS', align: "center", halign: "center"},
            {title: '操作', field: 'cusReplace', align: "center", halign: "center", formatter: function (val, row) {
                    if(row.AUTHENTICATION_RESULT == 0){
                        return "<a href=\"#\" onclick=\"toInfo('" + row.id + "')\">查看详情</a>&nbsp;&nbsp;" +
                                "<a href=\"#\" onclick=\"companyAuthNoCompanyById('" + row.id + "')\">提交</a>";
                    }else{
                        return "<a href=\"#\" onclick=\"toInfo('" + row.id + "')\">查看详情</a>&nbsp;&nbsp;"
                    }

                }}
        ]],
        toolbar: "#toolbar",
        pagination: true,
        nowrap: true,
        rownumbers: true,
        onSortColumn: function (sort, order) {
            pagessort = sort;
            pagesorder = order;
        },
        onDblClickRow: function (rowIndex, row) {
            //queryCarMess(row.id);
        },
        onLoadSuccess: function (data) {
            afterLoading();
        }
    });

    /**
     * 导出
     * @param url
     * @param formId
     * @param gridId
     */
    function exportDatagrid(url,formId,gridId){

        if(formId==undefined || formId==null){
            formId = "form_search";
        }
        var myUrl = url;
        var searchParames = $('#'+formId).serializeObject();


        var rows = $("#"+gridId).datagrid("getSelections");
        if (rows != null && rows.length != 0) {
            var ids = "";
            for(var i=0;i<rows.length;i++){
                ids += rows[i].id;
                if(i!=(rows.length-1))
                    ids += ","
            }

        }
        searchParames['query.ids'] = ids;

        myUrl += '?exportId='+new Date().getTime();
        for(var key in searchParames){
            var value = searchParames[key];
            if(value!=""){
                myUrl += ("&"+key+"="+value);
            }
        }


        window.open(myUrl,'_blank');
    }

</script>
</body>
</html>