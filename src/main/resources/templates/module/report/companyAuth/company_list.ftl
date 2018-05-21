<div id="table_com" name="datagrid" style="width: 90%;height: 100%"></div>
<script>
    $('#table_com').datagrid({
        url: '/companyAuth/test_data',
        sortName: "createTime",
        sortOrder: "desc",
        columns: [[
            {title: '车架号（VIN）', field: 'name', sortable: "true"},
            {title: 'ICCID', field: 'dictField',  sortable: "true"},
            {title: '随机码', field: 'nameField', sortable: "true"},
            {title: '导入结果', field: 'createBy',  sortable: "true"},
            {title: '失败原因', field: 'createTime', sortable: "true"},
        ]],
        pagination: true,
        nowrap: true
    });
</script>

