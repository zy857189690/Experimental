
<#--<script type="text/javascript" src="${base}/lib/jquery/jquery-1.11.3.min.js"></script>-->
<script type="text/javascript" charset="UTF-8">
    var layer_load_ID = -1;
    var timelate;
    var isInit = true;//是否是页面初始化
    var currentLevelNum1 = 0;//当前未处理的报警故障
    var currentLevelNum2 = 0;
    var currentLevelNum3 = 0;
    var bgMusic1;
    var bgMusic2;
    var bgMusic3;
    var bgMusic4;
    var bgMusic5;
    var settingData;
    // 企业平台标识8为青岛
    var systemTag = "${systemTag!}";
//    var currentLevelNum4 = 0;
//    var currentLevelNum5 = 0;
//    var currentLevelNum6 = 0;
    $(function () {
        fnDate();
        var setting = ${(setting)!};
        settingData = setting;
        if (null != setting && setting != "" && setting.isPlaySound == "1") {
            if (null != setting.mscLv1Url && undefined != setting.mscLv1Url && setting.mscLv1Url != "") {
                $("#bgMusic").append("<audio id='bgMusic1' src='${base}/tmp/alarmMusic/${(user.id)!}/" + setting.mscLv1Url +"' ></audio>");
                bgMusic1 = document.getElementById("bgMusic1");
            }
            if (null != setting.mscLv1Url && undefined != setting.mscLv2Url && setting.mscLv2Url != "") {
                $("#bgMusic").append("<audio id='bgMusic2' src='${base}/tmp/alarmMusic/${(user.id)!}/" + setting.mscLv2Url +" ></audio>");
                bgMusic2 = document.getElementById("bgMusic2");
            }
            if (null != setting.mscLv1Url && undefined != setting.mscLv3Url && setting.mscLv3Url != "") {
                $("#bgMusic").append("<audio id='bgMusic3' src='${base}/tmp/alarmMusic/${(user.id)!}/" + setting.mscLv3Url +"' ></audio>");
                bgMusic3 = document.getElementById("bgMusic3");
            }
            if (null != setting.mscLv1Url && undefined != setting.mscLv4Url && setting.mscLv4Url != "") {
                $("#bgMusic").append("<audio id='bgMusic4' src='${base}/tmp/alarmMusic/${(user.id)!}/" + setting.mscLv4Url +"' ></audio>");
                bgMusic4 = document.getElementById("bgMusic4");
            }
            if (null != setting.mscLv5Url && undefined != setting.mscLv5Url && setting.mscLv5Url != "") {
                $("#bgMusic").append("<audio id='bgMusic5' src='${base}/tmp/alarmMusic/${(user.id)!}/" + setting.mscLv5Url +"' ></audio>");
                bgMusic5 = document.getElementById("bgMusic5");
            }
        }
        var systemVersionNum="${systemVersionNum!}";
        $('#south1').append("<span style='float:left'>当前版本号："+systemVersionNum+"</span>");
        // 青岛平台不需要报警数据
        if (undefined != systemTag && systemTag != "" && systemTag != "8") {
            addSpan();
            if (null != settingData && undefined != settingData && undefined != settingData.isRecvFault && settingData.isRecvFault == "1") {
                timelate = setInterval("addSpan()", 15 * 1000);
            }
        }

        setInterval("fnDate()", 1000);
    });

    //添加tab
    function addSpan() {
        $.ajax({
            url: '${base}/sysFaultAlarm/faultAlert.html',
            type: "post",
            timeout: 1200000, //超时时间：20分钟
            dataType: 'json',
            success: function (jm) {
//                total=jm.data['total'];
//                var levels1 = jm.data['levels1'];
//                var levels2 = jm.data['levels2'];
//                var levels3 = jm.data['levels3'];
//                var levels4 = jm.data['levels4'];
//                var levels5 = jm.data['levels5'];
//                var levels6 = jm.data['levels6'];
                var levels1 = "-";
                if (null != jm.data['levels1'] && undefined != jm.data['levels1']) {
                    var levels1 = jm.data['levels1'];
                }
                var levels2 = "-";
                if (null != jm.data['levels2'] && undefined != jm.data['levels2']) {
                    var levels2 = jm.data['levels2'];
                }
                var levels3 = "-";
                if (null != jm.data['levels3'] && undefined != jm.data['levels3']) {
                    var levels3 = jm.data['levels3'];
                }
                var total = 0;
                if (levels1 != "-") {
                    total = total + parseInt(levels1);
                }
                if (levels2 != "-") {
                    total = total + parseInt(levels2);
                }
                if (levels3 != "-") {
                    total = total + parseInt(levels3);
                }

                $('#south1').empty();
                var img = "<img src='../../skin/skinicon/common/alerm.png'/ alt='' style='margin-top: -2px;margin-right: 2px;'>";
//                $('#south1').append("<span onclick='showAlerm()' style='cursor:pointer;float: right;margin-top: 0px;margin-right: 5px;'>"+img+"您有报警未处理故障总共:<b style='color: red'>"+total+"</b>条!(" +
                $('#south1').append("<span style='cursor:pointer;float: right;margin-top: 0px;margin-right: 5px;'>" +
                    img + "<span onclick='showAlerm(0)'>您有未处理报警中的平台报警总共:<b style='color: red'>" + total + "</b>条！</span>（" +
                    "<span onclick='showAlerm(1)'>1级：<b style='color: red'> " + levels1 + "</b>条,</span>" +
                    "<span onclick='showAlerm(2)'> 2级：<b style='color: red'> " + levels2 + "</b>条,</span>" +
                    "<span onclick='showAlerm(3)'>3级：<b style='color: red'> " + levels3 + "</b>条）</span>" +
//                            "4级:<b style='color: red'>"+levels4+"</b>条," +
//                            "5级:<b style='color: red'>"+levels5+"</b>条," +
//                            "6级:<b style='color: red'>"+levels6+"</b>条)" +
//                           "&nbsp;&nbsp;&nbsp;&nbsp;<b >"+jm.data['systemTime']+"</b>"+
                    "</span>");
                if (!isInit) {
                    //测试用
//                    if ( null != bgMusic1 && undefined != bgMusic1) {
//                        bgMusic1.play();
//                    }
//                    if ( null != bgMusic2 && undefined != bgMusic2) {
//                        bgMusic2.play();
//                    }
//                    if (null != bgMusic3 && undefined != bgMusic3) {
//                        bgMusic3.play();
//                    }
                    if (levels1 != "-" && parseInt(levels1) > parseInt(currentLevelNum1) && null != bgMusic1 && undefined != bgMusic1) {
                        bgMusic1.play();
                    }
                    if (levels2 != "-" && parseInt(levels2) > parseInt(currentLevelNum2) && null != bgMusic2 && undefined != bgMusic2) {
                        bgMusic2.play();
                    }
                    if (levels3 != "-" && parseInt(levels3) > parseInt(currentLevelNum3) && null != bgMusic3 && undefined != bgMusic3) {
                        bgMusic3.play();
                    }
                }
                if (levels1 != "-") {
                    currentLevelNum1 = parseInt(levels1);
                }
                if (levels2 != "-") {
                    currentLevelNum2 = parseInt(levels2);
                }
                if (levels3 != "-") {
                    currentLevelNum3 = parseInt(levels3);
                }
                isInit = false;
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }
    //js 获取当前时间
    function fnDate() {
        var oDiv = document.getElementById("south2");
        var date = new Date();
        var year = date.getFullYear();//当前年份
        var month = date.getMonth();//当前月份
        var data = date.getDate();//天
        var hours = date.getHours();//小时
        var minute = date.getMinutes();//分
        var second = date.getSeconds();//秒
        var time = "<b style='margin-left: 5px'>" + year + "-" + fnW((month + 1)) + "-" + fnW(data) + " " + fnW(hours) + ":" + fnW(minute) + ":" + fnW(second) + "</b>";
        oDiv.innerHTML = time;
    }
    //补位 当某个字段不是两位数时补0
    function fnW(str) {
        var num;
        str >= 10 ? num = str : num = "0" + str;
        return num;
    }
    function showAlerm(type) {
        window.parent.window.parent.addTabFun("平台报警处理", "/sysFaultAlarm/list.html?hrefType=south&leve="+type, 'm_sysFaultAlarm', "", 0, false);
    }
</script>
<div id="south" style="width: 100%">
    <div style="text-align: right;width: 90%;float: left" id="south1"></div>
    <div style="text-align: left;width: 10%;float: right" id="south2"></div>
<#--<table width="100%">-->
<#--<tr>-->
<#--<td width="85%" style="text-align: right" id="south1"></td>-->
<#--<td width="15%" style="text-align: right" id="south2"></td>-->
<#--</tr>-->
<#--</table>-->
</div>
<div id="bgMusic">

</div>
