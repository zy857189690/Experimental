package com.bitnei.cloud.report.service;

import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.cloud.service.IBaseService;
import com.bitnei.commons.datatables.PagerModel;
import com.bitnei.cloud.common.bean.AppBean;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

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

    /**
     * 导入查询导出
     */
    void importExport(MultipartFile file, String identity) throws Exception;
    /**
     * 导入查询
     * @param file
     * @param identity
     * @return
     * @throws Exception
     */
    AppBean importQuery(MultipartFile file, String identity) throws Exception;

    String getDate(int d);
}
