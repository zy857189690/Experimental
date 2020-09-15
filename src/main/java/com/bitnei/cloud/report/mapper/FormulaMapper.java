package com.bitnei.cloud.report.mapper;

import com.bitnei.cloud.report.domain.Formula;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;


@Component
@Mapper
public interface FormulaMapper {


    /**
     * 通过ID查询
     *
     * @param params
     * @return
     */
    Formula findById(Map<String, Object> params);


 	/**
     * 插入
     * @param obj
     * @return
     */
    int insert(Formula obj);

    /**
     * 更新
     * @param obj
     * @return
     */
    int update(Formula obj);

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
    List<Formula> pagerModel(Map<String, Object> params);
}
