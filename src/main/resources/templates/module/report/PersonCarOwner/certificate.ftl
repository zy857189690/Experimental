<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<#include "../../../inc/meta.ftl">
<#include  "../../../inc/js.ftl">
    <style type="text/css">
        .mt10{
            margin-top: 10px;
        }

        i:before {
            content: "* ";
            line-height: 30px;overflow-x: ;
            color: red;
            margin-left: 5px;
        }

        span{
            font-style: normal;
        }
        table{
            border-collapse:separate; border-spacing:10px;
        }
        td{
            width:200px;
            word-break:break-all;
        }
    </style>
    <script type="text/javascript">
        function keepUp() {
            close_win();
            addTabFun('个人车辆绑定', '${base}/personCarOwner/add', 'm_personCarOwner_bind_iframe')
        }
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
</head>
<body>
<div class="easyui-layout" fit="true">
    <div region="center" style="overflow: hidden;width: 50%;" >
        <div align="center"id="tab1">
            <table width="90%" class="mt10">
                <tr style="text-align: center">
                    <td>
                        <input type="hidden" value="${id}"/>
                        ${msg}
                    </td>
                </tr>
                <tr style="text-align: center">
                    <td>
                        <a class="easyui-linkbutton fsave"  href="javascript:void(0)" onclick="keepUp()">继续绑定车辆</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>