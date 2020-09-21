package com.bitnei.cloud.report.domain;

import lombok.*;


@Data
public class Drug  {

    private String id;

    /** 物料编号 **/
    private String code;
    /** 药品名称 **/
    private String dname;
    /** 规格 **/
    private String dgauge;
    /** 药品分子量 **/
    private String dmolecular;

}
