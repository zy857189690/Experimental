package com.bitnei.cloud.report.service;

import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.report.domain.Demo1;
import com.bitnei.cloud.report.domain.ExperimentalStage;
import com.bitnei.cloud.service.IBaseService;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


/**
* <p>
* ----------------------------------------------------------------------------- <br>
* 工程名 ： 基础框架 <br>
* 功能： Demo1Service接口<br>
* 描述： Demo1Service接口，在xml中引用<br>
* 授权 : (C) Copyright (c) 2017 <br>
* 公司 : 北京理工新源信息科技有限公司<br>
* ----------------------------------------------------------------------------- <br>
* 修改历史 <br>
* <table width="432" border="1">
* <tr>
* <td>版本</td>
* <td>时间</td>
* <td>作者</td>
* <td>改变</td>
* </tr>
* <tr>
* <td>1.0</td>
* <td>2018-03-13 17:07:14</td>
* <td>chenpeng</td>
* <td>创建</td>
* </tr>
* </table>
* <br>
* <font color="#FF0000">注意: 本内容仅限于[北京理工新源信息科技有限公司]内部使用，禁止转发</font> <br>
*
* @version 1.0
*
* @author chenpeng
* @since JDK1.8
*/

public interface IExperimentalStageService extends IBaseService {

    /**
    * 分页查询
    * @return
    */
    PagerModel pageQuery();

    /**
    * 删除多个
    */
    int deleteMulti(String ids);

    /**
    * 导出
    */
    void export();

    JsonModel saveSubmit(ExperimentalStage experimentalStage);

    JsonModel importHoles(String name, String code, MultipartFile file) throws Exception;

    List uploadPictureList(MultipartFile[] file, HttpServletRequest request);
}
