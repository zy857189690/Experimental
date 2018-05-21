package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.annotation.Module;
import com.bitnei.cloud.common.annotation.SLog;
import com.bitnei.cloud.report.service.IAuthLogService;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Module(name = "实名日志")
@Controller
@RequestMapping(value = "/AuthLog")
public class AuthLogController {

    public final static String BASE="/module/report/AuthLog/";

    @Autowired
    IAuthLogService iAuthLogService;
    /**
     * 实名认证管理页面
     * @param model
     * @return
     */
    @GetMapping(value = "/list")
    @SLog(action = "实名日志列表")
    public String list(Model model){
        return BASE + "list";
    }

    /**
     * 个人实名认证表格查询
     * @return
     */
    @PostMapping(value = "/datagrid")
    @ResponseBody
    public PagerModel datagrid(){

        PagerModel pm = iAuthLogService.pageQuery();

        return pm;

    }

    /**
     * 导出
     * @return
     */
    @GetMapping(value = "/export")
    public void export(){

        iAuthLogService.export();
        return ;

    }
}