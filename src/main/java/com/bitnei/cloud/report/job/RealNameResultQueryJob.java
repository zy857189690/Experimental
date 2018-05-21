package com.bitnei.cloud.report.job;

import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.common.HttpUtil;
import com.bitnei.cloud.common.pojo.UnicomURL;
import com.bitnei.cloud.report.domain.SysRealNameAuthenticationEntity;
import com.bitnei.cloud.report.service.ISysRealNameAuthService;
import com.bitnei.cloud.smc.util.DateUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

@Component
public class RealNameResultQueryJob {

    private final Logger LOGGER = Logger.getLogger(getClass());

    @Autowired
    private ISysRealNameAuthService SysRealNameAuthServiceImpl;

//    @Scheduled(fixedRate = 1000*60*60)
    public void queryRealNameResult(){
        try {
            String now = DateUtil.getNow();
            List<SysRealNameAuthenticationEntity> vinList = SysRealNameAuthServiceImpl.selectByAuthenticationResult("1");
            vinList.forEach( SysRealNameAuthenticationEntity ->{
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("vin", SysRealNameAuthenticationEntity.getVin());
                jsonObject.put("imei", "");
                jsonObject.put("brandid", UnicomURL.getVehicleCompanyBrandCode());
                JSONObject result = HttpUtil.unicomHttpUrlByParam(UnicomURL.getQueryRealName(), jsonObject);
                if(result.get("ret_code").equals("0")){
                    String timestamp = result.getString("timestamp");
                    JSONObject responseData = result.getJSONObject("response_data");
                    String isrealname = responseData.getString("isrealname");
                    if(!isrealname.equals("2")){
                        SysRealNameAuthenticationEntity.setAuthenticationResult(isrealname);
                        SysRealNameAuthenticationEntity.setUpdateUserId("-1");
                        SysRealNameAuthenticationEntity.setUpdateTime(now);
                        SysRealNameAuthenticationEntity.setRemarks(responseData.getString("description"));
                        SysRealNameAuthServiceImpl.updateSysRealNameAuthenticationEntityByPrimaryKeySelective(SysRealNameAuthenticationEntity);
                    }
                }else{
                    LOGGER.error("车辆" + SysRealNameAuthenticationEntity.getVin() + "查询认证结果联通返回错误：" + result.get("ret_msg").toString());
                }
            });
        } catch (Exception e) {
            LOGGER.error("定时更新实名认证结果定时器异常：" + Arrays.toString(e.getStackTrace()));
        }
    }

}
