package com.bitnei.cloud.report.job;

import com.bitnei.cloud.report.service.ISysRealNameAuthService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@SuppressWarnings("all")
public class RealNameSyncJob {

    Logger logger = LoggerFactory.getLogger(RealNameSyncJob.class);

    @Autowired
    ISysRealNameAuthService sysRealNameAuthService;

    /**
     * 轮询校验人工审核是否通过
     */
//    @Scheduled(fixedRate = 1000)
    public void sync() {
        sysRealNameAuthService.refreshRealNameState();
    }

}
