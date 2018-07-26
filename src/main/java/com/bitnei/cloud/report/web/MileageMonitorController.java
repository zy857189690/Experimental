package com.bitnei.cloud.report.web;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.common.ControlUtil;
import com.bitnei.cloud.common.annotation.Module;
import com.bitnei.cloud.common.annotation.SLog;
import com.bitnei.cloud.report.service.IMileageMonitorService;
import com.bitnei.cloud.report.service.impl.MileageMonitorService;
import org.apache.log4j.Logger;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * 运营分析-里程监控月报
 * Created by DFY on 2018/5/28.
 */
@Module(name = "运营分析-里程监控月报")
@Controller
@RequestMapping(value = "/report/operation/mileageMonitor")
public class MileageMonitorController {
    //模板文件目录
    public final static String BASE = "/module/report/operation/mileageMonitor/";

    private final Logger logger = Logger.getLogger(getClass());
    //模块基础请求前缀
    public final static String BASE_REQ_PATH = "/report/operation/mileageMonitor";
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
    private IMileageMonitorService mileageMonitorService;


    /**
     * 运营分析-跳转列表页面
     * @return
     */
    @RequestMapping("/list")
    @RequiresPermissions(URL_LIST)
    @SLog(action = "运营分析-列表页面")
    public String list(HttpServletRequest request) {
        Map<String, Object> params = ControlUtil.getParams(request);

        return BASE + "list";
    }

    /**
     * 查询区域月报
     * @return
     */
    @RequestMapping("queryMileageMonthly")
    @ResponseBody
    public JSONObject queryMileageMonthly(HttpServletRequest request){
        Map<String, Object> params = ControlUtil.getParams(request);
        return  mileageMonitorService.queryMileageMonthly(params);

    }

    /**
     * 下载区域月报
     * @return
     */
    @RequestMapping("downloadMileageMonthly")
    @RequiresPermissions(URL_EXPORT)
    public void downloadMileageMonthly(HttpServletRequest request){
        Map<String, Object> params = ControlUtil.getParams(request);
          mileageMonitorService.downloadMileageMonthly(params);

    }




    /**
     * 里程监控月报-钻取
     * @return
     */
    @RequestMapping("popup")
    public String popup(
            @RequestParam("data1") String data1,
            @RequestParam("data2") String data2,
            @RequestParam("endTime") String endTime,
            @RequestParam("cheLiangMing") String cheLiangMing,
            @RequestParam("yunYing") String yunYing,
            Model model) {
        model.addAttribute("data1",data1);
        model.addAttribute("data2",data2);
        model.addAttribute("endTime",endTime);
        model.addAttribute("cheLiangMing",cheLiangMing);
        model.addAttribute("yunYing",yunYing);
        return BASE + "popup";
    }


    /**
     * 钻取查询
     * @return
     */
    @RequestMapping("queryPopup")
    @ResponseBody
    public JSONObject queryPopup(HttpServletRequest request){

        Map<String, Object> params = ControlUtil.getParams(request);

        return  mileageMonitorService.queryPopup(params);

    }



    /**
     * 钻取下载
     * @return
     */
    @RequestMapping("downloadPopup")
    @ResponseBody
    @RequiresPermissions(URL_EXPORT)
    public void downloadPopup(HttpServletRequest request){

        Map<String, Object> params = ControlUtil.getParams(request);
        mileageMonitorService.downloadPopup(params);


    }
}
