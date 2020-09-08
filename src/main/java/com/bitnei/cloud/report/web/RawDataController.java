package com.bitnei.cloud.report.web;

import com.bitnei.cloud.report.service.IRawDataService;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/report/rawData")
public class RawDataController {

    public final static String BASE = "/module/report/rawData/";

    @Autowired
    private IRawDataService rawDataService;
    /**
     * 管理页面
     *
     * @param model
     * @return
     */
    @GetMapping(value = "/list")
    public String list(Model model) {
        return BASE + "list";
    }


    /**
     * 表格查询
     *
     * @return
     */
    @PostMapping(value = "/datagrid")
    @ResponseBody
    public PagerModel datagrid() {
        PagerModel pm = rawDataService.pageQuery();
        return pm;

    }
}
