package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.common.DateUtil;
import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.common.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.Demo1;
import com.bitnei.cloud.report.domain.ExperimentalStage;
import com.bitnei.cloud.report.mapper.Demo1Mapper;
import com.bitnei.cloud.report.service.IDemo1Service;
import com.bitnei.cloud.report.service.IExperimentalStageService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import com.bitnei.commons.util.UtilHelper;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.InputStream;
import java.util.*;


/**
 * <p>
 * ----------------------------------------------------------------------------- <br>
 * 工程名 ： 基础框架 <br>
 * 功能： Demo1Service实现<br>
 * 描述： Demo1Service实现<br>
 * 授权 : (C) Copyright (c) 2017 <br>
 * 公司 : 北京理工新源信息科技有限公司<br>
 * ----------------------------------------------------------------------------- <br>
 * 修改历史 <br>
 * <table width="432" border="1">
 * <tr>
 * <td>版本</td>
 * <td>时间</td>
 * <td>作者</td>
 * <td>改变</td>
 * </tr>
 * <tr>
 * <td>1.0</td>
 * <td>2018-03-13 17:07:14</td>
 * <td>chenpeng</td>
 * <td>创建</td>
 * </tr>
 * </table>
 * <br>
 * <font color="#FF0000">注意: 本内容仅限于[北京理工新源信息科技有限公司]内部使用，禁止转发</font> <br>
 *
 * @author chenpeng
 * @version 1.0
 * @since JDK1.8
 */
@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.ExperimentalStageMapper")
public class ExperimentalStageServiceImpl extends BaseService implements IExperimentalStageService {

    @Autowired
    protected HttpServletRequest request;

    @Override
    public PagerModel pageQuery() {
        DataGridOptions dataLayOptions = ServletUtil.getDataLayOptions();
        PagerModel pm = findPagerModel("pagerModel", dataLayOptions);
        return pm;
    }

    /**
     * 新增
     *
     * @param o
     * @return
     */
    @Override
    public int insert(Object o) {
        Demo1 demo1 = (Demo1) o;
        demo1.setId(UtilHelper.getUUID());
        demo1.setCreateTime(DateUtil.getNow());
        return super.insert(demo1);
    }

    /**
     * 更新
     *
     * @param o
     * @return
     */
    @Override
    public int update(Object o) {
        ExperimentalStage experimentalStage = (ExperimentalStage) o;
        // demo1.setUpdateTime(DateUtil.getNow());
        // demo1.setUpdateBy(ServletUtil.getCurrentUser());
        return super.update(experimentalStage);
    }

    @Override
    public <T> T findById(String id) {
        ExperimentalStage experimentalStage = super.findById(id);
        // DataLoader.loadNames(demo1);
        // DataLoader.loadDictNames(demo1);
        return (T) experimentalStage;
    }

    /**
     * 删除多个
     *
     * @param ids
     * @return
     */
    @Override
    public int deleteMulti(String ids) {
        String[] arr = ids.split(",");
        int count = 0;
        for (String id : arr) {
            int r = super.delete(id);
            count += r;
        }
        return count;
    }

    @Override
    public void export() {

   /*     List list = findBySqlId("pagerModel",ServletUtil.getQueryParams());
        DataLoader.loadNames(list);
        DataLoader.loadDictNames(list);

        String srcBase = RequestContext.class.getResource("/templates/").getFile();
        String srcFile = srcBase +"module/report/demo1/export.xls";

        ExcelData ed = new ExcelData();
        ed.setTitle("演示管理1");
        ed.setExportTime(DateUtil.getNow());
        ed.setData(list);
        String outName = String.format("%s-导出-%s.xls", "演示管理1", DateUtil.getShortDate());
        EasyExcel.renderResponse(srcFile,outName,ed);
*/
    }

    @Override
    public JsonModel saveSubmit(ExperimentalStage experimentalStage) {
        JsonModel jm = new JsonModel();
        String code = experimentalStage.getReportCode();
        Map<String, String> map = new HashMap<>(16);
        map.put("reportCode", code);
        List<ExperimentalStage> findByCode = findBySqlId("pagerModel", map);
        if (null!=experimentalStage.getReportImg()){
            String[] reportImg = experimentalStage.getReportImg();
            String join = StringUtils.join(reportImg, ",");
            experimentalStage.setReportImgs(join);
        }

        // 新增
        if (experimentalStage.getId().equals("-1")) {
            if (null != findByCode && findByCode.size() > 0) {
                jm.setFlag(false);
                jm.setMsg(code + "点样编号已经存在，请重新输入!");
                return jm;
            }
            experimentalStage.setId(UtilHelper.getUUID());
            super.insert(experimentalStage);

        } else {
            if (!experimentalStage.getId().equals(findByCode.get(0).getId())) {
                jm.setFlag(false);
                jm.setMsg(code + "点样编号已经存在，请重新输入!");
                return jm;
            }
            // 修改
            experimentalStage.setUpdateTime(DateUtil.getNowTime());
            update(experimentalStage);
        }
        jm.setFlag(true);
        jm.setMsg("保存成功!");
        return jm;
    }

    @Override
    public JsonModel importHoles(String name, String code, MultipartFile file) throws Exception {
        JsonModel jm = new JsonModel();
        String fileName = file.getOriginalFilename();

        if (file == null) {
            return JsonModel.error("文件获取失败！");
        }
        Long fileSize = file.getSize();
        if (fileSize > 10240 * 1024) {
            return JsonModel.error("文件大小超出最大10M限制！");
        }
        String suffixName = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();//去掉文件名，获取文件的后缀
        if (!".xls".equals(suffixName) && !".xlsx".equals(suffixName)) {
            return JsonModel.error("上传文件格式不正确，确认文件后缀名为xls、xlsx！");
        }

        boolean isExcel2003 = true;
        if (fileName.matches("^.+\\.(?i)(xlsx)$")) {
            isExcel2003 = false;
        }
        InputStream is = file.getInputStream();
        Workbook wb = null;
        if (isExcel2003) {
            wb = new HSSFWorkbook(is);
        } else {
            wb = new XSSFWorkbook(is);
        }
        Sheet sheet = wb.getSheetAt(0);

        Demo1 demo1 = new Demo1();
        Map<String, String> map = new HashMap<>(16);
        //前两行和最后一行不要 默认值
        for (int r = 2; r <= sheet.getLastRowNum() - 1; r++) {
            Row row = sheet.getRow(r);
            if (row == null) {
                continue;
            }
            if (row.getCell(0).getCellType() != 1) {
                // throw new MyException("导入失败(第"+(r+1)+"行,ID单元格格式请设为文本格式)");
            }
            //1-10 单元格数量
            for (int k = 1; k <= row.getLastCellNum() - 2; k++) {
                Cell cell0 = row.getCell(k);
                cell0.setCellType(CellType.STRING);
                String number0 = cell0.getStringCellValue().toString();
                String s = String.format("%02d", r * 10 - 20 + k);
                String key1 = "hno" + s;
                map.put(key1, number0);
            }
        }

        if (map.size() > 0) {
            map.put("id",UtilHelper.getUUID());
            map.put("name",name);
            map.put("code",code);
            map.put("createTime",DateUtil.getNow());
         //   demo1Mapper.insert(map);
        } else {
            jm.setMsg("孔位数据为空，请确认后导入操作！！");
            jm.setFlag(false);
            return jm;
        }
        jm.setFlag(true);
        return jm;
    }

    @Override
    public List uploadPictureList(MultipartFile[] file, HttpServletRequest request) {
        File targetFile=null;
        String msg="";//返回存储路径
        int code=1;
        List imgList=new ArrayList();
        if (file!=null && file.length>0) {
            for (int i = 0; i < file.length; i++) {
                String fileName=file[i].getOriginalFilename();//获取文件名加后缀
                if(fileName!=null&&fileName!=""){
                    String path = System.getProperty("user.dir")+"\\src\\main\\resources\\static\\pciture\\";

                    String returnUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() +"/pciture/";//存储路径
                   // String path = request.getSession().getServletContext().getRealPath("upload/imgs"); //文件存储位置
                    String fileF = fileName.substring(fileName.lastIndexOf("."), fileName.length());//文件后缀
                    fileName=new Date().getTime()+"_"+new Random().nextInt(1000)+fileF;//新的文件名

                    //先判断文件是否存在
                    String fileAdd = com.bitnei.cloud.smc.util.DateUtil.formatTime(new Date(),"yyyyMMdd");
                    File file1 =new File(path+"/"+fileAdd);
                    //如果文件夹不存在则创建

                    if(!file1 .exists()  && !file1 .isDirectory()){
                        // 多级目录创建
                        file1 .mkdirs();
                    }
                    targetFile = new File(file1, fileName);
                    try {
                        file[i].transferTo(targetFile);
                        msg=returnUrl+fileAdd+"/"+fileName;
                        imgList.add(msg);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return  imgList;
    }

}
