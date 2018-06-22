package com.bitnei.cloud.report.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.common.PublicDealUtil;
import com.bitnei.cloud.common.bean.ExcelData;
import com.bitnei.cloud.common.util.DataLoader;
import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.common.util.EasyExcel;
import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.cloud.report.mapper.MileageMonitorMapper;
import com.bitnei.cloud.report.service.IMileageMonitorService;
import com.bitnei.commons.datatables.DataGridOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.RequestContext;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class MileageMonitorService   implements IMileageMonitorService {

    @Autowired
    private MileageMonitorMapper mileageMonitorMapper;
    @Autowired
    private AreaMileageService  areaMileageService;

    /**
     * 查询里程分布
     * @param map
     * @return
     */
    public JSONObject queryMileageMonthly(Map<String, Object> map) {

        JSONArray arr=new JSONArray();
        JSONObject ob=new JSONObject();
        if(map.get("cheLiangMing")!=null){
            map.put("cheLiangMing","%"+map.get("cheLiangMing")+"%");
        }
        if(map.get("yunYing")!=null){
            if("0".equals(String.valueOf(map.get("yunYing"))) ){
                map.put("yunYing","%%");
            }else{
            map.put("yunYing","%"+map.get("yunYing")+"%");
            }
            }
        if(map.get("endTime")==null){
            String shiJian=  new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis()-86400000 ));
            map.put("shiJian",shiJian);
            map.put("date1",shiJian);
            Calendar cal = Calendar.getInstance();
            int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH );
            if(month==0){
                year--;
                month=12;
            }
            map.put("date2",getdate(year,month));
        }else{
            SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
            try {
                Date endTime = format.parse(ifDate(String.valueOf(map.get("endTime"))));
                Calendar cal = Calendar.getInstance();
                cal.setTime(endTime);
                int year = cal.get(Calendar.YEAR);
                int month = cal.get(Calendar.MONTH );
                if(month==0){
                    year--;
                    month=12;
                }
                map.put("date2",getdate(year,month));
                map.put("shiJian",ifDate( String.valueOf(map.get("endTime"))) );
                map.put("date1",ifDate( String.valueOf(map.get("endTime"))) );
            } catch (ParseException e) {

                ob.put("total",0);
                ob.put("rows",arr);
                 return ob;
            }


        }

        map= PublicDealUtil.bulidUserForParams(map);
        Object zongye = map.get("zongye");
        long zong=0;
        if(zongye!= null){
            try {
                zong = Integer.parseInt(String.valueOf(zongye));
            }catch(Exception e){}
        }
        if(zong==0){
            zong = mileageMonitorMapper.countMileageMonthly(map);
        }
        if(zong!=0){
            DataGridOptions options = ServletUtil.getDataLayOptions();
            Integer hang=options.getLength();
            Long page= (long)options.getPageNumber();
            Long zongYe= zong%hang==0?zong/hang:zong/hang+1;
            page=page<1?1:page>zongYe?zongYe:page;
            map.put("begin",(page-1)*hang);
            map.put("end",hang);
            List<Map<String, Object>> mileageMonthly = mileageMonitorMapper.queryMileageMonthly(map);
             arr = areaMileageService.listMapToJSONArray(mileageMonthly);
            ob.put("rows",arr);
            ob.put("total",zong);
            return ob;
        }

        ob.put("total",0);
        ob.put("rows",arr);

        return ob;
    }

    /**
     * 下载里程分布
     * @param map
     */
    public void downloadMileageMonthly(Map<String, Object> map){

        if(map.get("cheLiangMing")!=null){
            map.put("cheLiangMing","%"+map.get("cheLiangMing")+"%");
        }
        if(map.get("yunYing")!=null){
            if("0".equals(String.valueOf(map.get("yunYing"))) ){
                map.put("yunYing","%%");
            }else{
                map.put("yunYing","%"+map.get("yunYing")+"%");
            }
        }
        boolean b=true;
        if(map.get("endTime")==null){
            String shiJian=  new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis()-86400000 ));
            map.put("shiJian",shiJian);
            map.put("date1",shiJian);
            Calendar cal = Calendar.getInstance();
            int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH );
            if(month==0){
                year--;
                month=12;
            }
            map.put("date2",getdate(year,month));
        }else{
            SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
            try {
                Date endTime = format.parse(ifDate(String.valueOf(map.get("endTime"))));
                Calendar cal = Calendar.getInstance();
                cal.setTime(endTime);
                int year = cal.get(Calendar.YEAR);
                int month = cal.get(Calendar.MONTH );
                if(month==0){
                    year--;
                    month=12;
                }
                map.put("date2",getdate(year,month));
                map.put("shiJian",ifDate( String.valueOf(map.get("endTime"))) );
                map.put("date1",ifDate( String.valueOf(map.get("endTime"))) );
            } catch (ParseException e) {


            }


        }
        List lists=null;
            if(b){
                 map= PublicDealUtil.bulidUserForParams(map);
                lists= mileageMonitorMapper.queryMileageMonthly(map);
            }else{
                lists=new ArrayList<Map<String,Object>>();
            }
        DataLoader.loadNames(lists);
        DataLoader.loadDictNames(lists);
        String srcBase = RequestContext.class.getResource("/templates/").getFile();
        String srcFile = srcBase +"module/report/operation/mileageMonitor/export.xls";

        ExcelData ed = new ExcelData();
        ed.setTitle("里程分布统计");
        ed.setExportTime(DateUtil.getNow());
        ed.setData(lists);
        String outName = String.format("%s-导出-%s.xls", "里程分布统计", DateUtil.getNow());
        EasyExcel.renderResponse(srcFile,outName,ed);

    }

    /**
     * 查询里程分布钻取
     * @param map
     * @return
     */
    public JSONObject queryPopup(Map<String, Object> map) {

        JSONArray arr = new JSONArray();
        JSONObject ob = new JSONObject();

        if("500".equals(String.valueOf(map.get("data2")))){

            map.put("data3", "1");
            map.remove("data1");
        }
        if (map.get("endTime") == null) {
             map.put("endTime", ifDate(String.valueOf(map.get("endTime"))));
           }
            map = PublicDealUtil.bulidUserForParams(map);
            Object zongye = map.get("zongye");
            long zong = 0;

            if (zongye != null) {
                try {
                    zong = Integer.parseInt(String.valueOf(zongye));
                } catch (Exception e) {
                }
            }

            if (zong == 0) {
                zong = mileageMonitorMapper.countPopup(map);
            }
            if (zong != 0) {
                DataGridOptions options = ServletUtil.getDataLayOptions();
                Integer hang = options.getLength();
                Long page = (long) options.getPageNumber();
                Long zongYe = zong % hang == 0 ? zong / hang : zong / hang + 1;
                page = page < 1 ? 1 : page > zongYe ? zongYe : page;
                map.put("begin", (page - 1) * hang);
                map.put("end", hang);
                List<Map<String, Object>> mileageMonthly = mileageMonitorMapper.queryPopup(map);
                arr = areaMileageService.listMapToJSONArray(mileageMonthly);
                ob.put("rows", arr);
                ob.put("total", zong);
                return ob;
            }
            ob.put("total", 0);
            ob.put("rows", arr);

            return ob;



    }

    /**
     * 下载里程分布钻取
     * @param map
     */
    public void downloadPopup(Map<String, Object> map){


        JSONArray arr=new JSONArray();
        JSONObject ob=new JSONObject();
        if(map.get("yunYing")!=null){
            String yunYing = String.valueOf(map.get("yunYing"));
            int i = yunYing.indexOf("?");
            if(i>0){
            map.put("yunYing",yunYing.substring(0,i));
            }else{
                map.remove("yunYing");
            }
        }
        if("500".equals(String.valueOf(map.get("data2")))){

            map.put("data3", "1");
            map.remove("data1");
        }

        if(map.get("endTime")==null){
            map.put("endTime", ifDate(String.valueOf(map.get("endTime"))));
        }
        map= PublicDealUtil.bulidUserForParams(map);
        List lists = mileageMonitorMapper.queryPopup(map);

        DataLoader.loadNames(lists);
        DataLoader.loadDictNames(lists);

        String srcBase = RequestContext.class.getResource("/templates/").getFile();
        String srcFile = srcBase +"module/report/operation/mileageMonitor/popup.xls";
        //x~y公里车辆详情+导出时间
        Object data1 = map.get("data1");
        data1=data1==null?0:data1;
        Object data2 = map.get("data2");
        String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        String s=null;
        if(String.valueOf(data2).equals("0")){
                s="大于"+data1+"公里车辆详情"+date;
        }else if(String.valueOf(data1).equals("0")){
            s="小于"+data2+"公里车辆详情"+date;
        }else{
            s=data1+"-"+data2+"公里车辆详情"+date;
        }

        ExcelData ed = new ExcelData();
        ed.setTitle(s);
        ed.setExportTime(DateUtil.getNow());
        ed.setData(lists);
        String outName = String.format("%s-导出-%s.xls", s, DateUtil.getNow());
        EasyExcel.renderResponse(srcFile,outName,ed);

    }




    /**
     * 通过年份和月份获取每月最后一天的日期
     * @return
     */
    public  static String getdate(int year,int  month){
            int day=0;
        switch (month){
            case  1:
                day=31;
                break;
            case  2:
                if(year%4==0){
                if(year%100==0&&year%400!=0){
                    day=28;
                }else{
                    day=29;
                }
                }else{
                    day=28;
                }

                break;
            case  3:
                day=31;
                break;
            case  4:
                day=30;
                break;
            case  5:
                day=31;
                break;
            case  6:
                day=30;
                break;
            case  7:
                day=31;
                break;
            case  8:
                day=31;
                break;
            case  9:
                day=30;
                break;
            case  10:
                day=31;
                break;
            case  11:
                day=30;
                break;
            case  12:
                day=31;
                break;

            default:
                new RuntimeException("月份错误");
        }

        return year+"-"+month+"-"+day;
    }

    /**
     * 判断时间是否正确并且是否大于今天
     */
    public  static String ifDate(String date){

        SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date endTime = format.parse(date);
            if (endTime.getTime() > System.currentTimeMillis() - 86400000) {

                return new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis() - 86400000));

            } else {
                return date;
            }
        }catch (Exception e){
            return new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis() - 86400000));
        }



    }

}
