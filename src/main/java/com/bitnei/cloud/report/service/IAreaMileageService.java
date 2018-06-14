package com.bitnei.cloud.report.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import java.util.Map;

public interface IAreaMileageService {

    /**
     * 查询所有行驶区域
     * @return
     */
    public JSONArray getDrivingArea();


    /**
     * 查询所有运营单位
     * @return
     */
    public JSONArray getUnit();


    /**
     * 查询区域月报
     * @return
     */
    public JSONObject queryAreaMonthly(Map<String, Object> params);

    /**
     * 下载区域月报
     * @param params
     */
    public void downloadAreaMonthly(Map<String, Object> params);

}
