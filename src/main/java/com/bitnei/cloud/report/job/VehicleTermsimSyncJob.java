package com.bitnei.cloud.report.job;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.common.HttpUtil;
import com.bitnei.cloud.common.pojo.UnicomURL;
import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.report.domain.SysRealNameAuthenticationEntity;
import com.bitnei.cloud.report.service.ISysRealNameAuthService;
import com.bitnei.cloud.report.service.IVehicleService;
import com.bitnei.commons.util.UtilHelper;
import org.apache.log4j.Logger;
import org.apache.log4j.spi.NOPLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;
import java.util.TimerTask;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@Component
public class VehicleTermsimSyncJob {

    private final Logger LOGGER = Logger.getLogger(getClass());

    @Autowired
    private IVehicleService vehicleService;
    @Autowired
    private ISysRealNameAuthService SysRealNameAuthServiceImpl;

    /**
     * 向联通同步车辆数据
     */
//    @Scheduled(fixedRate = 1000*60*60)
    public void syncVehTerm(){
        String now = DateUtil.getNow();
        LOGGER.info("车辆同步定时器启动……" + now);
        String brand = UnicomURL.getVehicleCompanyBrandCode();

        Integer vehCount = vehicleService.getVehicleCount();
        Integer pageSize = 200;
        Integer pages = vehCount/200;
        if(vehCount % pageSize != 0){
            pages++;
        }

        if(vehCount != 0) {
            ExecutorService executorService = Executors.newFixedThreadPool(50);
            for (int i = 0; i < pages; i++) {
                executorService.execute(new SyncVehicleAuthThread(now, brand, pageSize, i));
            }
        }


    }

    private class SyncVehicleAuthThread implements Runnable{
        private String now;
        private String brand;
        private Integer pageSize;
        private int i;

        public SyncVehicleAuthThread(String now, String brand, Integer pageSize, int i) {
            this.now = now;
            this.brand = brand;
            this.pageSize = pageSize;
            this.i = i;
        }

        @Override
        public void run() {
            Integer startRow = pageSize*i;
            List<Map<String,Object>> vehinfoMap = vehicleService.getVehicleInfo(startRow, pageSize, brand);

            JSONObject requestData = new JSONObject();
            requestData.put("vehicles", vehinfoMap);

            JSONObject result = HttpUtil.unicomHttpUrlByParam("sync.vehicle", requestData);
            if(result == null){
                LOGGER.error("请求联通同步车辆信息接口异常，接口未返回任何数据");
            }
            String responseResult = result.getString("ret_code");
            JSONObject responseData = result.getJSONObject("response_data");
            if(responseResult.equals("0")) {
                JSONArray vcbacks = responseData.getJSONArray("vcbacks");

                for (int j = 0, k = vcbacks.size(); j < k; j++) {

                    JSONObject vehicleResult = vcbacks.getJSONObject(j);
                    String retCode = vehicleResult.get("retcode").toString();
                    String vehicleVin = vehicleResult.get("vin").toString();

                    SysRealNameAuthenticationEntity sysRealNameAuthenticationEntity = SysRealNameAuthServiceImpl.selectRealNameVin(vehicleVin);
                    if (sysRealNameAuthenticationEntity == null) {
                        sysRealNameAuthenticationEntity = new SysRealNameAuthenticationEntity();
                        String uuid = UtilHelper.getUUID();
                        sysRealNameAuthenticationEntity.setId(uuid);
                        sysRealNameAuthenticationEntity.setVin(vehicleVin);
                        sysRealNameAuthenticationEntity.setAuthenticationResult("0");
                        sysRealNameAuthenticationEntity.setRemarks(vehicleResult.getString("message"));
                        sysRealNameAuthenticationEntity.setCreateUserId("-1");
                        sysRealNameAuthenticationEntity.setCreateTime(now);
                        sysRealNameAuthenticationEntity.setState("1");
                        sysRealNameAuthenticationEntity.setSynResult(retCode);
                        sysRealNameAuthenticationEntity.setSysTime(now);
                        SysRealNameAuthServiceImpl.insertSelective(sysRealNameAuthenticationEntity);
                        LOGGER.info("车辆" + vehicleVin + "同步完成");
                    } else {
                        sysRealNameAuthenticationEntity.setRemarks(responseResult);
                        sysRealNameAuthenticationEntity.setSynResult(retCode);
                        sysRealNameAuthenticationEntity.setSysTime(now);
                        sysRealNameAuthenticationEntity.setUpdateTime(now);
                        sysRealNameAuthenticationEntity.setUpdateUserId("-1");
                        SysRealNameAuthServiceImpl.updateByPrimaryKeySelective(sysRealNameAuthenticationEntity);
                        LOGGER.info("车辆" + vehicleVin + "同步完成，更新数据完成");
                    }
                }
            }else{
                LOGGER.error("请求联通接口时返回错误信息：" + responseData.getString("ret_msg"));
            }
        }
    }
}
