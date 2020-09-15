package com.bitnei.cloud.report.web;

import com.bitnei.cloud.report.service.IDrugService;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.net.URLDecoder;


@Slf4j
@Controller
@RequestMapping(value = "/report/drug")
public class DrugController{

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    /** 模块基础请求前缀 **/
    public static final String BASE_AUTH_CODE ="DRUG";
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
    private IDrugService drugService;


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
