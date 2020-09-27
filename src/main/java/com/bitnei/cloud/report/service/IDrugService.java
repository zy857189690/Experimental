package com.bitnei.cloud.report.service;

import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.report.domain.Drug;
import com.bitnei.cloud.service.IBaseService;
import com.bitnei.commons.datatables.PagerModel;



public interface IDrugService extends IBaseService {


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
     Drug get(String id);

    Drug getByName(String name,String dgauges,String dmoleculars);


    /**
     * 新增
     * @param model  新增model
     * @return
     */
    JsonModel insert(Drug model);

    /**
     * 编辑
     * @param model  编辑model
     * @return
     */
    void update(Drug model);

    /**
    * 删除多个
     *
     * @param ids  id列表，用逗号分隔
     * @return
     *  影响行数
    */
    int deleteMulti(String ids);





}
