package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.ExcelUtil;
import com.bitnei.cloud.common.MemCacheManager;
import com.bitnei.cloud.common.annotation.Module;
import com.bitnei.cloud.common.annotation.SLog;
import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.report.service.IDayVehService;
import com.bitnei.commons.datatables.PagerModel;
import org.apache.log4j.Logger;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

/**
 * 工况分析-单车日报表
 * Created by DFY on 2018/5/28.
 */
@Module(name = "工况分析-单车日报表")
@Controller
@RequestMapping(value = "/report/workCondition/dayVeh")
public class DayVehController {
    @Value("${file.base}")
    private String base;
    @Value("${file.templateQuery}")
    private String templateQuery;
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
     * 工况分析-单车日报表
     * @return
     */
    @RequestMapping("/list")
    @RequiresPermissions(URL_LIST)
    @SLog(action = "工况分析-列表页面")
    public String list(ModelMap model) {
        String endTime = DateUtil.getShortDate();//当前日期yyyy-mm-dd
        String startTime = dayVehService.getDate(1);//默认往前一天
        model.put("startTime",startTime);
        model.put("endTime", endTime);
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
    @RequiresPermissions(URL_LIST)
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
        //Excel文件内容放入缓存
        //WebUser user = ServletUtil.getUser();
        //获取sessionId
        HttpSession session = request.getSession();
        //清空缓存车辆信息
        MemCacheManager.getInstance().remove(session.getId() + "InstantVeh");
        //添加缓存的车辆信息
        MemCacheManager.getInstance().set(session.getId() + "InstantVeh", lisVin);
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
    /**
     * 查询导出
     * @return
     */
    @PostMapping(value = "/importExport")
    @RequiresPermissions(URL_EXPORT)
    public void importExport(MultipartFile file, String identity) throws Exception {
        dayVehService.importExport(file,identity);
        return;

    }
//
//    /**
//     * 导入查询实现
//     * @param file
//     * @return
//     * @throws Exception
//     */
//    @PostMapping(value = "/improtSearch")
//    @ResponseBody
//    @RequiresPermissions(URL_LIST)
//    public AppBean improtSearch(MultipartFile file,String identity) throws Exception{
//
//        if (file == null) {
//            return new AppBean(-1, "文件获取失败！");
//        }
//
//        Long fileSize = file.getSize();
//        if (fileSize > 10240 * 1024) {
//            return new AppBean(-1, "文件大小超出最大10M限制！");
//        }
//
//        String fileName = file.getOriginalFilename();//获取上传文件的原名
//        String suffixName = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();//去掉文件名，获取文件的后缀
//        if (!".xls".equals(suffixName) && !".xlsx".equals(suffixName)) {
//            return new AppBean(-1, "上传文件格式不正确，确认文件后缀名为xls、xlsx！");
//        }
//
//        AppBean appBean = dayVehService.importQuery(file, identity);
//        return appBean;
//    }

    /**
     * 下载模板
     * @return
     */
    @GetMapping(value = "/downLooadModel")
    public void downLooadModel(HttpServletRequest request, HttpServletResponse response) {
        try {
            ExcelUtil.downloadModel(request, response, base, templateQuery);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
