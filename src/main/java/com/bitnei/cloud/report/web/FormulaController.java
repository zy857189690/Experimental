package com.bitnei.cloud.report.web;

import com.bitnei.cloud.report.service.IFormulaService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Slf4j
@Controller
@RequestMapping(value = "/report/formula")
public class FormulaController{

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    /** 模块基础请求前缀 **/
    public static final String BASE_AUTH_CODE ="FORMULA";
    /** 查看 **/
    public static final String AUTH_DETAIL = BASE_AUTH_CODE +"_DETAIL";
    /** 列表 **/
    public static final String AUTH_LIST = BASE_AUTH_CODE +"_LIST";
    /** 分页 **/
    public static final String AUTH_PAGER = BASE_AUTH_CODE +"_PAGER";
    /** 新增 **/
    public static final String AUTH_ADD = BASE_AUTH_CODE +"_ADD";
    /** 编辑 **/
    public static final String AUTH_UPDATE = BASE_AUTH_CODE +"_UPDATE";
    /** 删除 **/
    public static final String AUTH_DELETE = BASE_AUTH_CODE +"_DELETE";
    /** 导出 **/
    public static final String AUTH_EXPORT = BASE_AUTH_CODE +"_EXPORT";
    /** 导入 **/
    public static final String AUTH_IMPORT = BASE_AUTH_CODE +"_IMPORT";
    /** 批量导入 **/
    public static final String AUTH_BATCH_IMPORT = BASE_AUTH_CODE +"_BATCH_IMPORT";
    /** 批量更新 **/
    public static final String AUTH_BATCH_UPDATE = BASE_AUTH_CODE +"_BATCH_UPDATE";

    @Autowired
    private IFormulaService formulaService;


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
