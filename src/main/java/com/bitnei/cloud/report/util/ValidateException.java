package com.bitnei.cloud.report.util;

public class ValidateException extends RuntimeException{
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

    public ValidateException(String message){
        super(message);
        this.rmak = message;
    }

    @Override
    public String getMessage() {
        return rmak;
    }
}