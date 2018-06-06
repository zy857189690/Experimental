
/**
 * 公共常用JS
 */
$.fn.serializeObject = function () {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function () {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

/**
 * 弹出窗口
 */
function openModuleWin(winid, title, url, width, height) {
    my_window(winid, title, url, width, height);
}

/**
 * 新增窗口
 */
function openAddDataWin(winid, title, url, width, height, gridId) {
    openModuleWin(winid, url, title, width, height);
}

/**
 * 查看窗口
 */
function openViewDataWin(winid, title, url, width, height, gridId, id) {
    if ('' == id || id == undefined) {
        var row = $("#" + gridId).datagrid("getSelections");
        if (row != null && row.length == 1) {
            id = row[0].id;
        } else {
            alert("请选择单条记录！");
            return;
        }
    }
    url += ('?id=' + id);
    console.log(url);
    openModuleWin(winid, url, title, width, height);
}

/**
 * 编辑窗口
 */
function openUpdateDataWin(winid, title, url, width, height, gridId) {
    if ('' == id || id == undefined) {
        var row = $("#" + gridId).datagrid("getSelections");
        if (row != null && row.length == 1) {
            id = row[0].id;
        } else {
            alert("请选择单条记录！");
            return;
        }
    }
    openModuleWin(id, url, title, width, height);
}

/**
 * 删除记录
 */
function delRecord(title, url, gridId) {
    var rows = $("#" + gridId).datagrid("getSelections");
    if (rows != null && rows.length != 0) {
        var ids = "";
        for (var i = 0; i < rows.length; i++) {
            ids += rows[i].id;
            if (i != (rows.length - 1))
                ids += ","
        }
        $.messager.confirm('删除提示', '您确定要删除所选' + title + "?", function (r) {
            if (r) {
                $.ajax({
                    url: url,
                    type: "post",
                    data: {ids: ids},
                    dataType: 'json',
                    success: function (data) {
                        $.messager.alert("提示", data.message, 'info', function () {
                            $("#" + gridId).datagrid("reload");
                        });
                    }
                });
            }
        });
    } else {
        alert("请选择记录！");
        return;
    }
}

/**
 * 查询
 * @param formId
 * @param gridId
 */
function searchDatagrid(formId, gridId) {
    var searchParames = $('#' + formId).serializeObject();
    $("#" + gridId).datagrid("load", searchParames);
}

/**
 * 重置
 * @param formId
 * @param gridId
 */
function resetDatagrid(formId, gridId) {
    document.getElementById(formId).reset();
    $("#" + formId + " .textbox-value").val("");
    $("#" + formId + " .select2").select2().select2("val", "");
    $("#" + formId).form("reset");
    $("#" + formId + " input[type='hidden']").val("");
    searchDatagrid(formId, gridId);
}

/**
 * 导出
 * @param url
 * @param formId
 * @param gridId
 */
function exportDatagrid(url, formId, gridId) {
    if (formId == undefined || formId == null) {
        formId = "form_search";
    }
    var myUrl = url;
    var searchParames = $('#' + formId).serializeObject();
    var rows = $("#" + gridId).datagrid("getSelections");
    if (rows != null && rows.length != 0) {
        var ids = "";
        for (var i = 0; i < rows.length; i++) {
            ids += rows[i].id;
            if (i != (rows.length - 1))
                ids += ","
        }
    }
    searchParames['query.ids'] = ids;
    myUrl += '?exportId=' + new Date().getTime();
    for (var key in searchParames) {
        var value = searchParames[key];
        if (value != "") {
            myUrl += ("&" + key + "=" + value);
        }
    }
    window.open(myUrl, '_blank');
}

