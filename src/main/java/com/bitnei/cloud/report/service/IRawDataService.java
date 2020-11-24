package com.bitnei.cloud.report.service;

import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.service.IBaseService;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface IRawDataService  extends IBaseService {
    PagerModel pageQuery();

    JsonModel importRawDatas(String name, String code, String secondaryCoefficient,
                             String oneCoefficient,
                             String parameter,MultipartFile file) throws IOException;
}
