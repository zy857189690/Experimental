package com.bitnei.cloud.report.util;

/**
 * @author chenyl or 13718602502@163.com
 * 数据未更新异常捕获
 */
public class NeedUpdateException extends RuntimeException{

    private String code;

    private String rmak;

    public String getRmak() {
        return rmak;
    }

    public void setRmak(String rmak) {
        this.rmak = rmak;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public NeedUpdateException(String message){
        super(message);
        this.rmak = message;
    }

    @Override
    public String getMessage() {
        return rmak;
    }
}
