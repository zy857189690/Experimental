package com.bitnei.cloud.report.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.common.MmdXlsx;
import com.bitnei.cloud.common.PublicDealUtil;
import com.bitnei.cloud.common.bean.ExcelData;
import com.bitnei.cloud.common.util.DataLoader;
import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.common.util.EasyExcel;
import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.mapper.AreaMileageMapper;
import com.bitnei.commons.bean.WebUser;
import com.bitnei.commons.datatables.DataGridOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.RequestContext;


import java.text.SimpleDateFormat;
import java.util.*;

@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.VehHistoryMapper" )
public class AreaMileageService {

    @Autowired
    private AreaMileageMapper areaMileageMapper;
    @Autowired
    private StringRedisTemplate redisTemplate;


    public final static String AREA="REDIS_AREA";



    /**
     * 查询所有行驶区域
     * @return
     */
    public JSONArray getDrivingArea(){

        if(redisTemplate.hasKey(AreaMileageService.AREA)) {
            JSONArray arr = new JSONArray();
            List<Map<String, Object>> province =areaMileageMapper.getProvince();
            int size = province.size();
            JSONObject ob = null;
            final String name = "text";
            final String code = "id";
            for (int i = 0; i < size; i++) {
                Map<String, Object> map = province.get(i);
                if (map == null ||map.get("id")==null||map.get("id").equals("")) {
                    continue;
                }
                ob = new JSONObject(true);
                ob.put(name, map.get(name));
                ob.put(code, map.get(code));
                List<Map<String, Object>> area = areaMileageMapper.getArea(String.valueOf(map.get("mmd")));
                ob.put("children", listMapToJSONArray(area));
                ob.put("state","closed");
                arr.add(ob);
            }

            redisTemplate.opsForValue().set(AreaMileageService.AREA, arr.toString());
            return arr;
        }else{
            String area = redisTemplate.opsForValue().get(AreaMileageService.AREA);
            return JSONArray.parseArray(area);

        }
    }

    /**
     * 查询所有运营单位
     * @return
     */
    public JSONArray getUnit(){

        List<String> unit = areaMileageMapper.getUnit();

        return   listToJSONArray(unit);
    }

    public JSONArray listToJSONArray(List<String>  list){

        JSONArray arr=new JSONArray();

        if(list!=null&&list.size()!=0){
            int size = list.size();
            JSONObject ob=null;
            for(int i=0;i<size;i++){
                 ob=new JSONObject(true);
                ob.put("name",list.get(i));
                arr.add(ob);
            }
        }

        return arr;
    }


    public  JSONArray listMapToJSONArray(List<Map<String,Object>> listMap){
        JSONArray arr=new JSONArray();
        if(listMap!=null){
        int size = listMap.size();
        JSONObject ob=null;

        for(int i=0;i<size;i++){
            ob=new JSONObject(true);
            Map<String, Object>map = listMap.get(i);
            if(map!=null){
                for(Map.Entry<String,Object> k : map.entrySet()){
                    ob.put(k.getKey(),k.getValue());

                }
            }
            arr.add(ob);
        }
        }
        return arr;

    }

    /**
     * 查询区域月报
     * @return
     */
    public JSONObject queryAreaMonthly( Map<String, Object> params){

       // WebUser user = ServletUtil.getUser();
        Map<String, Object> map = params;//emptyToNull(params);


        JSONObject ob=new JSONObject();

        /*
        Object xingShi = map.get("xingShi");
        if(xingShi!=null){
            String xs = String.valueOf(xingShi);
            String[] split = xs.split(",");
            map.put("xingShi",split);
        }*/
        if(map.get("shangPai")!=null){
            map.put("shangPai","%"+map.get("shangPai")+"%");
        }
        if(map.get("VIN")!=null){
            map.put("VIN","%"+map.get("VIN")+"%");
        }
        if(map.get("chePai")!=null){
            map.put("chePai","%"+map.get("chePai")+"%");
        }
        if(map.get("cheLiangMing")!=null){
            map.put("cheLiangMing","%"+map.get("cheLiangMing")+"%");
        }
        if(map.get("yunYing")!=null){
            map.put("yunYing","%"+map.get("yunYing")+"/%");
        }
        if("-1".equals(map.get("jieDuan"))){
            map.remove("jieDuan");
        }
        if(map.get("endTime")==null){

            /**
            Calendar cal = Calendar.getInstance();
            int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH )+1;
            String date2=year+"-"+month+"-01";
            map.put("date2",date2);
            if(month==1){
                year--;
                month++;
            }
            String date1=year+"-"+(month-1)+"-01";

            map.put("date1",date1);
            map.put("date3",MileageMonitorService.getdate(year,month));
            map.put("shiJian",year+"年"+(month-1)+"月");
            */
          String shiJian=  new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis()-86400000 ));
          map.put("shiJian",shiJian);
          map.put("date2",shiJian);
        }else{
            map.put("shiJian",map.get("endTime"));
            map.put("date2",map.get("endTime"));
        }
        map=PublicDealUtil.bulidUserForParams(map);

        Object zongye = map.get("zongye");
        long zong=0;

            if(zongye!= null){
                 try {
                        zong = Integer.parseInt(String.valueOf(zongye));
                 }catch(Exception e){

                 }
            }

        if(zong==0){
            zong = areaMileageMapper.countAreaMonthly(map);
        }

        if(zong!=0){
            DataGridOptions options = ServletUtil.getDataLayOptions();

           // Long page = map.get("page")==null?1:Long.parseLong(String.valueOf(map.get("page")));
          //  Integer hang = map.get("hang")==null?10:Integer.parseInt(String.valueOf(map.get("hang")));
            Integer hang=options.getLength();
            Long page= (long)options.getPageNumber();
            Long zongYe= zong%hang==0?zong/hang:zong/hang+1;
            page=page<1?1:page>zongYe?zongYe:page;
            map.put("begin",(page-1)*hang);
            map.put("end",hang);
            List<Map<String, Object>> areaMonthly = areaMileageMapper.queryAreaMonthly(map);
            JSONArray arr = listMapToJSONArray(areaMonthly);
            ob.put("rows",arr);
            ob.put("total",zong);
            return ob;
        }

        ob.put("rows",new JSONArray());
        ob.put("total",0);

        return   ob;
    }


    /**
     * 把字符串转换为null
     * @param params
     * @return
     */
    public Map<String ,Object> emptyToNull(Map<String, Object> params){
            Map<String,Object> map=new HashMap<String,Object>();
            if(params!=null){

                for(Map.Entry<String, Object> k : params.entrySet()){
                    if(!k.getValue().equals("")){
                    map.put(k.getKey(),k.getValue());
                    }
                }
            }

        return map;
    }




    public void downloadAreaMonthly(Map<String, Object> params){
        Map<String, Object> map = params;//emptyToNull(params);


        JSONObject ob=new JSONObject();

        if(map.get("shangPai")!=null){
            map.put("shangPai","%"+map.get("shangPai")+"%");
        }
        if(map.get("VIN")!=null){
            map.put("VIN","%"+map.get("VIN")+"%");
        }
        if(map.get("chePai")!=null){
            map.put("chePai","%"+map.get("chePai")+"%");
        }
        if(map.get("cheLiangMing")!=null){
            map.put("cheLiangMing","%"+map.get("cheLiangMing")+"%");
        }
        if(map.get("yunYing")!=null){
            map.put("yunYing","%"+map.get("yunYing")+"/%");
        }
        if("-1".equals(map.get("jieDuan"))){
            map.remove("jieDuan");
        }
        if(map.get("endTime")==null){

            String shiJian=  new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis()-86400000 ));
            map.put("shiJian",shiJian);
            map.put("date2",shiJian);
        }else{
            map.put("shiJian",map.get("endTime"));
            map.put("date2",map.get("endTime"));
        }


        map=PublicDealUtil.bulidUserForParams(map);

        List lists = areaMileageMapper.downloadAreaMonthly(map);

        DataLoader.loadNames(lists);
        DataLoader.loadDictNames(lists);

        String srcBase = RequestContext.class.getResource("/templates/").getFile();
        String srcFile = srcBase +"module/report/operation/areaMileage/export.xls";

        ExcelData ed = new ExcelData();
        ed.setTitle("区域里程统计");
        ed.setExportTime(DateUtil.getNow());
        ed.setData(lists);
        String outName = String.format("%s-导出-%s.xls", "区域里程统计", DateUtil.getNow());
        EasyExcel.renderResponse(srcFile,outName,ed);

        /*
        List<String> list=new ArrayList<String>();
        list.add("报表生成时间");
        list.add("车牌号");
        list.add("VIN");
        list.add("上牌城市");
        list.add("行驶区域");
        list.add("运营单位");
        list.add("车型名称");
        list.add("行驶区域总里程（Km）");
        list.add("行驶区域GPS总里程（km）");
        list.add("最终核算里程（km）");
        list.add("车辆阶段");
        list.add("行驶区域里程占比（%）");
        lists.add(0,list);
        try {

            return MmdXlsx.setxlsx(lists);
        } catch (Exception e) {
            e.printStackTrace();
        }*/


    }



}
