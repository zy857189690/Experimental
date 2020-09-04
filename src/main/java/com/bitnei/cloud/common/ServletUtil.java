package com.bitnei.cloud.common;


import com.bitnei.commons.bean.WebUser;
import com.bitnei.commons.datatables.DataGridOptions;
import java.io.UnsupportedEncodingException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jodd.util.StringUtil;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class ServletUtil {
    private static ThreadLocal<Map<String, Object>> modelThreadLocal = new ThreadLocal();
    public static final String UC_COOKIE_NAME = "UCENTER_SESSION_ID";

    public ServletUtil() {
    }

    public static void addModelValue(String key, Object value) {
        Map<String, Object> model = (Map)modelThreadLocal.get();
        if (model == null) {
            model = new HashMap();
        }

        ((Map)model).put(key, value);
        modelThreadLocal.set(model);
    }

    public static Map<String, Object> getModelValues() {
        Map<String, Object> model = (Map)modelThreadLocal.get();
        if (model == null) {
            model = new HashMap();
        }

        return (Map)model;
    }

    public static void setExcelResponse(String fileName) {
        HttpServletResponse response = getResponse();
        response.setContentType("application/x-excel");
        response.setCharacterEncoding("UTF-8");

        try {
            response.addHeader("Content-Disposition", "attachment;filename=" + new String(fileName.getBytes("gbk"), "iso-8859-1"));
        } catch (UnsupportedEncodingException var3) {
            var3.printStackTrace();
        }

    }

    public static HttpServletRequest getRequest() {
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        ServletRequestAttributes sra = (ServletRequestAttributes)ra;
        HttpServletRequest request = sra.getRequest();
        return request;
    }

    public static HttpServletResponse getResponse() {
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        ServletRequestAttributes sra = (ServletRequestAttributes)ra;
        HttpServletResponse rsp = sra.getResponse();
        return rsp;
    }

    public static DataGridOptions getDataGridOptions() {
        HttpServletRequest request = getRequest();
        int pageSize = Integer.parseInt(request.getParameter("pageSize").toString());
        int curPage = Integer.parseInt(request.getParameter("curPage").toString());
        String sortName = request.getParameter("sortName").toString();
        String sortOrder = request.getParameter("sortOrder").toString();
        int start = pageSize * (curPage - 1);
        DataGridOptions options = new DataGridOptions();
        options.setSort(sortName);
        options.setOrder(sortOrder);
        options.setLength(pageSize);
        options.setStart(start);
        options.setPageNumber(curPage);
        options.setParams(getQueryParams());
        return options;
    }

    public static DataGridOptions getDataLayOptions() {
        HttpServletRequest request = getRequest();
        Object rows = request.getParameter("rows");
        int length;
        int page;
        if (rows == null) {
            length = 1000;
            page = 1;
        } else {
            length = Integer.valueOf(request.getParameter("rows"));
            page = Integer.valueOf(request.getParameter("page"));
        }

        String sort = request.getParameter("sort");
        String order = request.getParameter("order");
        int start = (page - 1) * length;
        DataGridOptions options = new DataGridOptions(length, start, page);
        options.setOrder(order);
        options.setSort(sort);
        options.setParams(getQueryParams());
        return options;
    }

    public static DataGridOptions getLayuiTableOptions() {
        HttpServletRequest request = getRequest();
        int page = Integer.parseInt(request.getParameter("page").toString());
        int limit = Integer.parseInt(request.getParameter("limit").toString());
        int pageSize = Integer.parseInt(request.getParameter("limit").toString());
        int curPage = Integer.parseInt(request.getParameter("page").toString());
        String sortName = "id";
        String sortOrder = "desc";
        int start = pageSize * (curPage - 1);
        DataGridOptions options = new DataGridOptions();
        options.setSort(sortName);
        options.setOrder(sortOrder);
        options.setLength(pageSize);
        options.setStart(start);
        options.setPageNumber(curPage);
        options.setParams(getQueryParams());
        return options;
    }

    public static Map<String, Object> getQueryParams() {
        HttpServletRequest request = getRequest();
        Map<String, Object> params = new HashMap();
        Enumeration<String> names = request.getParameterNames();
        new StringBuffer();

        while(names.hasMoreElements()) {
            String name = (String)names.nextElement();
            if (name.startsWith("query.")) {
                String value = request.getParameter(name);
                if (StringUtil.isNotEmpty(value)) {
                    String k = name.replace("query.", "");
                    params.put(k, value);
                }
            }
        }

        return params;
    }

    public static String getCurrentUser() {
        try {
            return getUser().getUsername();
        } catch (Exception var1) {
            return null;
        }
    }

    public static void setAttribute(String name, Object value) {
        getRequest().setAttribute(name, value);
    }

    public static Object getAttribute(String name) {
        return getRequest().getAttribute(name);
    }

    public static String getParameter(String name) {
        return getRequest().getParameter(name);
    }

    public static Object getSession(String name) {
        return getRequest().getSession().getAttribute(name);
    }

    public static void setSession(String name, Object value) {
        getRequest().getSession().setAttribute(name, value);
    }

    public static WebUser getUser() {
        return (WebUser)getSession("gUser");
    }

    public static ServletUtil.RequestType getRequestType() {
        HttpServletRequest request = getRequest();
        return StringUtil.isNotEmpty(request.getHeader("X-Requested-With")) ? ServletUtil.RequestType.AJAX : ServletUtil.RequestType.NORMAL;
    }

    public static String getUserCenterSessionId() {
        HttpServletRequest httpServletRequest = getRequest();
        Cookie[] cookies = httpServletRequest.getCookies();
        String sessionId = "";
        Cookie[] var3 = cookies;
        int var4 = cookies.length;

        for(int var5 = 0; var5 < var4; ++var5) {
            Cookie cookie = var3[var5];
            if (cookie.getName().equals("UCENTER_SESSION_ID")) {
                sessionId = cookie.getValue();
            }
        }

        return sessionId;
    }

    public static enum RequestType {
        AJAX,
        NORMAL;

        private RequestType() {
        }
    }
}

