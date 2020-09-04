/**
 * Created by Administrator on 2015/6/11 0011.
 */

/**
 * ����ģ���ѯ��û�д���comboboxΪselectʱ�����������ͳһ����
 */

function launchFullscreen(element) {
    if(element.requestFullscreen) {
        element.requestFullscreen();
    } else if(element.mozRequestFullScreen) {
        element.mozRequestFullScreen();
    } else if(element.webkitRequestFullscreen) {
        element.webkitRequestFullscreen();
    } else if(element.msRequestFullscreen) {
        element.msRequestFullscreen();
    }
}

function fullOpen(url,name){
    //window.open (url,name,'width='+(window.screen.availWidth-10)+',height='+(window.screen.availHeight-30)+ ',top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no')
    window.open(url,name);
}


$(function(){
    var bodyClass = $("body").attr("class");
    if(bodyClass!=undefined && bodyClass.indexOf("easyui-layout")>=0){
        var panel = $("body").layout("panel","north");
        if(panel[0]){
            var centerPanel = $("body").layout("panel","center");
            var options = panel.panel("options");
            var optionsCenter = centerPanel.panel("options");
            var title = options.title;
            if(title!=undefined && title=="查询"){
                var oldHeight = options.height;
                var oldCenterHeight = optionsCenter.height;
                var afterCenterHeight = oldCenterHeight-(120-oldHeight);
                var tdNum = panel.find('.table_search td').length;
                panel.panel("resize",{
                    height: (tdNum>9?2:1)*50 + 20
                });
                centerPanel.panel("resize",{
                    height:afterCenterHeight
                });

                $("body").layout("resize",{
                    height: $("body").length
                });
            }
        }
    }


    $("#form_search .easyui-combobox").each(function(index,el){
        var textboxname = $(this).attr("textboxname");
        var query_type = $(this).attr("query_type");
        var tag = $(this)[0].tagName;

        if(textboxname!=undefined  && query_type!=undefined && tag == "SELECT"){
            $(this).append("<input type='hidden' textboxname='"+textboxname+"' query_type='"+query_type+"'>");
        }
    });
    //$('.select2').select2({
    //    placeholder:'请选择',
    //    dropdownAutoWidth:true,
    //    allowClear:true
    //});
    //$('select.select2').each(function(index,element){
    //    var val = $(element).attr("value");
    //    if(val==undefined || val==null || val==''){
    //        val = '';
    //    }
    //    // $(element).select2({
    //    //     placeholder:{
    //    //         id:val
    //    //     }
    //    // });
    //    $(element).val(val).trigger("change");//或者
    //
    //    // $(".select2-dropdown").css('width','200px');
    //
    //
    //});
    //$(".input-fat").css("height","26px");
    //$(".input-fat").css("width","150px");
    $("form").addClass("sui-form");
    $("#ff .input-fat").css('height', '');
    $("#ff .input-fat").css('width', '178px');


    //if(document.getElementById("fullid")!=null){
    //    launchFullscreen(document.getElementById("fullid"));
    //}





});

(function($, h, c) {
    var a = $([]),
        e = $.resize = $.extend($.resize, {}),
        i,
        k = "setTimeout",
        j = "resize",
        d = j + "-special-event",
        b = "delay",
        f = "throttleWindow";
    e[b] = 250;
    e[f] = true;
    $.event.special[j] = {
        setup: function() {
            if (!e[f] && this[k]) {
                return false;
            }
            var l = $(this);
            a = a.add(l);
            $.data(this, d, {
                w: l.width(),
                h: l.height()
            });
            if (a.length === 1) {
                g();
            }
        },
        teardown: function() {
            if (!e[f] && this[k]) {
                return false;
            }
            var l = $(this);
            a = a.not(l);
            l.removeData(d);
            if (!a.length) {
                clearTimeout(i);
            }
        },
        add: function(l) {
            if (!e[f] && this[k]) {
                return false;
            }
            var n;
            function m(s, o, p) {
                var q = $(this),
                    r = $.data(this, d);
                r.w = o !== c ? o: q.width();
                r.h = p !== c ? p: q.height();
                n.apply(this, arguments);
            }
            if ($.isFunction(l)) {
                n = l;
                return m;
            } else {
                n = l.handler;
                l.handler = m;
            }
        }
    };
    function g() {
        i = h[k](function() {
                a.each(function() {
                    var n = $(this),
                        m = n.width(),
                        l = n.height(),
                        o = $.data(this, d);
                    if (m !== o.w || l !== o.h) {
                        n.trigger(j, [o.w = m, o.h = l]);
                    }
                });
                g();
            },
            e[b]);
    }
})(jQuery, this);







