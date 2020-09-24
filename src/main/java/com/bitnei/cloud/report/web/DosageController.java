package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.report.domain.Dosage;
import com.bitnei.cloud.report.service.IDosageService;
import com.bitnei.commons.datatables.PagerModel;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


/**
 *
 * */

@Slf4j
@Controller
@RequestMapping(value = "/report/dosage")
public class DosageController{

    public final static String BASE = "/module/report/dosage/";

    @Autowired
    private IDosageService dosageService;




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
        PagerModel pm = dosageService.pageQuery();
        return pm;

    }



    /**
     * 编辑
     *
     * @param
     * @return
     */
    @GetMapping( value = "/edit")
    public String edit(String id,Model model ) {
        if (!id.equals("-1")) {
            Dosage dosage = dosageService.findById(id);
            model.addAttribute("dosage", dosage);
        }
        return BASE + "edit";
    }


    @RequestMapping("/save")
    @ResponseBody
    public JsonModel save(Dosage dosage) {
        return dosageService.insert(dosage);
    }
    
     /**
     * 根据id获取对象
     *
     * @return
     */
    @GetMapping(value = "/gets")
    @ResponseBody
    public void get(@PathVariable String _){
        Dosage formula = dosageService.get(_);
    }




     /**
     * 多条件查询
     *
     * @return
     */
   /* @PostMapping(value = "/dosages")
    @ResponseBody
    public ResultMsg list(@RequestBody @Validated PagerInfo pagerInfo){
        Object result = dosageService.list(pagerInfo);
        return ResultMsg.getResult(result);
    }*/




    /**
    * 保存
    * @param model
    * @return
    */
  /*  @PostMapping(value = "/formula")
    @ResponseBody
    public ResultMsg add(@RequestBody @Validated({GroupInsert.class}) DosageModel model){

        dosageService.insert(model);
        return ResultMsg.getResult(I18nUtil.t("common.addSuccess"));
    }*/



    /**
    * 更新
    * @param model
    * @return
    */
   /* @PutMapping(value = "/dosages/{id}")
    @ResponseBody
    public ResultMsg update(@RequestBody @Validated({GroupUpdate.class}) DosageModel model, @PathVariable String id){


        dosageService.update(model);
        return ResultMsg.getResult(I18nUtil.t("common.editSuccess"));
    }*/




    /**
     * 删除
     * @param id
     * @return
     */
   /* @DeleteMapping(value = "/dosages/{id}")
    @ResponseBody
    public ResultMsg delete(@PathVariable String id){

        int count = dosageService.deleteMulti(id);
        return ResultMsg.getResult(I18nUtil.t("common.deleteSuccess", count));


    }*/









}
