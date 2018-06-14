package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.annotation.Module;
import com.bitnei.cloud.common.annotation.SLog;
import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.cloud.report.service.IAnomalyVehService;
import com.bitnei.commons.datatables.PagerModel;
import org.apache.log4j.Logger;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;

/**
 * 异常车辆统计
 * Created by DFY on 2018/5/28.
 */
@Module(name = "异常分析-异常车辆统计")
@Controller
@RequestMapping(value = "/report/anomaly/anomalyVeh")
public class AnomalyVehController {
    //模板文件目录
    public final static String BASE = "/module/report/anomaly/anomalyVeh/";

    private final Logger logger = Logger.getLogger(getClass());
    //模块基础请求前缀
    public final static String BASE_REQ_PATH = "/report/anomaly/anomalyVeh";
    //列表
    public final static String URL_LIST = BASE_REQ_PATH + "/list";

    //导出
    public final static String URL_EXPORT = BASE_REQ_PATH + "/export";
    //导入
    public final static String URL_IMPORT = BASE_REQ_PATH + "/import";

    @Autowired
    private IAnomalyVehService anomalyVehService;

    /**
     * 异常车辆统计-跳转列表页面
     * @return
     */
    @RequestMapping("/list")
    @RequiresPermissions(URL_LIST)
    @SLog(action = "异常车辆统计-跳转列表页面")
    public String list() {
        return BASE + "list";
    }

    /**
     * 表格查询
     * @return
     */
    @PostMapping(value = "/datagrid")
    @ResponseBody
    @RequiresPermissions(URL_LIST)
    public PagerModel datagrid(){
        PagerModel pm = anomalyVehService.pageQuery();
        return pm;
    }

    /**
     * 导出
     * @return
     */
    @GetMapping(value = "/export")
    @RequiresPermissions(URL_EXPORT)
    public void export(){
        anomalyVehService.export();
        return ;

    }

    /**
     * 导入查询实现
     * @param file
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/improtSearch")
    @ResponseBody
    @RequiresPermissions(URL_LIST)
    public AppBean improtSearch(HttpServletRequest request, MultipartFile file, String identity) throws Exception{

        if (file == null) {
            return new AppBean(-1, "文件获取失败！");
        }

        Long fileSize = file.getSize();
        if (fileSize > 10240 * 1024) {
            return new AppBean(-1, "文件大小超出最大10M限制！");
        }

        String fileName = file.getOriginalFilename();
        String suffixName = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
        if (!".xls".equals(suffixName) && !".xlsx".equals(suffixName)) {
            return new AppBean(-1, "上传文件格式不正确，确认文件后缀名为xls、xlsx！");
        }

        AppBean appBean = anomalyVehService.importQuery(request,file, identity);
        return appBean;
    }
}
