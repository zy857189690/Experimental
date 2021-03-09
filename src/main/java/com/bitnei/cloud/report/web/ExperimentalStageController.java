package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.report.domain.ExperimentalData;
import com.bitnei.cloud.report.service.IExperimentalStageService;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
* 实验数据管理
* */

@Controller
@RequestMapping(value = "/report/experimentalStage")
public class ExperimentalStageController {


    public final static String BASE = "/module/report/experimentalStage/";

    @Autowired
    private IExperimentalStageService experimentalStageService;

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
        PagerModel pm = experimentalStageService.pageQuery();
        return pm;

    }

    /**
     * 导出
     *
     * @return
     */
    @GetMapping(value = "/export")
    public void export() {

        experimentalStageService.export();
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

        Map<String,String> experimentalStage = experimentalStageService.findByView(id);
      //  experimentalStage.setReportImg(experimentalStage.getReportImgs().split(","));
        model.addAttribute("experimentalStage", experimentalStage);

        return BASE + "view";
    }


    /**
     * 保存
     *
     * @param
     * @return
     */
   @GetMapping( value = "/edit")
    public String edit(String id,Model model ) {
        if (!id.equals("-1")) {
            Map<String, String> byIdZyl = experimentalStageService.findByIdZyl(id);
            model.addAttribute("experimentalStage", byIdZyl);
        }
        return BASE + "edit";
    }



    /**
     * 保存
     *
     * @param
     * @return
     */
  /*  @RequestMapping("/getImgsById")
    @ResponseBody
    public List getImgsById(@RequestParam("id") String id, Model model) {
            ExperimentalStage experimentalStage = experimentalStageService.findById(id);
            String[] split = experimentalStage.getReportImgs().split(",");
            List<String> list = Arrays.asList(split);
        return list;
    }
*/



    /*
     * 编辑页面
     * @param model
     * @return
     */
 /*   @GetMapping(value = "/update")
    public String update(Model model, String id) {

        ExperimentalStage obj = experimentalStageService.findById(id);
        model.addAttribute("experimentalStage", obj);
        return BASE + "update";
    }*/

    @RequestMapping("/save")
    @ResponseBody
    public JsonModel save(ExperimentalData experimentalData) {
        return experimentalStageService.saveSubmit(experimentalData);
    }


    /**
     * 点击查询：导入excel查询车辆信息
     *
     * @return
     */
    @RequestMapping("/importHoles")
    @ResponseBody
    public JsonModel importHoles(HttpServletRequest request,  String name, String code, MultipartFile file) throws Exception {
        return experimentalStageService.importHoles(name,code,file);

    }


    @ResponseBody
    @RequestMapping("/uploadImgList")
    public List uploadPictureList( @RequestParam(value="file",required=false)MultipartFile[] file, HttpServletRequest request){
     return  experimentalStageService.uploadPictureList(file,  request);
    }

}