package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.annotation.Module;
import com.bitnei.cloud.report.service.ICommonFindService;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Module(name = "公共页面")
@Controller
@RequestMapping(value = "/select")

public class CommonFindController {

    public final static String BASE="/module/report/dialog/";

    @Autowired
    private ICommonFindService commonFindService;

    /**
     * 查找车辆
     * @return
     */
    @RequestMapping("/findvin")
    public String findVIN(String type,Model model){
        model.addAttribute("type",type);
        return  BASE + "findVIN";
    }

    /**
     * 查找个人车主
     * @return
     */
    @RequestMapping("/findpersonal")
    public String findPersonal(String type,Model model){
        model.addAttribute("type",type);
        return  BASE + "findPersonal";
    }


    /**
     * 车辆表格查询
     * @return
     */
    @PostMapping(value = "/datagridVIN")
    @ResponseBody
    public PagerModel datagridVIN(){
        PagerModel pm = commonFindService.pageQuery();
        return pm;
    }

    /**
     * 个人车主表格查询
     * @return
     */
    @PostMapping(value = "/datagridPersonal")
    @ResponseBody
    public PagerModel datagridPersonal(){
        PagerModel pm = commonFindService.datagridPersonal();
        return pm;
    }

}

