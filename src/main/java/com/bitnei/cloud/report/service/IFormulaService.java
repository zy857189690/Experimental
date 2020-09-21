package com.bitnei.cloud.report.service;

import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.report.domain.Formula;
import com.bitnei.cloud.service.IBaseService;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;


public interface IFormulaService extends IBaseService {


    /**
     * 全部查询
     * @return
     *  返回所有
     */
    PagerModel pageQuery();

    /**
     * 根据id获取
     *
     * @return
     */
     Formula get(String id);




    /**
     * 新增
     * @param model  新增model
     * @return
     */
    JsonModel insert(Formula model);

    /**
     * 编辑
     * @param model  编辑model
     * @return
     */
    void update(Formula model);

    /**
    * 删除多个
     *
     * @param ids  id列表，用逗号分隔
     * @return
     *  影响行数
    */
    int deleteMulti(String ids);


    Map<String,Object> findFormulaById(String id);
}
