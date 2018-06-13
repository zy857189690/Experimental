package com.bitnei.cloud.common;

import com.bitnei.cloud.common.util.DateUtil;
import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.RequestContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 *
 * @author Xiao Jin Lu
 * @ClassName: ExcelUtil
 * @Description: TODO(export excel)
 * @date 2018-06-06
 */
public class ExcelUtil {

    public static final int DATA_TYPE_STRING = 1;
    public static final int DATA_TYPE_INTEGER = 2;
    public static final int DATA_TYPE_DOUBLE = 3;
    public static final int DATA_TYPE_DATE = 4;
    /**
     * 转换为字符串的日期类型,格式为"yyyy/MM/dd" 比如:2007/01/12
     */
    public static final int DATA_TYPE_DATE_STR = 5;

    /**
     * 空值
     */
    public static final int DATA_TYPE_NULL = 6;



    public static DateFormat df = new SimpleDateFormat("yyyyMMddHHmm");

    /**
     * 验证上传文件的表头是否符合规范
     *
     * @param excelDoc   上传的文件
     * @param fileName   文件名
     * @param titleArray 匹配的表头
     * @return 如果匹配返回true，否者返回false
     * @throws Exception
     */
    public static boolean validateExcelTitle(File excelDoc, String fileName,
                                             String[] titleArray) throws Exception {
        String extend = fileName.substring(fileName.lastIndexOf("."));
        InputStream is = new FileInputStream(excelDoc);
        if (".xls".equals(extend)) {
            // excel 2003
            HSSFWorkbook workbook = new HSSFWorkbook(is); // 创建对Excel工作簿文件的引用
            HSSFSheet aSheet = workbook.getSheetAt(0);
            HSSFRow aRow = aSheet.getRow(0);
            for (short i = 0; i < titleArray.length; i++) {
                if (!titleArray[i].equals(getCellValue(aRow.getCell(i),
                        DATA_TYPE_STRING))) {
                    return false;
                }
            }
        } else if (".xlsx".equals(extend)) {
            // excel 2007
            XSSFWorkbook workbook = new XSSFWorkbook(is); // 创建对Excel工作簿文件的引用
            XSSFSheet aSheet = workbook.getSheetAt(0);
            XSSFRow aRow = aSheet.getRow(0);
            for (short i = 0; i < titleArray.length; i++) {
                if (!titleArray[i].equals(getCellValue(aRow.getCell(i),
                        DATA_TYPE_STRING))) {
                    return false;
                }
            }
        } else {
            throw new Exception("excel格式不正确");
        }
        return true;
    }

    /**
     * 解析exel文件：支持excel2003及2007
     *
     * @param excelDoc excel文件
     * @param fileName 文件名称
     * @param DataType 获取数组的数据类型
     * @return
     * @throws Exception
     */
    public static List<Object[]> ParseExcel(File excelDoc, String fileName,
                                            int[] DataType) throws Exception {
        String extend = fileName.substring(fileName.lastIndexOf("."));
        List<Object[]> objList = new ArrayList<Object[]>();
        InputStream is = new FileInputStream(excelDoc);
        if (".xls".equals(extend)) {
            // excel 2003
            HSSFWorkbook workbook = new HSSFWorkbook(is); // 创建对Excel工作簿文件的引用
            for (int numSheets = 0; numSheets < workbook.getNumberOfSheets(); numSheets++) {
                if (null != workbook.getSheetAt(numSheets)) {
                    HSSFSheet aSheet = workbook.getSheetAt(numSheets); // 获得一个sheet
                    for (int rowNumOfSheet = 0; rowNumOfSheet <= aSheet
                            .getLastRowNum(); rowNumOfSheet++) {
                        if (null != aSheet.getRow(rowNumOfSheet)) {
                            HSSFRow aRow = aSheet.getRow(rowNumOfSheet);
                            Object[] objRow = new Object[DataType.length];
                            for (short i = 0; i < objRow.length; i++) {
                                HSSFCell cell = aRow.getCell(i);
                                Object cellValue = null;
                                try {
                                    cellValue = getCellValue(cell, DataType[i]);
                                } catch (Exception e) {
                                }
                                objRow[i] = cellValue;
                            }
                            objList.add(objRow);
                        }
                    }
                }
            }
        } else if (".xlsx".equals(extend)) {
            // excel 2007
            XSSFWorkbook workbook = new XSSFWorkbook(is); // 创建对Excel工作簿文件的引用
            for (int numSheets = 0; numSheets < workbook.getNumberOfSheets(); numSheets++) {
                if (null != workbook.getSheetAt(numSheets)) {
                    XSSFSheet aSheet = workbook.getSheetAt(numSheets); // 获得一个sheet
                    for (int rowNumOfSheet = 0; rowNumOfSheet <= aSheet
                            .getLastRowNum(); rowNumOfSheet++) {
                        if (null != aSheet.getRow(rowNumOfSheet)) {
                            XSSFRow aRow = aSheet.getRow(rowNumOfSheet);
                            Object[] objRow = new Object[DataType.length];
                            for (short i = 0; i < objRow.length; i++) {
                                XSSFCell cell = aRow.getCell(i);
                                Object cellValue = null;
                                try {
                                    cellValue = getCellValue(cell, DataType[i]);
                                } catch (Exception e) {
                                }
                                objRow[i] = cellValue;
                            }
                            objList.add(objRow);
                        }
                    }
                }
            }
        } else {
            throw new Exception("excel格式不正确");
        }
        return objList;
    }


    /**
     * 中机车型管理读取导入Excel
     *
     * @param excelDoc excel文件
     * @param fileName 文件名称
     * @return
     * @throws Exception
     */
    public static List<Object[]>[] readExcel(File excelDoc, String fileName) throws Exception {
        String extend = fileName.substring(fileName.lastIndexOf("."));
        InputStream is = new FileInputStream(excelDoc);
        if (".xls".equals(extend)) {
            // excel 2003
            HSSFWorkbook workbook = new HSSFWorkbook(is); // 创建对Excel工作簿文件的引用
            //==========基本信息sheet页
            Sheet sheet1 = workbook.getSheetAt(1);
            int totalRow = sheet1.getPhysicalNumberOfRows();//获取sheet页总行数
            int totalColumn = sheet1.getRow(1).getPhysicalNumberOfCells();//获取sheet页总列数
            List<Object[]> objList1 = new ArrayList<Object[]>();
            for(int i = 2; i < totalRow; i ++){
                Row row = sheet1.getRow(i);
//                int cellsNum = row.getLastCellNum();
//                Object[] objRow = new Object[cellsNum];//基本信息sheet中的每行数据
                Object[] objRow = new Object[totalColumn];//基本信息sheet中的每行数据
                for(int j = 0; j < totalColumn; j ++) {
                    objRow[j] = row.getCell(j);
                }
                objList1.add(objRow);
            }
            //==========电池信息sheet页
            Sheet sheet2 = workbook.getSheetAt(2);
            int totalRow2 = sheet2.getPhysicalNumberOfRows();//获取sheet页总行数
            int totalColumn2 = sheet2.getRow(0).getPhysicalNumberOfCells();//获取sheet页总列数
            List<Object[]> objList2 = new ArrayList<Object[]>();
            for(int i = 1; i < totalRow2; i ++){
                Row row = sheet2.getRow(i);
//                int cellsNum = row.getLastCellNum();
//                Object[] objRow = new Object[cellsNum];//基本信息sheet中的每行数据
                Object[] objRow = new Object[totalColumn2];//基本信息sheet中的每行数据
                for(int j = 0; j < totalColumn2; j ++) {
                    objRow[j] = row.getCell(j);
                }
                objList2.add(objRow);
            }
            //==========电机信息sheet页
            Sheet sheet3 = workbook.getSheetAt(3);
            int totalRow3 = sheet3.getPhysicalNumberOfRows();//获取sheet页总行数
            int totalColumn3 = sheet3.getRow(0).getPhysicalNumberOfCells();//获取sheet页总列数
            List<Object[]> objList3 = new ArrayList<Object[]>();
            for(int i = 1; i < totalRow3; i ++){
                Row row = sheet3.getRow(i);
//                int cellsNum = row.getLastCellNum();
//                Object[] objRow = new Object[cellsNum];//基本信息sheet中的每行数据
                Object[] objRow = new Object[totalColumn3];//基本信息sheet中的每行数据
                for(int j = 0; j < totalColumn3; j ++) {
                    objRow[j] = row.getCell(j);
//                    System.out.println(objRow[j]);
                }
                objList3.add(objRow);
            }
            List<Object[]>[] listArr = new List[3];

            listArr[0] = objList1;
            listArr[1] = objList2;
            listArr[2] = objList3;

            return listArr;
        }
        return null;
    }

    /**
     * 获取excel单元格数据 2007版
     *
     * @param cell
     * @param dataType
     * @return
     * @throws ParseException
     */
    public static Object getCellValue(XSSFCell cell, int dataType)
            throws ParseException {

        Object obj = null;
        if (cell != null) {
            if (dataType == ExcelUtil.DATA_TYPE_STRING) {
                // String类型
                if (cell.getCellType() == XSSFCell.CELL_TYPE_STRING) {
                    obj = cell.getRichStringCellValue().getString();
                } else if (cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
                    obj = NumberUtil.format8Num(cell.getNumericCellValue());
                }
            } else if (dataType == ExcelUtil.DATA_TYPE_INTEGER) {
                // Integer类型
                if (cell.getCellType() == XSSFCell.CELL_TYPE_STRING) {
                    obj = Integer.parseInt(cell.getRichStringCellValue()
                            .getString());
                } else if (cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
                    obj = (int) cell.getNumericCellValue();
                }
            } else if (dataType == ExcelUtil.DATA_TYPE_DOUBLE) {
                // Double类型
                if (cell.getCellType() == XSSFCell.CELL_TYPE_STRING) {
                    obj = Double.parseDouble(cell.getRichStringCellValue()
                            .getString());
                } else if (cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
                    obj = cell.getNumericCellValue();
                }
            } else if (dataType == ExcelUtil.DATA_TYPE_DATE) {
                // date类型
                if (cell.getCellType() == XSSFCell.CELL_TYPE_STRING) {
                    obj = df.parse(cell.getRichStringCellValue().getString());
                } else if (cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
                    obj = cell.getDateCellValue();
                }
            } else if (dataType == ExcelUtil.DATA_TYPE_DATE_STR) {
                // str date类型
                if (cell.getCellType() == XSSFCell.CELL_TYPE_STRING) {
                    obj = cell.getRichStringCellValue().getString();
                } else if (cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
                    obj = df.format(cell.getDateCellValue());
                }
            } else if (dataType == ExcelUtil.DATA_TYPE_NULL) {
                obj = null;
            }
        }

        return obj;
    }

    /**
     * 获取cell单元格数据2003
     *
     * @param cell
     * @param dataType
     * @return
     * @throws ParseException
     */
    public static Object getCellValue(HSSFCell cell, int dataType)
            throws ParseException {
        Object obj = null;
        if (cell != null) {
            if (dataType == ExcelUtil.DATA_TYPE_STRING) {
                // String类型
                if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {
                    obj = cell.getRichStringCellValue().getString();
                } else if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                    obj = NumberUtil.format8Num(cell.getNumericCellValue());
                }
            } else if (dataType == ExcelUtil.DATA_TYPE_INTEGER) {
                // Integer类型
                if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {
                    obj = Integer.parseInt(cell.getRichStringCellValue()
                            .getString());
                } else if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                    obj = (int) cell.getNumericCellValue();
                }
            } else if (dataType == ExcelUtil.DATA_TYPE_DOUBLE) {
                // Double类型
                if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {
                    obj = Double.parseDouble(cell.getRichStringCellValue()
                            .getString());
                } else if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                    obj = cell.getNumericCellValue();
                }
            } else if (dataType == ExcelUtil.DATA_TYPE_DATE) {
                // date类型
                if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {
                    obj = df.parse(cell.getRichStringCellValue().getString());
                } else if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                    obj = cell.getDateCellValue();
                }
            } else if (dataType == ExcelUtil.DATA_TYPE_DATE_STR) {
                // str date类型
                if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {
                    obj = cell.getRichStringCellValue().getString();
                } else if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                    obj = df.format(cell.getDateCellValue());
                }
            } else if (dataType == ExcelUtil.DATA_TYPE_NULL) {
                obj = null;
            }
        }

        return obj;
    }

    public static String getCellString(XSSFCell cell) {
        String strValue = null;
        if (cell == null) {
            return strValue;
        }
        try {
            if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {
                strValue = cell.getRichStringCellValue().getString();
            } else if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                strValue = String.valueOf(cell.getNumericCellValue());
            }
        } catch (Exception e) {
        }
        return strValue;
    }

    public static double getCellDouble(XSSFCell cell) {
        double doubleValue = 0;
        if (cell == null) {
            return doubleValue;
        }
        try {
            if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {
                doubleValue = Double.parseDouble(cell.getRichStringCellValue()
                        .getString());
            } else if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                doubleValue = cell.getNumericCellValue();
            }
        } catch (Exception e) {
        }
        return doubleValue;
    }

    public static int getCellInt(XSSFCell cell) {
        int intValue = 0;
        if (cell == null) {
            return intValue;
        }
        try {
            if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {
                intValue = Integer.parseInt(cell.getRichStringCellValue()
                        .getString());
            } else if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                intValue = (int) cell.getNumericCellValue();
            }
        } catch (Exception e) {
        }
        return intValue;
    }

    public static String getCellString(HSSFCell cell) {
        String strValue = null;
        if (cell == null) {
            return strValue;
        }
        try {
            if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {
                strValue = cell.getRichStringCellValue().getString();
            } else if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                strValue = String.valueOf(cell.getNumericCellValue());
            }
        } catch (Exception e) {
        }
        return strValue;
    }

    public static double getCellDouble(HSSFCell cell) {
        double doubleValue = 0;
        if (cell == null) {
            return doubleValue;
        }
        try {
            if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {
                doubleValue = Double.parseDouble(cell.getRichStringCellValue()
                        .getString());
            } else if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                doubleValue = cell.getNumericCellValue();
            }
        } catch (Exception e) {
        }
        return doubleValue;
    }

    public static int getCellInt(HSSFCell cell) {
        int intValue = 0;
        if (cell == null) {
            return intValue;
        }
        try {
            if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {
                intValue = Integer.parseInt(cell.getRichStringCellValue()
                        .getString());
            } else if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                intValue = (int) cell.getNumericCellValue();
            }
        } catch (Exception e) {
        }
        return intValue;
    }

    /**
     * 通过map传递要导出的值
     *
     * @param list
     * @param name
     * @param titles
     * @param colums
     * @return
     * @throws IOException
     */
    public static InputStream exportExcel(List<Map> list, String name,
                                          String[] titles, String[] colums) throws IOException {
        InputStream is = null;
        HSSFWorkbook wb = null;
        HSSFSheet sheet = null;
        HSSFRow row = null;
        HSSFCell cell = null;
        Map map = null;
        String value = "";
        if (titles == null || colums == null) {
            return null;
        }
        wb = new HSSFWorkbook();
        sheet = wb.createSheet(name);
        for (int i = 0; i < list.size() + 1; i++) {
            if (i == 0) {
                row = sheet.createRow(0);
                for (int j = 0; j < titles.length; j++) {
                    cell = row.createCell((short) j);
                    cell.setCellValue(titles[j]);
                }
            } else {
                row = sheet.createRow(i);
                map = list.get(i - 1);
                for (int j = 0; j < colums.length; j++) {
                    cell = row.createCell((short) j);
                    if (map.get(colums[j]) == null) {
                        value = null;
                    } else {
                        value = map.get(colums[j]).toString();
                    }
                    cell.setCellValue(value);
                }
            }
        }
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        wb.write(baos);
        is = new ByteArrayInputStream(baos.toByteArray());
        baos.close();
        return is;
    }

    /**
     * 生成多sheet页excel，每页默认50000条
     *
     * @param list
     * @param name
     * @param titles
     * @param colums
     * @param pageNum 每页条数
     * @return
     * @throws IOException
     */
    public static InputStream exportExcelSheets(List<Map<String, Object>> list, String name,
                                                String[] titles, String[] colums, Integer pageNum) throws IOException {
        InputStream is = null;
        HSSFWorkbook wb = null;
        HSSFSheet sheet = null;
        HSSFRow row = null;
        HSSFCell cell = null;
        Map<String, Object> map = null;
        String value = "";
        if (null == list || list.size() == 0 || titles == null || colums == null) {
            return null;
        }
        if (null == pageNum) {
            pageNum = 50000;
        }
        System.out.println("================开始写入：" + DateUtil.getNow() + "================");
        int sheetNum = (int) Math.ceil(Double.valueOf(list.size()) / 50000);
        wb = new HSSFWorkbook();
        HSSFCellStyle cellStyle = wb.createCellStyle();// 创建单元格样式
        cellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);// 指定单元格居中对齐
        cellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
        HSSFFont font = wb.createFont();// 设置单元格字体
        font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
        font.setFontName("宋体");
        font.setFontHeight((short) 200);
        cellStyle.setFont(font);
        for (int i = 0; i < sheetNum; i++) {
            sheet = wb.createSheet(name + (i + 1));
            row = sheet.createRow(0);
            for (int j = 0; j < titles.length; j++) {
                sheet.setColumnWidth(j, 4000);
                cell = row.createCell((short) j);
                cell.setCellStyle(cellStyle);
                cell.setCellValue(titles[j]);
            }
            int h = 1;
            for (int k = pageNum * i; k < (pageNum * (i + 1)); k++) {
                if (k >= list.size()) {
                    break;
                }
                row = sheet.createRow(h);
                map = list.get(k);
                for (int j = 0; j < colums.length; j++) {
                    cell = row.createCell((short) j);
                    if (map.get(colums[j]) == null) {
                        value = "";
                    } else if (colums[j].equals("isSubsidy")) {
                        String isSubsidy = map.get(colums[j]).toString();
                        if (isSubsidy.equals("Y")) {
                            value = "已发放";
                        } else if (isSubsidy.equals("N")) {
                            value = "未发放";
                        } else {
                            value = "";
                        }
                    } else if (colums[j].equals("isAduitPass")) {//接入审核
                        String isAduitPass = map.get(colums[j]).toString();
                        if (isAduitPass.equals("Y")) {
                            value = "审核通过";
                        } else if (isAduitPass.equals("N")) {
                            value = "未经过审核";
                        } else {
                            value = "";
                        }
                    } else if (colums[j].equals("checkStatus")) {//稽查状态
                        String checkStatus = map.get(colums[j]).toString();
                        if (checkStatus.equals("0")) {
                            value = "正常";
                        } else if (checkStatus.equals("1")) {
                            value = "动态数据核验";
                        } else if (checkStatus.equals("2")) {
                            value = "里程核查";
                        } else if (checkStatus.equals("3")) {
                            value = "恶意空驶";
                        } else if (checkStatus.equals("4")) {
                            value = "闲置";
                        } else if (checkStatus.equals("5")) {
                            value = "报废";
                        } else if (checkStatus.equals("6")) {
                            value = "一车多终端";
                        } else {
                            value = "";
                        }
                    } else {
                        value = map.get(colums[j]).toString();
                    }
                    cell.setCellValue(value);
                }
                h++;
            }
        }
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        wb.write(baos);
        is = new ByteArrayInputStream(baos.toByteArray());
        baos.close();
        System.out.println("================写入结束：" + DateUtil.getNow() + "================");
        return is;
    }

    /**
     * 下载 模板
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public static void downloadModel(HttpServletRequest request, HttpServletResponse response,String base, String templateQuery) throws Exception {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF8");
        String dir = File.separator + request.getParameter("moduleName") + File.separator;    //设定文件保存的目录
        File dfile = null;
        String paramFile = request.getParameter("fileName");
        paramFile = new String(paramFile.getBytes("ISO-8859-1"), "utf8");
        String[] fileNames = paramFile.split(";");
        for (String fileName : fileNames) {
            BufferedInputStream in = null;
            BufferedOutputStream out = null;
            try {
                String srcBase = RequestContext.class.getResource(File.separator +"templates"+File.separator+"templateFile" + File.separator ).getFile();
                File f = new File( srcBase+templateQuery);
                dfile = f;
                response.setContentType("application/x-excel");
                response.setCharacterEncoding("UTF8");
                response.setHeader("Content-Disposition", "attachment; filename=" + new String(fileName.getBytes("utf8"), "ISO-8859-1"));
                response.setHeader("Content-Length", String.valueOf(f.length()));
                in = new BufferedInputStream(new FileInputStream(f));
                out = new BufferedOutputStream(response.getOutputStream());
                byte[] data = new byte[1024];
                int len = 0;
                while (-1 != (len = in.read(data, 0, data.length))) {
                    out.write(data, 0, len);
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (in != null) {
                    in.close();
                }
                if (out != null) {
                    out.close();
                }
            }
        }
    }
    /**
     * 下载 模板
     *下载
     * @param request
     * @param response
     * @throws Exception
     */
    public static void download(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF8");
        String dir = File.separator + "tmp" + File.separator + request.getParameter("moduleName") + File.separator;    //设定文件保存的目录
        boolean b = true; // 是否删除文件
        File dfile = null;
        String paramFile = request.getParameter("fileName");
        paramFile = new String(paramFile.getBytes("ISO-8859-1"), "utf8");
        String[] fileNames = paramFile.split(";");
        for (String fileName : fileNames) {
            if (!(fileName.endsWith(".zip") || fileName.endsWith(".ZIP")))
                fileName = fileName + ".xls";
            if (fileName.contains("~")) {
                String[] split = fileName.split("~");
                if (split.length == 2) {
                    fileName = split[0] + "\\" + split[1];
                    b = false;
                }
            }
            BufferedInputStream in = null;
            BufferedOutputStream out = null;
            try {
                String srcBase = RequestContext.class.getResource("/templates/").getFile();
                File f = new File(srcBase + File.separator + dir + fileName);
                dfile = f;
                response.setContentType("application/x-excel");
                response.setCharacterEncoding("UTF8");
                response.setHeader("Content-Disposition", "attachment; filename=" + new String(fileName.getBytes("utf8"), "ISO-8859-1"));
                response.setHeader("Content-Length", String.valueOf(f.length()));
                in = new BufferedInputStream(new FileInputStream(f));
                out = new BufferedOutputStream(response.getOutputStream());
                byte[] data = new byte[1024];
                int len = 0;
                while (-1 != (len = in.read(data, 0, data.length))) {
                    out.write(data, 0, len);
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (in != null) {
                    in.close();
                }
                if (out != null) {
                    out.close();
                }
                if (b && null != dfile) {
                    dfile.delete();
                }
            }
        }
    }

    /**
     * downFile
     *
     * @param request
     * @param response
     * @param fis
     * @param excelName
     * @return void
     * @throws IOException
     * @throws
     */
    public static void downFile(HttpServletRequest request, HttpServletResponse response, InputStream fis, String excelName) throws IOException {
        String fileName = excelName + df.format(new Date()) + ".xls";
        response.setContentType(getContentType(fileName));
        // 清空response
        response.reset();
        // 设置response的Header
        //response.addHeader("Content-Disposition", "attachment;filename="+new String(fileName.getBytes("utf-8"),"iso-8859-1"));  //转码之后下载的文件不会出现中文乱码
        response.addHeader("Content-Disposition", "attachment;filename=\"" + encodeFilename(request, fileName) + "\"");
        //以流的形式下载文件
//	     InputStream fis = new BufferedInputStream(new FileInputStream(nowPath)); 
        byte[] buffer = {};
        if (fis != null) {
            buffer = new byte[fis.available()];
            fis.read(buffer);
            fis.close();
        }
        OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
        toClient.write(buffer);
        toClient.flush();
        toClient.close();
    }

    //浏览器兼容
    public static String encodeFilename(HttpServletRequest request, String fileName) throws UnsupportedEncodingException {
        String agent = request.getHeader("USER-AGENT");
        try {
            // IE
            if (null != agent && -1 != agent.indexOf("MSIE")) {
                fileName = URLEncoder.encode(fileName, "UTF-8");
                // Firefox
            } else if (null != agent && -1 != agent.indexOf("Mozilla") && agent.contains("Firefox")) {
                fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
            } else if (null != agent && -1 != agent.indexOf("Mozilla") && !agent.contains("Firefox")) {
                fileName = URLEncoder.encode(fileName, "UTF-8");
            }
        } catch (UnsupportedEncodingException e) {
            try {
                fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
            } catch (UnsupportedEncodingException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
        }
        return fileName;
    }

    //设置下载文件类型
    private static String getContentType(String fileName) {
        String ext = fileName.substring(fileName.indexOf(".")).toLowerCase();
        if (ext.equals(".zip")) {
            return "application/zip";
        } else if (ext.equals(".xls") || ext.equals(".xlsx")) {
            return "application/x-excel";
        } else if (ext.equals(".doc") || ext.equals(".docx")) {
            return "application/msword";
        } else if (ext.equals(".pdf")) {
            return "application/pdf";
        } else if (ext.equals(".jpg") || ext.equals(".jpeg")) {
            return "image/jpeg";
        } else if (ext.equals(".gif")) {
            return "image/gif";
        } else if (ext.equals(".png")) {
            return "image/png";
        } else if (ext.equals(".bmp")) {
            return "image/bmp";
        }
        return "application/force-download";
    }

/**
 * 获取文件路径
 *
 *
 */

    public static String saveFile(MultipartFile file, String cls) {
        if (file == null || file.isEmpty() || file.getSize() == 0) {
            return null;
        }
        String date = DateUtil.formatTime(new Date(), DateUtil.DATA_FORMAT) + "_" + new Random().nextInt(1000);
        String dic = "veh-upload/" + cls + "/" + date;
        String dir = "D:/" + dic;
        String fileName = file.getOriginalFilename().replace("-", "_").replace(" ", "");
        try {
            FileUtils.writeByteArrayToFile(new File(dir, fileName), file.getBytes());
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
        return dir + "/" + fileName;
    }
/**
 *
 * 获取车辆Excel信息
 */
    public static List<Map> getVehicleInformation(MultipartFile mf) throws Exception {
        String path = saveFile(mf, "default");
        String fileName = mf.getOriginalFilename();
        //数组
        int[] titleArray = {1, 1};
        File flie = new File(path);
        List<Map> lisVin = new ArrayList<Map>();
        //读取Ex查询结果
        List<Object[]> list = ParseExcel(flie, fileName, titleArray);
        for (int i = 1; i < list.size(); i++) {
            Object[] objects = list.get(i);
            Map map = new HashedMap();
            if (objects[1] != null && objects[0] != null) {
                map.put("lic", objects[1].toString());
                map.put("vin", objects[0].toString());
            } else if (objects[0] != null) {
                if (StringUtil.isChinese(objects[0].toString())) {
                    map.put("lic", objects[1].toString());
                    map.put("vin", objects[0] == null ? null : objects[0].toString());
                } else {
                    map.put("lic", objects[1] == null ? null : objects[1].toString());
                    map.put("vin", objects[0].toString());
                }
            } else if (objects[1] != null) {
                if (StringUtil.isChinese(objects[1].toString())) {
                    map.put("lic", objects[1].toString());
                    map.put("vin", objects[0] == null ? null : objects[0].toString());
                } else {
                    map.put("lic", objects[1] == null ? null : objects[1].toString());
                    map.put("vin", objects[0] == null ? null : objects[0].toString());
                }
            }
            if (map.size() != 0) {
                lisVin.add(map);
            }
        }
        return lisVin;
    }


//	  public static void main(String[] args) throws IOException {
//
//	        try {
//	            HSSFWorkbook wb = new HSSFWorkbook();
//	            HSSFSheet sheet = wb.createSheet("测试");
//	            HSSFCellStyle style = wb.createCellStyle(); // 样式对象
//
//	            style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 垂直
//	            style.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 水平
//	            HSSFRow row = sheet.createRow((short) 0);
//	            HSSFRow row2 = sheet.createRow((short) 1);
//
//	            sheet.addMergedRegion(new Region(0, (short) 0, 1, (short) 0));
//	            HSSFCell ce = row.createCell((short) 0);
//	            ce.setCellValue("分户名称"); // 表格的第一行第一列显示的数据
//	            ce.setCellStyle(style); // 样式，居中
//	            sheet.addMergedRegion(new Region(0, (short) 1, 1, (short) 1));
//	            HSSFCell cc = row.createCell((short) 1);
//	            cc.setCellValue("仪表名称"); // 表格的第一行第一列显示的数据
//	            cc.setCellStyle(style); // 样式，居中
//	            sheet.addMergedRegion(new Region(0, (short) 2, 0, (short) 5));
//	            HSSFCell ca = row.createCell((short) 2);
//	            ca.setCellValue("起止表底数（kWh）"); // 表格的第一行第一列显示的数据
//	            ca.setCellStyle(style); // 样式，居中
//	            HSSFCell cellq = row2.createCell((short) 2);
//                HSSFCell cella = row2.createCell((short) 3);
//                HSSFCell cellz = row2.createCell((short) 4);
//                HSSFCell cellx = row2.createCell((short) 5);
//                cellq.setCellValue("起始时间");
//                cellq.setCellStyle(style);
//                cella.setCellValue("起始表数");
//                cella.setCellStyle(style);
//                cellz.setCellValue("截止时间");
//                cellz.setCellStyle(style);
//                cellx.setCellValue("截止表数");
//                cellx.setCellStyle(style);
//                sheet.addMergedRegion(new Region(0, (short) 6, 0, (short) 7));
//	            HSSFCell cq = row.createCell((short) 6);
//	            cq.setCellValue("本时段电能统计"); // 表格的第一行第一列显示的数据
//	            cq.setCellStyle(style); // 样式，居中
//	            HSSFCell cell1 = row2.createCell((short) 6);
//                HSSFCell cell2 = row2.createCell((short) 7);
//                cell1.setCellValue("电能（kWh）");
//                cell1.setCellStyle(style);
//                cell2.setCellValue("电费（元）");
//                cell2.setCellStyle(style);
//               /* sheet.addMergedRegion(new Region(0, (short) 8, 1, (short) 8));
//	            HSSFCell co = row.createCell((short) 8);
//	            co.setCellValue("明细查询"); // 表格的第一行第一列显示的数据
//	            co.setCellStyle(style); // 样式，居中
//	            */
//	            for (int i = 0; i < 3; i++) {
//	            	int num=0;
//	            	if (i==0) {
//						num=0;
//					}else{
//						num=2+3*i;
//					}
//	            	for (int j = 0; j < 3; j++) {
//	            		HSSFRow rowlist =null;
//	            		if (num==0) {
//	            			 rowlist = sheet.createRow((short) (num+2+j));
//						}else{
//							 rowlist = sheet.createRow((short) (num+j));
//						}
//		 	            HSSFCell celsiy = rowlist.createCell((short) 0);
//		 	            celsiy.setCellValue("用户测试"+i); // 表格的第一行第一列显示的数据
//		 	            celsiy.setCellStyle(style); // 样式，居中
//	            		HSSFCell celli = rowlist.createCell((short) 1);
//	            		celli.setCellValue("仪表"+j);
//	            		celli.setCellStyle(style);
//	            		HSSFCell cell = rowlist.createCell((short) 2);
//	                    cell.setCellValue("120121");
//	                    cell.setCellStyle(style);
//	                    HSSFCell cellsss = rowlist.createCell((short) 3);
//	                    cellsss.setCellValue("120121");
//	                    cellsss.setCellStyle(style);
//	                    HSSFCell cellss2s = rowlist.createCell((short) 4);
//	                    cellss2s.setCellValue("21");
//	                    cellss2s.setCellStyle(style);
//	                    HSSFCell cellss2s1 = rowlist.createCell((short) 5);
//	                    cellss2s1.setCellValue("12313231");
//	                    cellss2s1.setCellStyle(style);
//	                    HSSFCell cells1 = rowlist.createCell((short) 6);
//	                    cells1.setCellValue("188");
//	                    cells1.setCellStyle(style);
//		 	            HSSFCell celsiyw = rowlist.createCell((short) 7);
//		 	            celsiyw.setCellValue("8287"); // 表格的第一行第一列显示的数据
//		 	            celsiyw.setCellStyle(style); // 样式，居中
//		 	           /* HSSFCell celsi = rowlist.createCell((short) 8);
//		 	            celsi.setCellValue("明细查询"); // 表格的第一行第一列显示的数据
//		 	           	celsi.setCellStyle(style); // 样式，居中
//*/					}
//
//	            	if (i==0) {
//	            		sheet.addMergedRegion(new Region((short) (num+2), (short) 0, (short) (num+2+2),(short) 0));
//	            		sheet.addMergedRegion(new Region((short) (num+2), (short) 7, (short) (num+2+2),(short) 7));
//	            		//sheet.addMergedRegion(new Region((short) (num+2), (short) 8, (short) (num+2+2),(short) 8));
//					}else{
//						sheet.addMergedRegion(new Region((short) (num), (short) 0, (short) (num+2),(short) 0));
//						sheet.addMergedRegion(new Region((short) (num), (short) 7, (short) (num+2),(short) 7));
//						//sheet.addMergedRegion(new Region((short) (num), (short) 8, (short) (num+2),(short) 8));
//					}
//				}
//	            FileOutputStream fileOut = new FileOutputStream("D://workbook.xls");
//	            wb.write(fileOut);
//	            fileOut.close();
//	            System.out.print("OK");
//	        } catch (Exception ex) {
//	            ex.printStackTrace();
//	        }
//
//	    }


}
