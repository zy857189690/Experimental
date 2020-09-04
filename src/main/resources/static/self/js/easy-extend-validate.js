(function($) {
    /**
     * jQuery EasyUI 1.4 --- 功能扩展
     *
     * Copyright (c) 2009-2015 RCM
     *
     * 新增 validatebox 校验规则
     *
     */
    $.extend($.fn.validatebox.defaults.rules, {
        checkNum: {
            validator: function(value, param) {
                return /^([0-9]+)$/.test(value);
            },
            message: '请输入整数'
        },
        checkFloat: {
            validator: function(value, param) {
                return /^[+|-]?([0-9]+\.[0-9]+)|[0-9]+$/.test(value);
            },
            message: '请输入合法数字'
        },
        equalTo: {
            validator:function(value,param){
                return $(param[0]).val() == value;
            },
            message: '两次输入字符不匹配'
        },
        username : {// 验证用户名
            validator : function(value) {
                return /^[a-zA-Z][a-zA-Z0-9_]{4,15}$/i.test(value);
            },
            message : '用户名不合法(4~15位)'
        },
        userName : {// 验证用户名
            validator : function(value) {
                //return /^[^\uFF00-\uFFFF]{12}$/i.test(value);
                return /^[a-zA-Z0-9\x21-\x7e]{12}$/i.test(value);

            },
            message : '平台用户名不合法(12位)'
        },
        passWord : {// 验证用户名
            validator : function(value) {
                //return /^[^\uFF00-\uFFFF]{20}$/i.test(value);
                return /^[a-zA-Z0-9\x21-\x7e]{20}$/i.test(value);
            },
            message : '平台密码不合法(20位)'
        },
        sockpassWord : {// 验证用户名
            validator : function(value) {
                //return /^[^\uFF00-\uFFFF]{20}$/i.test(value);
                return /^[a-zA-Z0-9\x21-\x7e]{6,32}$/i.test(value);
            },
            message : '密码不合法(6~32位)'
        },
        ip : {// 验证IP地址
            validator : function(value) {
                return /d+.d+.d+.d+/i.test(value);
            },
            message : 'IP地址格式不正确'
        },
        realname : {// 验证姓名，可以是中文或英文
            validator : function(value) {
                return /^[\\Α\-\\￥]+$/i.test(value)|/^\w+[\w\s]+\w+$/i.test(value);
            },
            message : '请输入有效的姓名，长度2-6位'
        },
        mobile : {// 验证手机号码
            validator : function(value) {
                return /^(13|15|18|17|14)\d{9}$/i.test(value);
            },
            message : '手机号码格式不正确'
        },
        phone : {// 验证电话号码
            validator : function(value) {
                return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
            },
            message : '格式不正确,请使用下面格式:010-88888888'
        },
        selectRequired:{
            validator:function(value,param){
                return $(param[0]).find("option:contains('"+value+"')").val() != '';
            },
            message : '必须选其中一项'
        },
        carNo:{ //车牌号
            validator:function(value){
                var re=/^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$/;
                var result = value.match(re);
                return  result!=null
            },
            message:"车牌号码不正确"
        },
        letterNumber:{
            validator:function(value){
                var letterNumber=/^[A-Za-z0-9]+$/;
                return letterNumber.test(value);
            },
            message:"只能输入数字和字母"
        },
        code:{
            validator:function(value){
                var codeumber=/^[0-9]+$/;
                return codeumber.test(value);
            },
            message:"只能输入数字"
        },
        zip:{
            validator:function(val){
                var partten = /^[0-9 ]{6,6}$/;
                return partten.test(val);
            },
            message:"请输入正确的邮编"
        },
        tellPhone:{
            validator:function(tellphone){
                var isMobile=/^(?:13\d|15\d|17\d|18\d)\d{5}(\d{3}|\*{3})$/; //手机号码验证规则
                var isPhone=/^((0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/;   //座机验证规则
                (tellphone.match(isMobile)||tellphone.match(isPhone))
                var result = (tellphone.match(isMobile)||tellphone.match(isPhone));
                return result!=null;
            },
            message:"请输入有效的电话号码"
        },
        dataItemNO:{
            validator:function(value){
                if(parseInt(value)<0 || parseInt(value)>65535){
                    return false;
                }else{
                    return true;
                }

            },
            message:"序号范围(0~65535)"
        },
        numRange: {
            validator: function(value) {
                if(parseInt(value)<0 || parseInt(value)>65535){
                    return false;
                }else{
                    return true;
                }
            },
            message: '大小范围(0~65535)'
        },
        valuelength: {
            validator: function(value) {
                if(value.length<2 ||value.length>32){
                    return false;
                }else{
                    return true;
                }

            },
            message: '名称长度范围(0~32)'
        },
        textValue : {// 验证用户名
            validator : function(value) {
                return /^[^ ]{2,32}$/i.test(value);
            },
            message : '2~32位字符（不包含空格）'
        },
        textvale : {// 验证长度
            validator : function(value) {
                return /^[^ ]{1,32}$/i.test(value);
            },
            message : '2~32位字符（不包含空格）'
        },
        onlyLength : {// 验证长度
            validator : function(value) {
                if (value.length != 17) {
                    return false;
                }
                return true;
            },
            message : '输入内容长度为17位'
        },
        compareTo: {
            validator:function(value,param){
                if ($(param[0]).val() == "" || parseFloat($(param[0]).val()) >= parseFloat(value)) {
                    return false;
                }
                return true;
            },
            message: '下次保养里程应大于当前里程'
        },
        alphanumericQ: {
            validator : function(value) {
                return /^[^\u4e00-\u9fa5]{2,32}$/i.test(value);
            },
            message : '只能输入字母与数字(2~32)!'
        },
        englishCheckSub : {
            validator : function(value) {
                return /^[a-zA-Z0-9]+$/.test(value);},
            message : "只能包括英文字母、数字"
        }

    });
})(jQuery);