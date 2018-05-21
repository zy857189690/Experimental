/**
 * 关闭当前也签,不传参数只关闭当前也签
 */
function closeCurrentTab(title, url, id, icon, fullScreen,openNewTab) {
    var tab=window.parent.$('#centerTabs').tabs('getSelected');//获取当前选中tabs
    var index = window.parent.$('#centerTabs').tabs('getTabIndex',tab);//获取当前选中tabs的index
    if(title == 'undefined'){
        window.parent.$('#centerTabs').tabs('close',index);//关闭对应index的tabs
        return;
    }
    addNewTab(title, url, id, icon, fullScreen,openNewTab);
    window.parent.$('#centerTabs').tabs('close',index);//关闭对应index的tabs
}

/**
 * 添加一个新的也签
 * @param title
 * @param url
 * @param id
 * @param icon
 * @param fullScreen
 * @param openNewTab
 */
function addNewTab(title, url, id, icon, fullScreen,openNewTab) {
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

/**
 * 备注 国际移动台识别码(IMSI)--length[1, 15]
 *         车架号（VIN） -- midlength[17]
 *         终端编号--length[1,50 ]
 *         IMEI号 -- midlength[15]
 *         测试
 * */
function initValid(){
    $.extend($.fn.validatebox.defaults.rules, {
        phoneNum: { //验证手机号
            validator: function(value, param){
                return /^1[3-8]+\d{9}$/.test(value);
            },
            message: '请输入正确的手机号码。'
        },
        checksim: { //验证sim卡如checksim[9, 20]
            validator: function(value, param){
                var reg = /^[0-9]*$/;
                var len = $.trim(value).length;
                return len >=param[0] && len <= param[1] && reg.test(value);
            },
            message: 'SIM卡号是9至20位数字。'
        },
        standardlength: { //验证大写中英文字符串字节长度
            validator: function(value, param){
                var len = 0;
                for (var i = 0; i < value.length; i++) {
                    var a = value.charAt(i);
                    if (a.match(/[^\x00-\xff]/ig) != null) {
                        len += 2;
                    }
                    else {
                        len += 1;
                    }
                }
                return len >= param[0] && len <= param[1];
            },
            message: '长度必须介于{0}和{1}之间.'
        },
        midlength: {//
            validator: function (value, param) {
                var len = $.trim(value).length;
                return len == param[0] && /^[a-zA-Z0-9]+$/.test(value);
            },
            message: "长度必须是{0}且包含字母和数字."
        },
        checkiccid: {//校验iccid如checkiccid[20]
            validator: function (value, param) {
                var len = $.trim(value).length;
                return (len == param[0] || len == 19) && /^[0-9]*$/.test(value);
            },
            message: "长度必须是19或{0}位数字."
        },
        ownerCertId: {
            validator: function (value, param) {
                var len = $.trim(value).length;
                console.log(param);
                if($("#ownerCertType").val() == 'IDCARD'){//居民身份证
                    param[2] = "身份证15或18位";
                    return (len==15 || len==18) && IdentityCodeValid(value);
                }else if($("#ownerCertType").val() == 'HKIDCARD'){//港澳居民来往内地通行证
                    param[2] = "以1位大写字母开头和8位数字";
                    return len==9 && isHkongMacao(value);
                }else if($("#ownerCertType").val() == 'OTHERLICENCE'){//其他
                    param[2] = "长度为8-30位";
                    return len>=param[0] && len<=param[1];
                }else if($("#ownerCertType").val() == 'PASSPORT'){//护照
                    param[2] = "分别以DSPG开头1位大写字母和8位数字";
                    return len == 9 && isPassport(value);
                }else if($("#ownerCertType").val() == 'PLA'){//军官证
                    param[2] = "长度为8-30位";
                    return len>=param[0] && len<=param[1];
                }else if($("#ownerCertType").val() == 'POLICEPAPER'){//警官证
                    param[2] = "长度为8-30位";
                    return len>=param[0] && len<=param[1];
                }else if($("#ownerCertType").val() == 'TAIBAOZHENG'){//台湾居民来往大陆通行证
                    param[2] = "长度为8-30位";
                    return len>=param[0] && len<=param[1];
                }else if($("#ownerCertType").val() == 'UNITCREDITCODE'){//统一社会信用代码
                    param[2] = "18位包含大写字母和数字";
                    return len==18 && /^[A-Z0-9]+$/.test(value);
                }
                return true;
            },
            //message: "<span>长度必须介于{0}和{1}之间,<br>并且与证件类型格式匹配</span>"
            message: "{2}"

        }
    });

//军官证验证
    function isjunguanzheng(value) {
        var reg = /\S{8,10}/;
        value = value.replace(/(^\s*)|(\s*$)/g, "");
        if (reg.test(value) === false) {
            return false;
        } else {
            return true;
        }
    }

    function isTaiwan(value) {
        var re1 = /^[0-9]{8}$/;
        var re2 = /^[0-9]{10}$/;
        return re1.test(value) || re2.test(value);

    }
    function isPassport(value) {
        var c = /^G[0-9]{8}|P[0-9]{7}|S[0-9]{7,8}|D[0-9]+$/;
        return c.test(value);
    }

    function isHkongMacao(value) {
        var re = /^[A-Z]{1}([0-9]{8})$/;
        return re.test(value);
    }

    //验证身份证号方法
    function IdentityCodeValid(idcard){
        var Errors=new Array("验证通过!","身份证号码位数不对!","身份证号码出生日期超出范围或含有非法字符!","身份证号码校验错误!","身份证地区非法!");
        var area={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"xinjiang",71:"台湾",81:"香港",82:"澳门",91:"国外"}
        var idcard,Y,JYM;
        var S,M;
        var idcard_array = new Array();
        idcard_array = idcard.split("");
        if(area[parseInt(idcard.substr(0,2))]==null)
            return false;
        // return Errors[4];
        switch(idcard.length){
            case 15:
                if ((parseInt(idcard.substr(6,2))+1900) % 4 == 0 || ((parseInt(idcard.substr(6,2))+1900) % 100 == 0 && (parseInt(idcard.substr(6,2))+1900) % 4 == 0 )){
                    ereg = /^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$/;//测试出生日期的合法性
                }
                else{
                    ereg = /^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$/;//测试出生日期的合法性
                }
                if(ereg.test(idcard))
                // return Errors[0];
                    return true;
                else
                // return Errors[2];
                    return false;
                break;
            case 18:
                if( parseInt(idcard.substr(6,4)) % 4 == 0 || ( parseInt(idcard.substr(6,4)) % 100 == 0 && parseInt(idcard.substr(6,4))%4 == 0 )){
                    ereg = /^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$/;//闰年出生日期的合法性正则表达式
                }
                else{
                    ereg = /^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$/;//平年出生日期的合法性正则表达式
                }
                if(ereg.test(idcard)){
                    S = (parseInt(idcard_array[0]) + parseInt(idcard_array[10])) * 7 + (parseInt(idcard_array[1]) + parseInt(idcard_array[11])) * 9 + (parseInt(idcard_array[2]) + parseInt(idcard_array[12])) * 10 + (parseInt(idcard_array[3]) + parseInt(idcard_array[13])) * 5 + (parseInt(idcard_array[4]) + parseInt(idcard_array[14])) * 8 + (parseInt(idcard_array[5]) + parseInt(idcard_array[15])) * 4 + (parseInt(idcard_array[6]) + parseInt(idcard_array[16])) * 2 + parseInt(idcard_array[7]) * 1 + parseInt(idcard_array[8]) * 6 + parseInt(idcard_array[9]) * 3 ;
                    Y = S % 11;
                    M = "F";
                    JYM = "10X98765432";
                    M = JYM.substr(Y,1);
                    if(M == idcard_array[17])
                    // return Errors[0];
                        return true;
                    else
                    // return Errors[3];
                        return false;
                }
                else
                // return Errors[2];
                    return false;
                break;
            default:
                // return Errors[1];
                return false;
                break;
        }
        return true;
    }
}

function close_win(){
    window.top.window.$("#"+$(window.frameElement).parent().attr('id')).window('close');
}

//打开对话框
function openModuleEditWin(url,title, winid,width,height) {
    if (typeof (winid) == undefined){
        winid = "user";
    }
    if(typeof (width)== 'undefined'){
        width=600;
        height=560;
    }
    module_window(winid, url, title, width, height);
}

/**
 * 清楚input框内容，仅支持easyui样式的文本框
 * @param obj
 */
function clearInputVal(obj) {
    var val = $(obj).siblings(":first").textbox('getValue');
    $(obj).siblings(":first").textbox('setValue','')
}

//在最顶层弹出窗口
function module_window(winid,url,title,width,height, closable,other_data){
    if(!url) return;
    if(!width) width = 300;
    if(!height) height = 300;
    if (false != closable) {
        closable = true;
    }
    var html = "<div id='window_"+winid+"' style=\"padding:0px;\">"
        +"<iframe src='" + url + "' frameborder='0' result_data='"+other_data+"' id='"+winid+"Frame' name='"+winid+"Frame' marginheight='0' style='width:100%;height:95%;' marginwidth='0' scrolling='auto'></iframe>"
        +"</div>";
    var win = window.top.$(html).appendTo(window.top.document.body);
    win.window({
        //标题
        title : title,
        //宽度
        width : width,
        //是否模态
        modal : true,
        //是否显示阴影
        shadow : false,
        //
        closed : true,
        //是否显示右上角的关闭按钮
        closable : closable,
        //是否能最小化
        minimizable : false,
        //是否可折叠
        collapsible : false,
        //是否能最大化
        maximizable : false,
        //高度
        height : height,
        //是否可拖动
        draggable : true,
        //浮动量
        zIndex : -999999,
        //对于主父窗口如何停留的定义，true 该窗口停留在父窗口上， false 该窗口始终显示在最顶层，默认为false(这个定义等同于javax.swing里的dialog)
        inline : true,
        //关闭事件执行详细
        onClose : function() {
            //顶层模态需在顶层关闭，否则无效
            window.setTimeout(function() {
                window.top.$(win).window('destroy', false);
            }, 0);
        }
    });
    win.window('open');
    return win;
}