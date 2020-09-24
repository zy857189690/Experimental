package com.bitnei.cloud.report.service;

import com.bitnei.cloud.report.domain.SysModule;
import com.bitnei.cloud.service.IBaseService;

import java.util.List;

public interface IndexService extends IBaseService {
    List<SysModule> findSysMoudle();
}
