package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.common.bean.ExcelData;
import com.bitnei.cloud.common.util.DataLoader;
import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.common.util.EasyExcel;
import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.service.IAuthLogService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.support.RequestContext;

import java.util.List;

@Service
@Transactional
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.AuthLogMapper")
public class AuthLogService extends BaseService implements IAuthLogService{

    /**
     * 个人实名认证分页查询
     * @return
     */
    @Override
    public PagerModel pageQuery() {

        DataGridOptions options = ServletUtil.getDataLayOptions();
        PagerModel pm = findPagerModel("findAuthLog",options);
        return pm;

    }

    /**
     * 导出
     */
    @Override
    public void export() {

        List list = findBySqlId("findAuthLog",ServletUtil.getQueryParams());
        DataLoader.loadNames(list);
        DataLoader.loadDictNames(list);

        String srcBase = RequestContext.class.getResource("/templates/").getFile();
        String srcFile = srcBase +"module/report/AuthLog/export.xls";

        ExcelData ed = new ExcelData();
        ed.setTitle("实名日志");
        ed.setExportTime(DateUtil.getNow());
        ed.setData(list);
        String outName = String.format("%s-导出-%s.xls", "实名日志", DateUtil.getShortDate());
        EasyExcel.renderResponse(srcFile,outName,ed);

    }
}