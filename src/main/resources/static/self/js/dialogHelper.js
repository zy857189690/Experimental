/**
 * Created by chenp on 2016-11-20.
 */


/**
 * 获取url参数里的参数值
 * @param name
 * @returns {null}
 * @constructor
 */
function getQueryString(name) {

    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null)return unescape(r[2]);
    return null;
}

/**
 * 给控件赋值
 * @param name
 * @param val
 */


function closeCurLayWin() {
    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    parent.layer.close(index);
}
