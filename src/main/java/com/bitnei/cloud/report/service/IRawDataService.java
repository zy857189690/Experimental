package com.bitnei.cloud.report.service;

import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.service.IBaseService;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface IRawDataService  extends IBaseService {
    PagerModel pageQuery();

    JsonModel importRawDatas(MultipartFile file) throws IOException;

    List<Map<String,Object>> get(String id);
}
