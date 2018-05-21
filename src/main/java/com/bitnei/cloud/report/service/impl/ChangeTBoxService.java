package com.bitnei.cloud.report.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.common.HttpUtil;
import com.bitnei.cloud.common.pojo.UnicomURL;
import com.bitnei.cloud.report.service.IChangeTBoxService;
import com.bitnei.cloud.service.impl.BaseService;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
//@Mybatis(namespace = "com.bitnei.cloud.report.mapper.ChangeTBoxMapper")
public class ChangeTBoxService extends BaseService implements IChangeTBoxService{

    public JSONObject changeTBox(Map<String,String> map){
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("vin", map.get("vin"));
        jsonObject.put("brandid", UnicomURL.getVehicleCompanyBrandCode());
        jsonObject.put("oldiccid", map.get("oldiccid"));
        jsonObject.put("newiccid", map.get("newiccid"));
        jsonObject.put("imsi", map.get("imsi"));
        jsonObject.put("msisdn", map.get("msisdn"));
        jsonObject.put("imei", map.get("imei"));

        JSONObject result = HttpUtil.unicomHttpUrlByParam(UnicomURL.getChangeTbox(), jsonObject);

        return result;
    }

}
