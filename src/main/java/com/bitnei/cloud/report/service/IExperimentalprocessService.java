package com.bitnei.cloud.report.service;

import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.report.domain.Experimentalprocess;
import com.bitnei.cloud.service.IBaseService;
import com.bitnei.commons.datatables.PagerModel;

import java.util.List;
import java.util.Map;

public interface IExperimentalprocessService extends IBaseService {
    PagerModel pageQuery();

    Map<String, Object> indById(String id);
    JsonModel insert(Experimentalprocess experimentalprocess);

    JsonModel checkUpdate(Experimentalprocess experimentalprocess);

    List<Map<String,Object>> findNhBy(String id);
}
