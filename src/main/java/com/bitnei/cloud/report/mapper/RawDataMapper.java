package com.bitnei.cloud.report.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface RawDataMapper {
    void insert(Map<String, Object> map);
}
