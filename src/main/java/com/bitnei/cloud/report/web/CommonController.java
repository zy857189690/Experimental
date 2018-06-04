package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.annotation.Module;
import com.bitnei.cloud.report.service.ICommonService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 公共接口
 * Created by DFY on 2018/5/28.
 */
@Module(name = "运营分析-日汇总报表")
@Controller
@RequestMapping(value = "/report/common")
public class CommonController {

    private final Logger logger = Logger.getLogger(getClass());
    @Autowired
    private ICommonService commonService;

    /**
     * 查询区域树形下拉列表
     *
     * @return
     */
    @RequestMapping("/queryAreaList")
    @ResponseBody
    public String queryAreaList() {
        return commonService.queryAreaList();
    }

    /**
     * 查询单位树形下拉列表
     *
     * @return
     */
    @RequestMapping("/queryUnitList")
    @ResponseBody
    public String queryUnitList() {
        return commonService.queryUnitList();
    }

    /**
     * 查询车辆型号下拉列表
     *
     * @return
     */
    @RequestMapping("/queryVehModelList")
    @ResponseBody
    public String queryVehModelList() {
        String result = commonService.queryVehModelList();
        return result;
    }

    /**
     * 查询车辆种类下拉列表
     *
     * @return
     */
    @RequestMapping("/queryVehTypeList")
    @ResponseBody
    public String queryVehTypeList() {
        return commonService.queryVehTypeList();
    }

    /**
     * 查询车辆阶段下拉列表
     *
     * @return
     */
    @RequestMapping("/queryVehStageList")
    @ResponseBody
    public String queryVehStageList() {
        return commonService.queryVehStageList();
    }
}
