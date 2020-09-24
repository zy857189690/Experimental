<script type="text/javascript" charset="UTF-8">
    var layer_load_ID = -1;

    $(function () {
        centerTabs = $('#centerTabs').tabs({
            border: false,
            fit: true,
            onAdd: function (title, index) {
//                layer_load_ID = layer.load(2, {time: 10*1000});
            },
            onLoad: function (panel) {
//                if( layer_load_ID != -1){
//                    layer.close(layer_load_ID);
//                }
            },
            onSelect:function(title,index){
//                alert(title);
//                var selectTab =  centerTabs.getTab(index);
//                var content = centerTabs.getTab(index).selectTab.panel('options').content;
//                alert(content);
//                var tab = $('#tt').tabs('getSelected');

                //获取iframe名称
//                var frameName = $(".tabs-panels .panel:eq("+index+") iframe").attr("name");
//                if(frameName != undefined){
//                    window.frames[frameName].window.$("body").layout('resize', {
//                        width:'100%',
//                        height:"100%"
//                    });
//                }


                var sWindow = $(".tabs-panels .panel:eq("+index+") iframe")[0].contentWindow;
                resizeDatagrid(sWindow);
                window.parent.isshoye=false;//清除单车上的定时任务
                if(title=="首页" || title=="地图展示"){
                    window.parent.isshoye=true;//清除单车上的定时任务
                }

            }
        });
        setTimeout(function () {
            //沃特玛首页
            var href='/experimentManagement/report/demo1/list';
//            var href='/guide/main.html';
            var frameName = "homePageFrame";
            var content = '<iframe  id="homePage" scrolling="no" frameborder="0" name="' + frameName + '" src="'+href+'" style="width:100%;height:100%;"></iframe>';
            centerTabs.tabs('add', {
                title: '首页',
                content: content,
                closable: false,
                iconCls: '',
                tools: [
                    {
                        iconCls: 'icon-mini-refresh',
                        handler: function () {
                            $("#homePage").attr('src',href);
                        }
                    }

                ]
            });
        }, 0);
    });

    function resizeDatagrid(_window) {
        if (_window.hasLoad) {
            var _$ = _window.$;
            if (_$ == undefined) return;
            _$('#table').datagrid('reload');
        }
        $(_window).on('load', function () {
            _window.hasLoad = true;
        });
    }

    //添加tab
    function addTabFun(title, url, id, icon, fullScreen,openNewTab) {
        if ($.trim(url) != "") {
            if ($('#centerTabs').tabs('exists', title)&&(openNewTab==null||openNewTab==undefined||openNewTab==false)) {
                $('#centerTabs').tabs('select', title);
                var tab = $('#centerTabs').tabs("getSelected");



                var hrefType = '';

                if(url.indexOf("hrefType") > 0) {
                    hrefType = url.substring(url.indexOf("hrefType")+9, url.length);
                }

                if(hrefType == "south" && title == "平台报警处理") {
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

                    fm.attr('src', url);

                    $('#centerTabs').tabs("update", {
                        tab: tab,
                        options: {
                            content: fm
                        }
                    });
                }

                var contentWindow = tab.find('iframe')[0].contentWindow;
                resizeDatagrid(contentWindow);

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

            $('#centerTabs').tabs('add', {
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
//                    {
//                        iconCls: 'icon-full',
//                        handler: function () {
//                            var el = $("iframe[name='" + frameName + "']")[0];
////                            log(el);
//                            if (el != null) {
//                                launchFullscreen(el);
//                            }
//                        }
//                    }
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
<div id="centerTabs">
</div>
