package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.common.DateUtil;
import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.common.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.mapper.Demo1Mapper;
import com.bitnei.cloud.report.mapper.RawDataMapper;
import com.bitnei.cloud.report.service.IDemo1Service;
import com.bitnei.cloud.report.service.IExperimentalStageService;
import com.bitnei.cloud.report.service.IRawDataService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import com.bitnei.commons.util.UtilHelper;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.RawDataMapper")
public class RawDataServiceImpl extends BaseService implements IRawDataService {

    @Autowired
    private RawDataMapper rawDataMapper;
    @Autowired
    private IDemo1Service demo1Service;

    @Autowired
    private Demo1Mapper demo1Mapper;
    @Autowired
    private IExperimentalStageService experimentalStageService;

    @Override
    public PagerModel pageQuery() {
        DataGridOptions dataLayOptions = ServletUtil.getDataLayOptions();
        PagerModel pm = findPagerModel("pagerModel", dataLayOptions);
        return pm;
    }

    @Override
    public JsonModel importRawDatas( MultipartFile file) throws IOException {
        JsonModel jm = new JsonModel();
        String fileName = file.getOriginalFilename();
        if (file == null) {
            return JsonModel.error("文件不能为空");
        }
        Long fileSize = file.getSize();
        if (fileSize > 10240 * 1024) {
            return JsonModel.error("文件大小超出最大10M限制！");
        }
        String suffixName = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();//去掉文件名，获取文件的后缀
        if (!".xls".equals(suffixName) && !".xlsx".equals(suffixName)) {
            return JsonModel.error("上传文件格式不正确，确认文件后缀名为xls、xlsx！");
        }

        // 送检编号
        String code=fileName.substring(0,fileName.lastIndexOf("."));
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
        int number = 0;
        int number2 = 0;
        Map<String, Object> map = new HashMap<>(16);
        Map<String, Object> mapHole = new HashMap<>(16);
        for (int r = 1; r <= sheet.getLastRowNum(); r++) {
            // 第九行开始是位置图

            Row row = sheet.getRow(r);
            if (row == null || r==9) {
                continue;
            }

            if (r<9){
            for (int k = 1; k < row.getLastCellNum(); k++) {
                Cell cell0 = row.getCell(k);
                cell0.setCellType(CellType.NUMERIC);
                double numericCellValue = cell0.getNumericCellValue();
                int keyNumber = ++number;
                String s = String.format("%02d", keyNumber);
                String key1 = "vno" + s;
                map.put(key1, numericCellValue);
            }
            }else if(r>9&&r<=17) {
                for (int k = 1; k < row.getLastCellNum() ; k++) {
                    Cell cell0 = row.getCell(k);
                    cell0.setCellType(CellType.STRING);
                    String number0 = cell0.getStringCellValue().toString();
                    int keyNumber = ++number2;
                    String s = String.format("%02d", keyNumber);
                    String key1 = "hno" + s;
                    mapHole.put(key1, number0);
                }
            }
        }

        if (map.size() > 0) {
            map.put("id", UtilHelper.getUUID());
            mapHole.put("id", map.get("id"));
            map.put("code", code);
            String s = sheet.getRow(18).getCell(0).toString().split(":")[1];
            String stime=  s.trim().substring(0,10);
            map.put("stime", stime);
            map.put("speople",sheet.getRow(24).getCell(0).toString());
           /* map.put("secondaryCoefficient", secondaryCoefficient);
            map.put("oneCoefficient", oneCoefficient);
            map.put("parameter", parameter);

            map.put("secondaryCoefficientAgain", secondaryCoefficientAgain);
            map.put("oneCoefficientAgain", oneCoefficientAgain);
            map.put("parameterAgain", parameterAgain);*/
            map.put("createTime", DateUtil.getNow());
            // 原始数据
            rawDataMapper.insert(map);
            // 位置图
            demo1Mapper.insert(mapHole);


        } else {
            jm.setMsg("原始数据为空，请确认后导入操作！！");
            jm.setFlag(false);
            return jm;
        }
        jm.setFlag(true);
        return jm;
    }

    @Override
    public List<Map<String,Object>> get(String id) {
        Map<String,String> pram=new HashMap<>();
        pram.put("id",id);
        List<Map<String,Object>> result = findBySqlId("findById", pram);
        List<Map<String, Object>> maps = demo1Mapper.findById(pram);
        if (null!=maps&&maps.size()>0){
            Map<String, Object> map1 = maps.get(0);
            // 原始数据
            result.add(map1);

          /*  double secondaryCoefficient = Double.parseDouble(map.get("secondary_coefficient").toString());
            double oneCoefficient = Double.parseDouble(map.get("one_coefficient").toString());
            double parameter = Double.parseDouble(map.get("parameter").toString());
            double secondaryCoefficientAgain = Double.parseDouble(map.get("secondary_coefficient_again").toString());
            double oneCoefficientAgain = Double.parseDouble(map.get("one_coefficient_again").toString());
            double parameterAgain = Double.parseDouble(map.get("parameter_again").toString());
*/
            // 96 个原始数据  h_no23
          /*  for (int i=1;i<=96;i++){
                String s = String.format("%02d", i);
                String key = "v_no" + s;
                Double v = (Double)map.get(key);
               *//* double v1 = secondaryCoefficient * v * v + oneCoefficient * v + parameter;
                if (v1<=40){
                    v1 = secondaryCoefficientAgain * v * v + oneCoefficientAgain * v + parameterAgain;
                }*//*

              //  niheMap.put(key+"nh",v+"");
            }*/
        }
      //  result.add(niheMap);
        return result;
    }


}
