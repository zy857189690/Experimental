package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.annotation.Module;
import com.bitnei.cloud.common.annotation.SLog;
import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.cloud.report.service.ISysCustomerUnitService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Module(name = "客户单位")
@Controller
@RequestMapping(value = "/customerUnit")
public class CustomerUnitController {

    public final static String BASE="/module/report/CustomerUnit/";

    private final Logger logger = Logger.getLogger(getClass());

    public final static String BASE_REQ_PATH ="/CustomerUnit";

    @Autowired
    ISysCustomerUnitService iSysCustomerUnitService;

    /**
     * 客户单位列表页面
     * @param model
     * @return
     */
    @GetMapping(value = "/list")
    //@RequiresPermissions(URL_LIST)
    @SLog(action = "客户单位列表页面")
    public String list(Model model){
        return BASE + "list";

    }

    /**
     * 新增客户企业
     * @param model
     * @return
     */
    @GetMapping(value = "/add")
    //@RequiresPermissions(URL_LIST)
    @SLog(action = "新增客户企业")
    public String add(Model model){
        return BASE + "edit";

    }
    /**
     * 编辑客户企业
     * @param model
     * @return
     */
    @GetMapping(value = "/edit")
    //@RequiresPermissions(URL_LIST)
    @SLog(action = "编辑客户企业")
    public String edit(Model model){
        return BASE + "edit";

    }
    /**
     * 表格查询
     * @return
     */
    @PostMapping(value = "/datagrid")
    @ResponseBody
    //@RequiresPermissions(URL_LIST)
    public PagerModel datagrid(){
        DataGridOptions options = ServletUtil.getDataLayOptions();
        PagerModel pm = iSysCustomerUnitService.findPagerModel("pagerModel",options);
        return pm;
    }

    @GetMapping(value = "/getComInfo")
    public String getComInfo(String type,Model model){
        model.addAttribute("type",type);
        return  BASE + "search_com_dialog";
    }
}
