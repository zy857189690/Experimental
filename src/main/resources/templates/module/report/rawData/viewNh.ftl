<!DOCTYPE html>
<html>
<head>
<#include  "../../../inc/meta.ftl">
<#include  "../../../inc/js.ftl">


</head>
<body class="fbody">
<div style="padding: 10px" class="fcontainer">
    <form id="ff" method="post" enctype="" novalidate >
        <input type="hidden" name="id" id="id" value="${(rawData.id)!-1}">
        <#--<table class="table_edit" border="1">
            <tr>
                <td class="td_label"><label>点样编号:</label></td>
                <td class="td_input">
                    <input type='text' name='code' autocomplete="off" id='code' value="${(rawData.code)!-1}" class="input-fat" style="height: 26px;width: 178px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan"style="top:12px;left: 200px;">*</span>
                </td>
                <td class="td_label"><label>点样人:</label></td>
                <td class="td_input">
                    <input type='text' name='name' autocomplete="off" id='name' value="${(rawData.name)!}" class="input-fat" style="height: 26px;width: 178px"/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan"style="top:12px;left: 200px;">*</span>
                </td>
            </tr>

        </table>-->
        <table>
        <#--////////////////////////1-12///////////////-->
            <tr>
                <td class="td_input">
                    <input type='text' name='vno01' autocomplete="off" id='vno01'  value="${(rawDataNh.v_no01nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno02' autocomplete="off" id='vno02'  value="${(rawDataNh.v_no02nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno03' autocomplete="off" id='vno03'  value="${(rawDataNh.v_no03nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno04' autocomplete="off" id='vno04'  value="${(rawDataNh.v_no04nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno05' autocomplete="off" id='vno05'  value="${(rawDataNh.v_no05nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno06' autocomplete="off" id='vno06'  value="${(rawDataNh.v_no06nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno07' autocomplete="off" id='vno07'  value="${(rawDataNh.v_no07nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno08' autocomplete="off" id='vno08'  value="${(rawDataNh.v_no08nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno09' autocomplete="off" id='vno09'  value="${(rawDataNh.v_no09nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno10' autocomplete="off" id='vno10'  value="${(rawDataNh.v_no10nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno11' autocomplete="off" id='vno11'  value="${(rawDataNh.v_no11nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno12' autocomplete="off" id='vno12'  value="${(rawDataNh.v_no12nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
            </tr>
          <tr>
            <td class="td_input">
                <input type='text' name='pbs' autocomplete="off" id='pbs'  value="pbs" style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
            </td>
            <td class="td_input">
                <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs"  style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
            </td>
            <td class="td_input">
                <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs" style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
            </td><td class="td_input">
            <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs"  style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
        </td><td class="td_input">
            <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs" style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
        </td><td class="td_input">
            <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs" style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
        </td>
            <td class="td_input">
                <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs"  style="height: 26px;width: 50px;background-color: #0d8ddb" readonly"/>
            </td>
            <td class="td_input">
                <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs" style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
            </td><td class="td_input">
            <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs"  style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
        </td><td class="td_input">
            <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs" style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
        </td><td class="td_input">
            <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs" style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
        </td>
            <td class="td_input">
                <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs"  style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
            </td>

        </tr>
        <#--////////////////////////13-24///////////////-->
            <tr>
                <td class="td_input">
                    <input type='text' name='vno13' autocomplete="off" id='vno13'  value="${(rawDataNh.v_no13nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno14' autocomplete="off" id='vno14'  value="${(rawDataNh.v_no14nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno15' autocomplete="off" id='vno15'  value="${(rawDataNh.v_no15nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno16' autocomplete="off" id='vno16'  value="${(rawDataNh.v_no16nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno17' autocomplete="off" id='vno17'  value="${(rawDataNh.v_no17nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno18' autocomplete="off" id='vno18'  value="${(rawDataNh.v_no18nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno19' autocomplete="off" id='vno19'  value="${(rawDataNh.v_no19nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno20' autocomplete="off" id='vno20'  value="${(rawDataNh.v_no20nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno21' autocomplete="off" id='vno21'  value="${(rawDataNh.v_no21nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno22' autocomplete="off" id='vno22'  value="${(rawDataNh.v_no22nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno23' autocomplete="off" id='vno23'  value="${(rawDataNh.v_no23nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno24' autocomplete="off" id='vno24'  value="${(rawDataNh.v_no24nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
            </tr>

            <tr>
                <td class="td_input">
                    <input type='text' name='hno13' autocomplete="off" id='hno13' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno'14 autocomplete="off" id='hno14' value="200"
                           style="height: 26px;width: 50px;  background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno15' autocomplete="off" id='hno15' value="100"
                               style="height: 26px;width: 50px;  background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno16' autocomplete="off" id='hno16' value="40"
                            style="height: 26px;width: 50px;  background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno17' autocomplete="off" id='hno17' value="20"
                      style="height: 26px;width: 50px;  background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno18' autocomplete="off" id='hno18' value="10"
                              style="height: 26px;width: 50px;  background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno19' autocomplete="off" id='hno19' value="5" style="height: 26px;width: 50px;  background-color: #0d8ddb"
                              readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno20' autocomplete="off" id='hno20' value="2" style="height: 26px;width: 50px;  background-color: #0d8ddb"
                                readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno21' autocomplete="off" id='hno21' value="1" style="height: 26px;width: 50px;  background-color: #0d8ddb"
                               readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno22' autocomplete="off" id='hno22' value="0" style="height: 26px;width: 50px;  background-color: #0d8ddb"
                              readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno23' autocomplete="off" id='hno23' value="${(rawData.h_no23)!}"
                           style="height: 26px;width: 50px ;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno24' autocomplete="off" id='hno24' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
            </tr>
        <#--////////////////////////25-36///////////////-->
            <tr>
                <td class="td_input">
                    <input type='text' name='vno25' autocomplete="off" id='vno25'  value="${(rawDataNh.v_no25nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno26' autocomplete="off" id='vno26'  value="${(rawDataNh.v_no26nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno27' autocomplete="off" id='vno27'  value="${(rawDataNh.v_no27nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno28' autocomplete="off" id='vno28'  value="${(rawDataNh.v_no28nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno29' autocomplete="off" id='vno29'  value="${(rawDataNh.v_no29nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno30' autocomplete="off" id='vno30'  value="${(rawDataNh.v_no30nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno31' autocomplete="off" id='vno31'  value="${(rawDataNh.v_no31nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno32' autocomplete="off" id='vno32'  value="${(rawDataNh.v_no32nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno33' autocomplete="off" id='vno33'  value="${(rawDataNh.v_no33nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno34' autocomplete="off" id='vno34'  value="${(rawDataNh.v_no34nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno35' autocomplete="off" id='vno35'  value="${(rawDataNh.v_no35nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno36' autocomplete="off" id='vno36'  value="${(rawDataNh.v_no36nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
            </tr>

            <tr>
                <td>
                    <input type='text' name='hno25' autocomplete="off" id='hno25' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno26' autocomplete="off" id='hno26' value="${(rawData.h_no26)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno27' autocomplete="off" id='hno27' value="${(rawData.h_no27)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno28' autocomplete="off" id='hno28' value="${(rawData.h_no28)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno29' autocomplete="off" id='hno29' value="${(rawData.h_no29)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno30' autocomplete="off" id='hno30' value="${(rawData.h_no30)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno31' autocomplete="off" id='hno31' value="${(rawData.h_no31)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno32' autocomplete="off" id='hno32' value="${(rawData.h_no32)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno33' autocomplete="off" id='hno33' value="${(rawData.h_no33)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno34' autocomplete="off" id='hno34' value="${(rawData.h_no34)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno35' autocomplete="off" id='hno35' value="${(rawData.h_no35)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='hno36' autocomplete="off" id='hno36' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
            </tr>

        <#--////////////////////////37-48///////////////-->

            <tr>
                <td class="td_input">
                    <input type='text' name='vno37' autocomplete="off" id='vno37'  value="${(rawDataNh.v_no37nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno38' autocomplete="off" id='vno38'  value="${(rawDataNh.v_no38nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno39' autocomplete="off" id='vno39'  value="${(rawDataNh.v_no39nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno40' autocomplete="off" id='vno40'  value="${(rawDataNh.v_no40nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno41' autocomplete="off" id='vno41'  value="${(rawDataNh.v_no41nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno42' autocomplete="off" id='vno42'  value="${(rawDataNh.v_no42nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno43' autocomplete="off" id='vno43'  value="${(rawDataNh.v_no43nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno44' autocomplete="off" id='vno44'  value="${(rawDataNh.v_no44nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno45' autocomplete="off" id='vno45'  value="${(rawDataNh.v_no45nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno46' autocomplete="off" id='vno46'  value="${(rawDataNh.v_no46nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno47' autocomplete="off" id='vno47'  value="${(rawDataNh.v_no47nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno48' autocomplete="off" id='vno48'  value="${(rawDataNh.v_no48nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
            </tr>

            <tr>
                <td class="td_input">
                    <input type='text' name='h_no37' autocomplete="off" id='h_no37' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no38' autocomplete="off" id='h_no38' value="${(rawData.h_no38)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no39' autocomplete="off" id='h_no39' value="${(rawData.h_no39)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no40' autocomplete="off" id='h_no40' value="${(rawData.h_no40)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no41' autocomplete="off" id='h_no41' value="${(rawData.h_no41)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no42' autocomplete="off" id='h_no42' value="${(rawData.h_no42)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no43' autocomplete="off" id='h_no43' value="${(rawData.h_no43)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no44' autocomplete="off" id='h_no44' value="${(rawData.h_no44)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no45' autocomplete="off" id='h_no45' value="${(rawData.h_no45)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no46' autocomplete="off" id='h_no46' value="${(rawData.h_no46)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no47' autocomplete="off" id='h_no47' value="${(rawData.h_no47)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no48' autocomplete="off" id='h_no48' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
            </tr>

        <#--////////////////////////49-60///////////////-->
            <tr>
                <td class="td_input">
                    <input type='text' name='vno49' autocomplete="off" id='vno49'  value="${(rawDataNh.v_no49nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno50' autocomplete="off" id='vno50'  value="${(rawDataNh.v_no50nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno51' autocomplete="off" id='vno51'  value="${(rawDataNh.v_no51nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno52' autocomplete="off" id='vno52'  value="${(rawDataNh.v_no52nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno53' autocomplete="off" id='vno53'  value="${(rawDataNh.v_no53nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno54' autocomplete="off" id='vno54'  value="${(rawDataNh.v_no54nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno55' autocomplete="off" id='vno55'  value="${(rawDataNh.v_no55nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno56' autocomplete="off" id='vno56'  value="${(rawDataNh.v_no56nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno57' autocomplete="off" id='vno57'  value="${(rawDataNh.v_no57nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno58' autocomplete="off" id='vno58'  value="${(rawDataNh.v_no58nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno59' autocomplete="off" id='vno59'  value="${(rawDataNh.v_no59nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno60' autocomplete="off" id='vno60'  value="${(rawDataNh.v_no60nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
            </tr>
            <tr>
                <td class="td_input">
                    <input type='text' name='h_no49' autocomplete="off" id='h_no49' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no50' autocomplete="off" id='h_no50' value="${(rawData.h_no50)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no51' autocomplete="off" id='h_no51' value="${(rawData.h_no51)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no52' autocomplete="off" id='h_no52' value="${(rawData.h_no52)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no53' autocomplete="off" id='h_no53' value="${(rawData.h_no53)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no54' autocomplete="off" id='h_no54' value="${(rawData.h_no54)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no55' autocomplete="off" id='h_no55' value="${(rawData.h_no55)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no56' autocomplete="off" id='h_no56' value="${(rawData.h_no56)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no57' autocomplete="off" id='h_no57' value="${(rawData.h_no57)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no58' autocomplete="off" id='h_no58' value="${(rawData.h_no58)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no59' autocomplete="off" id='h_no59' value="${(rawData.h_no59)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no60' autocomplete="off" id='h_no60' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
            </tr>


        <#--////////////////////////61-72///////////////-->

            <tr>
                <td class="td_input">
                    <input type='text' name='vno61' autocomplete="off" id='vno61'  value="${(rawDataNh.v_no61nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno62' autocomplete="off" id='vno62'  value="${(rawDataNh.v_no62nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno63' autocomplete="off" id='vno63'  value="${(rawDataNh.v_no63nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno64' autocomplete="off" id='vno64'  value="${(rawDataNh.v_no64nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno65' autocomplete="off" id='vno65'  value="${(rawDataNh.v_no65nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno66' autocomplete="off" id='vno66'  value="${(rawDataNh.v_no66nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno67' autocomplete="off" id='vno67'  value="${(rawDataNh.v_no67nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno68' autocomplete="off" id='vno68'  value="${(rawDataNh.v_no68nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno69' autocomplete="off" id='vno69'  value="${(rawDataNh.v_no69nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno70' autocomplete="off" id='vno70'  value="${(rawDataNh.v_no70nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno71' autocomplete="off" id='vno71'  value="${(rawDataNh.v_no71nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno72' autocomplete="off" id='vno72'  value="${(rawDataNh.v_no72nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
            </tr>
            <tr>
                <td class="td_input">
                    <input type='text' name='h_no61' autocomplete="off" id='h_no61' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no62' autocomplete="off" id='h_no62' value="${(rawData.h_no62)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no63' autocomplete="off" id='h_no63' value="${(rawData.h_no63)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no64' autocomplete="off" id='h_no64' value="${(rawData.h_no64)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no65' autocomplete="off" id='h_no65' value="${(rawData.h_no65)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no66' autocomplete="off" id='h_no66' value="${(rawData.h_no66)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no67' autocomplete="off" id='h_no67' value="${(rawData.h_no67)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no68' autocomplete="off" id='h_no68' value="${(rawData.h_no68)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no69' autocomplete="off" id='h_no69' value="${(rawData.h_no69)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no70' autocomplete="off" id='h_no70' value="${(rawData.h_no70)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no71' autocomplete="off" id='h_no71' value="${(rawData.h_no71)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no72' autocomplete="off" id='h_no72' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
            </tr>
        <#--////////////////////////73-84///////////////-->
            <tr>
                <td class="td_input">
                    <input type='text' name='vno73' autocomplete="off" id='vno73'  value="${(rawDataNh.v_no73)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno74' autocomplete="off" id='vno74'  value="${(rawDataNh.v_no74)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno75' autocomplete="off" id='vno75'  value="${(rawDataNh.v_no75nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno76' autocomplete="off" id='vno76'  value="${(rawDataNh.v_no76nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno77' autocomplete="off" id='vno77'  value="${(rawDataNh.v_no77nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno78' autocomplete="off" id='vno78'  value="${(rawDataNh.v_no78nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno79' autocomplete="off" id='vno79'  value="${(rawDataNh.v_no79nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno80' autocomplete="off" id='vno80'  value="${(rawDataNh.v_no80nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno81' autocomplete="off" id='vno81'  value="${(rawDataNh.v_no81nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno82' autocomplete="off" id='vno82'  value="${(rawDataNh.v_no82nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno83' autocomplete="off" id='vno83'  value="${(rawDataNh.v_no83nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno84' autocomplete="off" id='vno84'  value="${(rawDataNh.v_no84nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
            </tr>

            <tr>
                <td class="td_input">
                    <input type='text' name='h_no73' autocomplete="off" id='h_no73' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no74' autocomplete="off" id='h_no74' value="${(rawData.h_no74)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no75' autocomplete="off" id='h_no75' value="${(rawData.h_no75)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no76' autocomplete="off" id='h_no76' value="${(rawData.h_no76)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no77' autocomplete="off" id='h_no77' value="${(rawData.h_no77)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no78' autocomplete="off" id='h_no78' value="${(rawData.h_no78)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no79' autocomplete="off" id='h_no79' value="${(rawData.h_no79)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no50' autocomplete="off" id='h_no50' value="${(rawData.h_no50)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no81' autocomplete="off" id='h_no81' value="${(rawData.h_no81)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no82' autocomplete="off" id='h_no82' value="${(rawData.h_no82)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no83' autocomplete="off" id='h_no83' value="${(rawData.h_no83)!}"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='h_no84' autocomplete="off" id='h_no84' value="pbs"
                           style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
            </tr>
        <#--////////////////////////85-96///////////////-->
            <tr>
                <td class="td_input">
                    <input type='text' name='vno85' autocomplete="off" id='vno85'  value="${(rawDataNh.v_no85nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno86' autocomplete="off" id='vno86'  value="${(rawDataNh.v_no86nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno87' autocomplete="off" id='vno87'  value="${(rawDataNh.v_no87nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno88' autocomplete="off" id='vno88'  value="${(rawDataNh.v_no88nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno89' autocomplete="off" id='vno89'  value="${(rawDataNh.v_no89nhnh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno90' autocomplete="off" id='vno90'  value="${(rawDataNh.v_no90nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno91' autocomplete="off" id='vno91'  value="${(rawDataNh.v_no91nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno92' autocomplete="off" id='vno92'  value="${(rawDataNh.v_no92nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno93' autocomplete="off" id='vno93'  value="${(rawDataNh.v_no93nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno94' autocomplete="off" id='vno94'  value="${(rawDataNh.v_no94nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno95' autocomplete="off" id='vno95'  value="${(rawDataNh.v_no95nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='vno96' autocomplete="off" id='vno96'  value="${(rawDataNh.v_no96nh)!-1}" style="height: 26px;width: 50px;background-color: yellow" readonly/>
                </td>
            </tr>
            <tr>
                <td class="td_input">
                    <input type='text' name='pbs' autocomplete="off" id='pbs'  value="pbs" style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs"  style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
                <td class="td_input">
                    <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs" style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td><td class="td_input">
                <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs"  style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
            </td><td class="td_input">
                <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs" style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
            </td><td class="td_input">
                <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs" style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
            </td>
                <td class="td_input">
                    <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs"  style="height: 26px;width: 50px;background-color: #0d8ddb" readonly"/>
                </td>
                <td class="td_input">
                    <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs" style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td><td class="td_input">
                <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs"  style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
            </td><td class="td_input">
                <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs" style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
            </td><td class="td_input">
                <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs" style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
            </td>
                <td class="td_input">
                    <input type='text' name='pbs' autocomplete="off" id='pbs' value="pbs"  style="height: 26px;width: 50px;background-color: #0d8ddb" readonly/>
                </td>
            </tr>

        </table>
    </form>
</div>
</body>
</html>
