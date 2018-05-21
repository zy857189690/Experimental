package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.service.ISysAuthPersonalTempService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.SysAuthPersonalTempMapper" )
public class SysAuthPersonalTempService extends BaseService implements ISysAuthPersonalTempService {
    @Override
    public PagerModel pagerQuery() {
        DataGridOptions options = ServletUtil.getDataLayOptions();
        PagerModel pm = findPagerModel("pagerModel",options);
        return pm;
    }
}