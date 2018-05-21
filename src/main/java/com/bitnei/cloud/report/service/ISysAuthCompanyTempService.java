package com.bitnei.cloud.report.service;

import com.bitnei.cloud.report.domain.SysAuthenticationCompanyTempEntity;
import com.bitnei.cloud.service.IBaseService;
import com.bitnei.commons.datatables.PagerModel;

public interface ISysAuthCompanyTempService extends IBaseService {
    PagerModel pagerQuery();

    SysAuthenticationCompanyTempEntity findByPk(String id);

    void updateRealName(SysAuthenticationCompanyTempEntity sysAuthenticationCompanyTempEntity);
}
