package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.SysModule;
import com.bitnei.cloud.report.service.IndexService;
import com.bitnei.cloud.service.impl.BaseService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Slf4j
@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.IndexMapper")
public class IndexServiceImpl extends BaseService implements IndexService {

    @Override
    public List<SysModule> findSysMoudle() {
        Map<String,String> map =new HashMap<>();
        return  findBySqlId("findSysMoudle",map);
    }
}
