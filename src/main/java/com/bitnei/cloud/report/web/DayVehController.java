package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.ExcelUtil;
import com.bitnei.cloud.common.annotation.Module;
import com.bitnei.cloud.common.annotation.SLog;
import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.cloud.report.service.IDayVehService;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * 工况分析-单车日报表
 * Created by DFY on 2018/5/28.
 */
@Module(name = "工况分析-单车日报表")
@Controller
@RequestMapping(value = "/report/workCondition/dayVeh")
public class DayVehController {
    //模板文件目录
    public final static String BASE = "/module/report/workCondition/dayVeh/";

    private final Logger logger = Logger.getLogger(getClass());
    //模块基础请求前缀
    public final static String BASE_REQ_PATH = "/report/workCondition/dayVeh";
    //新增
    public final static String URL_LIST = BASE_REQ_PATH + "/list";
    //新增
    public final static String URL_ADD = BASE_REQ_PATH + "/add";
    //编辑
    public final static String URL_UPDATE = BASE_REQ_PATH + "/update";
    //查看
    public final static String URL_VIEW = BASE_REQ_PATH + "/view";
    //删除
    public final static String URL_DEL = BASE_REQ_PATH + "/del";
    //导出
    public final static String URL_EXPORT = BASE_REQ_PATH + "/export";
    //导入
    public final static String URL_IMPORT = BASE_REQ_PATH + "/import";

    @Autowired
    private IDayVehService dayVehService;
    /**
     * 工况分析-跳转列表页面
     * @return
     */
    @RequestMapping("/list")
    @RequiresPermissions(URL_LIST)
    @SLog(action = "工况分析-列表页面")
    public String list() {
        return BASE + "list";
    }

    /**
     * 查询车辆种类下拉列表
     *
     * @return
     */
    @RequestMapping("/queryVehTypeList")
    @ResponseBody
    public String queryVehTypeList() {
        return dayVehService.queryVehTypeList();
    }

    /**
     * 查询车辆型号下拉列表
     *
     * @return
     */
    @RequestMapping("/queryVehModelList")
    @ResponseBody
    public String queryVehModelList() {
        String result = dayVehService.queryVehModelList();
        return result;
    }
    /**
     * 查询区域树形下拉列表
     *
     * @return
     */
    @RequestMapping("/queryAreaList")
    @ResponseBody
    public String queryAreaList() {
        return dayVehService.queryAreaList();
    }

    /**
     * 查询单位树形下拉列表
     *
     * @return
     */
    @RequestMapping("/queryUnitList")
    @ResponseBody
    public String queryUnitList() {
        return dayVehService.queryUnitList();
    }

    /**
     * 表格查询
     * @return
     */
    @PostMapping(value = "/datagrid")
    @ResponseBody
    @RequiresPermissions(URL_LIST)
    public PagerModel datagrid(){

        PagerModel pm = dayVehService.pageQuery();
        return pm;

    }

    /**
     * 上传文件(限制大小)
     *
     * @param request
     * @return
     * @throws IOException
     */
    @RequestMapping("/fileMin")
    @ResponseBody
    public AppBean fileMin(HttpServletRequest request) throws Exception {
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        MultipartFile mf = null;
        for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
            // 上传文件名
            mf = entity.getValue();
            break;
        }
        if (mf == null) {
            return new AppBean(-1, "文件获取失败");
        }
        long fileSize = mf.getSize();
        if (fileSize > 10240 * 1024) {
            return new AppBean(-1, "文件大小超出最大10M限制！");
        }
        List<Map> lisVin  =  ExcelUtil.getVehicleInformation(mf);//返回得到Excel表中的所有车辆的vin和车牌信息

        if (lisVin.size() == 0) {
            return new AppBean(-1, "文件内容不能为空！");
        }

        AppBean app = new AppBean();
        app.getData().put("path", "");//Map<String, Object>.put("path", "")
        app.getData().put("fileName", "");
        app.setMessage("");
        return app;
    }

    /**
     * 导出
     * @return
     */
    @GetMapping(value = "/export")
    @RequiresPermissions(URL_EXPORT)
    public void export(){

        dayVehService.export();
        return ;

    }
}
