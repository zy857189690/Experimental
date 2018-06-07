package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.annotation.Module;
import com.bitnei.cloud.common.annotation.SLog;
import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.report.service.IVehHistoryService;
import com.bitnei.commons.datatables.PagerModel;
import org.apache.log4j.Logger;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;

/**
 * 工况分析-车辆历史状态报表
 * Created by DFY on 2018/5/28.
 */
@Module(name = "工况分析-车辆历史状态报表")
@Controller
@RequestMapping(value = "/report/workCondition/vehHistory")
public class VehHistoryController {
    //模板文件目录
    public final static String BASE = "/module/report/workCondition/vehHistory/";

    private final Logger logger = Logger.getLogger(getClass());
    //模块基础请求前缀
    public final static String BASE_REQ_PATH = "/report/workCondition/vehHistory";
    //列表
    public final static String URL_LIST = BASE_REQ_PATH + "/list";
    //导出
    public final static String URL_EXPORT = BASE_REQ_PATH + "/export";

    @Autowired
    private IVehHistoryService vehHistoryService;

    /**
     * 车辆历史状态报表
     * @return
     */
    @RequestMapping("/list")
    @RequiresPermissions(URL_LIST)
    @SLog(action = "工况分析-列表页面")
    public String list(ModelMap model) {
        String endTime = DateUtil.getNow();
        Long nowTime = System.currentTimeMillis();
        nowTime = nowTime - 6 * 60 * 60 * 1000;
        String startTime = DateUtil.formatTime(new Date(nowTime), DateUtil.FULL_ST_FORMAT);
        model.put("startTime",startTime);
        model.put("endTime", endTime);
        return BASE + "list";
    }

	/**
     * 表格查询
     * @return
     */
    @PostMapping(value = "/datagrid")
    @ResponseBody
    @RequiresPermissions(URL_LIST)
    public PagerModel datagrid(){
        PagerModel pm = vehHistoryService.pageQuery();
        return pm;
    }

    /**
     * 导出
     * @return
     */
    @GetMapping(value = "/export")
    @RequiresPermissions(URL_EXPORT)
    public void export(){
        vehHistoryService.export();
        return ;

    }

}
