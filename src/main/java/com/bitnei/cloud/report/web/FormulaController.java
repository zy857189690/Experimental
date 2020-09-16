package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.report.domain.Dosage;
import com.bitnei.cloud.report.domain.Formula;
import com.bitnei.cloud.report.service.IFormulaService;
import com.bitnei.commons.datatables.PagerModel;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

/**
 * 实验配方管理
 * */
@Slf4j
@Controller
@RequestMapping(value = "/report/formula")
public class FormulaController{

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
    public String edit(@RequestParam("id") String id, Model model) {
        if (!id.equals("-1")) {
            Formula formula = formulaService.findById(id);
            model.addAttribute("formula", formula);
        }
        return BASE + "/edit";
    }


    @RequestMapping("/save")
    @ResponseBody
    public JsonModel save(Formula formula) {
        return formulaService.insert(formula);
    }
    
     /**
     * 根据id获取对象
     *
     * @return
     */
   /* @GetMapping(value = "/formulas/{id}")
    @ResponseBody
    public ResultMsg get(@PathVariable String id){

        FormulaModel formula = formulaService.get(id);
        return ResultMsg.getResult(formula);
    }*/




     /**
     * 多条件查询
     *
     * @return
     */
   /* @PostMapping(value = "/formulas")
    @ResponseBody
    public ResultMsg list(@RequestBody @Validated PagerInfo pagerInfo){

        Object result = formulaService.list(pagerInfo);
        return ResultMsg.getResult(result);
    }*/




    /**
    * 保存
    * @param model
    * @return
    */
  /*  @PostMapping(value = "/formula")
    @ResponseBody
    public ResultMsg add(@RequestBody @Validated({GroupInsert.class}) FormulaModel model){

        formulaService.insert(model);
        return ResultMsg.getResult(I18nUtil.t("common.addSuccess"));
    }
*/


    /**
    * 更新
    * @param model
    * @return
    */
   /* @PutMapping(value = "/formulas/{id}")
    @ResponseBody
    public ResultMsg update(@RequestBody @Validated({GroupUpdate.class}) FormulaModel model, @PathVariable String id){


        formulaService.update(model);
        return ResultMsg.getResult(I18nUtil.t("common.editSuccess"));
    }*/




    /**
     * 删除
     * @param id
     * @return
     */
   /* @DeleteMapping(value = "/formulas/{id}")
    @ResponseBody
    public ResultMsg delete(@PathVariable String id){

        int count = formulaService.deleteMulti(id);
        return ResultMsg.getResult(I18nUtil.t("common.deleteSuccess", count));


    }*/





}
