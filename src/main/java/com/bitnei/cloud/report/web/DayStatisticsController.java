package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.PublicDealUtil;
import com.bitnei.cloud.common.annotation.Module;
import com.bitnei.cloud.common.annotation.SLog;
import com.bitnei.cloud.report.service.IDayStatisticsService;
import com.bitnei.commons.datatables.PagerModel;
import org.apache.log4j.Logger;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Calendar;
import java.util.Map;

/**
 * 运营分析-日汇总报表
 * Created by DFY on 2018/5/28.
 */
@Module(name = "运营分析-日汇总报表")
@Controller
@RequestMapping(value = "/report/operation/dayStatistics")
public class DayStatisticsController {
    //模板文件目录
    public final static String BASE = "/module/report/operation/dayStatistics/";

    private final Logger logger = Logger.getLogger(getClass());
    //模块基础请求前缀
    public final static String BASE_REQ_PATH = "/report/operation/dayStatistics";
    //新增
    public final static String URL_LIST = BASE_REQ_PATH + "/list";
    //新增
    public final static String URL_ADD = BASE_REQ_PATH + "/add";
    //编辑
    public final static String URL_UPDATE = BASE_REQ_PATH + "/update";
    //查看
    public final static String URL_VIEW = BASE_REQ_PATH + "/view";
    //删除
    public final static String URL_DEL = BASE_REQ_PATH + "/del";
    //导出
    public final static String URL_EXPORT = BASE_REQ_PATH + "/export";
    //导入
    public final static String URL_IMPORT = BASE_REQ_PATH + "/import";
    @Autowired
    private IDayStatisticsService dayStatisticsService;

    /**
     * 运营分析-跳转列表页面
     *
     * @return
     */
    @RequestMapping("/list")
    @RequiresPermissions(URL_LIST)
    @SLog(action = "运营分析-列表页面")
    public String list(Model model) {
        String endDate = PublicDealUtil.getPastDate(1);
        String beginDate = PublicDealUtil.getPastDate(11);
        String idleBeginDate = PublicDealUtil.getPastDate(16);
        model.addAttribute("beginDate", beginDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("idleBeginDate", idleBeginDate);
        model.addAttribute("idleEndDate", endDate);
        return BASE + "list";
    }

    /**
     * 车辆监控情况统计
     *
     * @return
     */
    @RequestMapping("/queryMonitoringTable")
    @ResponseBody
    public PagerModel queryMonitoringTable() {
        return dayStatisticsService.queryMonitoringTable();
    }

    /**
     * 车辆活跃情况统计
     *
     * @return
     */
    @RequestMapping("/queryActiveTable")
    @ResponseBody
    public PagerModel queryActiveTable() {
        return dayStatisticsService.queryActiveTable();
    }

    /**
     * 车辆闲置情况统计
     *
     * @return
     */
    @RequestMapping("/queryIdleTable")
    @ResponseBody
    public PagerModel queryIdleTable() {
        return dayStatisticsService.queryIdleTable();
    }

    /**
     * 闲置车辆统计条件设置查询
     *
     * @return
     */
    @RequestMapping("/queryIdleByMileageValue")
    @ResponseBody
    public Map<String, Object> queryIdleByMileageValue() {
        return dayStatisticsService.queryIdleByMileageValue();
    }

    /**
     * 车辆行驶情况统计
     *
     * @return
     */
    @RequestMapping("/queryTravelTable")
    @ResponseBody
    public PagerModel queryTravelTable() {
        return dayStatisticsService.queryTravelTable();
    }

    /**
     * 充耗电情况统计
     *
     * @return
     */
    @RequestMapping("/queryElectricityTable")
    @ResponseBody
    public PagerModel queryElectricityTable() {
        return dayStatisticsService.queryElectricityTable();
    }

    /**
     * 查询弹出框表格
     *
     * @return
     */
    @RequestMapping("/queryDialogSearchTable")
    @ResponseBody
    public PagerModel queryDialogSearchTable() {
        return dayStatisticsService.queryDialogSearchTable();
    }

    /**
     * 导出
     */
    @GetMapping(value = "/export")
    public void export() {
        dayStatisticsService.export();
    }
}
