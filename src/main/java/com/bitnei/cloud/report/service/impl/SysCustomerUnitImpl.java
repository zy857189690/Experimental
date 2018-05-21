package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.service.ISysCustomerUnit;
import com.bitnei.cloud.service.impl.BaseService;
import org.springframework.stereotype.Service;


@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.SysCustomerUnitMapper" )
public class SysCustomerUnitImpl extends BaseService implements ISysCustomerUnit {
}
