package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.common.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.service.IRawDataService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.stereotype.Service;

@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.RawDataMapper")
public class RawDataServiceImpl extends BaseService implements IRawDataService  {
    @Override
    public PagerModel pageQuery() {
        DataGridOptions dataLayOptions = ServletUtil.getDataLayOptions();
        PagerModel pm = findPagerModel("pagerModel", dataLayOptions);
        return pm;
    }


}
