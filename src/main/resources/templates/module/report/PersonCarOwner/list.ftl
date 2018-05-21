
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
</head>
<body class="easyui-layout" fit="true">
<div region="center" style="overflow: hidden;width: 100%;">
    <div id="toolbar" style="padding:5px">
        <a href="#" onclick="add_item()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">新增</a>
        <a href="#" onclick="edit_item()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑</a>
        <a href="#" onclick="del_item()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>
        <a href="#" onclick="certification()" class="easyui-linkbutton">个人实名认证</a>
        <a id="a5" href="#" onclick="personBindVeh()" class="easyui-linkbutton">个人车辆绑定</a>
    </div>
    <div id="table" name="datagrid" style="width: 100%;height: 100%"></div>
</div>

<div data-options="region:'north',title:'查询',split:false,collapsable:false" style="width: 100%;height:90px;">
    <div style="width: 100%;border: 1;margin:5 5 5 10 ">
        <form id="form_search" name="form_search" class="sui-form form-inline cg-form select2">
            <table class="table_search">
                <tr>
                    <td class="td_label">
                        <label>姓名</label>
                    </td>
                    <td class="td_input">
                        <input type="text" query_type="lis" name="query.ownerName" id="ownerName" class="input-fat input" style="width: height: 26px;width:150px;" ><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>联系电话</label>
                    </td>
                    <td class="td_input">
                        <input type="text"  query_type="lis" name="query.mobilePhone" id="mobilePhone" class="input-fat input" style="width: height: 26px;width:150px;" ><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>证件号码</label>
                    </td>
                    <td class="td_input">
                        <input type="text"  query_type="lis" name="query.ownerCertId" id="ownerCertId" class="input-fat input" style="width: height: 26px;width:150px;" ><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
                    </td>
                    <td class="td_label">
                        <label>联系地址</label>
                    </td>
                    <td class="td_input">
                        <input type="text"  query_type="lis" name="query.address" id="address" class="input-fat input" style="width: height: 26px;width:150px;" ><a href="javascript:void(0);" class="clear" onclick="top.clearInputValue(this)">X</a>
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

    function search_item() {
        searchDatagrid('form_search','table');
    }

    function add_item() {
        var title = "新增个人车主";
        var url = "${base}/personCarOwner/add";
        openEditWin(url, title);
    }

    function resetParam() {
        reset_common(search_item);
        //$("#table").datagrid("reload");
    }
    function openEditWin(url,title,width,height) {
        var winid = "user";
        if(typeof (width)=='undefined'){
            width=600;
            height=600;
        }
        top.my_window(winid, url, title, width, height);

    }

    function del_item(id){
        var action = "${base}/personCarOwner/del";
        var rows = $("#table").datagrid("getSelections");
        if(rows!=null && rows.length !=0){
            var ids = "";
            for(var i=0;i<rows.length;i++){
                ids += rows[i].id;
                if(i!=(rows.length-1))
                    ids += ","
            }
            $.messager.confirm('删除提示', '您确定要删除所选'+"个人车主"+"?", function(r){
                if(r){
                    $.ajax({
                        url:action,
                        type:"post",
                        data:{ids:ids},
                        success:function(data){
                            if(data.code == 0){
                                $.messager.alert("提示",data.message,'info',function(){
                                    $("#table").datagrid("reload");
                                });
                            }else{
                                alert(data.message);
                            }
                        }
                    });
                }
            });

        }
        else{
            alert("请选定个人车主记录！");
            return;
        }
    }

    function certification(id) {
        var rows = $("#table").datagrid("getSelections");
        if (rows != null) {
            if (rows.length == 0 || rows.length > 1) {
                alert("请选定一条个人车主信息！");
                return;
            }
            id = rows[0].id;
        } else {
            alert("请选定个人车主信息！");
            return;
        }
        $.ajax({
            url: "${base}/personCarOwner/checkAuthInfo",
            type: 'POST',
            data: {id: id},
            success: function (data) {
                //1表示没有实名认证
                if(data.code == 0){
                    $.messager.confirm('提示', '该个人车主已通过实名认证，是否继续绑定车辆？', function(r){
                        if(r) {
                            var title = "个人车辆绑定";
                            var url = "${base}/PeopleAuth/personalVehicleBinding?id=" + (id);
                            openModuleEditWin(url, title,'personalVehicleBinding_frame', 650, 500);
                        }
                    });
                }else{
                    if (window.parent.$('#centerTabs').tabs('exists', '个人实名认证')){
                        $.messager.confirm('提示', '当前页签已打开，并存在编辑信息，关闭后信息将丢失，是否确认关闭？', function (r) {
                            if(r){
                                window.parent.$('#centerTabs').tabs('close', '个人实名认证');
                                var params = "?id=" + id + "&flag=personcarowner";
                                var url = '${base}/PeopleAuth/add_people_new' + params;
                                addTabFun('个人实名认证', url, 'PeopleAuth_add_iframe');
                            }else{
                                return;
                            }
                        })
                    }else {
                        var params = "?id=" + id + "&flag=personcarowner";
                        var url = '${base}/PeopleAuth/add_people_new' + params;
                        addTabFun('个人实名认证', url, 'PeopleAuth_add_iframe');
                    }

                }
            },
            error: function (responseStr) {
                console.log("error");
            }
        });
    }
    function personBindVeh(id) {
        var rows = $("#table").datagrid("getSelections");
        if (rows != null  ) {
            if (rows.length==0 || rows.length > 1) {
                alert("请选定一条个人车主信息！");
                return;
            }
            id = rows[0].id;
            ownerCertId=rows[0].ownerCertId
        } else {
            alert("请选定个人车主信息！");
            return;
        }
        $.ajax({
                url : "${base}/personCarOwner/checkAuthInfo",
                type : 'POST',
                data : {id:id},
                success : function(data) {
                    //1表示没有实名认证
                    if(data.code == 0){
                        var title = "个人车辆绑定";
                        var url = "${base}/PeopleAuth/personalVehicleBinding?id=" + (ownerCertId);
                        openModuleEditWin(url, title,'personalVehicleBinding_frame', 600, 530);
                    }else if (data.code == 1){
                        $.messager.confirm('提示', '该个人车主未通过实名认证，是否继续实名认证？', function(r){
                            if(r) {
                                <#--var params = "?id=" + id + "&flag=personcarowner";-->
                                <#--var url = '${base}/PeopleAuth/authInformation' + params;-->
                                <#--addTabFun('个人实名认证', url, 'm_PeopleAu_authInformation_iframe');-->

                                var params = "?id=" + id + "&flag=personcarowner";
                                var url = '${base}/PeopleAuth/add_people_new' + params;
                                addTabFun('个人实名认证', url, 'PeopleAuth_add_iframe');
                            }
                        });
                    }
                },
                error : function(responseStr) {
                    console.log("error");
                }
            });

    }

    function edit_item(id) {
        if ('' == id || id == undefined) {
            var row = $("#table").datagrid("getSelections");
            console.log(row);
            if (row != null  ) {
                if (row.length==0 || row.length > 1) {
                    alert("请选定一条个人车主信息！");
                    return;
                }
                id = row[0].id;
            } else {
                alert("请选定个人车主信息！");
                return;
            }
        }
        //判断是否可编辑
        $.ajax({
            url: "${base}/personCarOwner/checkAuthInfo",
            type: 'POST',
            data: {id: id},
            success: function (data) {
                //1表示没有实名认证
                if(data.code == 0){
                    alert("该个人车主已通过实名认证，不可编辑");
                }else {
                    var title = "编辑个人车主信息";
                    var url = "${base}/personCarOwner/edit?id=" + (id);
                    openEditWin(url, title);
                }
            },
            error: function (responseStr) {
                console.log("error");
            }
        });
    }
</script>
<script type="text/javascript">

    function showFaultDetail(id) {
        if ('' == id || id == undefined) {
            alert("数据错误");
            return
        }
        var title = "个人车主详情";
        var url = "${base}/personCarOwner/detail?id=" + (id);
        openEditWin(url, title);
    }

    var pagessort = "uuid";
    var pagesorder = "desc";
    $('#table').datagrid({
        url: '${base}/personCarOwner/datagrid',
        rownumbers:"true",
        frozenColumns: [[
        ]],
        columns: [[
            {field: 'ck', checkbox: true, fitColumns: false},
            {title: '姓名', field: 'ownerName',  sortable: "true",align:"center",halign:"center"},
            {title: '性别', field: 'sex', sortable: "true",align:"center",halign:"center", formatter: function (val, row) {
                    if (val == "M"){
                        return "男";
                    }else if (val == "F"){
                        return "女";
                    }else{
                        return "";
                    }

                }},
            {title: '联系电话', field: 'mobilePhone',sortable: "true",align:"center",halign:"center"},
            {title: '邮箱', field: 'email',  sortable: "true",align:"center",halign:"center"},
            {title: '证件类型', field: 'ownerCertType', sortable: "true",align:"center",halign:"center", formatter: function (val, row) {
                    if (val == "HKIDCARD"){
                        return "港澳居民来往内地通行证";
                    }else if (val == "IDCARD"){
                        return "居民身份证";
                    }else if (val == "OTHERLICENCE"){
                        return "其他";
                    }else if (val == "PASSPORT"){
                        return "护照";
                    }else if (val == "PLA"){
                        return "军官证";
                    }else if (val == "POLICEPAPER"){
                        return "警官证";
                    }else if (val == "TAIBAOZHENG"){
                        return "台湾居民来往大陆通行证";
                    }else if (val == "UNITCREDITCODE"){
                        return "统一社会信用代码";
                    }else{
                        return "";
                    }

                }},
            {title: '证件号码', field: 'ownerCertId', sortable: "true",align:"center",halign:"center"},
            {title: '所有人证件地址', field: 'ownerCertAddr',  sortable: "true",align:"center",halign:"center"},
            {title: '联系地址', field: 'address', sortable: "true",align:"center",halign:"center"},
            {title: '操作',field:"operation", align:"center",halign:"center", formatter: function (val, row) {
                    return "<a href=\"#\" onclick=\"showFaultDetail('" + row.id + "')\">查看详情</a>&nbsp;&nbsp;";
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

    //添加tab
    function addTabFun(title, url, id, icon, fullScreen,openNewTab) {
        if ($.trim(url) != "") {
            if (window.parent.$('#centerTabs').tabs('exists', title)&&(openNewTab==null||openNewTab==undefined||openNewTab==false)) {
                window.parent.$('#centerTabs').tabs('select', title);
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
            window.parent.$('#centerTabs').tabs('add', {
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
</script>
</body>
</html>