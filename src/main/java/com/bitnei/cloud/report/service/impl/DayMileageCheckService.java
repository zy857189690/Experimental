package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.common.bean.ExcelData;
import com.bitnei.cloud.common.util.DataLoader;
import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.common.util.EasyExcel;
import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.service.IDayMileageCheckService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.RequestContext;

import java.util.List;

/**
 * Created by xiaojinlu  on 2018/6/6.
 */
@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.DayMileageCheckMapper" )
public class DayMileageCheckService  extends BaseService implements IDayMileageCheckService {
    @Override
    public PagerModel pageQuery() {
        DataGridOptions options = ServletUtil.getDataLayOptions();
        PagerModel pm = findPagerModel("pagerModel",options);
        return pm;
    }

    @Override
    public void export() {
        List list = findBySqlId("pagerModel", ServletUtil.getQueryParams());
        DataLoader.loadNames(list);
        DataLoader.loadDictNames(list);

        String srcBase = RequestContext.class.getResource("/templates/").getFile();
        String srcFile = srcBase +"module/report/operation/dayMileageCheck/export.xls";

        ExcelData ed = new ExcelData();
        ed.setTitle("单日里程核算日报");
        ed.setExportTime(DateUtil.getNow());
        ed.setData(list);
        String outName = String.format("%s-导出-%s.xls", "单日里程核算日报", DateUtil.getShortDate());
        EasyExcel.renderResponse(srcFile,outName,ed);
    }
}
