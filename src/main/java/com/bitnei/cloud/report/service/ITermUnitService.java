package com.bitnei.cloud.report.service;

import com.bitnei.cloud.report.domain.SysTermModelUnitEntity;
import com.bitnei.cloud.service.IBaseService;

public interface ITermUnitService extends IBaseService {

    public SysTermModelUnitEntity selectByPrimaryKey(String id);

}
