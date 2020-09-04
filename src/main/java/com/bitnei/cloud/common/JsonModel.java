package com.bitnei.cloud.common;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * 返回json用的模型
 * 当前方法的好处是，前台写ajax脚本时，统一返回json对象（不能用于easyui中的dataGrid和tree）
 * @author khui
 *
 */
public class JsonModel implements Serializable{
    /**
     *
     */
    private static final long serialVersionUID = 1632199795193769196L;
    private String msg = "操作成功！";		//返回前台的信息
    private boolean flag = true;	//标识当前操作的状态，一般为标识操作成功或失败
    private Map<String,Object> data = new HashMap<String, Object>();

    public JsonModel(){

    }

    public JsonModel(boolean flag, String msg, Object resData){
        this.flag = flag;
        this.msg = msg;
        this.resData = resData;

    }

    private Object resData;

    public static JsonModel success(){
        return new JsonModel();
    }

    public static JsonModel success(String msg,Object resData){
        return new JsonModel(true,msg,resData);
    }

    public static JsonModel error(String msg){
        JsonModel jsonModel = new JsonModel();
        jsonModel.setFlag(false);
        jsonModel.setMsg(msg);
        return jsonModel;
    }

    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }

    public String getMsg() {
        return msg;
    }
    public void setMsg(String msg) {
        this.msg = msg;
    }
    public boolean isFlag() {
        return flag;
    }
    public void setFlag(boolean flag) {
        this.flag = flag;
    }

    public Object getResData() {
        return resData;
    }

    public void setResData(Object resData) {
        this.resData = resData;
    }

    public  boolean getflag(){
        return this.flag;
    }
}
