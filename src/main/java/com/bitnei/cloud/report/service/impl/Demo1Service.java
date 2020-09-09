package com.bitnei.cloud.report.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.common.*;
import com.bitnei.cloud.common.DateUtil;
import com.bitnei.cloud.report.domain.Demo1;
import com.bitnei.cloud.report.mapper.Demo1Mapper;
import com.bitnei.cloud.report.service.IDemo1Service;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.PagerModel;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.util.UtilHelper;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


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
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.Demo1Mapper")
public class Demo1Service extends BaseService implements IDemo1Service {

    @Autowired
    protected HttpServletRequest request;

    @Autowired
    private Demo1Mapper demo1Mapper;
    @Override
    public PagerModel pageQuery() {

     /*   Map<String, Object> map = ControlUtil.getParams(request);
        request.getSession().setAttribute("code",map.get("code"));
        PageInfo<Demo1> pageinfo = ControlUtil.getPageinfo(request);
        DataGridOptions options = new DataGridOptions();
        options.setParams(map);*/
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
        Demo1 demo1 = (Demo1) o;
        // demo1.setUpdateTime(DateUtil.getNow());
        // demo1.setUpdateBy(ServletUtil.getCurrentUser());
        return super.update(demo1);
    }

    @Override
    public <T> T findById(String id) {
        Demo1 demo1 = super.findById(id);
        // DataLoader.loadNames(demo1);
        // DataLoader.loadDictNames(demo1);
        return (T) demo1;
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
    public JsonModel saveSubmit(Demo1 demo1) {
        JsonModel jm = new JsonModel();
        String code = demo1.getCode();
        Map<String, String> map = new HashMap<>(16);
        map.put("code", code);
        List<Demo1> findByCode = findBySqlId("findByCode", map);

        // 新增
        if (demo1.getId().equals("-1")) {
            if (null != findByCode && findByCode.size() > 0) {
                jm.setFlag(false);
                jm.setMsg(code + "点样编号已经存在，请重新输入!");
                return jm;
            }
            demo1.setId(UtilHelper.getUUID());
            demo1.setCreateTime(DateUtil.getNow());
            super.insert(demo1);

        } else {
            if (!demo1.getId().equals(findByCode.get(0).getId())) {
                jm.setFlag(false);
                jm.setMsg(code + "点样编号已经存在，请重新输入!");
                return jm;
            }
            // 修改
            demo1.setUpdateTime(DateUtil.getNowTime());
            update(demo1);
        }
        jm.setFlag(true);
        jm.setMsg("保存成功!");
        return jm;
    }

    @Override
    public JsonModel importHoles(String name, String code, MultipartFile file) throws Exception {
        JsonModel jm = new JsonModel();

        Map<String, String> pram = new HashMap<>(16);
        pram.put("code", code);
        List<Demo1> findByCode = findBySqlId("findByCode", pram);
        if (null!=findByCode&&findByCode.size()>0){
            jm.setMsg("点样编号已存在，请确认后导入操作！！");
            jm.setFlag(false);
            return jm;
        }
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
        int number =0;
        Map<String, String> map = new HashMap<>(16);
        //前两行和最后一行不要 默认值
        for (int r = 0; r <= sheet.getLastRowNum() ; r++) {
            Row row = sheet.getRow(r);
            if (row == null) {
                continue;
            }

            for (int k = 0; k < row.getLastCellNum() ; k++) {
                Cell cell0 = row.getCell(k);
                cell0.setCellType(CellType.STRING);
                String number0 = cell0.getStringCellValue().toString();
                int keyNumber = ++number;
                String s = String.format("%02d", keyNumber);
                String key1 = "hno" + s;
                map.put(key1, number0);
            }
        }

        if (map.size() > 0) {
            map.put("id",UtilHelper.getUUID());
            map.put("name",name);
            map.put("code",code);
            map.put("createTime",DateUtil.getNow());
            demo1Mapper.insert(map);
        } else {
            jm.setMsg("孔位数据为空，请确认后导入操作！！");
            jm.setFlag(false);
            return jm;
        }
        jm.setFlag(true);
        return jm;
    }

}
