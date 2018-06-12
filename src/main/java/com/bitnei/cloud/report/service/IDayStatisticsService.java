package com.bitnei.cloud.report.service;

import com.bitnei.cloud.service.IBaseService;
import com.bitnei.commons.datatables.PagerModel;

import java.util.List;
import java.util.Map;

/**
 * 运营分析-日汇总报表
 * Created by DFY on 2018/5/30.
 */
public interface IDayStatisticsService extends IBaseService {

    /**
     * 车辆监控情况统计
     *
     * @return
     */
    PagerModel queryMonitoringTable();

    /**
     * 车辆活跃情况统计
     *
     * @return
     */
    PagerModel queryActiveTable();

    /**
     * 车辆闲置情况统计
     *
     * @return
     */
    PagerModel queryIdleTable();

    /**
     * 闲置车辆统计条件设置查询
     *
     * @return
     */
    Map<String, Object> queryIdleByMileageValue();

    /**
     * 车辆行驶情况统计
     *
     * @return
     */
    PagerModel queryTravelTable();

    /**
     * 充耗电情况统计
     *
     * @return
     */
    PagerModel queryElectricityTable();

    /**
     * 查询弹出框表格
     *
     * @return
     */
    PagerModel queryDialogSearchTable();

    /**
     * 导出
     */
    void export();
}
