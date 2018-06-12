package com.bitnei.cloud.common;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
/**
 * 需要引入 包
 * poi-3.8-20120326.jar
 * poi-ooxml-3.8-20120326.jar
 * poi-ooxml-schemas-3.8-20120326.jar
 * xmlbeans-2.3.0.jar
 * dom4j-1.6.1.jar
 * @author mmd
 *
 */
public class MmdXlsx {
	
	
	
	/**
	 * 获取.xlsx文件的数据
	 * 页  列  行
	 * @param file
	 * @return  对象数据
	 */
	public static List<List<List<String>>> getxlsx(InputStream file) throws RuntimeException{
		
		//是否为xlsx文件
		XSSFWorkbook  x=isxlsx(file);
		
		//总页数
		int pageCount = x.getNumberOfSheets();
		
		XSSFSheet sheetAt=null;
		
		List<List<List<String>>> a=new ArrayList<List<List<String>>>();
		
		
		//遍历总页数
		for(int i=0;i<pageCount;i++){
			
			 sheetAt = x.getSheetAt(i);
			
			 if(sheetAt==null)
				 continue;
			 a.add(getXSSFSheet(sheetAt));
			 
		}
		
		return a;
	}
	
	
	
private static List<List<String>> getXSSFSheet(XSSFSheet  xssf)throws RuntimeException{
		
		//总行数
		int rowNum = xssf.getLastRowNum();
	
		//row
		XSSFRow row=null;
		
		
		List<List<String>> rows=new ArrayList<List<String>>();
		
		List<String> cols=null;
		
		XSSFCell cell=null;
		
		//遍历行
		for(int i=0;i<=rowNum;i++){
			
			 row = xssf.getRow(i);
			
			if(row==null){
				rows.add(new ArrayList<String>());
				continue;
			}else{
				//总列
				short col = row.getLastCellNum();
				
				cols=new ArrayList<String>();
				
				for(int z=0;z<col;z++){
					
					 cell = row.getCell(z);
					 
					if(cell==null)
						cols.add(null);
					else
						cols.add(getValue(cell));
				}
				rows.add(cols);
			}
			
		}
		
		
		return rows;
	}
	
	
	
	
	
	
	/**
	 * 判断是否为xlsx文件
	 * @param file
	 * @return
	 * @throws Exception
	 */
	private static XSSFWorkbook isxlsx(InputStream file)throws RuntimeException{
		
		try {
		      return new XSSFWorkbook(file);
		} catch (Exception e) {
		throw new RuntimeException("文件不对  或者不是xlsx");
		}
		
	}
	
	/**
	 * 获取值
	 * @param xssfRow
	 * @return
	 */
	private static String getValue(XSSFCell xssfRow) {
		 
		
        if (xssfRow.getCellType() == xssfRow.CELL_TYPE_BOOLEAN) {
	            return String.valueOf(xssfRow.getBooleanCellValue());
      } else if (xssfRow.getCellType() == xssfRow.CELL_TYPE_NUMERIC) {
       
    	  if(HSSFDateUtil.isCellDateFormatted(xssfRow)){
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				return sdf.format(HSSFDateUtil.getJavaDate(xssfRow.getNumericCellValue())).toString();
			}
    	  	return String.valueOf(xssfRow.getNumericCellValue());
	        } else {
	        	
	        	
	        	return String.valueOf(xssfRow.getStringCellValue());
	       }
    }
	
	
	

	/**
	 * 
	 * @param file
	 * @param data
	 */
	public static byte[] setxlsx(InputStream file,List<List<List<String>>> data) throws Exception{
		
		XSSFWorkbook x = isxlsx(file);
		XSSFSheet sheetAt=null;
		//加载总页数
		for(int i=0;i<data.size();i++){
			
		
		 sheetAt = x.getSheetAt(i);
				
			 if(sheetAt==null)
				 continue;
			setXSSFSheet(sheetAt,data.get(i));
			
			
		}
		
	
		return XssToByte(x);	
		
	}
	
	
	public static byte[] setxlsx(List<List<String>> data) throws Exception{
	
		XSSFWorkbook x=new XSSFWorkbook();
		XSSFSheet sheet=x.createSheet();
		
		for(int i=0;i<data.size();i++){
			
			XSSFRow row = sheet.createRow(i);
			
			for(int j=0;j<data.get(i).size();j++){
				
				row.createCell(j).setCellValue(data.get(i).get(j));
				
			}
			
		}
		
		
		return XssToByte(x);	
	
	
	}



	private static void setXSSFSheet(XSSFSheet sheet,List<List<String>> list) {
		
			
				
			for(int i=0;i<list.size();i++){
				
				XSSFRow row = sheet.createRow(i+2);
				
				for(int j=0;j<list.get(i).size();j++){
					
					row.createCell(j).setCellValue(list.get(i).get(j));
					
				}
				
			}
		
		
	}
	


	
	private static byte[] XssToByte(XSSFWorkbook x) throws Exception {
		
		ByteArrayOutputStream os = new ByteArrayOutputStream();
		
			x.write(os);
		 byte[] b = os.toByteArray();
		
		
		return b;
	}



	

}
