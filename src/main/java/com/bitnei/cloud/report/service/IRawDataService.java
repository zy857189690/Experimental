package com.bitnei.cloud.report.service;

import com.bitnei.cloud.service.IBaseService;
import com.bitnei.commons.datatables.PagerModel;

public interface IRawDataService  extends IBaseService {
    PagerModel pageQuery();
}
