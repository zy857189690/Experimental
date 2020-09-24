package com.bitnei.cloud.common;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class JsonUtil {
    private static Log log = LogFactory.getLog(JsonUtil.class);

    public static String object2json(Object obj) {
        StringBuilder json = new StringBuilder();
        if (obj == null)
            json.append("\"\"");
        else if (((obj instanceof String)) || ((obj instanceof Integer)) || ((obj instanceof Float)) ||
                ((obj instanceof Boolean)) || ((obj instanceof Short)) || ((obj instanceof Double)) ||
                ((obj instanceof Long)) || ((obj instanceof BigDecimal)) || ((obj instanceof BigInteger)) ||
                ((obj instanceof Byte)))
            json.append("\"").append(string2json(obj.toString())).append("\"");
        else if ((obj instanceof Object[]))
            json.append(array2json((Object[]) obj));
        else if ((obj instanceof List))
            json.append(list2json((List) obj));
        else if ((obj instanceof Map))
            json.append(map2json((Map) obj));
        else if ((obj instanceof Set))
            json.append(set2json((Set) obj));
        else {
            json.append(bean2json(obj));
        }
        return json.toString();
    }

    public static String bean2json(Object bean) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        PropertyDescriptor[] props = (PropertyDescriptor[]) null;
        try {
            props = Introspector.getBeanInfo(bean.getClass(), Object.class).getPropertyDescriptors();
        } catch (IntrospectionException localIntrospectionException) {
        }
        if (props != null) {
            for (int i = 0; i < props.length; i++)
                try {
                    String name = object2json(props[i].getName());
                    String value = object2json(props[i].getReadMethod().invoke(bean, new Object[0]));
                    json.append(name);
                    json.append(":");
                    json.append(value);
                    json.append(",");
                } catch (Exception localException) {
                }
            json.setCharAt(json.length() - 1, '}');
        } else {
            json.append("}");
        }
        return json.toString();
    }

    public static String list2json(List<?> list) {
        ObjectMapper map = new ObjectMapper();
        try {
            return map.writeValueAsString(list);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return "";
        }

    }

    /**
     * ������תΪjson�ַ���
     * @param obj
     * @return
     */
    public  static  String Object2Json(Object obj){
        ObjectMapper map = new ObjectMapper();
        try {
            return map.writeValueAsString(obj);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return "";
        }
    }

    public static String array2json(Object[] array) {
        StringBuilder json = new StringBuilder();
        json.append("[");
        if ((array != null) && (array.length > 0)) {
            Object[] arrayOfObject = array;
            int j = array.length;
            for (int i = 0; i < j; i++) {
                Object obj = arrayOfObject[i];
                json.append(object2json(obj));
                json.append(",");
            }
            json.setCharAt(json.length() - 1, ']');
        } else {
            json.append("]");
        }
        return json.toString();
    }

    public static String map2json(Map<?, ?> map) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        if ((map != null) && (map.size() > 0)) {
            for (Iterator localIterator = map.keySet().iterator(); localIterator.hasNext(); ) {
                Object key = localIterator.next();
                json.append(object2json(key));
                json.append(":");
                json.append(object2json(map.get(key)));
                json.append(",");
            }
            json.setCharAt(json.length() - 1, '}');
        } else {
            json.append("}");
        }
        return json.toString();
    }

    public static String set2json(Set<?> set) {
        ObjectMapper map = new ObjectMapper();
        try {
            return map.writeValueAsString(set);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return "";
        }
    }

    public static String string2json(String s) {
        if (s == null)
            return "";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            char ch = s.charAt(i);
            switch (ch) {
                case '"':
                    sb.append("\\\"");
                    break;
                case '\\':
                    sb.append("\\\\");
                    break;
                case '\b':
                    sb.append("\\b");
                    break;
                case '\f':
                    sb.append("\\f");
                    break;
                case '\n':
                    sb.append("\\n");
                    break;
                case '\r':
                    sb.append("\\r");
                    break;
                case '\t':
                    sb.append("\\t");
                    break;
                case '/':
                    sb.append("\\/");
                    break;
                default:
                    if ((ch >= 0) && (ch <= '\037')) {
                        String ss = Integer.toHexString(ch);
                        sb.append("\\u");
                        for (int k = 0; k < 4 - ss.length(); k++) {
                            sb.append('0');
                        }
                        sb.append(ss.toUpperCase());
                    } else {
                        sb.append(ch);
                    }
            }
        }
        return sb.toString();
    }


}
