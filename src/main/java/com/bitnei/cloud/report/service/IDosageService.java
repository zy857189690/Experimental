package com.bitnei.cloud.report.service;

import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.report.domain.Dosage;
import com.bitnei.cloud.service.IBaseService;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.web.multipart.MultipartFile;



public interface IDosageService extends IBaseService {


    /**
     * 全部查询
     * @return
     *  返回所有
     */
   // Object list(PagerInfo pagerInfo);

    PagerModel pageQuery();
    /**
     * 根据id获取
     *
     * @return
     */
     Dosage get(String id);




    /**
     * 新增
     * @param model  新增model
     * @return
     */
    JsonModel insert(Dosage model);

    /**
     * 编辑
     * @param model  编辑model
     * @return
     */
    void update(Dosage model);

    /**
    * 删除多个
     *
     * @param ids  id列表，用逗号分隔
     * @return
     *  影响行数
    */
    int deleteMulti(String ids);


    /**
     * 批量导入
     *
     * @param file 文件
     */
    void batchImport(MultipartFile file);


    /**
     * 批量更新
     *
     * @param file 文件
     */
    void batchUpdate(MultipartFile file);


}
