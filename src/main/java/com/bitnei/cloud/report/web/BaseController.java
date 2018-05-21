package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.cloud.common.pojo.ExcelParseConfig;
import com.bitnei.cloud.report.util.ImportExcelUtil;
import org.apache.commons.io.IOUtils;
import org.apache.poi.ss.formula.functions.T;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.lang.reflect.Method;
import java.util.*;

/**
 * @author: fanglidong
 * @date: 2018/3/19
 */
@Controller
@RequestMapping("/base")
@SuppressWarnings("all")
public class BaseController{

    private Logger logger = LoggerFactory.getLogger(BaseController.class.getSimpleName());

    @Autowired
    protected ImportExcelUtil importExcelUtil;

    /**
     * 文件下载 restful
     * @author chenyl
     * @param fileName 文件名  例：/download_temp/test
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @GetMapping("/download_temp/{fileName}")
    @ResponseBody
    public AppBean downExcTemplates(
            @PathVariable(value = "fileName") String fileName,
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        AppBean appBean = downExcFile(String.format("%s.xls",fileName),fileName, request, response);
        return appBean;
    }

    /**
     * 文件下载
     * @author chenyl
     * @param fileName 文件名  例：/download_temp/test
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    protected AppBean downExcFile(String finalName,String fileName, HttpServletRequest request, HttpServletResponse response) {
        AppBean appBean = new AppBean();
        appBean.setCode(1);
        try{
            request.setCharacterEncoding("UTF8");
            response.setCharacterEncoding("UTF8");
            response.setContentType("text/html;charset=UTF-8");
            response.setContentType("application/x-excel");
            InputStream excelResourceInputStream = getDownLoadFile(fileName);
            response.setHeader("Content-Disposition", "attachment; filename=" + finalName);
            response.setHeader("Content-Length", String.valueOf(excelResourceInputStream.available()));
            IOUtils.copy(excelResourceInputStream,response.getOutputStream());
        }catch (Exception e){
            logger.error(e.getMessage());
            appBean.setCode(-1);
            appBean.setMessage(e.getMessage());
        }
        return appBean;
    }

    /**
     * 钩子函数 默认实现 由子类复写
     * @param fileName
     * @return
     * @throws IOException
     */
    protected InputStream getDownLoadFile(String fileName) throws IOException {
        Resource excelResource = new ClassPathResource(String.format("/temp/%s.xls",fileName));
        return excelResource.getInputStream();
    }


    /**
     *
     * @param contractFile
     * @param excelParseConfig
     * @param start
     * @param <T>
     * @return
     * @throws Exception
     */
    public <T> List<T> uploadTemplates(MultipartFile contractFile, ExcelParseConfig<T> excelParseConfig, int start)throws Exception{
        if(contractFile == null){
            throw new FileNotFoundException("文件没有找到");
        }
        //转换的util 可替换实现
        List<List<Object>> excel = importExcelUtil.
                getBankListByExcel(contractFile.getInputStream(),start);
        List<T> result = new ArrayList<>();
        for (List<Object> column : excel){
            //实际需要转换的对象
            T instance = (T) createObject(column, excelParseConfig);
            //额外的处理回调给调用者 例如返回代理对象用于提供额外的功能或者写入数据库
            //@see com.bitnei.cloud.common.pojo.SysCustomerUnitProxy
            instance = (T) excelParseConfig.getOnParseListener().onParse(instance);
            result.add(instance);
        }
        return result;

    }

    /**
     * 根据excel列设置拼接实体
     * @param column
     * @param excelParseConfig
     * @return
     * @throws Exception
     */
    private Object createObject(List<Object> column,ExcelParseConfig excelParseConfig) throws Exception{
        //获取所有setter方法
        List<Method> setters = new ArrayList(excelParseConfig.getSettingMap().values());
        Class<?> aClass = excelParseConfig.getaClass();
        //实际需要转换的实体
        Object instance = aClass.newInstance();
        for(int index = 0;index<column.size();index++){
            Method paramSetMethod = setters.get(index);
            //设置属性
            paramSetMethod.invoke(instance,column.get(index));
        }
        return instance;
    }

    public <T> List<T> uploadTemplates(MultipartFile contractFile,ExcelParseConfig<T> excelParseConfig)throws Exception{
        return uploadTemplates(contractFile,excelParseConfig,3);
    }

}