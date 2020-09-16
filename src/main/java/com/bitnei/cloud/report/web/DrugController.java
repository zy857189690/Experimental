package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.report.domain.Drug;
import com.bitnei.cloud.report.domain.ExperimentalStage;
import com.bitnei.cloud.report.service.IDrugService;
import com.bitnei.commons.datatables.PagerModel;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;



/**
 * 实验药品
 * */

@Slf4j
@Controller
@RequestMapping(value = "/report/drug")
public class DrugController{


    public final static String BASE = "/module/report/drug/";

    @Autowired
    private IDrugService drugService;



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
        PagerModel pm = drugService.pageQuery();
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
            ExperimentalStage experimentalStage = drugService.findById(id);
            model.addAttribute("experimentalStage", experimentalStage);
        }
        return BASE + "/edit";
    }


    @RequestMapping("/save")
    @ResponseBody
    public JsonModel save(Drug drug) {
        return drugService.insert(drug);
    }
     /**
     * 根据id获取对象
     *
     * @return
     */
 /*   @GetMapping(value = "/drugs/{id}")
    @ResponseBody
    public ResultMsg get(@PathVariable String id){

        DrugModel drug = drugService.get(id);
        return ResultMsg.getResult(drug);
    }
*/



     /**
     * 多条件查询
     *
     * @return
     */
  /*  @PostMapping(value = "/drugs")
    @ResponseBody
    public ResultMsg list(@RequestBody @Validated PagerInfo pagerInfo){

        Object result = drugService.list(pagerInfo);
        return ResultMsg.getResult(result);
    }
*/



    /**
    * 保存
    * @param model
    * @return
    */
   /* @PostMapping(value = "/drug")
    @ResponseBody
    public ResultMsg add(@RequestBody @Validated({GroupInsert.class}) DrugModel model){

        drugService.insert(model);
        return ResultMsg.getResult(I18nUtil.t("common.addSuccess"));
    }
*/


    /**
    * 更新
    * @param model
    * @return
    */
  /*  @PutMapping(value = "/drugs/{id}")
    @ResponseBody
    public ResultMsg update(@RequestBody @Validated({GroupUpdate.class}) DrugModel model, @PathVariable String id){


        drugService.update(model);
        return ResultMsg.getResult(I18nUtil.t("common.editSuccess"));
    }*/




    /**
     * 删除
     * @param id
     * @return
     */
   /* @DeleteMapping(value = "/drugs/{id}")
    @ResponseBody
    public ResultMsg delete(@PathVariable String id){
        int count = drugService.deleteMulti(id);
        return ResultMsg.getResult(I18nUtil.t("common.deleteSuccess", count));

    }*/







}
