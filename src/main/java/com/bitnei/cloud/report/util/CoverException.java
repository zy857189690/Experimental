package com.bitnei.cloud.report.util;

public class CoverException extends RuntimeException {
    public CoverException(String message){
        super(message);
    }
    public CoverException(){
        super("数据覆盖");
    }
}
