package com.bitnei.cloud.report.mapper;

import com.bitnei.cloud.report.domain.ExperimentalDataDatil;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ExperimentalStageMapper {
    void insertExDataDatil(ExperimentalDataDatil experimentalDataDatil);
}
