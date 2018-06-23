package com.bitnei.cloud.report.web;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.common.ControlUtil;
import com.bitnei.cloud.common.annotation.Module;
import com.bitnei.cloud.common.annotation.SLog;
import com.bitnei.cloud.report.service.IAreaMileageService;
import com.bitnei.cloud.report.service.impl.AreaMileageService;
import org.apache.log4j.Logger;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * 运营分析-区域里程月报
 * Created by DFY on 2018/5/28.
 */
@Module(name = "运营分析-区域里程月报")
@Controller
@RequestMapping(value = "/report/operation/areaMileage")
public class AreaMileageController {
    //模板文件目录
    public final static String BASE = "/module/report/operation/areaMileage/";

    private final Logger logger = Logger.getLogger(getClass());
    //模块基础请求前缀
    public final static String BASE_REQ_PATH = "/report/operation/areaMileage";
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
    private IAreaMileageService areaMileageService;

    /**
     * 运营分析-跳转列表页面
     *
     * @return
     */
    @RequestMapping("/list")
    @RequiresPermissions(URL_LIST)
    @SLog(action = "运营分析-列表页面")
    public String list() {
        return BASE + "list";
    }

    /**
     * 获得所有行驶区域
     * 用于下拉框
     *
     * @return
     */
    @RequestMapping("/getDrivingArea")
    @ResponseBody
    public JSONArray getDrivingArea() {
        return areaMileageService.getDrivingArea();
    }

    /**
     * 获得所有运营单位的信息
     * 用于下拉框
     *
     * @return
     */
    @RequestMapping("/getUnit")
    @ResponseBody
    public JSONArray getUnit() {
        return areaMileageService.getUnit();
    }

    /**
     * 查询区域月报
     *
     * @return
     */
    @RequestMapping("queryAreaMonthly")
    @ResponseBody
    public JSONObject queryAreaMonthly(HttpServletRequest request) {
        Map<String, Object> params = ControlUtil.getParams(request);
        return areaMileageService.queryAreaMonthly(params);
    }

    /**
     * 下载区域月报
     *
     * @param request
     * @return
     */
    @RequestMapping("downloadAreaMonthly")
    @ResponseBody
    public void downloadAreaMonthly(HttpServletRequest request) throws Exception {
        Map<String, Object> params = ControlUtil.getParams(request);
        areaMileageService.downloadAreaMonthly(params);
        /*
        byte[] bytes = areaMileageService.downloadAreaMonthly(params);
        HttpHeaders headers=new HttpHeaders();
        headers.setContentDispositionFormData("attachment",java.net.URLEncoder.encode("区域里程统计月报.xlsx","utf-8"));
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<byte[]>(bytes ,headers, HttpStatus.OK);
        */
    }

}
