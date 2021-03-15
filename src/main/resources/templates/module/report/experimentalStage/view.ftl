<!DOCTYPE html>
<html>
<head>
<#include  "../../../inc/meta.ftl">
<#include  "../../../inc/js.ftl">

    <script type="text/javascript">

        /*$(function(){
            var id=$("#id").val();
            var url = "/experimentManagement/report/experimentalStage/getImgsById?id=" + (id);
            $.ajax({
                url:url,
                method:'post',
                data:id,
                dataType:'json',
                success:function(data){
                    if(data!=null){
                        $.each(data,function(i,url){
                            //拼接图片列表
                            var id = $('#detailImgs li:last').attr('id');
                            id = id.substr(1);
                            id = parseInt(id) + 1;
                            var ids=id;
                            id = 'P'+id;
                            var a_hidden="<li id='"+ id +"'><input type='hidden' id='reportImg' value='"+url+"' name='reportImg'>";
                            var img_html="<img  src='"+url+"'  onclick='showOriginal(this)' original='"+url+"'>";
                            var a_html="<a href='javascript:void(0);' onclick='delespan1("+ids+")'></a>";
                            var li_html="</li>";
                            $('#detailImgs').append(a_hidden+img_html+a_html+li_html);
                        });
                    }
                }
            });
        }
        );*/

        function cancel() {
            if(window.top.$("div#window_addCompanyType").length>0){
                close_win_affirm($("#id").val(), "addCompanyType");
            }else{
                var id = $("#id").val();
                close_win_affirm(id);
            }
        }

    </script>
</head>
<body class="fbody">
<div style="padding: 10px" >
    <form id="ff" method="post" enctype="" novalidate >
        <input type="hidden" name="id" id="id" value="${(experimentalStage.id)!0}">
        <table class="table_edit" border="3">
          <#--  <tr>
                <td rowspan="3"> <label>${(experimentalStage.exNo)!0}</label> </td>
            </tr>-->
              <tr>
                  <td class="td_label"  colspan="13" height="50px" style="background-color: #00E8D7;text-align: center">
                      <label style="font-size: 20px">${(experimentalStage.exNo)!0}</label>&nbsp;&nbsp;&nbsp;
                      <label>载药量:${(experimentalStage.dosage)!-1} </label>
                  </td>
              </tr>

            <tr>
                <td class="td_label"><label>${(experimentalStage.exNo)!0}</label></td>
                <td class="td_label"><label>样品1浓度</label></td>
                <td class="td_label"><label>样品2浓度</label></td>
                <td class="td_label"><label>样品3浓度</label></td>
                <td class="td_label"><label>平均浓度</label></td>
                <td class="td_label"><label>样品1累计浓度</label></td>
                <td class="td_label"><label>样品2累计浓度</label></td>
                <td class="td_label"><label>样品3累计浓度</label></td>
                <td class="td_label"><label>平均累计浓度</label></td>
                <td class="td_label"><label>样品1累计百分比</label></td>
                <td class="td_label"><label>样品2累计百分比</label></td>
                <td class="td_label"><label>样品3累计百分比</label></td>
                <td class="td_label"><label>平均累计百分比</label></td>
                <#--<td class="td_input">
                    <input type='text' name='reportCode' autocomplete="off" id='reportCode' value="${(experimentalStage.reportCode)!}" class="input-fat" style="height: 26px;width: 178px" readonly/>
                    <span name="requireTag" class="requrieTag AbleStevenSpan"style="top:12px;left: 200px;">*</span>
                </td>-->
            </tr>
              <tr>
                  <td class="td_label"><label>Day001</label></td>
                  <td class="td_label"><label>${(experimentalStage.D001explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D001explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D001explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D001totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D001yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D001yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D001yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D001pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D001yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D001yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D001yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D001pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day002</label></td>
                  <td class="td_label"><label>${(experimentalStage.D002explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D002explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D002explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D002totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D002yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D002yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D002yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D002pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D002yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D002yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D002yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D002pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day003</label></td>
                  <td class="td_label"><label>${(experimentalStage.D003explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D003explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D003explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D003totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D003yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D003yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D003yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D003pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D003yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D003yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D003yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D003pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day004</label></td>
                  <td class="td_label"><label>${(experimentalStage.D004explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D004explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D004explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D004totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D004yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D004yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D004yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D004pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D004yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D004yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D004yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D004pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day005</label></td>
                  <td class="td_label"><label>${(experimentalStage.D005explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D005explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D005explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D005totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D005yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D005yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D005yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D005pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D005yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D005yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D005yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D005pjbf)!0}</label></td>
              </tr>

              <tr>
                  <td class="td_label"><label>Day006</label></td>
                  <td class="td_label"><label>${(experimentalStage.D006explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D006explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D006explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D006totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D006yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D006yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D006yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D006pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D006yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D006yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D006yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D006pjbf)!0}</label></td>
              </tr>

              <tr>
                  <td class="td_label"><label>Day007</label></td>
                  <td class="td_label"><label>${(experimentalStage.D007explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D007explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D007explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D007totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D007yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D007yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D007yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D007pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D007yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D007yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D007yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D007pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day008</label></td>
                  <td class="td_label"><label>${(experimentalStage.D008explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D008explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D008explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D008totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D008yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D008yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D008yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D008pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D008yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D008yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D008yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D008pjbf)!0}</label></td>
              </tr>

              <tr>
                  <td class="td_label"><label>Day009</label></td>
                  <td class="td_label"><label>${(experimentalStage.D009explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D009explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D009explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D009totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D009yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D009yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D009yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D009pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D009yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D009yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D009yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D009pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day010</label></td>
                  <td class="td_label"><label>${(experimentalStage.D010explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D010explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D010explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D010totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D010yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D010yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D010yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D010pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D010yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D010yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D010yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D010pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day011</label></td>
                  <td class="td_label"><label>${(experimentalStage.D011explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D011explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D011explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D011totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D011yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D011yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D011yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D011pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D011yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D011yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D011yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D011pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day012</label></td>
                  <td class="td_label"><label>${(experimentalStage.D012explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D012explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D012explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D012totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D012yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D012yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D012yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D012pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D012yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D012yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D012yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D012pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day013</label></td>
                  <td class="td_label"><label>${(experimentalStage.D013explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D013explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D013explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D013totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D013yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D013yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D013yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D013pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D013yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D013yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D013yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D013pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day014</label></td>
                  <td class="td_label"><label>${(experimentalStage.D014explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D014explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D014explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D014totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D014yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D014yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D014yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D014pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D014yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D014yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D014yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D014pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day015</label></td>
                  <td class="td_label"><label>${(experimentalStage.D015explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D015explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D015explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D015totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D015yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D015yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D015yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D015pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D015yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D015yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D015yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D015pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day016</label></td>
                  <td class="td_label"><label>${(experimentalStage.D016explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D016explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D016explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D016totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D016yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D016yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D016yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D016pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D016yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D016yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D016yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D016pjbf)!0}</label></td>
              </tr>

              <tr>
                  <td class="td_label"><label>Day017</label></td>
                  <td class="td_label"><label>${(experimentalStage.D017explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D017explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D017explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D017totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D017yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D017yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D017yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D017pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D017yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D017yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D017yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D017pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day018</label></td>
                  <td class="td_label"><label>${(experimentalStage.D018explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D018explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D018explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D018totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D018yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D018yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D018yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D018pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D018yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D018yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D018yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D018pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day019</label></td>
                  <td class="td_label"><label>${(experimentalStage.D019explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D019explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D019explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D019totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D019yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D019yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D019yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D019pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D019yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D019yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D019yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D019pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day020</label></td>
                  <td class="td_label"><label>${(experimentalStage.D020explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D020explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D020explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D020totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D020yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D020yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D020yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D020pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D020yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D020yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D020yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D020pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day021</label></td>
                  <td class="td_label"><label>${(experimentalStage.D021explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D021explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D021explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D021totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D021yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D021yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D021yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D021pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D021yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D021yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D021yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D021pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day022</label></td>
                  <td class="td_label"><label>${(experimentalStage.D022explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D022explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D022explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D022totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D022yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D022yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D022yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D022pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D022yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D022yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D022yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D022pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day023</label></td>
                  <td class="td_label"><label>${(experimentalStage.D023explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D023explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D023explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D023totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D023yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D023yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D023yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D023pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D023yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D023yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D023yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D023pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day024</label></td>
                  <td class="td_label"><label>${(experimentalStage.D024explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D024explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D024explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D024totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D024yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D024yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D024yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D024pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D024yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D024yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D024yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D024pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day025</label></td>
                  <td class="td_label"><label>${(experimentalStage.D025explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D025explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D025explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D025totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D025yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D025yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D025yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D025pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D025yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D025yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D025yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D025pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day026</label></td>
                  <td class="td_label"><label>${(experimentalStage.D026explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D026explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D026explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D026totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D026yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D026yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D026yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D026pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D026yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D026yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D026yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D026pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day027</label></td>
                  <td class="td_label"><label>${(experimentalStage.D027explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D027explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D027explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D027totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D027yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D027yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D027yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D027pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D027yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D027yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D027yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D027pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day028</label></td>
                  <td class="td_label"><label>${(experimentalStage.D028explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D028explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D028explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D028totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D028yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D028yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D028yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D028pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D028yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D028yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D028yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D028pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day029</label></td>
                  <td class="td_label"><label>${(experimentalStage.D029explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D029explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D029explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D029totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D029yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D029yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D029yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D029pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D029yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D029yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D029yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D029pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day030</label></td>
                  <td class="td_label"><label>${(experimentalStage.D030explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D030explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D030explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D030totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D030yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D030yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D030yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D030pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D030yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D030yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D030yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D030pjbf)!0}</label></td>
              </tr>
              <tr>
                  <td class="td_label"><label>Day031</label></td>
                  <td class="td_label"><label>${(experimentalStage.D031explameOne)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D031explameTwo)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D031explameThree)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D031totalnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D031yp1ljnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D031yp12jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D031yp13jnd)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D031pjljnd)!0}</label></td>

                  <td class="td_label"><label>${(experimentalStage.D031yp1ljndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D031yp12jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D031yp13jndbf)!0}</label></td>
                  <td class="td_label"><label>${(experimentalStage.D031pjbf)!0}</label></td>
              </tr>
          <#--<tr>
              <td class="td_label"><label>报告人:</label></td>
              <td class="td_input">
                  <input type='text' name='reportUserName' autocomplete="off" id='reportUserName' value="${(experimentalStage.reportUserName)!}" class="input-fat" style="height: 26px;width: 178px" readonly/>
                  <span name="requireTag" class="requrieTag AbleStevenSpan"style="top:12px;left: 200px;">*</span>
              </td>
              <td class="td_label"><label>报告时间:</label></td>
              <td class="td_input">
                  <input type='text' name='reportTime' autocomplete="off" id='reportTime' value="${(experimentalStage.reportTime)!}" class="input-fat" style="height: 26px;width: 178px"readonly/>
                  <span name="requireTag" class="requrieTag AbleStevenSpan"style="top:12px;left: 200px;">*</span>
              </td>
          </tr>
      </table>
      <table>
          <tr>
              <td class="td_label"><label>理论配方:</label></td>
              <td class="td_input">
                  <input type='text' name='theoreticalFormula' autocomplete="off" id='theoreticalFormula' value="${(experimentalStage.theoreticalFormula)!}"  style="height: 26px;width: 800px"readonly/>
                  <span name="requireTag" class="requrieTag AbleStevenSpan">*</span>
              </td>
          </tr>

          <tr>
              <td class="td_label"><label>实际配方:</label></td>
              <td class="td_input">
                  <input type='text' name='actualFormula' autocomplete="off" id='actualFormula' value="${(experimentalStage.actualFormula)!}"  style="height: 26px;width: 800px" readonly/>
                  <span name="requireTag" class="requrieTag AbleStevenSpan">*</span>
              </td>
          </tr>
          <tr>
              <td class="td_label"><label>报告内容:</label></td>
              <td class="td_input">
                  <textarea name="reportContent" id="reportContent"  clos="1800" rows="10" style="width: 800px;height: 150px" readonly>${(experimentalStage.reportContent)!}</textarea>
                  <span name="requireTag" class="requrieTag AbleStevenSpan">*</span>
              </td>
          </tr>
          <tr>
              <td class="td_label"><label>实验图片上传:</label></td>
              <td class="td_input" id="fileinput">
                  <div class="cp-img" id="logoImgDiv6">
                      <ul id="detailImgs" style="overflow: hidden;">
                          <li style="display:none;" id="P0">
                      </ul>
                      <span id="hiddenss1"></span>
                  </div>
              </td>
          </tr>-->
        </table>
    </form>
</div>
</body>
</html>
