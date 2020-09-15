package com.bitnei.cloud.report.mapper;

import com.bitnei.cloud.report.domain.Dosage;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;


@Component
@Mapper
public interface DosageMapper {


    /**
     * 通过ID查询
     *
     * @param params
     * @return
     */
    Dosage findById(Map<String, Object> params);


 	/**
     * 插入
     * @param obj
     * @return
     */
    int insert(Dosage obj);

    /**
     * 更新
     * @param obj
     * @return
     */
    int update(Dosage obj);

	/**
     * 删除
     * @param params
     * @return
     */
    int delete(Map<String, Object> params);

    /**
     * 查询
     * @param params
     * @return
    */
    List<Dosage> pagerModel(Map<String, Object> params);
}
