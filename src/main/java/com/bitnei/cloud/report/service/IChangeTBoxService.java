package com.bitnei.cloud.report.service;

import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.service.IBaseService;

import java.util.Map;

public interface IChangeTBoxService extends IBaseService {

    public JSONObject changeTBox(Map<String,String> map);

}
