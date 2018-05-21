package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.SysTermModelUnitEntity;
import com.bitnei.cloud.report.service.ITermUnitService;
import com.bitnei.cloud.service.impl.BaseService;
import org.springframework.stereotype.Service;

@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.SysTermModelUnitMapper")
public class TermUnitService extends BaseService implements ITermUnitService {

    public SysTermModelUnitEntity selectByPrimaryKey(String id){
        SysTermModelUnitEntity sysTermModelUnitEntity = unique("selectByPrimaryKey", id);
        return sysTermModelUnitEntity;
    }
}
