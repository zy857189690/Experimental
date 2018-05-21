package com.bitnei.cloud.report.service;

import com.bitnei.cloud.service.IBaseService;

import java.util.List;
import java.util.Map;

public interface IVehicleService extends IBaseService {

    public Integer getVehicleCount();

    public List<Map<String, Object>> getVehicleInfo(Integer startRow, Integer pageSize, String brand);
}
