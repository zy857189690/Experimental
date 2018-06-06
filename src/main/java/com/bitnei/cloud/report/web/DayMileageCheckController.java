package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.annotation.Module;
import com.bitnei.cloud.common.annotation.SLog;
import org.apache.log4j.Logger;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 运营分析-单日里程核算日报
 * Created by DFY on 2018/5/28.
 */
@Module(name = "运营分析-单日里程核算日报")
@Controller
@RequestMapping(value = "/report/operation/dayMileageCheck")
public class DayMileageCheckController {
    //模板文件目录
    public final static String BASE = "/module/report/operation/dayMileageCheck/";

    private final Logger logger = Logger.getLogger(getClass());
    //模块基础请求前缀
    public final static String BASE_REQ_PATH = "/report/operation/dayMileageCheck";
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

    /**
     * 运营分析-跳转列表页面
     * @return
     */
    @RequestMapping("/list")
    @RequiresPermissions(URL_LIST)
    @SLog(action = "运营分析-列表页面")
    public String list() {
        return BASE + "list";
    }
}
