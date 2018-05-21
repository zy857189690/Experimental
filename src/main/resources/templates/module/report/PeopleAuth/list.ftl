
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
        <div id="tableTabsOn" class="easyui-tabs" data-options="fit:true,border:false,plain:true">
            <div title="个人实名认证">
                <iframe name="indextab" id="PeopleAuthIframe" scrolling="auto" src="${base}/PeopleAuth/people/datagrid" frameborder="0" style="width:100%;height:100%;"></iframe>
            </div>
            <div title="企业实名认证">
                <iframe name="indextab2" id="EnterpriseAuthIframe" scrolling="auto" src="${base}/EnterpriseAuth/enterprise/datagrid" frameborder="0" style="width:100%;height:100%;"></iframe>
            </div>
        </div>
    </div>
<script type="text/javascript">
    //当前tab页的flag
    var currTabl = 0;
    $('#tableTabsOn').tabs({
        border: false,
        selected:parseInt("${flag}"),
        onSelect: function (title, index) {
            //var data = searchPram();
            if( index == 1 ){
                $("#tableTabsOn").tabs('select',title);
            }
            if( index == 0 ){
                $("#tableTabsOn").tabs('select',title);
            }
        }
    });

</script>
</body>
</html>