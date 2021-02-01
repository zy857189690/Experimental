package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.report.domain.Experimentalprocess;
import com.bitnei.cloud.report.service.IExperimentalprocessService;
import com.bitnei.cloud.report.service.IFormulaService;
import com.bitnei.cloud.report.service.IRawDataService;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 *
 * 实验过程
* **/
@Controller
@RequestMapping(value = "/report/experimentalProcess")
public class ExperimentalprocessController {
    public final static String BASE = "/module/report/experimentalProcess/";

    @Autowired
    private IExperimentalprocessService experimentalprocessService;


    @Autowired
    private IRawDataService rawDataService;

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
        PagerModel pm = experimentalprocessService.pageQuery();
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
            // 查询拟合公式
            // List<Map<String, Object>> maps = rawDataService.get(id);
           Experimentalprocess experimentalProcess = experimentalprocessService.findById(id);
           model.addAttribute("experimentalProcess", experimentalProcess);
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
    public String view(Model model, String id ) {
        List<Map<String,Object>> experimentalProcess = experimentalprocessService.findNhBy(id);
  /*      Map<String, Object> result = formulaService.findFormulaById(experimentalProcess.getFormulaId());
        model.addAttribute("formula", result);
        model.addAttribute("experimentalProcess", experimentalProcess);
        if (StringUtils.isNotEmpty(flag)){
            return    BASE + "confirm";
        }*/

        if (experimentalProcess.size()>0){
            model.addAttribute("rawData", experimentalProcess.get(0));
            model.addAttribute("rawDataNh", experimentalProcess.get(1));
        }
        return BASE + "view";
    }

    @RequestMapping("/save")
    @ResponseBody
    public JsonModel save(@Valid Experimentalprocess experimentalprocess) {
        return experimentalprocessService.insert(experimentalprocess);
    }

    /**
     * 确认复核
     *
     * @param
     * @return
     */
    @RequestMapping(value = "/confirm")
    @ResponseBody
    public JsonModel confirm(@Valid Experimentalprocess experimentalprocess) {
        JsonModel jm   =   experimentalprocessService.checkUpdate(experimentalprocess);
        return jm;
    }
}
