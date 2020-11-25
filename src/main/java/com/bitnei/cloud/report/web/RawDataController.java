package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.report.service.IRawDataService;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

// 原始数据
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

    @RequestMapping(value = "/imports")
    public String imports() {
        return BASE + "imports";
    }

    /**
     * 导入excel
     *
     * @return
     */
    @RequestMapping("/importRawDatas")
    @ResponseBody
    public JsonModel importRawDatas(HttpServletRequest request, String name, String code,
                                    String secondaryCoefficient,
                                    String oneCoefficient,
                                    String parameter,
                                    String secondaryCoefficientAgain,
                                    String oneCoefficientAgain,
                                    String parameterAgain,
                                    MultipartFile file) throws Exception {
        return rawDataService.importRawDatas(name, code,
                secondaryCoefficient, oneCoefficient, parameter,
                secondaryCoefficientAgain,oneCoefficientAgain,parameterAgain, file);
    }

    @GetMapping(value = "/view")
    public String view(Model model, String id) {
        List<Map<String,Object>> rawData = rawDataService.get(id);
        if (rawData.size()>0){
            model.addAttribute("rawData", rawData.get(0));
            //model.addAttribute("rawDataNh", rawData.get(1));
        }
        return BASE + "view";
    }

    @GetMapping(value = "/viewNh")
    public String viewNh(Model model,String id) {
       List<Map<String,Object>> rawData = rawDataService.get(id);
        if (rawData.size()>0){
            model.addAttribute("rawData", rawData.get(0));
            model.addAttribute("rawDataNh", rawData.get(1));
        }
        return BASE + "viewNh";
    }
}
