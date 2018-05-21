package com.bitnei.cloud.report.service;

import com.bitnei.cloud.service.IBaseService;
import com.bitnei.commons.datatables.PagerModel;

public interface IAuthLogService extends IBaseService {


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