package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.common.bean.ExcelData;
import com.bitnei.cloud.common.util.DataLoader;
import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.cloud.report.domain.Demo;
import com.bitnei.cloud.report.service.IDemoService;
import org.springframework.web.servlet.support.RequestContext;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.LayModel;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import com.bitnei.commons.util.PagerUtil;
import com.bitnei.commons.util.UtilHelper;
import org.springframework.stereotype.Service;
import com.bitnei.cloud.common.util.EasyExcel;

import java.util.List;

/**
* <p>
* ----------------------------------------------------------------------------- <br>
* 工程名 ： 基础框架 <br>
* 功能： DemoService实现<br>
* 描述： DemoService实现<br>
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
@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.DemoMapper" )
public class DemoService extends BaseService implements IDemoService {

    @Override
    public PagerModel pageQuery() {
        DataGridOptions options = ServletUtil.getDataLayOptions();
        PagerModel pm = findPagerModel("pagerModel",options);
        return pm;
    }

    /**
    * 新增
    * @param o
    * @return
    */
    @Override
    public int insert(Object o) {

        Demo demo = (Demo)o;
        demo.setId(UtilHelper.getUUID());
        demo.setCreateTime(DateUtil.getNow());
        demo.setCreateBy(ServletUtil.getCurrentUser());
        return super.insert(demo);
    }

    /**
    * 更新
    * @param o
    * @return
    */
    @Override
    public int update(Object o) {
        Demo demo = (Demo)o;
        demo.setUpdateTime(DateUtil.getNow());
        demo.setUpdateBy(ServletUtil.getCurrentUser());
        return super.update(demo);
    }

    @Override
    public <T> T findById(String id) {
        Demo demo  = super.findById(id);
        return (T)demo;
    }

    /**
    * 删除多个
    * @param ids
    * @return
    */
    @Override
    public int deleteMulti(String ids) {
        String[] arr = ids.split(",");
        int count = 0;
        for (String id:arr){
            int r = super.delete(id);
            count+=r;
        }
        return count;
    }

    @Override
    public void export() {

        List list = findBySqlId("pagerModel", ServletUtil.getQueryParams());
        DataLoader.loadNames(list);
        DataLoader.loadDictNames(list);

        String srcBase = RequestContext.class.getResource("/templates/").getFile();
        String srcFile = srcBase +"module/demo/demo/export.xls";

        ExcelData ed = new ExcelData();
        ed.setTitle("演示管理");
        ed.setExportTime(DateUtil.getNow());
        ed.setData(list);
        String outName = String.format("%s-导出-%s.xls", "演示管理", DateUtil.getShortDate());
        EasyExcel.renderResponse(srcFile,outName,ed);



    }

}