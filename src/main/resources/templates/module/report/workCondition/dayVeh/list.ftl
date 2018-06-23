
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <#include "../../../../inc/meta.ftl">
    <#include  "../../../../inc/js.ftl">
    <script>
        $(function (){
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
                            height: (tdNum>9?2:1)*50 + 75
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
        });
    </script>
    <style type="text/css">
        .td_input a:not(.bg_button) {
            right: 20px !important;
        }
    </style>
</head>
<body class="easyui-layout" fit="true" id="fullid">
<div region="center" style="overflow: hidden; width: 100%;height: 300px;">
    <div id="toolbar" style="padding:5px" class="cg-moreBox">
        <@shiro.hasPermission name="/report/demo1/export">
            <a href="#" onclick="exportData()" class="easyui-linkbutton"
                data-options="iconCls:'icon-export'" menu="0">导出</a>
        </@shiro.hasPermission>
        <a href="#" onclick="reportSpecification()" data-options="iconCls:'icon-export'" menu="0" style="float: right;margin-top:6px;margin-right: 100px">报表说明</a>
    </div>
    <div id="table" name="datagrid" style="width: 100%;height: 100%"></div>
</div>
<div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 130px">
    <div style="width: 100%;border: 1;margin:5 5 5 10 ">
        <form id="form_search" name="" class="sui-form cg-form">
            <div style="width: 90%; height: 20px; margin: 10px;">
                <label>条件查询</label>
                <input type="radio" id = "condition" name="query.adminFlag" onclick="operationtd(true)"  checked="checked"  value="0" ></input>
                <label>导入查询</label>
                <input type="radio" id = "import" name="query.adminFlag" value="1" onclick="operationtd(false)" ></input>
            </div>
            <table class="table_search" style="height: 90px;">
                <tr>
                    <td class="td_label" id="fileButton">
                        <label>文件上传:</label>
                    </td>
                    <td class="td_input" id="fileShow">
                        <input type="file" id="file" style="height: 30px; width: 168px;" name="myfile" />
                    <#--<input type="button" onclick="UpladFile()" value="文件解析" />-->
                    </td>

                    <td class="td_label">
                        <label>查询时间:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" name="query.startTime" id="startTime" style="height: 30px; width: 168px" value="${(startTime)!}" class="easyui-datebox" autocomplete="off" data-options="editable:false"/>
                    </td>

                    <td class="td_label" style="text-align: center;">
                        <label>至</label>
                    </td>
                    <td class="td_input">
                        <input type="text" name="query.endTime" id="endTime" style="height: 30px;width: 168px" value="${(endTime)!}" class="easyui-datebox" autocomplete="off" data-options="editable:false"/>
                    </td>

                    <td class="td_label" style="text-align: center;">
                        <label>车牌号:</label>
                    </td>
                    <td class="td_input">
                        <input id="licensePlate" type="text"class="input-fat input" style="width:150px;"   name="query.licensePlate"  autocomplete="off" >
                    </td>

                    <td class="td_label" style="text-align: right">
                        <label>VIN:</label>
                    </td>

                    <td class="td_input">
                        <input id="vin" type="text"class="input-fat input" style="width:150px;"   name="query.vin"  autocomplete="off" >
                    </td>
                    <td class="td_label">
                        <label>车辆种类:</label>
                    </td>
                    <td class="td_input">
                        <input id="vehTypeId" name="query.vehTypeId" style="width: 168px;" />
                    </td>

                    <td class="td_label">
                        <label>车型型号:</label>
                    </td>
                    <td class="td_input">
                        <input id="vehModelName" name="query.vehModelName" editable="false" style="width: 168px;" />
                    </td>

                    <td class="td_label">
                        <label>运营单位:</label>
                    </td>
                    <td class="td_input">
                        <input id="useUintId" name="query.useUintId" style="width: 168px;" />
                    </td>

                    <td class="td_label">
                        <label>上牌区域:</label>
                    </td>
                    <td class="td_input">
                        <input id="sysDivisionId" name="query.sysDivisionId" style="width: 168px;" />
                    </td>

                <#--<td class="td_label" id="fileButton">-->
                <#--<label>文件上传</label>-->
                <#--</td>-->
                <#--<td class="td_input" id="fileShow">-->
                <#--<input type="file" id="file" style="width: height: 26px;width:120px;" name="myfile" />-->
                <#--<input type="button" onclick="UpladFile()" value="文件解析" />-->
                <#--</td>-->

                <#--<td class="td_input" id="fileDown"  >-->
                <#--<input type="button" onclick="downFile()" value="导入查询模板下载" />-->
                <#--</td>-->

                <#--<td style="vertical-align: center;text-align: right;border: 1px" class="cg-btnGroup">-->
                <#--<a href="#" onclick="searchButton()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>-->
                <#--<a href="#" onclick="resetButton()" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>-->
                <#--</td>-->

                    <td style="vertical-align: center;text-align: right;border: 1px" class="cg-btnGroup">
                        <a href="#" onclick="searchButton()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
                        <a href="#" onclick="resetButton()" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>
                    <#--<a href="#" id="impQuery" onclick="importSeach()" data-options="iconCls:'icon-reset'">导入查询</a>-->
                        <a href="#" onclick="downFile()" id = "downLadfile" data-options="iconCls:'icon-reset'">导入查询模板下载</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>

<div id="report" class="easyui-window" title="报表说明" style="width:853px;height:600px; display: none;" data-options="modal:true,closed:true">
    <div class="easyui-layout">
        <table class="easyui-datagrid">
            <thead>
            <tr>
                <th data-options="field:'code', width: 160, resizable: true">名称</th>
                <th data-options="field:'name', width: 700, resizable: true">定义</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>日活跃总时间(h)</td><td>有实时数据上传的车辆为活跃车辆，单车单日实时数据上传总时长；<br />
                排除自动唤醒的时间。<br />
                自动唤醒判断：如上传了整车数据中的电池总电流和总电压，则视为非自动唤醒。</td>
            </tr>
            <tr>
                <td>日总行驶时间(h)</td><td>车辆活跃且速度大于等于0；排除自动唤醒时间；时间累加；</td>
            </tr>
            <tr>
                <td>日行驶次数</td><td>以点火/熄火为一次完整行驶，部分车辆因熄火时，登出指令丢失，<br />
                系统判定若车辆超过连续10包无任何数居不上传（约250秒），判定为熄火；次数累加</td>
            </tr>
            <tr>
                <td>日总行驶里程(Km)</td><td>当日行驶里程总和</td>
            </tr>
            <tr>
                <td>单次运行最大里程(Km)</td><td>每次行驶，里程最大值</td>
            </tr>
            <tr>
                <td>当日累计耗电量</td><td>终端直接上传累计耗电量，当日累计耗电量=今日最后耗电量-昨日最后耗电量；</td>
            </tr>
            <tr>
                <td>实际百公里耗电量</td><td>当天耗电量/当天行驶里程*100</td>
            </tr>
            <tr>
                <td>百公里额定耗电量</td><td>整车参数与配置，固定参数</td>
            </tr>
            <tr>
                <td>单次充电后最大耗电量(Kw.h)</td><td>当日n次充电过程中，因车辆运行产生电量消耗，<br />
                两次充电之间，最大的耗电量的差值，如果当天只充1次电，那么该值就是当日累计耗电；<br />
                1、上传的电量是剩余电量；<br />
                2、如果当天没有充电，以2个0点之间的差值计算；<br />
                3、当天充电了未行驶，计算结果为负数，归为0</td>
            </tr>
            <tr>
                <td>充电总次数</td><td>由充电状态（只含停车充电，排除能量回收发生的充电状态）转变为未充电计为1次充电；充电次数累加</td>
            </tr>
            <tr>
                <td>充电总时长</td><td>当日每次充电的充电状态持续时长累计；充电时长累加</td>
            </tr>
            <tr>
                <td>单次最长充电时间（h）</td><td>每次充电中，充电状态持续时间最长的一次；</td>
            </tr>
            <tr>
                <td>单次充电最大行驶里程</td><td>两次充电之间每次行驶中行驶里程数值最大</td>
            </tr>
            <tr>
                <td>日最高速度(Km/h)</td><td>上传速度最大值</td>
            </tr>
            <tr>
                <td>日均行驶速度(Km/h)</td><td>日平均速度，（当日总里程）/车辆行驶时间</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
<script>
    $(function(){
        //初始化条件数据
        initSelectChoose();
        document.getElementById("fileButton").style.display = "none";
        document.getElementById("fileShow").style.display = "none";
        document.getElementById("downLadfile").style.display = "none";
    });

    //序列化搜索条件
    var queryParams = $('#form_search').serializeObject();

    //重置使用参数对象(暂时存储初次加载的数据，用于重置事件)
    var resetQueryParams = queryParams;

    //重置
    function resetButton(){
        identity = "";
        var startTimeTemp = "${startTime}";
        var endTimeTemp = "${endTime}";
        $("#startTime").datebox("setValue",startTimeTemp);
        $("#endTime").datebox("setValue",endTimeTemp);
        //初始化条件
        initSelectChoose();
        //bug修改：清空车牌号和vin
        $("#licensePlate").val("");
        $("#vin").val("");
        $("#file").val("");
        $('#table').datagrid("load", resetQueryParams);
    }
    <#--$('#table').datagrid({-->
        <#--url: '${base}/report/demo1/datagrid',-->
        <#--sortName: "createTime",-->
        <#--sortOrder: "desc",-->
        <#--columns: [[-->
            <#--{field: 'ck', checkbox: true, width: '20'},-->
            <#--{field: 'name', title: '名称'},-->
            <#--{field: 'dictField', title: '字典值'},-->
            <#--{field: 'nameField', title: '名称值'},-->
            <#--{field: 'createTime', title: '创建时间'},-->
            <#--{field: 'createBy', title: '创建人'},-->
            <#--{field: 'updateTime', title: '更新时间'},-->
            <#--{field: 'updateBy', title: '更新人'},-->
        <#--]],-->
        <#--toolbar: "#toolbar",-->
        <#--pagination: true,-->
        <#--nowrap: true-->

    <#--});-->

    $('#table').datagrid({
        url:'${base}/report/workCondition/dayVeh/datagrid',
        sortName: "lastCommunTime",
        sortOrder: "desc",
        queryParams: queryParams,
        columns:[[
            // {field: 'ck', checkbox: true, width: '20'},
            {field:'number',title:'序号',align:'center',halign:'center',
                formatter:function(value,row,index){
                    if(value == null){
                        return index+1;
                    }
                }},
            {field:'reportDate',title:'日期',align:'center',halign:'center'},
            {field:'licensePlate',title:'车牌号',align:'center',halign:'center'},
            {field:'vin',title:'VIN',align:'center',halign:'center'},
            {field:'vehTypeId',title:'车辆种类',align:'center',halign:'center'},
            {field:'vehModelName',title:'车型型号',align:'center',halign:'center'},
            {field:'modelNoticeId',title:'公告号',align:'center',halign:'center'},
            {field:'termPartFirmwareNumbers',title:'终端零件号',align:'center',halign:'center'},
            {field:'termBarCode',title:'条形码编码',align:'center',halign:'center'},
            {field:'termVendorCode',title:'终端厂商自定义编号',align:'center',halign:'center'},
            {field:'manuUnitId',title:'车辆厂商',align:'center',halign:'center'},
            {field:'useUintId',title:'运营单位',align:'center',halign:'center'},
            {field:'sysDivisionId',title:'上牌区域',align:'center',halign:'center'},
            {field:'entryDate',title:'激活时间',align:'center',halign:'center'},
            {field:'saleTime',title:'销售日期',align:'center',halign:'center'},
            {field:'dailyActiveTotalTime',title:'日活跃总时间（h）',align:'center',halign:'center'},
            {field:'runTimeSum',title:'日总行驶时间（h）',align:'center',halign:'center'},
            {field:'runTimes',title:'日行驶次数',align:'center',halign:'center'},
            {field:'runKm',title:'日总行驶里程（km）',align:'center',halign:'center'},
            {field:'runKmMax',title:'单次运行最大里程（km）',align:'center',halign:'center'},
            {field:'lastMeterMileage',title:'总里程',align:'center',halign:'center'},
            {field:'lastGpsMileage',title:'GPS总里程',align:'center',halign:'center',
                formatter:function(value,row,index){
                    if(value == null){
                        return "-";
                    }
                }},
            {field:'chargeConsume',title:'当日累计耗电量（kw.h）',align:'center',halign:'center',
                formatter:function(value,row,index){
                    if(value == null){
                        return "-";
                    }
                }},
            {field:'chargeCon100km',title:'实际百公里耗电量',align:'center',halign:'center',
                formatter:function(value,row,index){
                    if(value == null){
                        return "-";
                    }
                }},
            {field:'statedCharge_con100km',title:'百公里额定耗电量',align:'center',halign:'center',
                formatter:function(value,row,index){
                    if(value == null){
                        return "-";
                    }
                }},
            {field:'chargeSconsumeMax',title:'单次充电后最大耗电量（kw.h）',align:'center',halign:'center',
                formatter:function(value,row,index){
                    if(value == null){
                        return "-";
                    }
                }},
            {field:'chargeTimes',title:'充电总次数',align:'center',halign:'center'},
            {field:'fastTimes',title:'快充次数',align:'center',halign:'center',
                formatter:function(value,row,index){
                    if(value == null){
                        return "-";
                    }
                }},
            {field:'lowTimes',title:'慢充次数',align:'center',halign:'center',
                formatter:function(value,row,index){
                    if(value == null){
                        return "-";
                    }
                }},
            {field:'chargeTimeSum',title:'充电总时长',align:'center',halign:'center'},
            {field:'chargeTimeMax',title:'单次最长充电时间（h）',align:'center',halign:'center'},
            {field:'singleChargeMaxMileage',title:'单次充电最大行驶里程',align:'center',halign:'center'},
            {field:'runSpeedMax',title:'日最高速度（km/h）',align:'center',halign:'center'},
            {field:'runSpeedAvg',title:'日平均速度（km/h）',align:'center',halign:'center'},
            {field:'lastCommunTime',title:'数据最后上传时间',align:'center',halign:'center'},
        ]],
        toolbar:"#toolbar",
        pagination:true,
        nowrap:true
        // rownumbers: true
    });

    toolbar2Menu("table");
    $("#table").datagrid({

        onRowContextMenu: function (e, rowIndex, rowData) { //右键时触发事件
            e.preventDefault(); //阻止浏览器捕获右键事件
            $(this).datagrid("clearSelections"); //取消所有选中项
            $(this).datagrid("selectRow", rowIndex); //根据索引选中该行
            $('#contextMenu_jygl').menu('show', {
                left: e.pageX,//在鼠标点击处显示菜单
                top: e.pageY
            });
            e.preventDefault();  //阻止浏览器自带的右键菜单弹出
        },

    })
</script>
<script language="javascript" charset=”utf-8″>

    var identity = "";
    function checkTime(){
        //时间校验
        var endTime = $('#endTime').datetimebox("getValue");
        var startTime = $('#startTime').datetimebox("getValue");
        endTime = new Date(endTime);
        startTime = new Date(startTime);
        if (endTime < startTime) {
            $.messager.alert('提示','开始时间必须小于结束时间！');
            return false;
        }
        if (endTime < startTime) {
            $.messager.alert('提示','结束时间必须大于开始时间！');
            return false;
        }
        var startTimeFormat = startTime.Format("yyyy-MM-dd");
        var endTimeFormate = endTime.Format("yyyy-MM-dd");
        var days = (new Date(endTimeFormate).getTime() - new Date(startTimeFormat).getTime()) / 86400000;
        if (days > 30){
            $.messager.alert('提示','选择开始时间与结束时间间隔最大为30天！');
            return false;
        }
        return true;
    }
    /*查询事件*/
    function searchButton(){
        var val=$('input:radio[id="import"]:checked').val();
        if(val == 1){
            importSearchButton();
        }else {
            identity = "";
            if (checkTime()) {
                //请求查询
                searchDatagrid('form_search','table');
            }
        }
    }
    // /*查询事件*/
    // function searchButton(){
    //     if (!checkTime()) {
    //         return;
    //     }
    //     var val=$('input:radio[id="import"]:checked').val();
    //     //var valaaa=$('input:radio[id="daoru"]:checked').val();
    //     if(val == 1){
    //         var file = document.getElementById("file").files[0];
    //         //if（true）
    //         if (fileCheck(file)) {
    //             UpladFile();
    //         }
    //         searchDatagrid('form_search','table');
    //     }else {
    //         // console.log("wedsaaaaaaaaaaaae")
    //         //请求查询
    //         searchDatagrid('form_search','table');
    //     }
    // }

    /**
     * 初始化下拉选择框
     */
    function initSelectChoose() {
        //上牌区域
        $('#sysDivisionId').combotree({
            url: '${base}/report/workCondition/dayVeh/queryAreaList'
        });
        //运营单位
        $('#useUintId').combotree({
            url: '${base}/report/workCondition/dayVeh/queryUnitList'
        });
        //车辆型号
        $('#vehModelName').combobox({
            url: '${base}/report/workCondition/dayVeh/queryVehModelList',
            valueField: 'id',
            textField: 'text'
        });
        //车辆种类
        $('#vehTypeId').combotree({
            url: '${base}/report/workCondition/dayVeh/queryVehTypeList'
        });
    }


    /***
     * 文件解析
     * @constructor
     */
    function UpladFile() {
        var fileObj = document.getElementById("file").files[0]; // 获取文件对象

        var FileController = "${base}/report/workCondition/dayVeh/fileMin";                    // 接收上传文件的后台地址

        // FormData 对象

        var form = new FormData();

        form.append("author", "hooyes");                        // 可以增加表单数据

        form.append("file", fileObj);                           // 文件对象
        // XMLHttpRequest 对象

        var xhr = new XMLHttpRequest();

        xhr.open("post", FileController, true);

        xhr.onload = function (data) {

        };
        xhr.send(form);
        xhr.onreadystatechange =function(){
            if (xhr.readyState == 4){
                // alert(xhr.responseText);
                var data =  eval("("+xhr.responseText+")");

                if (data.code == 0) {
                    $.messager.show({
                        title:'文件解析结果',
                        msg:'解析成功.',
                        timeout:2000,
                        showType:'slide'
                    });
                } else {
                    $.messager.show({
                        title:'文件解析结果',
                        msg:'解析失败.',
                        timeout:2000,
                        showType:'slide'
                    });
                }
            }
        }

    }

    /*模板下载*/
    function downFile() {
        var downUrl = "${base}/report/common/downLoadModel?moduleName=model&fileName=templateQuery.xls";
        window.open(downUrl);
    }

    /*报表说明弹框*/
    function reportSpecification(){
        $('#report').window("open");
    }


    //导入查询弹窗口
    function importSeach(){
        $('#win').window('open');
    }

    //导入查询弹窗查询事件
    function importSearchButton(){
        if (!checkTime()) {
            return;
        }
        var formData = new FormData($( "#form_search" )[0]);//新建一个类似表单的对象
        var file = document.getElementById("file").files[0];//获取文件对象
        if (fileCheck(file)) {
            formData.append("file",file);//在表单对象后面插入文件对象,第二个参数是文件对象

            //importType 导入查询标识，用于区分SQL拼接
            formData.append("identity", "importType");
            identity = "importType";
            $.ajax({
                url : "${base}/report/workCondition/dayVeh/improtSearch",
                type : 'POST',
                data : formData,//规定连同请求发送到服务器的数据
                async : false,
                cache : false,
                contentType : false,
                processData : false,
                success : function(data) {
                    if (data.code == 0) {//‘0’代表调用成功执行方法
                        var loadData = data.message.length == 0 ? {} :$.parseJSON(data.message);//controller查询到的数据返回给loadDate，通过datagrid加载显示在页面
                        $('#table').datagrid('loadData', loadData);
                        $('#win').window('close');
                        $.messager.alert('提示','查询成功！');
                    } else {
                        $.messager.alert('提示',data.message);
                    }
                },
                error : function(data) {
                    $.messager.alert('提示','请求系统失败！！');
                }
            });
        }
    }

    /**
     * 检验文件的格式
     * @param file
     */
    function fileCheck(file){
        if (file == undefined || file == null || file == "") {
            $.messager.alert('提示','请选择导入查询文件！');
            return false;
        }
        if (file.size > 10240 * 1024) {
            $.messager.alert('提示','文件大小超出最大为10M限制！');
            return false;
        }
        var fileName = file.name;
        var suffixName = (fileName.substr(fileName.lastIndexOf("."))).toLowerCase();
        if (suffixName != ".xls" && suffixName != ".xlsx") {
            $.messager.alert('提示','上传文件格式不正确，确认文件后缀名为xls、xlsx！');
            return false;
        }
        return true;
    }


    /*导出功能*/
    function exportData() {
        //校验开始结束时间是否合法
        if (!checkTime()) {
            return;
        }

        //普通的导出
        if (identity == "") {
            exportDatagrid('${base}/report/workCondition/dayVeh/export', 'form_search', 'table');
        }
        //导入查询后的导出
        if (identity == "importType") {
            var xhh = new XMLHttpRequest();
            var formData = new FormData($("#form_search")[0]);
            var file = document.getElementById("file").files[0];

            if (fileCheck(file)) {
                formData.append("file", file);
                //importType 导入查询标识，用于区分SQL拼接
                formData.append("identity", "importType");
                xhh.response
                xhh.open("post", "${base}/report/workCondition/dayVeh/importExport");
                xhh.responseType = 'blob';
                xhh.onreadystatechange = function () {
                    if (xhh.readyState === 4 && xhh.status === 200) {
                        var name = xhh.getResponseHeader("Content-disposition");
                        var contentType = xhh.getResponseHeader("Content-type");
                        console.log("name:" + name + "==" + contentType);
                        var dataStr = new Date().Format("yyyyMMddhhmmss");
                        var filename = name.substring(20, name.length);
                        var blob = new Blob([xhh.response], {type: 'text/xls'});
                        var csvUrl = URL.createObjectURL(blob);
                        var link = document.createElement('a');
                        link.href = csvUrl;
                        var suf = checkSuffixes(contentType);
                        link.download = "单车日报表-" + dataStr + suf;
                        link.click();
                    }
                };
                xhh.send(formData);
            }
        }
    }

    /**
     * 判断文件后缀名
     * @param suffixesName
     * @returns {*}
     */
    function checkSuffixes(suffixesName) {
        if (suffixesName.indexOf("zip") > 0) {
            return ".zip";
        }
        if (suffixesName.indexOf("x-excel") > 0) {
            return ".xls";
        }
    }
    function   operationtd(nub) {
        if (nub) {
            $("#fileButton").hide();
            $("#fileShow").hide();
            $("#downLadfile").hide();
        } else {
            $("#fileButton").show();
            $("#fileShow").show();
            $("#downLadfile").show();
        }

    }
    // $("#condition").change(function() {
    //     //$("#daoruchaxun").hide();
    //     $("#fileButton").hide();
    //     $("#fileShow").hide();
    //     $("#downLadfile").hide();
    // });
    //
    // $("#import").change(function() {
    //     //$("#daoruchaxun").show();
    //     $("#fileButton").show();
    //     $("#fileShow").show();
    //     $("#downLadfile").show();
    // });

</script>
</html>