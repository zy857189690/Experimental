
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<#include "../../../../inc/meta.ftl">
<#include "../../../../inc/js.ftl">
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

        function timestampToTime(timestamp) {
            var date;
            if(timestamp.toString().length >11){
                date = new Date(timestamp);
            }else {
                date = new Date(timestamp * 1000);
            }
            //时间戳为10位需*1000，时间戳为13位的话不需乘1000
            Y = date.getFullYear() + '-';
            M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
            D = date.getDate() + ' ';
            h = date.getHours() + ':';
            m = date.getMinutes() + ':';
            s = date.getSeconds();
            return Y+M+D+h+m+s;
        }

    </script>
    <style type="text/css">
        .td_input a:not(.bg_button) {
            right: 20px !important;
        } "
        .td_label text-align: right;
    </style>
</head>
<body class="easyui-layout" fit="true" id="fullid">
<div id="report" class="easyui-window" title="列表说明" style=" overflow:scroll; width:853px;height:100%;display: none" data-options="modal:true,closed:true">
    <div class="easyui-layout">
        <table class="easyui-datagrid">
            <thead>
            <tr>
                <th data-options="field:'code'" style="width: 167px">名称</th>
                <th data-options="field:'name'" style="width: 731px">定义</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>统计日期</td><td>

                报表以日报的方式生成，每天凌晨3点生成前一天的统计日报，每辆车每天生成一条数据，统计日期（显示前一天的日期）<br />是日报统计的时间维度——（0~24点）；<br />

                特殊情况：如因政策、业务需求变化等原因导致算法调整，系统将清楚原算法生成的日报，重新根据新算法生成每辆车的日报；
            </td>
            </tr>
            <tr>
                <td> 当日首次上线时间  </td><td>统计日期内，T-BOX第一次上线时间，格式HH：MM：SS（24小时制）</td>
            </tr>
            <tr>
                <td>当日开始里程</td><td>当日首次上线时间对应的车辆仪表里程；</td>
            </tr>
            <tr>
                <td>当日最后通讯时间</td><td>统计日期内，T-BOX最后一次向平台发送实时数据的时间，格式HH：MM：SS（24小时制）</td>
            </tr>
            <tr>
                <td>当日结束里程</td><td>当日最后通讯时间对应的车辆仪表里程；</td>
            </tr>
            <tr>
                <td>核查数据总条数</td><td>统计日期内车辆上传总数据条数，包括有效、无效、异常</td>
            </tr>
            <tr>
                <td>含无效数据条数</td><td> 里程核查数据无效检测是对GB/T 32960.3-2016 中7.2.3.1 整车数据及7.2.3.5 车辆位置数据进行<br />数据无效检测，具体检测内容为GB/T 32960.3-2016 中的0xff。</td>
            </tr>
            <tr>
                <td> 含异常数据条数 </td><td>请注意：在进行数据项异常判定之前，系统已经进行了数据项有效性判断；<br />

                里程核查数据异常检测是GB/T 32960.3中 7.2.3.1 7.2.3.1整车数据及GB/T 32960.3 -2016 中 7.2.3.5 <br />车辆未知数据进行数据异常检测，具体形式项目为：<br />

                （1）车辆状态 ∈[1 ,2,3 ]<br />

                （2）车速 ∈[0,200)<br />

                （3）里程 ∈[上线开始里程,上线结束里程 ]<br />

                （4）总电压 ∈(0,1000]<br />

                （5）总电流 ∈[总电流均值 -100, 总电流均值 +100]<br />

                （6）SOC ∈（0,100]<br />

                （7）定位状态 ∈[0]<br />

                （8）经度 ∈(73,135)<br />

                （9）纬度 ∈(4,53)<br />

                说明：吉利车辆自动唤醒上传的数据因总电压、总电流为空或异常，<br />自动唤醒上传的数据将被是做异常数据。</td>
            </tr>
            <tr>
                <td>当日上线里程</td><td>当日结束里程-当日开始里程</td>
            </tr>
            <tr>
                <td>总跳变扣除里程恒</td><td>仪表里程跳变检测用于检测车辆在行驶过程中有无仪表里程的突变，对有突变超过阈值<br />（2km，按照每帧数据30秒间隔，合240KM/h）的里程进行标记，<br />并计算得出测评周期内因仪表里程跳变需要扣除里程。</td>
            </tr>
            <tr>
                <td>总连续电流扣除里程</td><td>

                连续电流检测主要用于对上传的动力电池数据是否真实进行检测，检测中若有总电流大于阈值（20A）的情况下，<br />连续3帧及以上总电流连续数值相同，需对这种现象进行标记。<br />


                对于测评周期内连续3帧相同的现象频次大于阈值（占比为0.1%）的情况，将对应连续3帧数据内发生的里程跳变进行计算，<br />得到测评周期内连续电流检测扣除里程。</td>
            </tr>
            <tr>
                <td>当日有效里程</td><td>有效里程=当日在线里程-里程跳变需扣除里程-连续电流检测需扣除里程</td>
            </tr>
            <tr>
                <td>当日轨迹里程</td><td>对经过无效检测和异常检测过滤后的非熄火状态车辆数据池，进行GPS里程计算，<br />得到车辆在测评周期内的GPS 里程。</td>
            </tr>
            <tr>
                <td>有效里程和轨迹里程相对误差</td><td>偏差率=（有效里程-轨迹里程）/轨迹里程*100%</td>
            </tr>
            <tr>
                <td>上线里程和有效里程相对误差</td><td>偏差率=（有效里程-轨迹里程）/轨迹里程*100%</td>
            </tr>
            <tr>
                <td>上线里程和有效里程相对误差</td><td>

                偏差率=（在线里程-有效里程）/有效里程*100%
            </td>
            </tr>
            <tr>
                <td>单日核算里程</td><td>

                若车辆有实时数据，优先选择实时数据进行核算；若无实时数据，选取补发数据。<br />

                对车辆每日在线里程、有效里程、轨迹里程（GPS里程）进行比较，得到单日核算里程：<br />

                步骤1：计算在线里程和有效里程的偏差率，如果小于等于5%，选取在线里程和轨迹里程进一步比较，否则选取有效里程；<br />

                步骤2：使用步骤1获取的里程和轨迹里程计算偏差率，如果小于等于5%，核算里程使用步骤1李德里程，<br />否则核算里程选取步骤1里程和轨迹里程两者最小值；
            </td>
            </tr>

            </tbody>
        </table>
    </div>
</div>

<div region="center" style="overflow: hidden; width: 100%;">
    <div id="toolbar" style="padding:5px" class="cg-moreBox">
       <#-- <@shiro.hasPermission name="/report/demo1/view">
            <a href="#" onclick="view_item()" class="easyui-linkbutton"
               data-options="iconCls:'icon-view'" menu="0">查看</a>
        </@shiro.hasPermission>
        <@shiro.hasPermission name="/report/demo1/add">
        <a href="#" onclick="add_item()" class="easyui-linkbutton"
           data-options="iconCls:'icon-add'" menu="0">增加</a>
        </@shiro.hasPermission>
        <@shiro.hasPermission name="/report/demo1/update">
        <a href="#" onclick="edit_item()" class="easyui-linkbutton"
           data-options="iconCls:'icon-edit'" >编辑</a>
        </@shiro.hasPermission>
        <@shiro.hasPermission name="/report/demo1/del">
        <a href="#" onclick="del_item()" class="easyui-linkbutton"
           data-options="iconCls:'icon-remove'" >删除</a>
        </@shiro.hasPermission>-->
        <#--<@shiro.hasPermission name="/report/operation/dayMileageCheck/export">-->
           <a href="#" onclick="gridList()" class="easyui-linkbutton"
               data-options="iconCls:'icon-export'" menu="0">导出</a>
        <#--</@shiro.hasPermission>-->
           <a href="#" onclick="reportSpecification()" data-options="iconCls:'icon-export'" menu="0" style="float: right;margin-left: 5px;margin-right: 5px;  margin-top:5px;margin-right: 100px">列表说明</a>
    </div>
    <div id="table" name="datagrid" style="width: 100%; height: 100%;"></div>
</div>
<div data-options="region:'north',title:'查询',split:true,collapsable:true" style="width: 100%;height: 200px">
    <div style="width: 100%;border: 1;margin:5 5 5 10 ">
        <form id="form_search" name="" class="sui-form cg-form">
            <div style="width: 90%; height: 20px; margin: 10px;">
                <label>条件查询</label>
                <input type="radio" name="query.adminFlag" id="tiaojian" onclick="operationtd(true)"  checked="checked"  value="0" ></input>
                <label>导入查询</label>
                <input type="radio" name="query.adminFlag" id = "daoru" value="1" onclick="operationtd(false)" ></input>
            </div>
            <table class="table_search" style="height: 90px;">
                <tr>
                    <td class="td_label" style="text-align: right;" id="fileButton">
                        <label>文件上传:</label>
                    </td>
                    <td class="td_input" id="fileShow">
                        <input type="file" id="file" style="height: 30px; width: 164px;" name="myfile" />
                    </td>

                    <td class="td_label" style="text-align: right;" >
                        <label>统计日期:</label>
                    </td>
                    <td class="td_input">
                        <input  type="text" class="easyui-datebox" name="query.reportDateStart"  value="${(reportDateStart)!}"  id = "reportDateStart"  style="height: 30px; width: 168px;" >
                    </td>
                    <td class="td_label" style="text-align: center">
                        <label>至</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="easyui-datebox"  name="query.reportDateEnd"  value="${(reportDateEnd)!}"  id = "reportDateEnd"  style="height: 30px; width: 168px;" >
                    </td>

                    <td class="td_label" style="text-align: right;">
                        <label>VIN:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" name="query.vin"  id = "vin" style="width:150px;" >
                    </td>

                    <td class="td_label" style="text-align: right;">
                        <label>车牌号:</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" id="licensePlate" name="query.licensePlate"  style="width:150px;" >
                    </td>
                    <td class="td_label" style="text-align: right;">
                        <label>车辆种类:</label>
                    </td>
                    <td class="td_input">
                        <input id="vehTypeId"  name="query.vehtype"  editable="false" style="width: 168px;" >
                    </td>
                    <td class="td_label" style="text-align: right;">
                        <label>车辆型号:</label>
                    </td>
                    <td class="td_input">
                        <input id="vehModelName" name="query.vehModelNum" style="width: 168px;">
                    </td>
                    <td class="td_label" style="text-align: right;">
                        <label>运营单位:</label>
                    </td>

                    <td class="td_input">
                        <input id="useUnitId" name="query.unit" editable="false" style="width: 168px;">
                    </td>
                    <td class="td_label" style="text-align: right;">
                    </td>
                    <td class="td_input">
                    </td>


                    <td class="td_label" style="text-align: right;">
                        <label>上牌区域:</label>
                    </td>
                    <td class="td_input">
                        <input id="areaId" name="query.veharea" editable="false" style="width: 168px;">
                    </td>
                    <td class="td_label" style="text-align: right;">
                        <label>当日有效里程大于(km):</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" id="dayVaildMileage" name="query.dayVaildMileage" style="width:100px;position: relative;left: 50px;">
                    </td>
                    <td class="td_label" style="text-align: right;">
                        <label>当日轨迹里程大于(km):</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" id="dayGpsMileage" name="query.dayGpsMileage" style="width:100px;position: relative;left: 50px;">
                    </td>
                    <td class="td_label" style="text-align: right;">
                        <label>当日在线里程大于(km):</label>
                    </td>
                    <td class="td_input">
                        <input type="text" class="input-fat input" id="dayOnlineMileage" name="query.dayOnlineMileage" style="width:100px;position: relative;left: 50px;">
                    </td>
                    <td class="td_label" style="width:388px ">
                    </td>
                    <td class="td_input">
                    </td>
                    <td style="vertical-align: center;text-align: right;border: 1px" class="cg-btnGroup">
                        <a href="#" onclick="searchButton()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
                        <a href="#" onclick="resetButton()" class="easyui-linkbutton" data-options="iconCls:'icon-reset'">重置</a>
                    <#--<input type="button" onclick="downFile()" value="导入查询模板下载" />-->
                        <a href="#" onclick="downFile()" id = "downLadfile" data-options="iconCls:'icon-reset'">导入查询模板下载</a>

                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>

</body>
<script>

    //序列化搜索条件
    var queryParams = $('#form_search').serializeObject();

    //重置使用参数对象(暂时存储初次加载的数据，用于重置事件)
    var resetQueryParams = queryParams;

    //重置
    function resetButton(){
        var startTimeTemp = "${reportDateStart}";
        var endTimeTemp = "${reportDateEnd}";
        $('#reportDateStart').datebox('setValue',startTimeTemp);
        $('#reportDateEnd').datebox('setValue',endTimeTemp);
        $('#vin').val("");
        $('#licensePlate').val("");
        $('#dayOnlineMileage').val("");
        $('#dayGpsMileage').val("");
        $('#dayVaildMileage').val("");
        //初始化条件
        initSelectChoose();
        $('#table').datagrid("load", resetQueryParams);
    }

    $('#table').datagrid({
        url: '${base}/report/operation/dayMileageCheck/datagrid',
        sortName: "ID",
        sortOrder: "desc",
        rownumbers: true,
        frozenColumns:[[
            {field: 'ck', checkbox: true,align:'center',halign:'center'},
            /*{field: 'ids', title: '序号',align:'center', width: '90', formatter: function (value, row, index) {
                return index+1;
            }},*/
            {field: 'vin', title: 'VIN',align:'center',halign:'center'},
            {field: 'licensePlate', title: '车牌号',align:'center',halign:'center'}
        ]],
        columns: [[
            {field: 'reportDate', title: '统计日期',align:'center',halign:'center'},
            {field: 'firstOnlineTime', title: '当日首次上线时间',align:'center',halign:'center'},
            {field: 'firstStartMileage', title: '当日开始里程(KM)',align:'center',halign:'center'},
            {field: 'lastCommitTime', title: '当日最后通讯时间',align:'center',halign:'center'},
            {field: 'lastEndMileage', title: '当日结束里程(KM)',align:'center',halign:'center'},
            {field: 'checkDataTotalNum', title: '核查数据总条数(条)',align:'center',halign:'center'},
            /*{field: 'invalidNum', title: '含无效数据条数(条)',align:'center', width: '160'},
            {field: 'abnormalNum', title: '含异常数据条数(条)',align:'center', width: '160'},*/
            {field: 'abnormalNum', title: '无效异常总条数（条）',align:'center',halign:'center', formatter: function (value, row, index) {

                return row.invalidNum+row.abnormalNum;
            }},
            {field: 'dayOnlineMileage', title: '当日上线里程(KM)',align:'center',halign:'center'},
            {field: 'deductJumpMileage', title: '总跳变扣除里程(KM)',align:'center',halign:'center'},
            {field: 'deductCurrentMileage', title: '总连续电流扣除里程(KM)',align:'center',halign:'center'},
            {field: 'dayValidMileage', title: '当日有效里程(KM)',align:'center',halign:'center'},
            {field: 'dayGpsMileage', title: '当日轨迹里程(KM)',align:'center',halign:'center'},
            {field: 'validGpsDeviation', title: '有效里程和轨迹里程相对误差（百分比）',align:'center',halign:'center'},
            {field: 'onlineValidDeviation', title: '上线里程和有效里程相对误差（百分比）',align:'center',halign:'center'},
            {field: 'dayCheckMileage', title: '单日核算里程(KM)',align:'center',halign:'center'},
            {field: 'veharea', title: '上牌区域',align:'center',halign:'center'},
            {field: 'unit', title: '运营单位',align:'center',halign:'center'},
            {field: 'vehModelNum', title: '车辆型号',align:'center',halign:'center'},
            {field: 'vehtype', title: '车辆种类',align:'center',halign:'center'},
        ]],
        toolbar: "#toolbar",
        pagination: true,
        nowrap: true


    });
//    toolbar2Menu("monitoringTable");
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
<script language="javascript">
    $(function(){
                initSelectChoose();
       /* $('#fileButton').css("visibility", "hidden");
        $('#fileShow').css("visibility", "hidden");
        $('#fileDown').css("visibility", "hidden");*/
        document.getElementById("fileButton").style.display = "none";
        document.getElementById("fileShow").style.display = "none";
        document.getElementById("downLadfile").style.display = "none";
        //日期默认昨天数据
    });
    /**
     * 增加
     */
    function add_item() {
        var title = "增加演示1";
        var url = "${base}/report/demo1/add";
        openAddDataWin('report_demo1',title,url,"600",'600','table');
    }

    /**
     * 查看
     */
    function view_item() {
        var title = "增加演示1";
        var url = "${base}/report/demo1/view";
        openViewDataWin('report_demo1',title,url,"600",'600','table');
    }

    /**
     * 编辑
     * @param id
     */
    function edit_item(id) {

        var title = "编辑演示1";
        var url = "${base}/report/demo1/update?id=" + (id);
        openUpdateDataWin('report_demo1',title,url,"600",'600','table');

    }


    /**
     * 编辑
     * @param id
     */
    function del_item() {

        var title = "演示1";
        var url = "${base}/report/demo1/del";
        delRecord(title,url,'table');

    }

    /***
     * 文件上传
     * @constructor
     */
    function UpladFile() {
        var fileObj = document.getElementById("file").files[0]; // 获取文件对象

        var FileController = "${base}/report/operation/dayMileageCheck/fileMin";                    // 接收上传文件的后台地址

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
                    searchDatagrid('form_search','table')
                } else {
                    $.messager.show({
                        title:'文件解析结果',
                        msg:data.message,
                        timeout:2000,
                        showType:'slide'
                    });
                }
            }
        }

    }

    /*模板下载*/
    function downFile() {
        var downUrl = "${base}/report/operation/dayMileageCheck/downLooadModel?moduleName=model&fileName=templateQuery.xls";
        window.open(downUrl);
    }

    /*导出列表*/
    function gridList() {
       var url= '${base}/report/operation/dayMileageCheck/export';
       var formId= 'form_search';
       var gridId=  'table';
       var listId="";

        if (formId == undefined || formId == null) {
            formId = "form_search";
        }
        var myUrl = url;
        var searchParames = $('#' + formId).serializeObject();
        //获取选中行数据
        var rows = $("#" + gridId).datagrid("getSelections");
        if(rows.length <= 0){
            alert("请勾选导出的数据");
            return;
        }
        for(var i=0;i<rows.length;i++){
            listId+="\'"+rows[i].ids+"\',";
        }
        if(rows.length>0){
            listId="("+listId+ "\'\')";

        }
        var rowAll = $("#" + gridId).datagrid("getRows");
        //定义是否是选中导出
        var stutsEx;
        if(rowAll.length == rows.length){
            stutsEx= '';
        }else {
                stutsEx= '1';
        }

        searchParames['query.listId'] = listId;
        searchParames['query.stutsEx'] = stutsEx;
        myUrl += '?exportId=' + new Date().getTime();
        for (var key in searchParames) {
            var value = searchParames[key];
            if (value != "") {
                myUrl += ("&" + key + "=" + value);
            }
        }
        window.open(myUrl, '_blank');
    }


    /**
     * 初始化下拉选择框
     */
    function initSelectChoose() {
        //上牌区域
        $('#areaId').combotree({
            url: '${base}/report/common/queryAreaList'
        });
        //运营单位
        $('#useUnitId').combotree({
            url: '${base}/report/common/queryUnitList'
            // editable:true
        });
        //车辆型号
        $('#vehModelName').combobox({
            url: '${base}/report/common/queryVehModelList',
            valueField: 'id',
            textField: 'modelNoticeId'
        });
        //车辆种类
        $('#vehTypeId').combotree({
            url: '${base}/report/common/queryVehTypeList'
            // editable:true
        });
    }


    function   operationtd(nub) {
        if(nub){
            $("#fileButton").hide();
            $("#fileShow").hide();
            $("#downLadfile").hide();/*
            $('#fileButton').css("visibility", "hidden");
            $('#fileShow').css("visibility", "hidden");
            $('#fileDown').css("visibility", "hidden");*/
        }else {
            $("#fileButton").show();
            $("#fileShow").show();
            $("#downLadfile").show();
            /*$('#fileButton').css("visibility", "visible");
            $('#fileShow').css("visibility", "visible");
            $('#fileDown').css("visibility", "visible");*/
        }

    }



    /*查询事件*/
    function searchButton(){
         if(checkTime()){

        var val=$('input:radio[id="daoru"]:checked').val();

        //var valaaa=$('input:radio[id="daoru"]:checked').val();
        if(val == 1){
            var file = document.getElementById("file").files[0];
            if (fileCheck(file)) {
                UpladFile();
            }

        }else {
                //请求查询
                searchDatagrid('form_search','table');
        }
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



    /*报表说明弹框*/
    function reportSpecification(){
        $('#report').window("open");
    }


    //获取日期
    function  getYesterdayDate() {
        var day1 = new Date();
        day1.setTime(day1.getTime()-24*60*60*1000);
        return day1.getFullYear()+"-" + (day1.getMonth()+1) + "-" + day1.getDate();


    }

    /*校验开始时间/结束时间是否合法*/
    function checkTime(){
        //时间校验
        var endTime = $("input[name='query.reportDateEnd']").val();
        var startTime = $("input[name='query.reportDateStart']").val();
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
            $.messager.alert('提示','选择开始时间与结束时间间隔最大为31天！');
            return false;
        }
        return true;
    }
</script>
</html>