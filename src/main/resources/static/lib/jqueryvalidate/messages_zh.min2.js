/*! jQuery Validation Plugin - v1.13.1 - 10/14/2014
 * http://jqueryvalidation.org/
 * Copyright (c) 2014 Jörn Zaefferer; Licensed MIT */
! function (a) {
    "function" == typeof define && define.amd ? define(["jquery", "jquery.validate.min"], a) : a(jQuery)
}(function (a) {
    var icon = "<i class='fa fa-times-circle'></i>  ";
    a.extend(a.validator.messages, {
        required: icon + "<span style='color: red;top: auto'> *必选</span>",
        remote: icon + "<span style='color: red;top: auto'> *请修正此栏位</span>",
        email: icon + "<span style='color: red;top: auto'> *请输入有效的电子邮件</span>",
        url: icon + "<span style='color: red;top: auto'> *请输入有效的网址</span>",
        date: icon + "<span style='color: red;top: auto'> *请输入有效的日期</span>",
        dateISO: icon + "<span style='color: red;top: auto'> *请输入有效的日期 (YYYY-MM-DD)</span>",
        number: icon + "<span style='color: red;top: auto'> *请输入正确的数字</span>",
        digits: icon + "<span style='color: red;top: auto'> *只能输入数字</span>",
        creditcard: icon + "<span style='color: red;top: auto'> *请输入有效的信用卡号码</span>",
        equalTo: icon + "<span style='color: red;top: auto'> *你的输入不相同</span>",
        extension: icon + "<span style='color: red;top: auto'> *请输入有效的后缀</span>",
        maxlength: a.validator.format(icon + "<span style='color: red;top: auto'> *最多 {0} 个字</span>"),
        minlength: a.validator.format(icon + "<span style='color: red;top: auto'> *最少 {0} 个字</span>"),
        rangelength: a.validator.format(icon + "<span style='color: red;top: auto'> *请输入长度为 {0} 至 {1} 之间的字串</span>"),
        range: a.validator.format(icon + "<span style='color: red;top: auto'> *请输入 {0} 至 {1} 之间的数值</span>"),
        max: a.validator.format(icon + "<span style='color: red;top: auto'> *请输入不大于 {0} 的数值</span>"),
        min: a.validator.format(icon + "<span style='color: red;top: auto'> *请输入不小于 {0} 的数值</span>")
    })
});
