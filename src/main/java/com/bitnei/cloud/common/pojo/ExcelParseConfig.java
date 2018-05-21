package com.bitnei.cloud.common.pojo;

import java.lang.reflect.Method;
import java.util.*;

/**
 * @author chenyl or 13718602502@163.com
 *
 */
public class ExcelParseConfig<T> {

    /**
     * 解析回调接口 用于其他额外处理 默认为不处理任何事情
     */
    public interface OnParseListener<T>{
        default T onParse(T instance){return instance;}
    }

    private OnParseListener onParseListener = new OnParseListener() {};

    /**
     * 对应列的setting方法
     */
    private List<String> columnSetter;

    /**
     * 转换为实体class对象
     */
    private Class<T> aClass;

    /**
     * 如果为导入 无需传入
     */
    private List<String> columnNames;

    private Map<String,Method> settingMap = new LinkedHashMap<>();

    public ExcelParseConfig(Class<T> aClass) throws Exception{
        if(aClass == null){
            throw new RuntimeException();
        }
        this.aClass = aClass;
    }

    private void findClassSetter(Class<?> aClass) {
        for(String setting : columnNames){
            try {
                Method method = aClass.getMethod(setting,String.class);
                settingMap.put(setting,method);
            } catch (NoSuchMethodException e) {
                e.printStackTrace();
            }
        }
    }

    public Class<?> getaClass() {
        return aClass;
    }

    public void setaClass(Class<T> aClass) {
        this.aClass = aClass;
    }

    public Map<String, Method> getSettingMap() {
        return settingMap;
    }

    public void setSettingMap(Map<String, Method> settingMap) {
        this.settingMap = settingMap;
    }

    /**
     * 根据value 获取KEY
     * @param map
     * @param value
     * @return
     */
    public static ArrayList valueGetKey(Map map, String value) {
        Set set = map.entrySet();
        ArrayList arr = new ArrayList<>();
        Iterator it = set.iterator();
        while(it.hasNext()) {
            Map.Entry entry = (Map.Entry)it.next();
            if(entry.getValue().equals(value)) {
                int s = (int)entry.getKey();
                arr.add(s);
            }
        }
        return arr;
    }


    public OnParseListener getOnParseListener() {
        return onParseListener;
    }

    public void setOnParseListener(OnParseListener onParseListener) {
        this.onParseListener = onParseListener;
    }

    public List<String> getColumnSetter() {
        return columnSetter;
    }

    public void setColumnSetter(List<String> columnSetter) {
        this.columnSetter = columnSetter;
    }

    public List<String> getColumnNames() {
        return columnNames;
    }

    public void setColumnNames(List<String> columnNames) {
        this.columnNames = columnNames;
        findClassSetter(aClass);
    }
}
