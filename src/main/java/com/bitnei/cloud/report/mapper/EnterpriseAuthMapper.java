package com.bitnei.cloud.report.mapper;

import com.bitnei.cloud.report.domain.EnterpriseAuth;

public interface EnterpriseAuthMapper {
    /**
     * 获取认证车辆的相关绑定信息
     *
     * @param enterpriseAuth 查询条件PO
     * @return 查询到的车辆信息
     */
    EnterpriseAuth selectByExample(EnterpriseAuth enterpriseAuth);

    EnterpriseAuth findBySimCardId(String id);
}