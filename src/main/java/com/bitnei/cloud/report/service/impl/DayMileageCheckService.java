package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.common.MemCacheManager;
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
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContext;

import javax.servlet.http.HttpServletRequest;
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
        options.getParams().put("vehtype", options.getParams().get("vehtype[]")==null?"":options.getParams().get("vehtype[]"));
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
            DayMileageCheck dayMileageCheck = sessionTemplate.selectOne(  mapper+"findInForVinAndLic", params);
            if (dayMileageCheck != null) {
                sb.append("'" + dayMileageCheck.getId().toString() + "',");
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
        mapParams.put("vehtype", mapParams.get("vehtype[]")==null?"":mapParams.get("vehtype[]"));
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
