package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.report.domain.Demo1;
import com.bitnei.cloud.report.service.IDemo1Service;
import com.bitnei.commons.datatables.PagerModel;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value = "/report/experimentalStage")
public class ExperimentalStage {


    public final static String BASE = "/module/report/experimentalStage/";
    private final Logger logger = Logger.getLogger(getClass());
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


    /*
     * 编辑页面
     * @param model
     * @return
     */
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
     * 点击查询：导入excel查询车辆信息
     *
     * @return
     */
    @RequestMapping("/importHoles")
    @ResponseBody
    public JsonModel importHoles(HttpServletRequest request,  String name, String code, MultipartFile file) throws Exception {
        return demo1Service.importHoles(name,code,file);

    }
}