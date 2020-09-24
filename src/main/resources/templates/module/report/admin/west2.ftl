<div  class="easyui-accordion xy-west" data-options="fit:true,border:false" style="overflow-y: scroll;">
    <#--<ul id="LeftTree" class="easyui-tree"></ul>-->
    <#--<div id="">-->
        <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav metismenu" id="side-menu">

                    <li>
                        <a href="#">
                            <span class="nav-label">实验原料管理</span><span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level collapse">
                            <li><a href="drug">实验药品管理</a></li>
                        </ul>
                    </li>
                    <li class="active">
                        <a href="#"> <span class="nav-label nav-label01">实验初始管理</span> <span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                        <#--class="active"--><#-- 自动展开-->
                            <li ><a href="formula"> 配方管理</a></li>
                            <li ><a href="position"> 实验位置图管理</a></li>
                            <li><a href="dashboard_2.html">实验管理</a></li>
                            <li><a href="dashboard_3.html">点样位置图管理</a></li>
                            <li><a href="dashboard_4_1.html">原始数据管理</a></li>
                            <li><a href="dashboard_5.html">实验过程报告管理</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#"> <span class="nav-label">Menu Levels </span><span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level collapse">
                            <li>
                                <a href="index.html#">Third Level <span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <li><a href="index.html#">Third Level Item</a></li>
                                    <li>
                                        <a href="index.html#">Third Level Item</a>
                                    </li>
                                    <li>
                                        <a href="index.html#">Third Level Item</a>
                                    </li>

                                </ul>
                            </li>
                            <li><a href="index.html#">Second Level Item</a></li>
                            <li>
                                <a href="index.html#">Second Level Item</a></li>
                            <li>
                                <a href="index.html#">Second Level Item</a></li>
                        </ul>
                    </li>
                </ul>

            </div>
        </nav>
    <#--</div>-->
<#--<#list root.children as node>-->
<#--<div title="${node.name}" data-options="iconCls:'${(node.icon)!}'" style="padding:4px;overflow:auto;">-->
<#--<ul id="tt1" class="easyui-tree" data-options="animate:true,dnd:true">-->
<#--<#list node.children as child>-->
<#--<li ><span><a href='#' iconCls="${(child.icon)!}" onclick="addTabFun('${child.name}','${(child.action)  !}','m_'+'${child.moduleName}','${(child.icon)!}',${child.isFullScreen!})">${child.name}</a></span></li>-->
<#--</#list>-->
<#--</ul>-->
<#--</div>-->
<#--</#list>-->
</div>

<style>
    ::-webkit-scrollbar{width:14px;}
    ::-webkit-scrollbar-track{background-color: #2978b3;}
    ::-webkit-scrollbar-thumb{background-color: #00aff0;}
    ::-webkit-scrollbar-thumb:hover {background-color: #48b2f0
    }
    ::-webkit-scrollbar-thumb:active {background-color:#00aff0}


    .nav-label {
        padding-left: 26px;
    }

 /*   .nav-label01 {
        background: url("../../images/cheliangjiankong.png") no-repeat left center;
        background-size: contain;
    }
    .nav-label02 {
        background: url("../../images/anquanguanli.png") no-repeat left center;
        background-size: contain;
    }
    .nav-label03 {
        background: url("../../images/shouhoufuwu.png") no-repeat left center;
        background-size: contain;
    }
    .nav-label04 {
        background: url("../../images/tongjifenxi.png") no-repeat left center;
        background-size: contain;
    }
    .nav-label05 {
        background: url("../../images/cheliangguanli.png") no-repeat left center;
        background-size: contain;
    }
    .nav-label06 {
        background: url("../../images/lingpeijianguanli.png") no-repeat left center;
        background-size: contain;
    }
    .nav-label07 {
        background: url("../../images/yonghuzhongxin.png") no-repeat left center;
        background-size: contain;
    }
    .nav-label08{
        background: url("../../images/kehuguanli.png") no-repeat left center;
        background-size: contain;
    }
    .nav-label09 {
        background: url("../../images/pingtaikaifangshezhi.png") no-repeat left center;
        background-size: contain;
    }
    .nav-label10 {
        background: url("../../images/xitongguanli.png") no-repeat left center;
        background-size: contain;
    }
    .nav-label11 {
        background: url("../../images/yuanchengkongzhi.png") no-repeat left center;
        background-size: contain;
    }
    .nav-label12 {
        background: url("../../images/yuanchengshengji.png") no-repeat left center;
        background-size: contain;
    }
    .nav-label13 {
        background: url("../../images/huishouzhan.png") no-repeat left center;
        background-size: contain;
    }
    .nav-label14 {
        background: url("../../images/beiyong-beifen.png") no-repeat left center;
        background-size: contain;
    }
    .nav-label15 {
        background: url("../../images/guzhangbaojing-hui.png") no-repeat left center;
        background-size: contain;
    }
    .nav-label16 {
        background: url("../../images/jiankongzhongxin-hui.png") no-repeat left center;
        background-size: contain;
    }
    .nav-label17 {
        background: url("../../images/shujuguanli-hui.png") no-repeat left center;
        background-size: contain;
    }
    .nav-label18 {
        background: url("../../images/shujujiaohuan-hui.png") no-repeat left center;
        background-size: contain;
    }
    .nav-label19 {
        background: url("../../images/dapingzhanshi_hui.png") no-repeat left center;
        background-size: contain;
    }
    .nav-label20 {
        background: url("../../images/appweihuzhongxin.png") no-repeat left center;
        background-size: contain;
    }

  !*  .active .nav-label01 {
        background: url("../../images/cheliangjiankong_h.png") no-repeat left center;
        background-size: contain;
    }*!
    .active .nav-label02 {
        background: url("../../images/anquanguanli_h.png") no-repeat left center;
        background-size: contain;
    }
    .active .nav-label03 {
        background: url("../../images/shouhoufuwu_h.png") no-repeat left center;
        background-size: contain;
    }
    .active .nav-label04 {
        background: url("../../images/tongjifenxi_h.png") no-repeat left center;
        background-size: contain;
    }
    .active .nav-label05 {
        background: url("../../images/cheliangguanli_h.png") no-repeat left center;
        background-size: contain;
    }
    .active .nav-label06 {
        background: url("../../images/lingpeijianguanli_h.png") no-repeat left center;
        background-size: contain;
    }
    .active .nav-label07 {
        background: url("../../images/yonghuzhongxin_h.png") no-repeat left center;
        background-size: contain;
    }
    .active .nav-label08{
        background: url("../../images/kehuguanli_h.png") no-repeat left center;
        background-size: contain;
    }
    .active .nav-label09 {
        background: url("../../images/pingtaikaifangshezhi_h.png") no-repeat left center;
        background-size: contain;
    }
    .active .nav-label10 {
        background: url("../../images/xitongguanli_h.png") no-repeat left center;
        background-size: contain;
    }
    .active .nav-label11 {
        background: url("../../images/yuanchengkongzhi_h.png") no-repeat left center;
        background-size: contain;
    }
    .active .nav-label12 {
        background: url("../../images/yuanchengshengji_h.png") no-repeat left center;
        background-size: contain;
    }
    .active .nav-label13 {
        background: url("../../images/huishouzhan_h.png") no-repeat left center;
        background-size: contain;
    }
    .active .nav-label14 {
        background: url("../../images/beiyong-lan.png") no-repeat left center;
        background-size: contain;
    }
    .active .nav-label15 {
        background: url("../../images/guzhangbaojing-lan.png") no-repeat left center;
        background-size: contain;
    }
    .active .nav-label16 {
        background: url("../../images/jiankongzhongxin-lan.png") no-repeat left center;
        background-size: contain;
    }
    .active .nav-label17 {
        background: url("../../images/shujujiaohuan-an.png") no-repeat left center;
        background-size: contain;
    }
    .active .nav-label18 {
        background: url("../../images/shujujiaohuan-lan.png") no-repeat left center;
        background-size: contain;
    }
    .active .nav-label19 {
        background: url("../../images/dapingzhanshi_lan.png") no-repeat left center;
        background-size: contain;
    }*/

    .navbar-static-side{
        width: 206px;
    }
    .sidebar-collapse, .sidebar-collapse * {
        box-sizing: border-box;
    }
    .nav {
        padding-left: 0;
        margin-bottom: 0;
        list-style: none;
    }
    .nav:before {
        display: table;
        content: " ";
    }
    .nav>li {
        position: relative;
        display: block;
    }
    .nav > li > a {
        color: #c4cddc;
        font-weight: 500;
        padding: 14px 20px 14px 25px;
        transition: .4s all ease;
    }
    .nav > li > a:hover {
        color: #fff;
    }
    .nav>li>a {
        position: relative;
        display: block;
        padding: 12px 15px;
    }
    .active .nav-label {
        color: #2ee0ff;
    }
    ul.nav-second-level li.active>a {
        color: #2ee0ff;
    }
    .nav.nav-second-level.collapse[style] {
        height: auto !important;
    }

    .metismenu .collapse {
        display: none;
    }
    .nav.nav-second-level > li.active {
        border: none;
    }
    .nav > li.active {
        border-left: 4px solid #00adff;
        background: #0d356a;
    }
    .nav-second-level li, .nav-third-level li {
        border-bottom: none !important;
    }
    .nav > li.active > a {
        color: #ffffff;
    }
    .nav-second-level li a {
        padding: 8px 10px 8px 10px;
        padding-left: 42px;
    }
    .nav-third-level li a {
        padding-left: 56px;
    }
    .metismenu .arrow {
        float: right;
        line-height: 1.42857;
    }
    .metismenu .collapse.in {
        display: block;
    }
    .metismenu .collapsing {
        position: relative;
        height: 0;
        overflow: hidden;
        -webkit-transition-timing-function: ease;
        transition-timing-function: ease;
        -webkit-transition-duration: .35s;
        transition-duration: .35s;
        -webkit-transition-property: height, visibility;
        transition-property: height, visibility;
    }

    .metismenu .active > a > .fa.arrow:before {
        content: "\f107";
    }

    .active > a > .fa.arrow:before {
        content: "\f107";
    }

    .metismenu .fa.arrow:before {
        content: "\f104";
    }

    .fa.arrow:before {
        content: "\f104";
    }

    .nav-second-level li:last-child {
        margin-bottom: 10px;
    }

    .navbar-static-side a {
        text-decoration: none;
    }

    #indexLayout>.layout-panel-west .panel-header-noborder {
        height: 30px;
    }
    #indexLayout>.layout-panel-west .panel-title {
        line-height: 30px;
    }
    #centerTabs>.tabs-header-noborder {
        height: 40px;
    }
    #centerTabs>.tabs-header-noborder .tabs {
        padding-top: 7px;
        padding-left: 14px;
    }
    @media screen and (max-width:1366px) {
        .nav>li>a {

            padding: 8px 15px;
        }
        .nav-second-level li a {
            padding: 4px 10px 4px 10px;
            padding-left: 42px;
        }
        .nav-third-level li a {
            padding-left: 56px;
        }
    }
</style>
<script>
    $(function(){
//        var h = $(window).height();
//        $("#LeftTree").height(h-130);
//        $(document).resize(function() {
//            h = $(window).height();
//            $("#LeftTree").height(h-130);
//        });
//        $(".easyui-tree").tree({
//            onClick:function(node){
//                var anode = $(node.text);
//                eval(anode.attr("onclick"));
//            },
//            onLoadSuccess:function(node, data){
//
//                for(i=0;i<data.length;i++){
//                    var tree_id = data[i].domId;
//                    var anode = $(data[i].text);
//                    $("#"+tree_id+" .tree-icon").addClass(anode.attr("iconCls"));
//                }
//
//            }
//        });
        <#--var treeData = str2obj('${root}');-->
        /*$("#LeftTree").tree({
            data:treeData['children'],
            onClick: function(node){
                if(node.openType == '2'){//弹出新页面
                    window.top.open(node.attributes.url,"_blank");
                }else{
                    //判断点击的节点是否是子节点是子节点就添加tab,否则就return打开这个节点
                    addTabFun(node.text,node.attributes.url,'m_'+node.attributes.divs);
                }
            },
            onDblClick: function(node) {
                $(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
                node.state = node.state === 'closed' ? 'open' : 'closed';
            },
            onLoadSuccess:function(node, data){
                for(var i=0;i<data.length;i++){
                    checkChildren(data[i]);
                }
            }
        });*/
    });

    function checkChildren(node){
        var children=node.children;
        if(children.length==0){
            /*var text=node.text;
            /*var v1=$("span[class='tree-title']:contains("+text+")");
            var v2=v1.prev().prev();
            console.log(v2);
            v2.removeClass("tree-hit tree-collapsed");
            v2.addClass("tree-indent");*/
            var id=node.id;
            var node = $('#LeftTree').tree('find', id);
            var v1=$(node.target);
            var v2=v1.attr("id");
            var v3=$("#"+v2).children("span");
            v3.each(function(){
                if(($(this).attr("class"))=="tree-hit tree-collapsed"){
                    $(this).removeClass("tree-hit tree-collapsed");
                    $(this).addClass("tree-indent");
                }
            });
    }else{
            for(var i=0;i<children.length;i++){
                checkChildren(children[i]);
            }
        }
    }
</script>
<script>
    // 创建新的nav

</script>

<script src="../../skin/js/jquery.metisMenu.js"></script>
<script src="../../skin/js/jquery.slimscroll.min.js"></script>
<script src="../../skin/js/inspinia.js"></script>
<script src="../../skin/js/pace.min.js"></script>
