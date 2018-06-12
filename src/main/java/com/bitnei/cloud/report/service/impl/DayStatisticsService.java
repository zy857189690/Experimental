package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.common.PublicDealUtil;
import com.bitnei.cloud.common.bean.ExcelData;
import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.common.util.EasyExcel;
import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.service.IDayStatisticsService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.bean.WebUser;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.support.RequestContext;

import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

/**
 * 运营分析-日汇总报表
 * Created by DFY on 2018/5/30.
 */
@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.DayStatisticsMapper")
public class DayStatisticsService extends BaseService implements IDayStatisticsService {

    /**
     * 车辆监控情况统计
     *
     * @return
     */
    @Override
    public PagerModel queryMonitoringTable() {
        DataGridOptions options = ServletUtil.getDataLayOptions();
        options.setParams(PublicDealUtil.bulidUserForParams(options.getParams()));
        PagerModel pm = findPagerModel("queryMonitoringTable", options);
        return pm;
    }

    /**
     * 车辆活跃情况统计
     *
     * @return
     */
    @Override
    public PagerModel queryActiveTable() {
        DataGridOptions options = ServletUtil.getDataLayOptions();
        options.setParams(PublicDealUtil.bulidUserForParams(options.getParams()));
        PagerModel pm = findPagerModel("queryActiveTable", options);
        return pm;
    }

    /**
     * 车辆闲置情况统计
     *
     * @return
     */
    @Override
    public PagerModel queryIdleTable() {
        DataGridOptions options = ServletUtil.getDataLayOptions();
        Map<String, Object> params = PublicDealUtil.bulidUserForParams(options.getParams());
        if (null == params.get("beginDate") || null == params.get("endDate") || null == params.get("idleMileageValue")
                || StringUtils.isEmpty(params.get("beginDate").toString()) || StringUtils.isEmpty(params.get("endDate").toString())
                || StringUtils.isEmpty(params.get("idleMileageValue").toString())) {
            return null;
        }
        options.setParams(params);
        PagerModel pm = findPagerModel("queryIdleTable", options);
        return pm;
    }

    /**
     * 闲置车辆统计条件设置查询
     *
     * @return
     */
    @Override
    public Map<String, Object> queryIdleByMileageValue() {
        DataGridOptions options = ServletUtil.getDataLayOptions();
        options.setParams(PublicDealUtil.bulidUserForParams(options.getParams()));
        List<Map<String, Object>> list = findBySqlId("queryIdleByMileageValue", options.getParams());
        if (null != list && list.size() > 0) {
            return list.get(0);
        }
        return null;
    }

    /**
     * 车辆行驶情况统计
     *
     * @return
     */
    @Override
    public PagerModel queryTravelTable() {
        DataGridOptions options = ServletUtil.getDataLayOptions();
        options.setParams(PublicDealUtil.bulidUserForParams(options.getParams()));
        PagerModel pm = findPagerModel("queryTravelTable", options);
        return pm;
    }

    /**
     * 充耗电情况统计
     *
     * @return
     */
    @Override
    public PagerModel queryElectricityTable() {
        DataGridOptions options = ServletUtil.getDataLayOptions();
        options.setParams(PublicDealUtil.bulidUserForParams(options.getParams()));
        PagerModel pm = findPagerModel("queryElectricityTable", options);
        return pm;
    }

    /**
     * 查询弹出框表格
     *
     * @return
     */
    @Override
    public PagerModel queryDialogSearchTable() {
        DataGridOptions options = ServletUtil.getDataLayOptions();
        options.setParams(PublicDealUtil.bulidUserForParams(options.getParams()));
        String searchType = options.getParams().get("searchType").toString();
        String funcName = "";
        if (searchType.equals("dayCount") || searchType.equals("newVehCount")) {//车辆监控情况统计-车辆录入总数（辆）、新增录入车辆数（辆）
            funcName = "queryVehCountTableForDialog";
        } else if (searchType.equals("notOnlineCount")) {//车辆监控情况统计-通讯异常车辆数（辆）
            funcName = "queryVehNotOnlineCountTableForDialog";
        } else if (searchType.equals("dayActiveCount")) {//车辆活跃情况统计-当天活跃车辆总数
            funcName = "queryVehDayActiveCountTableForDialog";
        } else if (searchType.equals("abnormalVehCount")) {//车辆活跃情况统计-里程异常数（辆）
            funcName = "queryVehAbnormalVehCountTableForDialog";
        } else if (searchType.equals("chargeVehCount")) {//充耗电情况统计-充电车辆总数
            funcName = "queryVehElectricityVehCountTableForDialog";
        }
        PagerModel pm = findPagerModel(funcName, options);
        return pm;
    }

    /**
     * tab页导出
     */
    @Override
    public void export() {
        Map<String, Object> params = PublicDealUtil.bulidUserForParams(ServletUtil.getQueryParams());
        String tabId = PublicDealUtil.getMapValueString(params.get("tabId"));
        String excelName = PublicDealUtil.getMapValueString(params.get("excelName"));//导出文件模版名称
        String funcName = PublicDealUtil.getMapValueString(params.get("funcName"));//访问方法名
        String excelTitle = PublicDealUtil.getMapValueString(params.get("excelTitle"));//导出excel的title
        if (tabId.equals("dialog")) {
            String searchType = PublicDealUtil.getMapValueString(params.get("searchType"));
            if (searchType.equals("dayCount") || searchType.equals("newVehCount")) {//车辆监控情况统计-车辆录入总数（辆）、新增录入车辆数（辆）
                funcName = "queryVehCountTableForDialog";
            } else if (searchType.equals("notOnlineCount")) {//车辆监控情况统计-通讯异常车辆数（辆）
                funcName = "queryVehNotOnlineCountTableForDialog";
            } else if (searchType.equals("dayActiveCount")) {//车辆活跃情况统计-当天活跃车辆总数
                funcName = "queryVehDayActiveCountTableForDialog";
            } else if (searchType.equals("abnormalVehCount")) {//车辆活跃情况统计-里程异常数（辆）
                funcName = "queryVehAbnormalVehCountTableForDialog";
            } else if (searchType.equals("chargeVehCount")) {//充耗电情况统计-充电车辆总数
                funcName = "queryVehElectricityVehCountTableForDialog";
            }
        }
        List<Map<String, Object>> list = findBySqlId(funcName, params);
        String srcBase = RequestContext.class.getResource("/templates/").getFile();
        String srcFile = srcBase + "module/report/operation/dayStatistics/" + excelName + ".xls";
        ExcelData ed = new ExcelData();
        ed.setTitle(excelTitle);
        ed.setExportTime(DateUtil.getNow());
        ed.setData(buildExcelData(tabId, list));
        String outName = String.format("%s-导出-%s.xls", excelTitle, DateUtil.getShortDate());
        EasyExcel.renderResponse(srcFile, outName, ed);
    }

    /**
     * 遍历组合excel导出数据
     *
     * @param tabId
     * @param list
     * @return
     */
    private List buildExcelData(String tabId, List<Map<String, Object>> list) {
        if (null == list || list.size() == 0) {
            return null;
        }
        if (StringUtils.isEmpty(tabId) || tabId.equals("dialog")) {
            return list;
        }
        DecimalFormat df = new DecimalFormat("#.##");
        double d1 = 0;
        double d2 = 0;
        for (Map<String, Object> map : list) {
            if (tabId.equals("monitoring")) {
                String dayCount = PublicDealUtil.getMapValueString(map.get("dayCount"));
                String notOnlineCount = PublicDealUtil.getMapValueString(map.get("notOnlineCount"));
                if (!StringUtils.isEmpty(dayCount) && !StringUtils.isEmpty(notOnlineCount)) {
                    d1 = Double.valueOf(dayCount);
                    d2 = Double.valueOf(notOnlineCount);
                    map.put("ratio", df.format(((d1 - d2) / d1) * 100) + "%");
                } else {
                    map.put("ratio", "");
                }
            } else if (tabId.equals("active")) {
                String dayCount = PublicDealUtil.getMapValueString(map.get("dayCount"));
                String dayActiveCount = PublicDealUtil.getMapValueString(map.get("dayActiveCount"));
                String abnormalVehCount = PublicDealUtil.getMapValueString(map.get("abnormalVehCount"));
                String activeTimeCount = PublicDealUtil.getMapValueString(map.get("activeTimeCount"));
                if (!StringUtils.isEmpty(dayCount) && !StringUtils.isEmpty(dayActiveCount)) {
                    map.put("activeRate", df.format((Double.valueOf(dayActiveCount) / Double.valueOf(dayCount)) * 100) + "%");
                } else {
                    map.put("activeRate", "");
                }
                if (!StringUtils.isEmpty(abnormalVehCount) && !StringUtils.isEmpty(dayCount)) {
                    map.put("abnormalRate", df.format((Double.valueOf(abnormalVehCount) / Double.valueOf(dayCount)) * 100) + "%");
                } else {
                    map.put("abnormalRate", "");
                }
                if (!StringUtils.isEmpty(activeTimeCount) && !StringUtils.isEmpty(dayActiveCount)) {
                    map.put("activeTime", df.format(Double.valueOf(activeTimeCount) / Double.valueOf(dayActiveCount)));
                } else {
                    map.put("activeTime", "");
                }
            } else if (tabId.equals("idle")) {

            } else if (tabId.equals("travel")) {
                String dayTravelTime = PublicDealUtil.getMapValueString(map.get("dayTravelTime"));
                String vehOnlineCount = PublicDealUtil.getMapValueString(map.get("vehOnlineCount"));
                String zlc = PublicDealUtil.getMapValueString(map.get("zlc"));
                if (!StringUtils.isEmpty(dayTravelTime) && !StringUtils.isEmpty(vehOnlineCount)) {
                    map.put("vehAverageTime", df.format(Double.valueOf(dayTravelTime) / Double.valueOf(vehOnlineCount)));
                } else {
                    map.put("vehAverageTime", "");
                }
                if (!StringUtils.isEmpty(zlc) && !StringUtils.isEmpty(vehOnlineCount)) {
                    map.put("vehAverageMileage", df.format(Double.valueOf(zlc) / Double.valueOf(vehOnlineCount)));
                } else {
                    map.put("vehAverageMileage", "");
                }
                if (!StringUtils.isEmpty(zlc) && !StringUtils.isEmpty(dayTravelTime)) {
                    map.put("dayAverageSpeed", df.format(Double.valueOf(zlc) / Double.valueOf(dayTravelTime)));
                } else {
                    map.put("dayAverageSpeed", "");
                }
            } else if (tabId.equals("electricity")) {
                String chargeTime = PublicDealUtil.getMapValueString(map.get("chargeTime"));
                if (!StringUtils.isEmpty(chargeTime)) {
                    map.put("chargeTime", df.format(Double.valueOf(chargeTime)));
                }
                String chargeCount = PublicDealUtil.getMapValueString(map.get("chargeCount"));
                String chargeVehCount = PublicDealUtil.getMapValueString(map.get("chargeVehCount"));
                if (!StringUtils.isEmpty(chargeCount) && !StringUtils.isEmpty(chargeVehCount)) {
                    map.put("vehAveCharge", df.format(Double.valueOf(chargeCount) / Double.valueOf(chargeVehCount)));
                } else {
                    map.put("vehAveCharge", "");
                }
                if (!StringUtils.isEmpty(chargeTime) && !StringUtils.isEmpty(chargeCount)) {
                    map.put("vehAveChargeTime", df.format(Double.valueOf(chargeTime) / Double.valueOf(chargeCount)));
                } else {
                    map.put("vehAveCharge", "");
                }
            }
        }
        return list;
    }
}
