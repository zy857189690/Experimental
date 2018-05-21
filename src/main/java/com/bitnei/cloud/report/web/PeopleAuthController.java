package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.annotation.Module;
import com.bitnei.cloud.common.annotation.SLog;
import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.report.domain.*;
import com.bitnei.cloud.report.enums.ResultEnum;
import com.bitnei.cloud.report.mapper.SysAuthPersonalTempMapper;
import com.bitnei.cloud.report.mapper.SysRealNameAuthMapper;
import com.bitnei.cloud.report.service.ICompanyAuthService;
import com.bitnei.cloud.report.service.IPeopleAuthService;
import com.bitnei.cloud.report.service.IPersonCarOwnerService;
import com.bitnei.cloud.report.service.ISysAuthPersonalTempService;
import com.bitnei.cloud.report.util.CoverException;
import com.bitnei.cloud.report.util.ValidateException;
import com.bitnei.commons.datatables.PagerModel;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;


@Module(name = "个人实名认证")
@Controller
@RequestMapping(value = "/PeopleAuth")
public class PeopleAuthController {

    public final static String BASE = "/module/report/PeopleAuth/";

    private final Logger logger = Logger.getLogger(getClass());

    public final static String BASE_REQ_PATH = "/PeopleAuth";

    public final static String URL_LIST = BASE_REQ_PATH + "/list/";

    @Autowired
    private IPeopleAuthService iPeopleAuthService;

    @Autowired
    SysAuthPersonalTempMapper sysAuthPersonalTempMapper;

    @Autowired
    private ISysAuthPersonalTempService sysAuthPersonalTempService;

    @Autowired
    private IPersonCarOwnerService iPersonCarOwnerService;

    @Autowired
    SysRealNameAuthMapper sysRealNameAuthMapper;

    @Autowired
    ICompanyAuthService companyAuthService;

    /**
     * 实名认证管理页面
     *
     * @param model
     * @param flag  通过接收和传值flag到前台，来选择默认的tab页
     * @return
     */
    @GetMapping(value = "/list")
    //@RequiresPermissions(URL_LIST)
    @SLog(action = "实名认证管理页面")
    public String list(Model model, @RequestParam(value = "flag", required = false) String flag) {
        if (!"1".equals(flag))
            flag = "0";
        model.addAttribute("flag", flag);
        return BASE + "list";
    }

    /**
     * 个人实名认证列表页
     *
     * @param model
     * @return
     */
    @GetMapping(value = "/people/datagrid")
    //@RequiresPermissions(URL_LIST)
    @SLog(action = "个人实名认证列表页")
    public String peopleDatagrid(Model model) {
        return BASE + "datagrid";
    }


    /**
     * 个人实名认证表格查询
     *
     * @return
     */
    @PostMapping(value = "/datagrid")
    @ResponseBody
    public PagerModel datagrid() {

        PagerModel pm = iPeopleAuthService.pageQuery();

        return pm;

    }


    /**
     * 新增个人实名认证
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/authInformation")
    @SLog(action = "新增个人实名认证")
    public String authInformation(Model model, @RequestParam(value = "certid", required = false) String id) {
        SysOwnerPeopleEntity OwnerPeopleEntity = iPeopleAuthService.selectByOwnerCert(id);
        model.addAttribute("sysOwnerPeopleEntity", OwnerPeopleEntity);
        return BASE + "authInformation";
    }

    /**
     * 企业实名认证
     *
     * @param id   企业id/sim卡id
     * @param flag =sim?由沃特玛sim卡管理传值过来需要回显sim卡相关信息，否则回显客户单位相关信息
     * @return
     */
    @GetMapping("/add_people_new")
    public String addPeopleNew(Model model, @RequestParam(value = "id", required = false) String id,
                               @RequestParam(value = "flag", required = false) String flag) {
        if ("simcard".equals(flag)) {
            EnterpriseAuth enterpriseAuth = this.companyAuthService.findBySimCardId(id);
            model.addAttribute("enterpriseAuth", enterpriseAuth);
            model.addAttribute("sysOwnerPeopleEntity", new SysOwnerPeopleEntity());
            model.addAttribute("btnflag", "simcard");
        } else if ("personcarowner".equals(flag)) {
            SysOwnerPeopleEntity sysOwnerPeopleEntity = this.iPersonCarOwnerService.findById(id);
            model.addAttribute("sysOwnerPeopleEntity", sysOwnerPeopleEntity);
            model.addAttribute("btnflag", "personcarowner");
        } else {
            model.addAttribute("enterpriseAuth", new EnterpriseAuth());
            model.addAttribute("sysOwnerPeopleEntity", new SysOwnerPeopleEntity());
            model.addAttribute("btnflag", "initial");
        }
        return BASE + "authInformation";
    }

    /**
     * 个人车辆绑定页
     *
     * @return
     */
    @RequestMapping(value = "/personalVehicleBinding")
    @SLog(action = "新增个人车辆绑定")
    public String personalVehicleBinding(@ModelAttribute SysAuthenticationPersonalTempEntity param,
                                         Model model) {
        SysOwnerPeopleEntity entity=iPeopleAuthService.selectByOwnerCert(param.getId());
        model.addAttribute("mode", entity);
        return BASE + "personalVehicleBinding";
    }

    /**
     * 个人车辆绑定
     *
     * @param enterpriseAuth
     * @param sysOwnerPeopleEntity
     * @return
     */
    @PostMapping(value = "/savePersonalBinding")
    @ResponseBody
    public AppBean savePersonalBinding(
            @RequestParam(value = "param", required = false) String cover,
            @ModelAttribute EnterpriseAuth enterpriseAuth,
            @ModelAttribute SysOwnerPeopleEntity sysOwnerPeopleEntity) {
        try {
            iPeopleAuthService.savePersonalBinding(cover, enterpriseAuth, sysOwnerPeopleEntity);
            return new AppBean(ResultEnum.RESULT_YES.getValue(), "绑定成功");
        } catch (Exception e) {
            if (e instanceof CoverException) {
                return new AppBean(ResultEnum.RESULT_EXCEPTTYPE.getValue(), "绑定失败:" + e.getMessage());
            }
            if (e.getMessage().indexOf("Connection timed out") != -1) {
                return new AppBean(ResultEnum.RESULT_NO.getValue(), "绑定失败:绑定请求超时，请再次提交");
            }
            return new AppBean(ResultEnum.RESULT_NO.getValue(), "绑定失败:" + e.getMessage());
        }
    }


    /**
     * 新增保存
     *
     * @param sysAuthenticationPersonalTempEntity
     * @return
     */
    @PostMapping(value = "/saveInformation")
    @ResponseBody
    @SLog(action = "保存个人实名认证")
    public AppBean saveInformation(@ModelAttribute SysAuthenticationPersonalTempEntity sysAuthenticationPersonalTempEntity) {
        AppBean ab = new AppBean();
        try {
            iPeopleAuthService.insert(sysAuthenticationPersonalTempEntity);
            ab.setMessage("保存成功");
        } catch (Exception e) {
            ab.setMessage("保存异常");
        }
        return ab;
    }

    /**
     * 新增提交并保存
     *
     * @param sysOwnerPeopleEntity
     * @param enterpriseAuth
     * @return
     */
    @PostMapping(value = "/addPeopleAuth")
    @ResponseBody
    @SLog(action = "提交并保存个人实名认证")
    public AppBean addPeopleAuth(
            @RequestParam("param") String cover,
            @ModelAttribute EnterpriseAuth enterpriseAuth,
            @ModelAttribute SysOwnerPeopleEntity sysOwnerPeopleEntity) {
        try {
            SysRealNameAuthenticationEntity entity = iPeopleAuthService.authPersonal(cover, enterpriseAuth, sysOwnerPeopleEntity);
            AppBean appBean = new AppBean(ResultEnum.RESULT_YES.getValue(), "认证成功");
            Map<String, Object> result = new HashMap();

            Class type = entity.getClass();
            BeanInfo beanInfo = Introspector.getBeanInfo(type);
            PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();
            for (PropertyDescriptor descriptor : propertyDescriptors) {
                String propertyName = descriptor.getName();
                if (!propertyName.equals("class")) {
                    Method readMethod = descriptor.getReadMethod();
                    Object res = readMethod.invoke(entity);
                    if (res != null) {
                        result.put(propertyName, res);
                    } else {
                        result.put(propertyName, "");
                    }
                }
            }
            appBean.setData(result);
            return appBean;
        } catch (Exception e) {
            if (e instanceof CoverException) {
                return new AppBean(ResultEnum.RESULT_EXCEPTTYPE.getValue(), "认证失败:" + e.getMessage());
            }
            if (e.getMessage().indexOf("Connection timed out") != -1) {
                return new AppBean(ResultEnum.RESULT_NO.getValue(), "认证失败:认证请求超时，请再次提交");
            }
            return new AppBean(ResultEnum.RESULT_NO.getValue(), "认证失败:" + e.getMessage());
        }
    }

    /**
     * 编辑
     *
     * @param param
     * @param model
     * @return
     */
    @GetMapping("/authInformation_edit")
    @SLog(action = "编辑个人实名认证")
    public String companyAuthEdit(@RequestParam("category") String category, @ModelAttribute SysAuthenticationPersonalTempEntity param,
                                  Model model) {

        SysAuthenticationPersonalTempEntity entity =
                sysAuthPersonalTempService.findById(param.getId());
        model.addAttribute("mode", entity);
        model.addAttribute("category", category);
        return BASE + "edit";
    }

    /**
     * 详情
     *
     * @param param
     * @param model
     * @return
     */
    @GetMapping("/people_all_info")
    @SLog(action = "个人实名认证查看详情")
    public String companyAuthInfo(@ModelAttribute SysAuthenticationPersonalTempEntity param,
                                  Model model) {
        SysAuthenticationPersonalTempEntity entity =
                sysAuthPersonalTempService.findById(param.getId());
        model.addAttribute("mode", entity);
        return BASE + "details_one";
    }

    /**
     * 导出
     *
     * @return
     */
    @GetMapping(value = "/export")
    @SLog(action = "个人实名认证导")
    public void export() {

        iPeopleAuthService.export();
        return;

    }

    /**
     * 编辑保存
     *
     * @param sysAuthenticationPersonalTempEntity
     * @return
     */
    @PostMapping(value = "/updateInformation")
    @ResponseBody
    @SLog(action = "个人实名认证编辑保存")
    public AppBean updateInformation(@RequestParam("category") int category, @ModelAttribute SysAuthenticationPersonalTempEntity sysAuthenticationPersonalTempEntity) {
        AppBean ab = new AppBean();
        try {
            if (category == 1) {
                //关系表s
                sysAuthenticationPersonalTempEntity.setUpdateTime(DateUtil.getNow());
                iPeopleAuthService.insert(sysAuthenticationPersonalTempEntity);
                sysRealNameAuthMapper.deleteByPrimaryKey(sysAuthenticationPersonalTempEntity.getId());
            } else if (category == 2) {
                //临时表
                sysAuthenticationPersonalTempEntity.setUpdateTime(DateUtil.getNow());
                sysAuthPersonalTempMapper.updateByPrimaryKeySelective(sysAuthenticationPersonalTempEntity);
            }
            ab.setMessage("保存成功");
        } catch (Exception e) {
            ab.setMessage("保存异常");
        }
        return ab;
    }

    /**
     * 编辑提交并保存
     *
     * @param sysOwnerPeopleEntity
     * @param enterpriseAuth
     * @return
     */
    @PostMapping(value = "/updatePeopleAuth")
    @ResponseBody
    @SLog(action = "编辑个人实名认证提交并保存")
    public AppBean updatePeopleAuth(@RequestParam("category") int category,
                                    @RequestParam("param") String cover,
                                    @ModelAttribute EnterpriseAuth enterpriseAuth,
                                    @ModelAttribute SysOwnerPeopleEntity sysOwnerPeopleEntity) {
        try {
            SysRealNameAuthenticationEntity entity = new SysRealNameAuthenticationEntity();
            if (category == 1) {
                //关系表
                entity = iPeopleAuthService.authPersonal(cover, enterpriseAuth, sysOwnerPeopleEntity);
            } else if (category == 2) {
                //临时表
                entity = iPeopleAuthService.authPersonal(cover, enterpriseAuth, sysOwnerPeopleEntity);
                iPeopleAuthService.delete(sysOwnerPeopleEntity.getId());
            }
            AppBean appBean = new AppBean(ResultEnum.RESULT_YES.getValue(), "认证成功");
            Map<String, Object> result = new HashMap();
            Class type = entity.getClass();
            BeanInfo beanInfo = Introspector.getBeanInfo(type);
            PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();
            for (PropertyDescriptor descriptor : propertyDescriptors) {
                String propertyName = descriptor.getName();
                if (!propertyName.equals("class")) {
                    Method readMethod = descriptor.getReadMethod();
                    Object res = readMethod.invoke(entity);
                    if (res != null) {
                        result.put(propertyName, res);
                    } else {
                        result.put(propertyName, "");
                    }
                }
            }
            appBean.setData(result);
            return appBean;
        } catch (Exception e) {
            if (e instanceof CoverException) {
                return new AppBean(ResultEnum.RESULT_EXCEPTTYPE.getValue(), "认证失败:" + e.getMessage());
            }
            if (e.getMessage().indexOf("Connection timed out") != -1) {
                return new AppBean(ResultEnum.RESULT_NO.getValue(), "认证失败:认证请求超时，请再次提交");
            }
            return new AppBean(ResultEnum.RESULT_NO.getValue(), "认证失败:" + e.getMessage());
        }
    }

    /**
     * 页面提交
     *
     * @param id
     * @param cover
     * @return
     */
    @SLog(action = "个人实名认证提交")
    @PostMapping(value = "/submitPeopleAuth")
    @ResponseBody
    public AppBean submitPeopleAuth(@RequestParam(value = "id", required = false) String id, @RequestParam(value = "param", required = false) String cover) {
        try {
            iPeopleAuthService.submitPeopleAuth(id, cover);
            return new AppBean("提交成功");
        } catch (Exception e) {
            if(e instanceof ValidateException){
                return new AppBean(ResultEnum.RESULT_VALIDATEEXCEPTION.getValue(), "提交失败:" + e.getMessage());
            }
            if (e instanceof CoverException){
                return new AppBean(ResultEnum.RESULT_EXCEPTTYPE.getValue(), "提交失败:" + e.getMessage());
            }
            return new AppBean("提交失败:" + e.getMessage());
        }
    }


}