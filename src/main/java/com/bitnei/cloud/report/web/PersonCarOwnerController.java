package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.annotation.Module;
import com.bitnei.cloud.common.annotation.SLog;
import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.cloud.report.domain.SysOwnerPeopleEntity;
import com.bitnei.cloud.report.domain.SysRealNameAuthenticationEntity;
import com.bitnei.cloud.report.enums.ResultEnum;
import com.bitnei.cloud.report.service.IPeopleAuthService;
import com.bitnei.cloud.report.service.IPersonCarOwnerService;
import com.bitnei.cloud.report.util.FileUnloadUtil;
import com.bitnei.commons.bean.WebUser;
import com.bitnei.commons.datatables.PagerModel;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

@Module(name = "个人车主")
@Controller
@RequestMapping(value = "/personCarOwner")
public class PersonCarOwnerController extends BaseController {

    public final static String BASE="/module/report/PersonCarOwner/";

    private final Logger logger = Logger.getLogger(getClass());

    public final static String BASE_REQ_PATH ="/PersonCarOwner";

    private static final long CAPACITY = 500*1024;
    @Autowired
    private IPersonCarOwnerService iPersonCarOwnerService;

    @Autowired
    private IPeopleAuthService iPeopleAuthService;
    /**
     * 个人车主列表页面
     * @param model
     * @return
     */
    @GetMapping(value = "/list")
    //@RequiresPermissions(URL_LIST)
    @SLog(action = "个人车主列表页面")
    public String list(Model model){
        WebUser user = ServletUtil.getUser();
        return BASE + "list";

    }

    /**
     * 新增页面
     * @param
     * @return
     */
    @GetMapping(value = "/add")
    //@RequiresPermissions(BASE_REQ_PATH+"add")
    @SLog(action = "新增页面")
    public String add() {
        return BASE+"edit";
    }

    /**
     * 编辑页面
     * @param model
     * @return
     */
    @GetMapping(value = "/edit")
    //@RequiresPermissions(BASE_REQ_PATH+"add")
    @SLog(action = "编辑页面")
    public String edit(Model model, String id) {
        SysOwnerPeopleEntity sysOwnerPeopleEntity = this.iPersonCarOwnerService.findById(id);
        model.addAttribute("sysOwnerPeopleEntity",sysOwnerPeopleEntity);
        return BASE+"edit";
    }

    /**
     * 跳转个人实名认证提示页面
     * @param model
     * @return
     */
    @GetMapping(value = "/certificate")
    //@RequiresPermissions(BASE_REQ_PATH+"add")
    @SLog(action = "跳转个人实名认证提示页面")
    public String certificate(Model model, String id, String msg) {
        model.addAttribute("id", id);
        model.addAttribute("msg",msg);
        return BASE+"certificate";
    }

    /**
     * 详情页面
     * @param model
     * @return
     */
    @GetMapping(value = "/detail")
    //@RequiresPermissions(BASE_REQ_PATH+"add")
    @SLog(action = "编辑页面")
    public String detail(Model model, String id) {
        SysOwnerPeopleEntity sysOwnerPeopleEntity = this.iPersonCarOwnerService.findById(id);
        model.addAttribute("sysOwnerPeopleEntity",sysOwnerPeopleEntity);
        return BASE+"detail";
    }

    /**
     * 保存车主信息
     * @param
     * @return
     */
    @PostMapping(value = "/save")
    @ResponseBody
    @SLog(action = "保存车主信息")
    public AppBean save(SysOwnerPeopleEntity sysOwnerPeopleEntity) {
        return this.iPersonCarOwnerService.saveOrUpdate(sysOwnerPeopleEntity);
    }

    /**
     * 逻辑删除
     * @param ids
     * @return
     */
    @RequestMapping("/del")
    @ResponseBody
    @SLog(action = "逻辑删除")
    public AppBean del(String ids) {
        return this.iPersonCarOwnerService.del(ids);
    }

    /**
     * 查询个人实名认证结果
     * @param id
     * @return
     */
    @RequestMapping("/checkAuthInfo")
    @ResponseBody
    @SLog(action = "查询个人实名认证结果")
    public AppBean checkAuthInfo(@RequestParam("id") String id) {
        List<SysRealNameAuthenticationEntity> list = this.iPeopleAuthService.checkAuthInfo(id);
        if (list.size()>0){
            return new AppBean(ResultEnum.RESULT_YES.getValue(),"认证通过");
        }
        return new AppBean(ResultEnum.RESULT_NO.getValue(), "该车主没有认证");
    }

    /**
     * 表格查询
     * @return
     */
    @PostMapping(value = "/datagrid")
    @ResponseBody
    //@RequiresPermissions(URL_LIST)
    @SLog(action = "表格查询")
    public PagerModel datagrid(){
        PagerModel pm = this.iPersonCarOwnerService.pageQuery();
        return pm;
    }

    /**
     * 上传图片
     * @param request
     * @param file
     * @param imgData
     * @return
     */
    @RequestMapping("/upload")
    @ResponseBody
    @SLog(action = "图片上传")
    public HashMap<String, String> upload(HttpServletRequest request, @RequestParam(value = "file", required = false)MultipartFile file,String imgData) {
        String contentType = file.getContentType();
        String fileName = file.getOriginalFilename();
        String filePath = request.getSession().getServletContext().getRealPath("imgupload/");
        HashMap<String, String> map = new HashMap<>();
        try {
            FileUnloadUtil.uploadFile(file.getBytes(), filePath, fileName);
            FileUnloadUtil.reduceImg(filePath+fileName, filePath+fileName, 500, 400,null);
            String imageBinary = FileUnloadUtil.getImageBinary(filePath+fileName);
            map.put("url",imageBinary);
            if(imageBinary.getBytes("utf-8").length<=CAPACITY){
                map.put("status", "0");
            }else {
                map.put("status", "1");
            }
            return map;
        } catch (Exception e) {
            // TODO: handle exception
        }
        map.put("status", "1");
        return map;
    }
}
