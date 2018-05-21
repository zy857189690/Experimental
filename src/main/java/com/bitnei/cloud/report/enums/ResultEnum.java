package com.bitnei.cloud.report.enums;

/**
 * AppBean中code返回给前台的值0代表正常1代表失败
 */
public enum ResultEnum {

    /**
     * 0 成功
     */
    RESULT_YES(0),
    /**
     * 失败
     */
    RESULT_NO(1),
    /**
     * 覆盖异常判断
     */
    RESULT_EXCEPTTYPE(2),
    /**
     * 系统数据异常判断
     */
    RESULT_VALIDATEEXCEPTION(3);
    private Integer value;
    ResultEnum(Integer value){
        this.value = value;
    }
    public Integer getValue() {
        return value;
    }
}
