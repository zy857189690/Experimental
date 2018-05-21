package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.service.ICommonFindService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.stereotype.Service;

@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.CommonFindMapper" )
public class CommonFindService extends BaseService implements ICommonFindService {


    /**
     * 车辆分页查询
     * @return
     */
    @Override
    public PagerModel pageQuery() {

        DataGridOptions options = ServletUtil.getDataLayOptions();
        PagerModel pm = findPagerModel("findVIN",options);
        return pm;

    }


    /**
     * 个人车主分页查询
     * @return
     */
    @Override
    public PagerModel datagridPersonal() {

        DataGridOptions options = ServletUtil.getDataLayOptions();
        PagerModel pm = findPagerModel("findPersonal",options);
        return pm;

    }
}