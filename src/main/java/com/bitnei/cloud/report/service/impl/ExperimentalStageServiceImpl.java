package com.bitnei.cloud.report.service.impl;

import com.alibaba.fastjson.JSON;
import com.bitnei.cloud.common.DateUtil;
import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.common.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.Demo1;
import com.bitnei.cloud.report.domain.ExperimentalData;
import com.bitnei.cloud.report.domain.ExperimentalDataDatil;
import com.bitnei.cloud.report.mapper.ExperimentalStageMapper;
import com.bitnei.cloud.report.service.IExperimentalStageService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import com.bitnei.commons.util.UtilHelper;
import lombok.extern.slf4j.Slf4j;
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
import java.util.stream.Collectors;


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
@Slf4j
public class ExperimentalStageServiceImpl extends BaseService implements IExperimentalStageService {

    @Autowired
    protected HttpServletRequest request;

    @Autowired
    private ExperimentalStageMapper experimentalStageMapper;

    @Override
    public ExperimentalDataDatil findById(String id) {
        return null;
    }

    @Override
    public PagerModel pageQuery() {
        DataGridOptions dataLayOptions = ServletUtil.getDataLayOptions();
        PagerModel pm = findPagerModel("pagerModel", dataLayOptions);
        return pm;
    }


    /**
     * 更新
     *
     * @param o
     * @return
     */


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
    public JsonModel saveSubmit(ExperimentalData experimentalData) {
        JsonModel jm = new JsonModel();
        jm.setFlag(true);
      /*  String code = experimentalStage.getReportCode();
        Map<String, String> map = new HashMap<>(16);
        map.put("reportCode", code);
        List<ExperimentalStage> findByCode = findBySqlId("pagerModel", map);
        if (null != experimentalStage.getReportImg()) {
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

        }*/
        update("updateDosage",experimentalData);
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
            map.put("id", UtilHelper.getUUID());
            map.put("name", name);
            map.put("code", code);
            map.put("createTime", DateUtil.getNow());
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
        File targetFile = null;
        String msg = "";//返回存储路径
        int code = 1;
        List imgList = new ArrayList();
        if (file != null && file.length > 0) {
            for (int i = 0; i < file.length; i++) {
                String fileName = file[i].getOriginalFilename();//获取文件名加后缀
                if (fileName != null && fileName != "") {
                    String path = System.getProperty("user.dir") + "\\src\\main\\resources\\static\\pciture\\";

                    String returnUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/pciture/";//存储路径
                    // String path = request.getSession().getServletContext().getRealPath("upload/imgs"); //文件存储位置
                    String fileF = fileName.substring(fileName.lastIndexOf("."), fileName.length());//文件后缀
                    fileName = new Date().getTime() + "_" + new Random().nextInt(1000) + fileF;//新的文件名

                    //先判断文件是否存在
                    String fileAdd = com.bitnei.cloud.smc.util.DateUtil.formatTime(new Date(), "yyyyMMdd");
                    File file1 = new File(path + "/" + fileAdd);
                    //如果文件夹不存在则创建

                    if (!file1.exists() && !file1.isDirectory()) {
                        // 多级目录创建
                        file1.mkdirs();
                    }
                    targetFile = new File(file1, fileName);
                    try {
                        file[i].transferTo(targetFile);
                        msg = returnUrl + fileAdd + "/" + fileName;
                        imgList.add(msg);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return imgList;
    }

    @Override
    public void addEx(Map<String, Object> map, Map<String, Object> mapHole, String exNo, String startTime, String updateTime, String status) {

       /* for(Map.Entry<String, Object> entry : map.entrySet()){
            String mapKey = entry.getKey();
            Object mapValue = entry.getValue();
            System.out.println(mapKey+":"+mapValue);
        }*/

        // 去掉id
        mapHole.remove("id");
        // 记录已经发现的实验编号
        Map<String, String> mapOver = new HashMap<>(16);
        List<ExperimentalData> findaAllExNo = findBySqlId("findaAllExNo", null);
        Map<String, String> collect = findaAllExNo.stream().collect(Collectors.toMap(ExperimentalData::getExNo, ExperimentalData::getId));
        for (Map.Entry<String, Object> entry : mapHole.entrySet()) {
            String key = entry.getKey();
            String value1 = entry.getValue().toString();
            if (!"pbs".equals(value1) && value1.length() > 3) {
                ExperimentalData experimentalData = new ExperimentalData();
                String[] split = value1.split("-");
                // 实验编号
                String exNos = split[0];
                String day = split[1];
                String yangpinNumber = split[2];
                String s = collect.get(exNos);
                ExperimentalDataDatil experimentalDataDatil = new ExperimentalDataDatil();
                experimentalDataDatil.setId(UtilHelper.getUUID());
                experimentalDataDatil.setReportDate(day);

                String replace = key.replace("h_no", "v_no");
                String value = map.get(replace).toString();
                switch (yangpinNumber) {
                    // 取浓度数值
                    case "1":
                        experimentalDataDatil.setExplameOne(value);
                        break;
                    case "2":
                        experimentalDataDatil.setExplameTwo(value);
                        break;
                    case "3":
                        experimentalDataDatil.setExplameThree(value);
                        break;
                }

                if (null == s) {
                    // 赋值ID
                    String id = UtilHelper.getUUID();
                    collect.put(exNos, id);
                    //入库操作
                    experimentalData.setId(id);
                    experimentalData.setExNo(exNos);
                    experimentalData.setStartTime(startTime);
                    experimentalData.setUpdateTime(updateTime);
                    experimentalData.setStatus(status);
                    insert(experimentalData);
                    // 入库详情
                    experimentalDataDatil.setExperimentalId(id);
                    experimentalStageMapper.insertExDataDatil(experimentalDataDatil);
                    // findBySqlId("insertExDataDatil",experimentalDataDatil);
                    //insert("insertDatil",experimentalData);
                } else {
                    // 全部为更新操作
                    experimentalDataDatil.setExperimentalId(s);
                    Map<String, String> parm = new HashMap<>();
                    parm.put("experimentalId", s);
                    parm.put("reportDate", experimentalDataDatil.getReportDate());
                    List<Map<String, String>> findExperimentals = findBySqlId("findExperimentals", parm);
                    if (findExperimentals.size() >= 1) {
                        // 更新操作
                        update(experimentalDataDatil);
                    } else {
                        //新增操作
                        experimentalStageMapper.insertExDataDatil(experimentalDataDatil);
                    }

                }
            }
        }
    }

    @Override
    public  Map<String,String> findByView(String id) {
        Map<String,String> map=new HashMap<>();
        map.put("id",id);
        List<ExperimentalDataDatil> findExs = findBySqlId("findExsDatil", map);

        // 改实验是否已经拟合完成

        // 记录加值
        double yp1ljnd=0l; // 样品1累计浓度
        double yp12jnd=0l;// 样品2累计浓度
        double yp13jnd=0l;// 样品3累计浓度

        for (ExperimentalDataDatil e : findExs){
            double totalnd=0l;
            if (StringUtils.isNotEmpty(e.getExplameOne())){
                double one = Double.parseDouble(e.getExplameOne());
                yp1ljnd+=one;
                e.setYp1ljnd(yp1ljnd);
                totalnd+=one;
            }
            if (StringUtils.isNotEmpty(e.getExplameTwo())){
                double tow = Double.parseDouble(e.getExplameTwo());
                yp12jnd+=tow;
                e.setYp12jnd(yp12jnd);
                totalnd+=tow;
            }
            if (StringUtils.isNotEmpty(e.getExplameThree())){
                double three = Double.parseDouble(e.getExplameThree());
                yp13jnd+=three;
                e.setYp13jnd(yp13jnd);
                totalnd+=three;
            }
            // 平均浓度
            e.setTotalnd(totalnd/3);
            //累计浓度百分比
            e.setPjljnd((yp1ljnd+yp12jnd+yp13jnd)/3);
            e.setYp1ljndbf(yp1ljnd/10);
            e.setYp12jndbf(yp12jnd/10);
            e.setYp13jndbf(yp13jnd/10);
            //平均累计百分比
            e.setPjbf((e.getYp1ljndbf()+e.getYp12jndbf()+e.getYp13jndbf())/3);
        }
        log.info(JSON.toJSONString(findExs));
        // 转换成map到前端显示
        Map<String,String> remap=new HashMap<>(16);
        for (ExperimentalDataDatil e: findExs){
            String reportDate = e.getReportDate();
            remap.put("exNo",e.getExNo());

            remap.put(reportDate+"explameOne",e.getExplameOne()==null ? "0": e.getExplameOne());
            remap.put(reportDate+"explameTwo",e.getExplameTwo()==null ? "0": e.getExplameTwo());
            remap.put(reportDate+"explameThree",e.getExplameThree()==null ? "0": e.getExplameThree());
            remap.put(reportDate+"totalnd",e.getTotalnd()+"");

            remap.put(reportDate+"yp1ljnd",e.getYp1ljnd()+"");
            remap.put(reportDate+"yp12jnd",e.getYp12jnd()+"");
            remap.put(reportDate+"yp13jnd",e.getYp13jnd()+"");
            remap.put(reportDate+"pjljnd",e.getPjljnd()+"");

            remap.put(reportDate+"yp1ljndbf",e.getYp1ljndbf()+"");
            remap.put(reportDate+"yp12jndbf",e.getYp12jndbf()+"");
            remap.put(reportDate+"yp13jndbf",e.getYp13jndbf()+"");
            remap.put(reportDate+"pjbf",e.getPjbf()+"");

        }
        remap.put("dosage",findExs.get(0).getDosage());
        return remap;
    }

    @Override
    public Map<String, String> findByIdZyl(String id) {
        Map<String,String> map =new HashMap<>(16);
        map.put("id",id);
        ExperimentalData experimentalData = unique("pagerModel", map);
        map.put("exNo",experimentalData.getExNo());
        map.put("dosage",experimentalData.getDosage());
        return map;
    }
}
