package com.bitnei.cloud.report.service;

import com.alibaba.fastjson.JSONObject;

import java.util.Map;

public interface IMileageMonitorService {

    /**
     * 查询里程分布
     * @param map
     * @return
     */
    public JSONObject queryMileageMonthly(Map<String, Object> map);


    /**
     * 下载里程分布
     * @param map
     */
    public void downloadMileageMonthly(Map<String, Object> map);


    /**
     * 查询里程分布钻取
     * @param map
     * @return
     */
    public JSONObject queryPopup(Map<String, Object> map);


    /**
     * 下载里程分布钻取
     * @param map
     */
    public void downloadPopup(Map<String, Object> map);
}
