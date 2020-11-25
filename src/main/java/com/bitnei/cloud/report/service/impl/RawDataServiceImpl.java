package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.common.DateUtil;
import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.common.ServletUtil;
import com.bitnei.cloud.common.StringUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.Demo1;
import com.bitnei.cloud.report.domain.RawData;
import com.bitnei.cloud.report.mapper.RawDataMapper;
import com.bitnei.cloud.report.service.IDemo1Service;
import com.bitnei.cloud.report.service.IRawDataService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import com.bitnei.commons.util.UtilHelper;
import lombok.extern.slf4j.Slf4j;
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

    @Override
    public PagerModel pageQuery() {
        DataGridOptions dataLayOptions = ServletUtil.getDataLayOptions();
        PagerModel pm = findPagerModel("pagerModel", dataLayOptions);
        return pm;
    }

    @Override
    public JsonModel importRawDatas(String name, String code,
                                    String secondaryCoefficient,
                                    String oneCoefficient,
                                    String parameter,
                                    String secondaryCoefficientAgain,
                                    String oneCoefficientAgain,
                                    String parameterAgain,
                                    MultipartFile file) throws IOException {
        JsonModel jm = new JsonModel();
        if (StringUtil.isEmpty(code)) {
            jm.setMsg("点样编号为空，请确认后导入操作！！");
            jm.setFlag(false);
            return jm;
        }else {
            Map<String,String> parm=new HashMap<>(16);
            parm.put("code",code);
            List<Object> pagerModel = demo1Service.findBySqlId("pagerModel", parm);
            if (null==pagerModel||pagerModel.size()==0) {
                jm.setMsg("点样编号不存在，请确认实验阶段后导入操作！！");
                jm.setFlag(false);
                return jm;
            }
            parm.clear();
            parm.put("byCode",code);
            List<Object> pagerModel1 = findBySqlId("pagerModel", parm);
            if (null!=pagerModel1&&pagerModel1.size()>0) {
                jm.setMsg("点样编号重复存在，请确认后导入操作！！");
                jm.setFlag(false);
                return jm;
            }

        }
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
        Map<String, Object> map = new HashMap<>(16);
        for (int r = 0; r <= sheet.getLastRowNum(); r++) {
            Row row = sheet.getRow(r);
            if (row == null) {
                continue;
            }
           /* if (row.getCell(0).getCellType() != 1) {
                // throw new MyException("导入失败(第"+(r+1)+"行,ID单元格格式请设为文本格式)");
            }*/
            for (int k = 0; k < row.getLastCellNum(); k++) {
                Cell cell0 = row.getCell(k);
                cell0.setCellType(CellType.NUMERIC);
                double numericCellValue = cell0.getNumericCellValue();
                int keyNumber = ++number;
                String s = String.format("%02d", keyNumber);
                String key1 = "vno" + s;
                map.put(key1, numericCellValue);
            }
        }

        if (map.size() > 0) {
            map.put("id", UtilHelper.getUUID());
            map.put("code", code);
            map.put("secondaryCoefficient", secondaryCoefficient);
            map.put("oneCoefficient", oneCoefficient);
            map.put("parameter", parameter);

            map.put("secondaryCoefficientAgain", secondaryCoefficientAgain);
            map.put("oneCoefficientAgain", oneCoefficientAgain);
            map.put("parameterAgain", parameterAgain);


            map.put("createTime", DateUtil.getNow());
            rawDataMapper.insert(map);
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
        Map<String,Object> niheMap=new HashMap<>(16);
        if (null!=result&&result.size()>0){
            Map<String, Object> map = result.get(0);
            double secondaryCoefficient = Double.parseDouble(map.get("secondary_coefficient").toString());
            double oneCoefficient = Double.parseDouble(map.get("one_coefficient").toString());
            double parameter = Double.parseDouble(map.get("parameter").toString());
            double secondaryCoefficientAgain = Double.parseDouble(map.get("secondary_coefficient_again").toString());
            double oneCoefficientAgain = Double.parseDouble(map.get("one_coefficient_again").toString());
            double parameterAgain = Double.parseDouble(map.get("parameter_again").toString());

            // 96 个原始数据
            for (int i=1;i<=96;i++){
                String s = String.format("%02d", i);
                String key = "v_no" + s;
                Double v = (Double)map.get(key);
                //double v = Double.parseDouble(map.get(key));
                double v1 = secondaryCoefficient * v * v + oneCoefficient * v + parameter;
                if (v1<=40){
                    v1 = secondaryCoefficientAgain * v * v + oneCoefficientAgain * v + parameterAgain;
                }
                niheMap.put(key+"nh",v1+"");
            }
        }
        result.add(niheMap);
        return result;
    }


}
