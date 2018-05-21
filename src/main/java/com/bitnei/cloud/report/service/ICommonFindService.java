package com.bitnei.cloud.report.service;

import com.bitnei.cloud.service.IBaseService;
import com.bitnei.commons.datatables.PagerModel;

public interface ICommonFindService extends IBaseService{


    /**
     * 车辆分页查询
     * @return
     */
    PagerModel pageQuery();

    /**
     * 个人车主分页查询
     * @return
     */
    PagerModel datagridPersonal();


}