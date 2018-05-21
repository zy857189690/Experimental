package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.annotation.Module;
import com.bitnei.cloud.common.annotation.SLog;
import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.cloud.common.bean.ExcelData;
import com.bitnei.cloud.common.pojo.*;
import com.bitnei.cloud.common.util.*;
import com.bitnei.cloud.gen.config.ProjectConfig;
import com.bitnei.cloud.report.domain.EnterpriseAuth;
import com.bitnei.cloud.report.domain.SysAuthenticationCompanyTempEntity;
import com.bitnei.cloud.report.domain.SysCustomerUnitEntity;
import com.bitnei.cloud.report.domain.SysRealNameAuthenticationEntity;
import com.bitnei.cloud.report.service.*;
import com.bitnei.cloud.report.service.impl.SysCustomerUnitServiceImpl;
import com.bitnei.cloud.report.util.CoverException;
import com.bitnei.commons.datatables.PagerModel;
import com.bitnei.commons.util.SecurityUtil;
import freemarker.template.Template;
import jodd.util.ClassLoaderUtil;
import jodd.util.StringUtil;
import org.apache.commons.collections.MapUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.NotOLE2FileException;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.RequestContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;

/**
 *
 * 企业实名认证
 * @author chenyl or 13718602502@163.com
 */
@Module(name = "企业实名认证")
@Controller
@RequestMapping(value = "/companyAuth")
@SuppressWarnings("all")
public class CompanyAuthController extends BaseController{
    public final static String BASE="/module/report/companyAuth/";

    @Autowired
    ICompanyAuthService companyAuthService;

    @Autowired
    ISysRealNameAuthService sysRealNameAuthService;

    @Autowired
    ISysAuthCompanyTempService sysAuthCompanyTempService;

    @Autowired
    ISysCustomerUnit sysCustomerUnit;

    @Autowired
    ISysCustomerUnitService customerUnitService;

    @Autowired
    ConstantMap constantMap;

    static Logger logger = LoggerFactory.getLogger(CompanyAuthController.class.getSimpleName());

    /**
     * 车辆绑定
     * @return
     */
    @GetMapping("/dialog")
    @SLog(action="车辆绑定")
    public String dialog(){
        return  BASE + "companyAuth";
    }

    /**
     * 测试列表页
     * @return
     */
    @GetMapping("/list")
    public String toList(){
        return BASE + "temp_list";
    }

    /**
     * 企业实名认证
     * @param id
     * @param flag
     * @return
     */
    @GetMapping("/company_new")
    public String toNew(Model model, @RequestParam(value = "id",required = false) String id,
                        @RequestParam(value = "flag",required = false) String flag){
        if ("no_real_customer".equals(flag)){
            SysAuthenticationCompanyTempEntity entity = sysAuthCompanyTempService.findByPk(id);
            model.addAttribute("sysCustomerUnitEntity",entity);
        }else{
            model.addAttribute("enterpriseAuth", new EnterpriseAuth());
            model.addAttribute("sysCustomerUnitEntity",new SysCustomerUnitEntity());
            model.addAttribute("btnflag", "initial");
        }
        return BASE + "add";
    }

    /**
     * 企业实名认证
     * @param id 企业id/sim卡id
     * @param flag =sim?由沃特玛sim卡管理传值过来需要回显sim卡相关信息，否则回显客户单位相关信息
     * @return
     */
    @GetMapping("/add_company_new")
    public String addCompanyNew(Model model, @RequestParam(value = "id",required = false) String id,
                        @RequestParam(value = "flag",required = false) String flag){
        if ("sim".equals(flag)){
            EnterpriseAuth enterpriseAuth = this.companyAuthService.findBySimCardId(id);
            model.addAttribute("enterpriseAuth", enterpriseAuth);
            model.addAttribute("sysCustomerUnitEntity",new SysCustomerUnitEntity());
            model.addAttribute("btnflag", "simcard");
        }else if ("customer".equals(flag)){
            SysCustomerUnitEntity sysCustomerUnitEntity = this.sysCustomerUnit.findById(id);
            model.addAttribute("sysCustomerUnitEntity",sysCustomerUnitEntity);
            model.addAttribute("btnflag", "customer");
        }else{
            model.addAttribute("enterpriseAuth", new EnterpriseAuth());
            model.addAttribute("sysCustomerUnitEntity",new SysCustomerUnitEntity());
            model.addAttribute("btnflag", "initial");
        }
        return BASE + "add";
    }
    /**
     * 企业实名认证详情
     * @return
     */
    @GetMapping("/company_details")
    public String toDetails(){
        return BASE + "details_one";
    }

    /**
     * 导入结果
     */
    @GetMapping("/import_result")
    @SLog(action="企业实名认证批量导入结果查询")
    public String import_result(Model model,@RequestParam(value = "json",required = false) String json){
        model.addAttribute("json",json);
        return BASE + "import_result";
    }

    @PostMapping("/test_data")
    @ResponseBody
    public PagerModel testData(){
        return null;
    }

    /**
     * 企业实名认证
     * @param enterpriseAuth 车辆信息
     * @param sysCustomerUnitEntity 企业信息
     * @param resultType 标记是否为临时表数据 如果是实名认证完成后需要删除这条记录
     * @return
     */
    @PostMapping("/company_auth")
    @ResponseBody
    @SLog(action="企业实名认证")
    public AuthResult companyAuth(
            @ModelAttribute EnterpriseAuth enterpriseAuth,
            @ModelAttribute SysCustomerUnitEntity sysCustomerUnitEntity,
            @RequestParam(value = "currentDataId",required = false) String currentId,
            @RequestParam(value = "authenticationResult",required = false) String resultType,
            @RequestParam(value = "cover",required = false) String cover){
        AuthResult result = new AuthResult();
        result.setCode(1);
        try{
            result.setEntity(companyAuthService.authCustomer(enterpriseAuth,sysCustomerUnitEntity,currentId,resultType,cover));
        }catch (Exception e){
            result.setMessage(e.getMessage());
            if(e instanceof CoverException){
                result.setCode(2);
                return result;
            }
            result.setCode(-1);
            return result;
        }
        result.setMessage("提交成功");
        return result;
    }

    /**
     * 针对列表直接提交而建立的接口
     * 针对未提交的
     * 且没有企业信息的情况下
     * @param enterpriseAuth
     * @param sysCustomerUnitEntity
     * @return
     */
    @PostMapping("/company_auth_no_company")
    @ResponseBody
    @SLog(action="企业实名认证提交")
    public AuthResult companyAuth(@ModelAttribute SysAuthenticationCompanyTempEntity param,
                                  @RequestParam(value = "cover",required = false) String cover){
        AuthResult result = new AuthResult();
        result.setCode(1);
        try{
            result.setEntity(companyAuthService.authCustomer(param,cover));
        }catch (Exception e){
            result.setMessage(e.getMessage());
            if(e instanceof CoverException){
                result.setCode(2);
                return result;
            }
            result.setCode(-1);
            return result;
        }
        result.setMessage("提交成功");
        return result;
    }


    /**
     * 只负责保存 不做校验
     * 企业实名保存
     * @return
     */
    @PostMapping("/company_temp_save")
    @ResponseBody
    @SLog(action="企业实名认证保存")
    public AppBean companyAuthSave(
            @ModelAttribute SysAuthenticationCompanyTempEntity sysAuthenticationCompanyTempEntity){
        AppBean result = new AppBean();
        result.setCode(1);
        try{
            companyAuthService.saveAuthenticationCompanyTemp(sysAuthenticationCompanyTempEntity);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.setCode(-1);
            result.setMessage(e.getMessage());
            return result;
        }
        result.setMessage("保存成功");
        return result;
    }

    /**
     * 更新 不做校验
     * 企业实名保存
     * @return
     */
    @PostMapping("/company_temp_update")
    @ResponseBody
    @SLog(action="企业实名认证更新")
    public AppBean companyAuthUpdate(
            @ModelAttribute SysAuthenticationCompanyTempEntity sysAuthenticationCompanyTempEntity){
        AppBean result = new AppBean();
        result.setCode(1);
        try{
            sysAuthCompanyTempService.updateRealName(sysAuthenticationCompanyTempEntity);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.setCode(-1);
            result.setMessage(e.getMessage());
            return result;
        }
        result.setMessage("保存成功");
        return result;
    }

    /**
     * 认证信息详详情
     * @param param
     * @param model
     * @return
     */
    @GetMapping("/company_all_info")
    @SLog(action="企业实名认证详情")
    public String companyAuthInfo(@ModelAttribute SysAuthenticationCompanyTempEntity param,
            Model model){
        SysAuthenticationCompanyTempEntity entity =
                sysAuthCompanyTempService.findById(param.getId());
        SysAuthenticationCompanyTempProxy proxy = new SysAuthenticationCompanyTempProxy();
        BeanUtils.copyProperties(entity,proxy);
        model.addAttribute("mode",proxy);
        return BASE + "details_one";
    }

    /**
     * 认证信息详编辑
     * @param param
     * @param model
     * @return
     */
    @GetMapping("/company_edit")
    public String companyAuthEdit(@ModelAttribute SysAuthenticationCompanyTempEntity param,
                                  Model model){
        SysAuthenticationCompanyTempEntity entity =
                sysAuthCompanyTempService.findById(param.getId());
        model.addAttribute("mode",entity);
        return BASE + "edit";
    }

    /**
     * 企业认证列表详情
     * @return
     */
    @PostMapping("/datagrid")
    @ResponseBody
    @SLog(action="企业实名认证列表")
    public PagerModel companyAuthList(){
        try{
            return sysAuthCompanyTempService.pagerQuery();
        }catch (Exception e){
            logger.error(e.getMessage());
            return null;
        }
    }

    /**
     * 跳转企业车辆绑定
     * @param param
     * @param model
     * @return
     */
    @GetMapping("/company_to_bind_car")
    public String companyToBindCar(
            @ModelAttribute SysRealNameAuthenticationEntity param,
            Model model,@RequestParam(value = "flag", required = false) String flag){
        if ("enterprise".equals(flag)){
            model.addAttribute("flag", flag);
        }
        model.addAttribute("authentication_id",param.getAuthenticationId());
        return BASE + "company_bind_car";
    }

    /**
     * 企业车辆绑定
     * @param enterpriseAuth 车辆相关信息
     * @param sysCustomerUnitEntity 客户信息 只使用ID 扩展性接受实体
     * @return
     */
    @PostMapping("/company_bind_car")
    @ResponseBody
    @SLog(action="企业车辆绑定")
    public AppBean companyBindCar(
            @ModelAttribute EnterpriseAuth enterpriseAuth,
            @ModelAttribute SysCustomerUnitEntity sysCustomerUnitEntity){
        AppBean result = new AppBean();
        result.setCode(1);
        try{
            SysRealNameAuthenticationEntity entity = companyAuthService.bindCar(enterpriseAuth, sysCustomerUnitEntity);
            Map<String,Object> resultData = new HashMap<>();
            resultData.put("id", entity.getId());
            result.setData(resultData);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.setCode(-1);
            result.setMessage(e.getMessage());
            return result;
        }
        result.setMessage("绑定成功");
        return result;
    }

    /**
     * 企业批量实名认证
     * @param flag 0表示实名认证通过前台需要文本展示1代表实名认证没有通过，返回前台需要都是可编辑的
     *
     * @return
     */
    private static final String DISPLAY_TEXT = "0";
    private static final String DISPLAY_EDIT = "1";
    @GetMapping("/company_all")
    public String toNewAll(
            @ModelAttribute SysCustomerUnitEntity sysCustomerUnitEntity,
            @RequestParam(value = "flag", required = false) String flag,
                           Model model){

        sysCustomerUnitEntity = sysCustomerUnit.findById(sysCustomerUnitEntity.getId());
        model.addAttribute("mode",sysCustomerUnitEntity);
        if (DISPLAY_TEXT.equals(flag) || DISPLAY_EDIT.equals(flag)){
            model.addAttribute("is_edit", flag);
            return BASE + "add_all_edit";
        }else{
            model.addAttribute("is_edit", DISPLAY_EDIT);
            return BASE + "add_all_edit";
        }
    }

    /**
     * 导入excel示例。
     */
    private ExcelParseConfig.OnParseListener<EnterpriseAuth> onParseListener =
            new ExcelParseConfig.OnParseListener<EnterpriseAuth>() {
        @Override
        public EnterpriseAuth onParse(EnterpriseAuth instance) {
            return instance;
        }
    };

    @PostMapping("/company_all_auth_noCom")
    @ResponseBody
    public Map<String,Object> authAllNoComInfo(
            @ModelAttribute SysCustomerUnitEntity sysCustomerUnitEntity,
            @RequestParam(value = "fileName",required = false) MultipartFile multipartFile){
        SysCustomerUnitEntity entity = customerUnitService.findById(sysCustomerUnitEntity.getId());
        return authAll(entity,multipartFile);
    }

    /**
     * 企业批量实名认证
     * @return
     */
    @PostMapping("/company_all_auth")
    @ResponseBody
    @SLog(action="企业批量实名认证")
    public Map<String,Object> authAll(
            @ModelAttribute SysCustomerUnitEntity sysCustomerUnitEntity,
            @RequestParam(value = "fileName",required = false) MultipartFile multipartFile){
        List<EnterpriseAuth> enterpriseAuths = null;
        //整装认证结果
        Map<String,Object> result = new HashMap<>();
        result.put("code",0);
        try {
            ExcelParseConfig<EnterpriseAuth> excelParseConfig = new ExcelParseConfig<>(EnterpriseAuth.class);
            excelParseConfig.setColumnNames(Arrays.
                    asList("setVin","setSerialNumber","setImei","setSimCartNumber","setIccid","setLineNameEn","setChannelId"));
            excelParseConfig.setOnParseListener(onParseListener);
            enterpriseAuths = uploadTemplates(multipartFile, excelParseConfig);
            //数据处理通过应用的方式操作 enterpriseAuths
            companyAuthService.authCustomerAll(sysCustomerUnitEntity,enterpriseAuths);
            //导入完毕 开始生成excel
            createXlsResult(enterpriseAuths);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            result.put("code",-1);
            result.put("message",e.getMessage());
            if(e instanceof NotOLE2FileException){
                result.put("message","导入文件格式或数据不正确");
            }
            return result;
        }
        if(enterpriseAuths == null){
            result.put("total",0);
        }else{
            result.put("total",enterpriseAuths.size());
        }
        result.put("rows",enterpriseAuths);
        return result;
    }

    /**
     * 生成导出结果xls
     * @param enterpriseAuths
     */

    private void createXlsResult(List list) {
        DataLoader.loadNames(list);
        DataLoader.loadDictNames(list);
        String srcBase = RequestContext.class.getResource("/templates/").getFile();
        String srcFile = srcBase +"module/report/companyAuth/result.xls";
        ExcelData ed = new ExcelData();
        ed.setTitle("企业实名认证");
        ed.setExportTime(DateUtil.getNow());
        ed.setData(list);
        String outName = String.format("%s-导出-%s.xls", "批量企业实名认证结果", DateUtil.getShortDate());
        renderResponse(srcFile,downloadPath+"result.xls",outName,ed);
    }

    /**
     * 企业批量实名认证(保存)
     * @return
     */
    @PostMapping("/company_all_save")
    @ResponseBody
    @SLog(action="企业批量实名认证保存")
    public Map<String,Object> authAllSave(
            @ModelAttribute SysCustomerUnitEntity sysCustomerUnitEntity,
            @RequestParam(value = "fileName",required = false) MultipartFile multipartFile){
        List<EnterpriseAuth> enterpriseAuths = null;
        //整装认证结果
        Map<String,Object> result = new HashMap<>();
        result.put("code",0);
        try {
            ExcelParseConfig<EnterpriseAuth> excelParseConfig = new ExcelParseConfig<>(EnterpriseAuth.class);
            excelParseConfig.setColumnNames(Arrays.
                    asList("setVin","setSerialNumber","setImei","setSimCartNumber","setIccid","setLineNameEn","setChannelId"));
            excelParseConfig.setOnParseListener(onParseListener);
            enterpriseAuths = uploadTemplates(multipartFile, excelParseConfig);
            //数据处理通过应用的方式操作 enterpriseAuths
            companyAuthService.authCustomerAllSave(sysCustomerUnitEntity,enterpriseAuths);
            createXlsResult(enterpriseAuths);
        } catch (Exception e) {
            result.put("code",-1);
            result.put("message",e.getMessage());
            if(e instanceof NotOLE2FileException){
                result.put("message","导入文件格式或数据不正确");
            }
            return result;
        }
        if(enterpriseAuths == null){
            result.put("total",0);
        }else{
            result.put("total",enterpriseAuths.size());
        }
        result.put("rows",enterpriseAuths);
        return result;
    }

    /**
     * 刷新
     * @return
     */
    @GetMapping("/refresh")
    @ResponseBody
    @SLog(action="企业实名认证刷新")
    public AppBean refresh(){
        AppBean result = new AppBean();
        result.setCode(1);
        try{
            sysRealNameAuthService.refreshRealNameState();
        }catch (Exception e){
            logger.error(e.getMessage());
            result.setCode(-1);
            result.setMessage(e.getMessage());
            return result;
        }
        return result;
    }

    /**
     * 导出
     * @return
     */
    @GetMapping("/export")
    @SLog(action="企业实名认证导出")
    public void export(){
        List list = sysAuthCompanyTempService.findBySqlId("pagerModel",ServletUtil.getQueryParams());
        DataLoader.loadNames(list);
        DataLoader.loadDictNames(list);

        String srcBase = RequestContext.class.getResource("/templates/").getFile();
        String srcFile = srcBase +"module/report/companyAuth/export.xls";

        ExcelData ed = new ExcelData();
        ed.setTitle("企业实名认证");
        ed.setExportTime(DateUtil.getNow());
        ed.setData(list);
        String outName = String.format("%s-导出-%s.xls", "企业实名认证", DateUtil.getShortDate());
        EasyExcel.renderResponse(srcFile,outName,ed);
    }

    /**
     * 对EasyExcel的改动
     * @param dstFile
     * @param headers
     * @param fields
     */
    public static void renderResponse(String srcFile,String dstFile, String outName, ExcelData ed) {
        try {
            ProjectConfig projectConfig = (ProjectConfig)ApplicationContextProvider.getBean("projectConfig");
            InputStream stream = null;
            if (projectConfig.getDev().getMode().equals("prod")) {
                if (!srcFile.startsWith("/templates")) {
                    int index = srcFile.indexOf("/templates");
                    srcFile = srcFile.substring(index);

                }
                logger.info("prod");
                stream = ClassLoaderUtil.getResourceAsStream(srcFile);
                logger.info(srcFile);
            } else {
                logger.info("dev");
                stream = new FileInputStream(srcFile);
                logger.info(srcFile);
            }

            POIFSFileSystem poifsFileSystem = new POIFSFileSystem((InputStream)stream);
            HSSFWorkbook workbook = new HSSFWorkbook(poifsFileSystem);
            HSSFSheet sheet = workbook.getSheetAt(0);
            HSSFRow fieldRow = sheet.getRow(1);
            Iterator<Cell> cellIterator = fieldRow.cellIterator();
            StringBuffer templateBody = new StringBuffer();
            templateBody.append("<#list list as obj>");

            while(cellIterator.hasNext()) {
                Cell cell = (Cell)cellIterator.next();
                String attr = cell.getStringCellValue();
                if (cellIterator.hasNext()) {
                    templateBody.append(attr).append("#C");
                } else {
                    templateBody.append(attr).append("#R");
                }
            }

            templateBody.append("</#list>");
            sheet.removeRow(fieldRow);
            String md5 = SecurityUtil.getMd5(templateBody.toString());
            FreeMarkerUtil freeMarkerUtil = (FreeMarkerUtil)ApplicationContextProvider.getBean("freeMarkerUtil");
            freeMarkerUtil.addStringTemplate(md5, templateBody.toString());
            Template template = freeMarkerUtil.getTemplate(md5);
            Map<String, Object> root = new HashMap();
            root.put("list", ed.getData());
            StringWriter writer = new StringWriter();
            template.process(root, writer);
            String str = writer.toString();
            String[] rows = str.split("\\#R");

            for(int i = 0; i < rows.length; ++i) {
                String row = rows[i];
                if (StringUtil.isNotEmpty(row)) {
                    HSSFRow hssfRow = sheet.createRow(i + 1);
                    String[] cells = row.split("\\#C");

                    for(int j = 0; j < cells.length; ++j) {
                        hssfRow.createCell(j).setCellValue(cells[j]);
                    }
                }
            }

            //在这里写入到本地磁盘
            FileOutputStream os = new FileOutputStream(dstFile);
            workbook.write(os);
            os.close();
            poifsFileSystem.close();
        } catch (Exception var24) {
            var24.printStackTrace();
        }

    }

    @Value(value = "${download-path}")
    String downloadPath;

    /**
     * 需要注明文件存储路径
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @GetMapping("/download_result")
    @ResponseBody
    @SLog(action="企业实名认证结果导出")
    public AppBean downExcTemplates(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        return downExcFile("import_result.xls",downloadPath+"result.xls", request, response);
    }

    /**
     * 复写的方法 从本地磁盘加载文件
     * @param fileName
     * @return
     * @throws IOException
     */
    @Override
    protected InputStream getDownLoadFile(String fileName) throws IOException {
        return new FileInputStream(fileName);
    }
}
