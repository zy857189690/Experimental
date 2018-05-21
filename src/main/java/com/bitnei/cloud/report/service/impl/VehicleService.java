package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.service.IVehicleService;
import com.bitnei.cloud.service.impl.BaseService;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.VehicleMapper")
public class VehicleService extends BaseService implements IVehicleService {

    public Integer getVehicleCount(){
        Integer count = unique("vehicleCount", null);
        return count;
    }

    @Override
    public List<Map<String, Object>> getVehicleInfo(Integer startRow, Integer pageSize, String brand){
        Map<String,Object> param = new HashMap<String,Object>();
        param.put("startRow", startRow);
        param.put("pageSize", pageSize);
        param.put("brand", brand);
        List<Map<String, Object>> vehInfoMap = findBySqlId("findVehicleByPage", param);
        return vehInfoMap;
    }

}
