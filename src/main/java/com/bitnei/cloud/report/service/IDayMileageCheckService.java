package com.bitnei.cloud.report.service;

import com.bitnei.cloud.service.IBaseService;
import com.bitnei.commons.datatables.PagerModel;

/**
 * Created by xiaojinlu on 2018/6/6.
 */
public interface IDayMileageCheckService extends IBaseService {
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
