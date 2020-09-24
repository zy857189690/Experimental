package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.report.domain.Formula;
import com.bitnei.cloud.report.service.IFormulaService;
import com.bitnei.commons.datatables.PagerModel;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Map;

/**
 * 实验配方管理
 */
@Slf4j
@Controller
@RequestMapping(value = "/report/formula")
public class FormulaController {

    public final static String BASE = "/module/report/formula/";

    @Autowired
    private IFormulaService formulaService;


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
        PagerModel pm = formulaService.pageQuery();
        return pm;

    }


    /**
     * 编辑
     *
     * @param
     * @return
     */
    @RequestMapping("/edit")
    public String edit(String id, Model model) {
            if (!id.equals("-1")) {
                Map<String, Object> result = formulaService.findFormulaById(id);
                model.addAttribute("formula", result);
            }
            return BASE + "edit";
    }


    /**
     * 查看页面
     *
     * @param model
     * @return
     */
    @GetMapping(value = "/view")
    public String view(Model model, String id) {
        Map<String, Object> result = formulaService.findFormulaById(id);
        model.addAttribute("formula", result);
        return BASE + "view";
    }

    @RequestMapping("/save")
    @ResponseBody
    public JsonModel save(@Valid Formula formula) {
        return formulaService.insert(formula);
    }


}
