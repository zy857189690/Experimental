<script language="JavaScript">
    $(function(){
    });

    /**
     * 弹出窗口，主要用在弹出选择框
     * @param url
     * @param width
     * @param heiht
     * @param nameId 显示文本框ID
     */
    var selObj;
    var li;
    var dialogVars = {};
    function openSelectDialog(obj, title, url, width, height, extData) {
        console.log(7);
        $('#selectDlg').html("");
        dialogVars = {};

        selObj = obj;

        var nameId = $(obj).attr("id");
        if (nameId == "") {
            alert("显示文本框的ID不能为空");
            return;
        }
        var val = "";
        if($(selObj).nextAll().length>1){
            val = $(obj).siblings('input[type="hidden"]').val();
        }else{
            val = $(obj).val();
        }
        var w = width + "px";
        var h = height + "px";
        var u = '';

        if (extData == undefined) {
            extData = {};
        }
        extData['val'] = val;
        dialogVars = extData;

        $('#selectDlg').dialog({
            title: title,
            width: width,
            height: height,
            closed: false,
            cache: false,
            href: url,
            modal: true,
            onLoad: function () {
                initLoad(extData);
            }
        });

    }

    /**
     *
     * @param obj
     * @param title
     * @param url
     * @param width
     * @param height
     * @param extData
     */
    function openHomeSelectDialog(obj, title, url, width, height, extData) {

        $('#selectDlg').html("");
        dialogVars = {};

        selObj = obj;

        var nameId = $(obj).attr("id");
        if (nameId == "") {
            alert("显示文本框的ID不能为空");
            return;
        }
        var val = "";
        if($(selObj).nextAll().length>1){
            val = $(obj).siblings('input[type="hidden"]').val();
        }else{
            val = $(obj).val();
        }
        var w = width + "px";
        var h = height + "px";
        var u = '';

        if (extData == undefined) {
            extData = {};
        }
        extData['val'] = val;
        dialogVars = extData;

        $('#selectDlg').dialog({
            title: title,
            width: width,
            height: height,
            closed: false,
            cache: false,
            href: url,
            modal: true,
            onLoad: function () {
                initLoad();
            }
        });

    }

    /**
     *
     *  @param obj
     *  @param title
     *  @param url
     *  @param width
     *  @param height
     *  @param extData
     */
    function openSelectEDialog(obj, title, url, width, height, extData) {
        $('#selectDlg').html("");
        dialogVars = {};

        selObj = obj;

        var nameId = $(obj).attr("id");
        if (nameId == "") {
            alert("显示文本框的ID不能为空");
            return;
        }
        var val = $(obj).next().val();

        var w = width + "px";
        var h = height + "px";
        var u = '';

        if (extData == undefined) {
            extData = {};
        }
        extData['val'] = val;
        dialogVars = extData;

        $('#selectDlg').dialog({
            title: title,
            width: width,
            height: height,
            closed: false,
            cache: false,
            href: url,
            modal: true,
            onLoad: function () {
                initLoad(extData);
            }
        });

    }

    /****
     *
     * @param obj
     * @param title
     * @param url
     * @param width
     * @param height
     * @param extData
     * **/
    function openVehicleSelectDialog(obj, title, url, width, height, extData) {
        $('#selectDlg').html("");
        selObj = obj;
        var nameId = $(obj).attr("id");
        if (nameId == "") {
            alert("显示文本框的ID不能为空");
            return;
        }
        $('#selectDlg').dialog({
            title: title,
            width: width,
            height: height,
            closed: false,
            cache: false,
            href: url,
            modal: true,
            onLoad: function () {
                initLoad(extData);
            }
        });
    }

    /**
     *
     * @param name
     * @param val
     * */
    function confirmSelect(name, val) {
        $(selObj).val(name);
        //配合弹出框改造，重置取值位置 add by yuexw 2017年4月28日
        if($(selObj).nextAll().length>1){
            $(selObj).siblings('input[type="hidden"]').val(val).change();
        }else{
            $(selObj).next().val(val).change();
        }
        $('#selectDlg').dialog("close");
        $('#selectDlg').html("");

    }

    /**
     * @param name1
     * @param val1
     * @param name2
     * @param val2
     * @param name3
     * @param val3
     * **/
    function confirmVehicleSelect(name1, val1, name2, val2, name3, val3) {
//        $("#manuUnitName").val(name1);
//        $("#manuUnitId").val(val1);
//        $("#vehModelName").val(name2);
//        $("#vehModelId").val(val2);
//        $("#batchName").val(name3);
//        $("#batchId").val(val3);
//        $(selObj).val(name);
        var val = name1 + "," + val1 + "," + name2 + "," + val2 + "," + name3 + "," + val3;
        if($(selObj).nextAll().length > 1){
            //配合弹出框改造，重置取值位置 add by yuexw 2017年4月27日
            $(selObj).siblings('input[type="hidden"]').val(val).change();
        }else{
            $(selObj).next().val(val).change();
        }
        $('#selectDlg').dialog("close");
        $('#selectDlg').html("");

    }

    /**
     * @param key
     * */
    function getDialogVar(key) {
        return dialogVars[key];
    }

    /**
     * @param obj
     * */
    function clearInputValue(obj) {
        $(obj).prev().val("");
        if ($(obj).next().length > 0) {
            $(obj).next().val("");
        }
    }

    /**
     *  @param data
     *  @param val
     * */
    function isSelect(data, val) {
        for (var i = 0; i < data.length; i ++) {
            if (data[i]['id'] == val) {
                return true;
            } else if (null != data[i]['children'] && data[i]['children'].length > 0) {
                if (isSelect(data[i]['children'], val)) {
                    return true;
                }
            }
        }
        return false;
    }

    /**存储dialog窗口的返回的数据*/
    var resData;

    /**赋值dialog数据*/
    function setDialogResData(data){
        resData = data;
    }

    /**获取dialog数据*/
    function getDialogResData(){
        return resData;
    }
</script>


<div id="selectDlg" ></div>
