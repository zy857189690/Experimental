package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.common.MemCacheManager;
import com.bitnei.cloud.common.PublicDealUtil;
import com.bitnei.cloud.common.StringUtil;
import com.bitnei.cloud.common.bean.ExcelData;
import com.bitnei.cloud.common.util.DataLoader;
import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.common.util.EasyExcel;
import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.DayMileageCheck;
import com.bitnei.cloud.report.service.IDayMileageCheckService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import com.github.pagehelper.PageRowBounds;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContext;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by xiaojinlu  on 2018/6/6.
 */
@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.DayMileageCheckMapper" )
public class DayMileageCheckService  extends BaseService implements IDayMileageCheckService {
    private final String mapper = "com.bitnei.cloud.report.mapper.DayMileageCheckMapper.";
    @Override
    public PagerModel pageQuery() {

        DataGridOptions options = ServletUtil.getDataLayOptions();
        options.getParams().put("vehtype", options.getParams().get("vehtype")==null?"":options.getParams().get("vehtype"));
        if(options.getParams().get("reportDateStart")==null && options.getParams().get("reportDateEnd")==null){
            options.getParams().put("reportDateStart", options.getParams().get("reportDateStart")==null? com.bitnei.cloud.common.DateUtil.getShortNextDay(com.bitnei.cloud.common.DateUtil.getNextDay(new Date())):options.getParams().get("reportDateStart"));
            options.getParams().put("reportDateEnd", options.getParams().get("reportDateEnd")==null? com.bitnei.cloud.common.DateUtil.getShortNextDay(com.bitnei.cloud.common.DateUtil.getNextDay(new Date())):options.getParams().get("reportDateEnd"));

        }
        if(options.getParams().get("reportDateStart")!=null && options.getParams().get("reportDateEnd")==null){
            options.getParams().put("reportDateStart", options.getParams().get("reportDateStart")==null? com.bitnei.cloud.common.DateUtil.getShortNextDay(com.bitnei.cloud.common.DateUtil.getNextDay(new Date())):options.getParams().get("reportDateStart"));
            options.getParams().put("reportDateEnd",  options.getParams().get("reportDateEnd")==null? com.bitnei.cloud.common.DateUtil.getTheSpecifiedDay(31,options.getParams().get("reportDateStart").toString()):options.getParams().get("reportDateEnd"));

        }
        if(options.getParams().get("reportDateStart")==null && options.getParams().get("reportDateEnd")!=null){
            options.getParams().put("reportDateStart", options.getParams().get("reportDateStart")==null? com.bitnei.cloud.common.DateUtil.getTheSpecifiedDay(-31,options.getParams().get("reportDateEnd").toString()):options.getParams().get("reportDateStart"));
            options.getParams().put("reportDateEnd", options.getParams().get("reportDateEnd")==null? com.bitnei.cloud.common.DateUtil.getShortNextDay(com.bitnei.cloud.common.DateUtil.getNextDay(new Date())):options.getParams().get("reportDateEnd"));

        }

       options.getParams().put("adminFlag", options.getParams().get("adminFlag")==null? "0":options.getParams().get("adminFlag"));

        //options.setParams();
        Map<String, Object> userprss = PublicDealUtil.bulidUserForParams(options.getParams());
        options.getParams().put("userId", userprss==null?"":userprss.get("userId")==null?"":userprss.get("userId"));
        options.getParams().put("isLeader", userprss==null?"":userprss.get("isLeader")==null?"":userprss.get("isLeader"));
        options.getParams().put("areaPath", userprss==null?"":userprss.get("areaPath")==null?"":userprss.get("areaPath"));
        options.getParams().put("userUnitPath", userprss==null?"":userprss.get("userUnitPath")==null?"":userprss.get("userUnitPath"));
        // 判断是条件查询还是导入查询
        PagerModel pm = null;
        if("0".equals(options.getParams().get("adminFlag"))){
            pm = findPagerModel("pagerModel",options);
        }else {
            options.getParams().put("vehicId", getVehicId());
            pm = findPagerModel("pagerModel",options);
        }
        return pm;
    }

    private String getVehicId() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        List<Map> lisVin = (List<Map>) MemCacheManager.getInstance().get(request.getSession().getId() + "InstantVeh");
        StringBuffer sb = new StringBuffer();
        if (lisVin == null) {
            return "";
        }
        for (int i = 0; i < lisVin.size(); i++) {
            Map map = lisVin.get(i);
            Map<String, Object> params = new HashMap();
            params.put("lic", map.get("lic") == null ? null : map.get("lic").toString());
            params.put("vin", map.get("vin") == null ? null : map.get("vin").toString());
            params.put("reportDateStart", map.get("reportDateStart") == null ?  com.bitnei.cloud.common.DateUtil.getShortNextDay(com.bitnei.cloud.common.DateUtil.getNextDay(new Date())) : map.get("reportDateStart"));
            params.put("reportDateEnd", map.get("reportDateEnd") == null ? com.bitnei.cloud.common.DateUtil.getShortNextDay(com.bitnei.cloud.common.DateUtil.getNextDay(new Date())) : map.get("reportDateEnd"));
            DayMileageCheck dayMileageCheck = sessionTemplate.selectOne(  mapper+"findInForVinAndLic", params);
            if (dayMileageCheck != null) {
                sb.append("'" + dayMileageCheck.getIds().toString() + "',");
            }
        }
        String splitNull = "(" + sb.toString() + "'')";
        if (StringUtil.notEmpty(sb.toString())) {
            splitNull = splitNull.replace(",''", "");
        }
        return splitNull;
    }

    @Override
    public void export() {
        List list =null;
        Map<String, Object> mapParams = ServletUtil.getQueryParams();
        mapParams.put("vehtype", mapParams.get("vehtype")==null?"":mapParams.get("vehtype"));
        Map<String, Object> userprss = PublicDealUtil.bulidUserForParams(mapParams);
        mapParams.put("userId", userprss==null?"":userprss.get("userId")==null?"":userprss.get("userId"));
        mapParams.put("isLeader", userprss==null?"":userprss.get("isLeader")==null?"":userprss.get("isLeader"));
        mapParams.put("areaPath", userprss==null?"":userprss.get("areaPath")==null?"":userprss.get("areaPath"));
        mapParams.put("userUnitPath", userprss==null?"":userprss.get("userUnitPath")==null?"":userprss.get("userUnitPath"));
        if(mapParams.get("reportDateStart")==null && mapParams.get("reportDateEnd")==null){
            mapParams.put("reportDateStart", mapParams.get("reportDateStart")==null? com.bitnei.cloud.common.DateUtil.getShortNextDay(com.bitnei.cloud.common.DateUtil.getNextDay(new Date())):mapParams.get("reportDateStart"));
            mapParams.put("reportDateEnd", mapParams.get("reportDateEnd")==null? com.bitnei.cloud.common.DateUtil.getShortNextDay(com.bitnei.cloud.common.DateUtil.getNextDay(new Date())):mapParams.get("reportDateEnd"));

        }
        if(mapParams.get("reportDateStart")!=null && mapParams.get("reportDateEnd")==null){
            mapParams.put("reportDateStart", mapParams.get("reportDateStart")==null? com.bitnei.cloud.common.DateUtil.getShortNextDay(com.bitnei.cloud.common.DateUtil.getNextDay(new Date())):mapParams.get("reportDateStart"));
            mapParams.put("reportDateEnd", mapParams.get("reportDateEnd")==null? com.bitnei.cloud.common.DateUtil.getTheSpecifiedDay(31,mapParams.get("reportDateStart").toString()):mapParams.get("reportDateEnd"));

        }
        if(mapParams.get("reportDateStart")==null && mapParams.get("reportDateEnd")!=null){
            mapParams.put("reportDateStart", mapParams.get("reportDateStart")==null? com.bitnei.cloud.common.DateUtil.getTheSpecifiedDay(-31,mapParams.get("reportDateEnd").toString()):mapParams.get("reportDateStart"));
            mapParams.put("reportDateEnd", mapParams.get("reportDateEnd")==null? com.bitnei.cloud.common.DateUtil.getShortNextDay(com.bitnei.cloud.common.DateUtil.getNextDay(new Date())):mapParams.get("reportDateEnd"));

        }

        if(!StringUtil.notEmpty(mapParams.get("stutsEx")==null?"":mapParams.get("stutsEx").toString())){
            //按照条件查询
            if("0".equals(mapParams.get("adminFlag"))){
                list = sessionTemplate.selectList(mapper+"pagerModel", mapParams);
            }else {
                mapParams.put("vehicId", getVehicId());
                list = sessionTemplate.selectList(mapper+"pagerModel", mapParams);
            }
        }else {
            //按照前台传过来的id查询
            list = sessionTemplate.selectList(mapper+"pagerModelForId", mapParams);
        }

        DataLoader.loadNames(list);
        DataLoader.loadDictNames(list);

        String srcBase = RequestContext.class.getResource("/templates/").getFile();
        String srcFile = srcBase +"module/report/operation/dayMileageCheck/export.xls";

        ExcelData ed = new ExcelData();
        ed.setTitle("单日里程核算日报");
        ed.setExportTime(DateUtil.getNow());
        ed.setData(list);
        String outName = String.format("%s-导出-%s.xls", "单日里程核算日报", DateUtil.getShortDate());
        EasyExcel.renderResponse(srcFile,outName,ed);
    }
}
