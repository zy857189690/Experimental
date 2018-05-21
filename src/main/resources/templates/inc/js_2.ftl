

<#--<link href="https://cdn.insdep.com/themes/1.0.0/easyui.css" rel="stylesheet" type="text/css">-->
<#--<link href="https://cdn.insdep.com/themes/1.0.0/easyui_animation.css" rel="stylesheet" type="text/css">-->


<#--<link href="https://cdn.insdep.com/themes/1.0.0/easyui_plus.css" rel="stylesheet" type="text/css">-->
<#--<!---->
<#--easyui_plus.css-->
<#--Insdep对easyui的额外增强样式,内涵所有 insdep_xxx.css 的所有组件样式-->
<#--根据需求可单独引入insdep_xxx.css或不引入，此样式不会对easyui产生影响-->
<#--&ndash;&gt;-->

<#--<link href="https://cdn.insdep.com/themes/1.0.0/insdep_theme_default.css" rel="stylesheet" type="text/css">-->
<#--<!---->
<#--insdep_theme_default.css-->
<#--Insdep官方默认主题样式,更新需要自行引入，此样式不会对easyui产生影响-->
<#--&ndash;&gt;-->


<!--
    icon.css
    美化过的easyui官方icons样式，根据需要自行引入
-->

<link rel="stylesheet" type="text/css" href="${base}/lib/easyui-1.5.1/themes/default/easyui2.css">
<link rel="stylesheet" type="text/css" href="${base}/lib/easyui-1.5.1/themes/icon.css">
<#--<link href="https://cdn.insdep.com/themes/1.0.0/icon.css" rel="stylesheet" type="text/css">-->

<link rel="stylesheet" type="text/css" href="${base}/lib/easyui-1.5.1/themes/IconExtension.css">
<link rel="stylesheet" type="text/css" href="${base}/lib/easyui-1.5.1/themes/icon_nat.css">
<link rel="stylesheet" type="text/css" href="${base}/style/style.css"/>
<link rel="stylesheet" type="text/css" href="${base}/skin/skincss/iframeblue.css"/>
<#--<link href="${base}/lib/select2/css/select2.min.css" rel="stylesheet"/>-->
<link href="http://g.alicdn.com/sj/dpl/1.5.1/css/sui.min.css" rel="stylesheet">
<#--<link rel="stylesheet" href="/lib/layui/css/layui.css">-->
<link rel="stylesheet" href="${base}/style/inputClearIcon.css">


<script type="text/javascript" src="${base}/lib/jquery/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${base}/lib/layer/layer.js"></script>
<script type="text/javascript" src="${base}/lib/jqueryvalidate/jquery.validate.min.js"></script>
<script type="text/javascript" src="${base}/lib/jqueryvalidate/messages_zh.min.js"></script>
<script src="${base}/lib/select2/js/select2.min.js"></script>
<script type="text/javascript" src="${base}/lib/jquery/jquery.cookie.js"></script>
<#--<script type="text/javascript" src="${base}/lib/easyui-1.4.3/jquery.easyui.min.js"></script>-->
<#--<script type="text/javascript" src="${base}/lib/easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>-->

<script type="text/javascript" src="${base}/lib/easyui-1.5.1/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${base}/lib/easyui-1.5.1/locale/easyui-lang-zh_CN.js"></script>
<#--<script type="text/javascript" src="https://cdn.insdep.com/themes/1.0.0/jquery.insdep-extend.min.js"></script>-->

<script type="text/javascript" src="${base}/js/easy-extend-validate.js"></script>
<script type="text/javascript" src="${base}/js/ex.js"></script>
<script src="/lib/layui/layui.js"></script>
<script type="text/javascript" src="${base}/js/common_2.js"></script>
<script type="text/javascript" src="${base}/lib/echarts/echarts.js"></script>
<script type="text/javascript" src="${base}/lib/My97DatePicker/WdatePicker.js"></script>
<#--<script type="text/javascript" src="${base}/lib/select2/js/select2.min.js"></script>-->
<script src="${base}/js/dialogHelper.js"></script>
<#--<script type="text/javascript" src="${base}/lib/select2/js/select2.full.min.js"></script>-->

<#--弹出框统一修改：将文本框触发弹出改为放大镜图标触发 add by yuexw 2017年4月27日-->
<script>
    //供list页面右侧弹出框调用（针对onfocus按钮）
    function openDg(obj){
        var $this = $('#'+obj),txtEle = $this.siblings('input:text');
        var focus = $this.attr('foucus_');
        txtEle.attr('onclick',focus);
        txtEle.trigger('click');
        txtEle.removeAttr('onclick');
    }
    //供新增/编辑页面弹出框调用（针对onclick按钮）
    function openDgS(obj){
        var $this = $('#'+obj),txtEle = $this.siblings('input:text');
        var focus = $this.attr('foucus_');
        txtEle.attr('onclick',focus);
        txtEle.trigger('click');
    }

    $(function(){
        //供list页面右侧弹出框调用（隐藏原有针对input框的onfocus事件，新增放大镜图标并绑定新的触发事件）
        $("input[onfocus^='top.openSelectDialog']").each(function(i,obj){
            var $obj = $(obj);
            var focus = $obj.attr('onfocus');
            $obj.removeAttr('onfocus');
            $obj.parent().append('<a href="javascript:openDg(\'openDg_'+i+'\');" id="openDg_'+i+'" class="bg_button" foucus_="'+focus+'"></a>');
            $obj.next('a[class="clear"]').css({ "position": "absolute", "right": "30px" });
            $obj.change(function(){
                var $this = $(this),val = $this.val(),aEle = $obj.next('a[class="clear"]');
                if(val !=null && val != ''){
                    aEle.show();
                }else{
                    aEle.hide();
                }
            });

        });
        //供新增/编辑页面弹出框调用（隐藏原有针对input框的onclick事件，新增放大镜图标并绑定新的触发事件）
        $("input[onclick^='top.open']").each(function(i,obj){
            var $obj = $(obj);
            var focus = $obj.attr('onclick');
            $obj.removeAttr('onclick');
            $obj.parent().append('<a href="javascript:openDgS(\'openDg_'+i+'\');" id="openDg_'+i+'" class="bg_buttons" foucus_="'+focus+'"></a>');

        });

    });

    function afterLoading() {
        $('.datagrid-header-rownumber').text("序号");
    }
    </script>










