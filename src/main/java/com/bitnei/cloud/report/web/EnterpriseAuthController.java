package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.annotation.Module;
import com.bitnei.cloud.common.annotation.SLog;
import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.cloud.report.domain.SysCustomerUnitEntity;
import com.bitnei.cloud.report.service.ICompanyAuthService;
import com.bitnei.cloud.report.service.ISysCustomerUnit;
import com.bitnei.cloud.report.service.ISysRealNameAuthService;
import com.bitnei.commons.datatables.PagerModel;
import org.apache.log4j.Logger;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;


@Module(name = "企业实名认证")
@Controller
@RequestMapping(value = "/EnterpriseAuth")
public class EnterpriseAuthController {

    public final static String BASE="/module/report/EnterpriseAuth/";

    private final Logger logger = Logger.getLogger(getClass());

    public final static String BASE_REQ_PATH ="/EnterpriseAuth";

    public final static String URL_LIST = BASE_REQ_PATH +"/list";

    @Autowired
    private ISysRealNameAuthService iSysRealNameAuthService;

    @Autowired
    ISysCustomerUnit sysCustomerUnit;
    /**
     * 管理页面
     * @param model
     * @return
     */
    @GetMapping(value = "/enterprise/datagrid")
    //@RequiresPermissions(URL_LIST)
    @SLog(action = "企业实名认证列表")
    public String peopleDatagrid(Model model){
        return BASE + "datagrid";

    }

    @GetMapping(value = "/checkInfo")
    //@RequiresPermissions(URL_LIST)
    @SLog(action = "企业实名认证列表")
    @ResponseBody
    public AppBean checkInfo(String id){
        return this.iSysRealNameAuthService.checkInfo(id);
    }

    /**
     * 表格查询
     * @return
     */
    @PostMapping(value = "/datagrid")
    @ResponseBody
    //@RequiresPermissions(URL_LIST)
    public PagerModel datagrid(){
        PagerModel pm=null;
        return pm;
    }

    /**
     * 企业实名认证
     * @param id 企业id/sim卡id
     * @param flag =sim?由沃特玛sim卡管理传值过来需要回显sim卡相关信息，否则回显客户单位相关信息
     * @return
     */
    @GetMapping("/company_new")
    public String toNew(Model model, @RequestParam("id") String id, @RequestParam("flag") String flag){
        if ("sim".equals(flag)){
            //todo 这里需要查询SIM卡相关信息

            model.addAttribute("sysCustomerUnitEntity",new SysCustomerUnitEntity());
            return BASE + "simCardAuth";
        }else{
            SysCustomerUnitEntity sysCustomerUnitEntity = this.sysCustomerUnit.findById(id);
            model.addAttribute("sysCustomerUnitEntity",sysCustomerUnitEntity);
            return BASE + "add";
        }
    }
}