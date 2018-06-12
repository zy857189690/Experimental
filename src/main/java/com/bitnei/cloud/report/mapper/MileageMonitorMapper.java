package com.bitnei.cloud.report.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;


public interface MileageMonitorMapper {

    public List<Map<String,Object>> queryMileageMonthly(Map<String,Object> map );

    public long countMileageMonthly(Map<String,Object> map );




    public List<Map<String,Object>>  queryPopup(Map<String,Object> map );

    public long  countPopup(Map<String,Object> map );


}
