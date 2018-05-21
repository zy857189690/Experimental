package com.bitnei.cloud.report.service;


import com.bitnei.cloud.service.IBaseService;
import com.bitnei.commons.datatables.PagerModel;


/**
* <p>
* ----------------------------------------------------------------------------- <br>
* 工程名 ： 基础框架 <br>
* 功能： DemoService接口<br>
* 描述： DemoService接口，在xml中引用<br>
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
* <td>2018-01-08 15:16:18</td>
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

public interface IDemoService extends IBaseService {

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

}
