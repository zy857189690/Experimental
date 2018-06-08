package com.bitnei.cloud.report.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.common.PublicDealUtil;
import com.bitnei.cloud.common.bean.ExcelData;
import com.bitnei.cloud.common.util.DataLoader;
import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.common.util.EasyExcel;
import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.service.IDayVehService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.RequestContext;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.DayVehMapper")
public class DayVehService extends BaseService implements IDayVehService {
    @Override
    public String queryVehTypeList() {
        List<Map<String, Object>> list = findBySqlId("queryVehTypeList", null);
        if (null != list && list.size() > 0) {
            Map<String, Object> rMap = new HashMap<String, Object>();
            rMap.put("id", "0");
            rMap.put("text", "全部");
            rMap.put("parent_id", "-1");
            rMap.put("state", "open");
            rMap.put("children", PublicDealUtil.initTreeDate(list, rMap.get("id").toString()));
            return "[" + JSONObject.toJSONString(rMap) + "]";
        }
        return null;
    }

    /**
     * 查询车辆型号下拉列表
     * @return
     */
    @Override
    public String queryVehModelList() {
        List<Map<String, Object>> list = findBySqlId("queryVehModelList", null);
        return JSONObject.toJSONString(list);
    }

    /**
     * 查询区域列表
     *
     * @return
     */
    @Override
    public String queryAreaList() {
        List<Map<String, Object>> list = findBySqlId("queryAreaList", null);
        if (null != list && list.size() > 0) {
            Map<String, Object> rMap = list.get(0);
            rMap.put("children", PublicDealUtil.initTreeDate(list, rMap.get("id").toString()));
            rMap.put("state", "open");
            return "[" + JSONObject.toJSONString(rMap) + "]";
        }
        return null;
    }

    /**
     * 查询单位树形下拉列表
     * @return
     */
    @Override
    public String queryUnitList() {
        List<Map<String, Object>> list = findBySqlId("queryUnitList", null);
        if (null != list && list.size() > 0) {
            Map<String, Object> rMap = list.get(0);
            rMap.put("children", PublicDealUtil.initTreeDate(list, rMap.get("id").toString()));
            rMap.put("state", "open");
            return "[" + JSONObject.toJSONString(rMap) + "]";
        }
        return null;
    }

    @Override
    public PagerModel pageQuery() {

        DataGridOptions options = ServletUtil.getDataLayOptions();
        PagerModel pm = findPagerModel("reportDate_desc",options);
        return pm;
    }


    @Override
    public void export() {

        List list = findBySqlId("reportDate_desc",ServletUtil.getQueryParams());
        DataLoader.loadNames(list);
        DataLoader.loadDictNames(list);

        String srcBase = RequestContext.class.getResource("/templates/").getFile();
        String srcFile = srcBase +"module/report/workCondition/dayVeh/export.xls";

        ExcelData ed = new ExcelData();
        ed.setTitle("单车日报");
        ed.setExportTime(DateUtil.getNow());
        ed.setData(list);
        String outName = String.format("%s-导出-%s.xls", "单车日报", DateUtil.getShortDate());
        EasyExcel.renderResponse(srcFile,outName,ed);



    }
}
