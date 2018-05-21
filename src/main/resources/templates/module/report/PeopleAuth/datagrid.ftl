
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<#include "../../../inc/meta.ftl">
<#include  "../../../inc/js.ftl">
    <style type="text/css">
        .td_input a:not(.bg_button) {
            right: 20px !important;
        }
    </style>
    <script language="javascript">

        $(function(){
            window.top.renovate = $("#table");
        })
        function add_item() {
            if (window.top.$('#centerTabs').tabs('exists', '个人实名认证')){
                $.messager.confirm('提示', '当前页签已打开，并存在编辑信息，关闭后信息将丢失，是否确认关闭？', function (r) {
                    if(r){
                        window.top.$('#centerTabs').tabs('close', '个人实名认证');
                        addTabFun('个人实名认证', '${base}/PeopleAuth/authInformation', 'PeopleAuth_add_iframe');
                    }else{
                        return;
                    }
                })
            }else {
                addTabFun('个人实名认证', '${base}/PeopleAuth/authInformation', 'PeopleAuth_add_iframe');
            }
        }
        //个人实名认证
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
        //个人车辆绑定
        function edit_item() {

            var length = $("#table").datagrid("getSelections").length;
            if(length > 1 || length == 0){
                $.messager.alert("提示",'请选择一条数据',"info");
                return;
            };
            var row = $("#table").datagrid("getSelected");
                if(row.authentication_result!=('2')){
                    if(window.parent.parent.$('#centerTabs').tabs('exists', "个人实名认证")){
                        $.messager.confirm('提示', '当前页签已打开，并存在编辑信息，关闭后信息将丢失，是否确认关闭？', function (r) {
                            if(r){
                                window.parent.parent.$('#centerTabs').tabs('close',"个人实名认证")
                                addTabFun('个人实名认证', '${base}/PeopleAuth/authInformation?certid='+row.owner_cert_id, 'PeopleAuth_add_iframe')
                            }else{
                                return;
                            }
                        })
                        return;
                    }
                    addTabFun('个人实名认证', '${base}/PeopleAuth/authInformation?certid='+row.owner_cert_id, 'PeopleAuth_add_iframe')
                }else{
                    var title = "个人车辆绑定";
                    var url = "${base}/PeopleAuth/personalVehicleBinding?id="+row.owner_cert_id;
                    openModuleEditWin(url, title,'personalVehicleBinding_frame', 600, 560);
                }
        }
        //弹出页面
        function openEditWin(url,title,width,height) {
            var winid = "user";
            if(width==undefined){
                width=530;
                height=550;
            }
            top.my_window(winid, url, title, width, height);

        }
        //编辑
        function edit(){
            var length = $('#table').datagrid('getSelections').length;
            if(length > 1 || length == 0){
                $.messager.alert("提示",'请选择一条数据',"info");
                return;
            }

            var rows = $('#table').datagrid('getSelected');
            if(rows.authentication_result == 1||rows.authentication_result == 2){
                $.messager.alert("提示",'只可编辑未申请以及未通过的数据',"info");
                return;
            }
            debugger;
            if (window.parent.parent.$('#centerTabs').tabs('exists', "个人实名认证编辑")){
                $.messager.confirm('提示', '当前页签已打开，并存在编辑信息，关闭后信息将丢失，是否确认关闭？', function (r) {
                    if(r){
                        window.parent.parent.$('#centerTabs').tabs('close',"个人实名认证编辑")
                        addTabFun("个人实名认证编辑","${base}/PeopleAuth/authInformation_edit?category="+rows.category+"&id="+rows.id+"&authentication_result="+rows.authentication_result,"PeopleAuth_edit_iframe");
                    }else{
                        return;
                    }
                })
            }else {
                addTabFun("个人实名认证编辑","${base}/PeopleAuth/authInformation_edit?category="+rows.category+"&id="+rows.id+"&authentication_result="+rows.authentication_result,"PeopleAuth_edit_iframe");
            }
        }
        //查看详情
        function toInfo(id){
            addTabFun("个人实名认证详情","${base}/PeopleAuth/people_all_info?id="+id,"m_PeopleAuth_iframe",true);
        }
        //刷新
        function refreshRealName(){
            $.ajax({
                type : 'get',
                url : '${base}/companyAuth/refresh',
                success : function(data) {
                    $("#table").datagrid("reload");
                }
            });
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
        //提交
         function submit(_param){
             var length = $('#table').datagrid('getSelections').length;
             if(length > 1 || length == 0){
                 $.messager.alert("提示",'请选择一条数据',"info");
                 return;
             }
             var rows = $('#table').datagrid('getSelected');
             if(rows.authentication_result == 1||rows.authentication_result == 2||rows.authentication_result==3){
                 $.messager.alert("提示",'只可提交未申请的数据',"info");
                 return;
             }
             $.ajax({
                 type : 'post',
                 url : '${base}/PeopleAuth/submitPeopleAuth?id='+rows.id+"&param="+_param,
                 success : function(data) {
                     if (data.code == 2){
                         if (_param == "Cover"){
                             return;
                         }
                         $.messager.confirm("操作提示", data.message, function (data) {
                             if (data){
                                 submit("Cover");
                             }
                         });
                     }else if(data.code == 3){
                         $.messager.alert("操作提示", data.message);
                     }else{
                         $.messager.alert("操作提示",data.message,'info',function(){
                             $("#table").datagrid("load",form2Object('form_search'));
                         });
                     }
                 }
             });
         }
        function submits(index,_param){
            var rows = $('#table').datagrid('getRows');
            var row = rows[index];
            console.log(row);
            if(row.authentication_result == 1||row.authentication_result == 2||row.authentication_result==3){
                $.messager.alert("提示",'只可提交未申请以及认证失败的数据',"info");
                return;
            }
            $.ajax({
                type : 'post',
                url : '${base}/PeopleAuth/submitPeopleAuth?id='+row.id+"&param="+_param,
                success : function(data) {
                    if (data.code == 2){
                        if (_param == "Cover"){
                            return;
                        }
                        $.messager.confirm("操作提示", data.message, function (data) {
                            if (data){
                                submits(index,"Cover");
                            }
                        });
                    }else if(data.code == 3){
                        $.messager.alert("操作提示", data.message);
                    }else{
                        $.messager.alert("操作提示",data.message,'info',function(){
                            $("#table").datagrid("load",form2Object('form_search'));
                        });
                    }
                }
            });
        }

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

                vin = row[0].vin;
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
                        var url = "${base}/changeTBox/add?vin=" + vin +"&sign=people" ;
                        my_window("changeTBox", url, title, 470, 430);
                    }else{
                        $.messager.alert("提示", "该条数据未通过实名认证，不能更换T-BOX");
                    }
                }
            });
        }
    </script>
</head>
<body class="easyui-layout" fit="true">
<div region="center" style="overflow: hidden;width: 100%;">
    <div id="toolbar" style="padding:5px">
        <a href="#" onclick="add_item()" class="easyui-linkbutton">个人实名认证</a>
        <a href="#" onclick="edit_item()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">个人车辆绑定</a>
        <a href="#" onclick="changeTBox()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">更换T-BOX</a>
        <a href="#" onclick="edit()" class="easyui-linkbutton">编辑</a>
        <a href="#" onclick="submit()" class="easyui-linkbutton">提交</a>
        <a href="#" onclick="refreshRealName()"  >刷新</a>
        <a href="#" onclick="exportDatagrid('${base}/PeopleAuth/export','form_search','table')">导出</a>
    </div>
    <div id="table" name="datagrid" style="width: 100%;height: 100%"></div>
</div>

<div data-options="region:'north',title:'查询',split:false,collapsable:false" style="width: 100%;height:90px;">
    <div style="width: 100%;border: 1;margin:5 5 5 10 ">
        <form id="form_search" name="form_search" class="sui-form form-inline cg-form">
            <table class="table_search">
                <tr>
                    <td class="td_label">
                        <label>移动用户号码</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.sim_card" id="sim_card" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>ICCID</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.iccid" id="iccid" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>认证结果</label>
                    </td>
                    <td class="td_input">
                        <select name="query.authentication_result" id="authentication_result" query_type="eqs" style="height: 30px;width:168px;">
                            <option value="">全部</option>
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
                        <input type="text" query_type="lis" name="query.vin" id="vin" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>终端编号</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.serial_number" id="serial_number" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>顾客姓名</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.owner_name" id="owner_name" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>证件号:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.owner_cert_id" id="owner_cert_id" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>手机号:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.mobile_phone" id="mobile_phone" class="input-fat input" style="width: height: 26px;width:150px;" required><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td style="vertical-align: center;text-align: right;border: 1px" class="cg-btnGroup">
                        <a href="#" onclick="searchDatagrid('form_search','table')" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
                        <a href="#" onclick="resetDatagrid('form_search','table')" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>
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
        url: '${base}/PeopleAuth/datagrid',
        sortName: "update_time",
        sortOrder: "desc",
        fitColumns:true,//宽度自适应
        rownumbers:"true",
        frozenColumns: [[
        ]],
        columns: [[
            {field: 'ck', checkbox: true, fitColumns: false},
            {title: '移动用户号码', field: 'sim_card',  sortable: "true",align:"center",halign:"center"},
            {title: 'ICCID', field: 'iccid', sortable: "true",align:"center",halign:"center"},
            {title: '认证结果', field: 'authentication_result',sortable: "true",align:"center",halign:"center",formatter: function (val, row) {
                if (val == 0) {
                    return '<span>未申请</span>';
                }
                if (val == 1) {
                    return '<span>认证中</span>';
                }
                if (val == 2) {
                    return '<span>已通过</span>';
                }
                if (val == 3) {
                    return '<span>未通过</span>';
                }
             }
             },
            {title: 'VIN', field: 'vin',  sortable: "true",align:"center",halign:"center"},
            {title: '终端编号', field: 'serial_number', sortable: "true",align:"center",halign:"center"},
            {title: '顾客姓名', field: 'owner_name', sortable: "true",align:"center",halign:"center"},
            {title: '证件号', field: 'owner_cert_id',  sortable: "true",align:"center",halign:"center"},
            {title: '手机号', field: 'mobile_phone', sortable: "true",align:"center",halign:"center"},
            {title: '备注', field: 'remarks',  sortable: "true",align:"center",halign:"center"},
            {title: '操作', field: 'licensePlate',  sortable: "true",align:"center",halign:"center", formatter: function (val, row, index) {
                if(row.authentication_result == 0){
                    return "<a href=\"#\" onclick=\"toInfo('" + row.id + "')\">查看详情</a>&nbsp;&nbsp;" +
                            "<a href=\"#\" onclick=\"submits('"+index+"')\">提交</a>";
                }else{
                    return "<a href=\"#\" onclick=\"toInfo('" + row.id + "')\">查看详情</a>&nbsp;&nbsp;"
                }
                }}
        ]],
        toolbar: "#toolbar",
        pagination: true,
        nowrap: true,
        onSortColumn: function (sort, order) {
            pagessort = sort;
            pagesorder = order;
        },
        onDblClickRow: function (rowIndex, row) {
            // queryCarMess(row.id);
        },
        onLoadSuccess:function(data){
            afterLoading();
            // buttonShow(index);

        }
    });
    toolbar2Menu("table");
</script>
</body>
</html>