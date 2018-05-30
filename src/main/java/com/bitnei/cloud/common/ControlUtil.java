package com.bitnei.cloud.common;

import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.nio.charset.Charset;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

public class ControlUtil {

    public static <T>PageInfo<T> getPageinfo(HttpServletRequest request){
        String page = request.getParameter("page");
        String pagesize = request.getParameter("rows");
        String sort = request.getParameter("sort");
        String order = request.getParameter("order");
        int p = 0;
        int pz = 0;
        if(!StringUtils.isEmpty(page)) p = Integer.parseInt(page); else p = 1;
        if(!StringUtils.isEmpty(pagesize)) pz = Integer.parseInt(pagesize);

        PageInfo pageinfo = new PageInfo();
        pageinfo.setPage(p);
        pageinfo.setPagesize(pz);

        if(!StringUtils.isEmpty(order))
            pageinfo.setOrder(order);
        if(!StringUtils.isEmpty(sort))
            pageinfo.setSort(sort);

        return pageinfo;
    }

    public static Map<String,Object> getParams(HttpServletRequest request){

        return getParams(request, new HashMap<String,Object>());
    }
    public static Map<String,Object> getParams(HttpServletRequest request,Map<String,Object> map){
        Enumeration enu=request.getParameterNames();
        while(enu.hasMoreElements()){
            String paraName=(String)enu.nextElement();
            if("order".equals(paraName)){
                Object value = request.getParameter(paraName);
                map.put("order", value);
            }
            if("sort".equals(paraName)){
                Object value = request.getParameter(paraName);
                map.put("orderBy", value);
            }
            if(paraName.indexOf("query.") >= 0){
                String param = paraName.substring(paraName.indexOf(".") + 1);
                Object value = request.getParameter(paraName).replaceAll("%","\\\\%").replaceAll("_","\\\\_");
                param = param.replace("#", "");

                if(null != value && !StringUtils.isEmpty(value.toString()) && !sqlValidate((String)value)){
                    map.put(param, value);
                }
            }
        }
        return map;
    }

    //效验SQL关键字
    protected static boolean sqlValidate(String str) {
        str = str.toLowerCase();//统一转为小写
        //设定过滤掉的sql关键字，在每个关键字后面加个空格,可以避免单词中的某些字符正好匹配关键字，被清空的错误判断
        String badStr = "and |or |exec |execute |insert |select |delete |truncate |update |alter |drop ";
        String[] badStrs = badStr.split("\\|");
        for (int i = 0; i < badStrs.length; i++) {
            if (str.indexOf(badStrs[i]) >= 0) {
                return true;
            }
        }
        return false;
    }

    public static Map<String,Object> getParamsConvertCode(HttpServletRequest request,Map<String,Object> map){
        Enumeration enu=request.getParameterNames();
        while(enu.hasMoreElements()){
            String paraName=(String)enu.nextElement();
            if("order".equals(paraName)){
                Object value = request.getParameter(paraName);
                map.put("order", value);
            }
            if("sort".equals(paraName)){
                Object value = request.getParameter(paraName);
                map.put("orderBy", value);
            }
            if(paraName.indexOf("query.") >= 0){
                String param = paraName.substring(paraName.indexOf(".") + 1);
                //
                Object value = request.getParameter(paraName);
                try{
                    String val = value.toString();
                    if(null != val && Charset.forName("ISO-8859-1").newEncoder().canEncode(val)){
                        value = new String(val.getBytes("ISO-8859-1"), "UTF-8");
                    }
                }catch (Exception e){

                }

                if(null != value && !StringUtils.isEmpty(value.toString())){
                    map.put(param, value.toString().replaceAll("%","\\\\%").replaceAll("_","\\\\_"));
                }
            }
        }
        return map;
    }

    public static Map<String,Object> requestToMap(HttpServletRequest request){
        Map<String, Object> map = new HashMap<>();
        Enumeration rnames = request.getParameterNames();
        for (Enumeration e = rnames; e.hasMoreElements();) {
            String thisName = e.nextElement().toString();
            String thisValue = request.getParameter(thisName);
            map.put(thisName, thisValue);
        }
        return map;
    }
}
