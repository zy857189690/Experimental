package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.ExcelUtil;
import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.common.ServletUtil;
import com.bitnei.cloud.report.domain.Demo1;
import com.bitnei.cloud.report.service.IDemo1Service;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.util.*;

@Controller
@RequestMapping(value = "/report/demo1")
public class Demo1Controller {

    //模板文件目录
    public final static String BASE = "/module/report/demo1/";

    private final Logger logger = Logger.getLogger(getClass());
    //模块基础请求前缀
    public final static String BASE_REQ_PATH = "/report/demo1";
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
    private IDemo1Service demo1Service;


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

        PagerModel pm = demo1Service.pageQuery();
        return pm;

    }

    /**
     * 导出
     *
     * @return
     */
    @GetMapping(value = "/export")
    public void export() {

        demo1Service.export();
        return;

    }


    /**
     * 新增页面
     *
     * @param model
     * @return
     */
    @GetMapping(value = "/add")
    public String add(Model model) {

        return BASE + "add";
    }


    /**
     * 查看页面
     *
     * @param model
     * @return
     */
    @GetMapping(value = "/view")
    public String view(Model model, String id) {
        Demo1 obj = demo1Service.findById(id);
        model.addAttribute("demo1", obj);
        return BASE + "view";
    }


    /**
     * 保存
     *
     * @param
     * @return
     */
    @RequestMapping("/edit")
    public String edit(@RequestParam("id") String id, Model model) {
        if (!id.equals("-1")) {
            Demo1 demo1 = demo1Service.findById(id);
            model.addAttribute("demo1", demo1);
        }
        return BASE + "/edit";
    }


    @RequestMapping(value = "/imports")
    public String imports() {
        return BASE + "imports";
    }


    @GetMapping(value = "/update")
    public String update(Model model, String id) {

        Demo1 obj = demo1Service.findById(id);
        model.addAttribute("obj", obj);
        return BASE + "update";
    }

    @RequestMapping("/save")
    @ResponseBody
    public JsonModel save(Demo1 demo1) {
        return demo1Service.saveSubmit(demo1);
    }


    /**
     * 导入excel
     *
     * @return
     */
    @RequestMapping("/importHoles")
    @ResponseBody
    public JsonModel importHoles(HttpServletRequest request,  String name, String code, MultipartFile file) throws Exception {
        return demo1Service.importHoles(name,code,file);
    }
}