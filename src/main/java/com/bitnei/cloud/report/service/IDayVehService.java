package com.bitnei.cloud.report.service;

import com.bitnei.cloud.service.IBaseService;
import com.bitnei.commons.datatables.PagerModel;

public interface IDayVehService extends IBaseService{
    /**
     * 查询车辆种类树形下拉列表
     * @return
     */
    String queryVehTypeList();

    /**
     * 查询车辆型号下拉列表
     * @return
     */
    String queryVehModelList();

    /**
     * 查询区域树形下拉列表
     *
     * @return
     */
    String queryAreaList();

    /**
     * 查询单位树形下拉列表
     * @return
     */
    String queryUnitList();

    /**
     * 分页查询
     * @return
     */
    PagerModel pageQuery();

    /**
     * 导出
     */
    void export();
}
