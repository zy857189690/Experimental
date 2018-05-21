package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.SysCustomerUnitEntity;
import com.bitnei.cloud.report.mapper.SysCustomerUnitMapper;
import com.bitnei.cloud.report.service.ISysCustomerUnitService;
import com.bitnei.cloud.service.impl.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.SysCustomerUnitMapper" )
public class SysCustomerUnitServiceImpl extends BaseService implements ISysCustomerUnitService {
}
