package com.bitnei.cloud.report.domain;

import lombok.*;


@Data
public class Dosage  {

    /** 配方编号 **/
    private String id;

    /** 药品质量 **/
    private Double dquality;
    /** 药品物质的量  摩尔  摩尔量=质量/分子量**/
    private Double dmolar;

    private String  formulaid;
    private String  drugid;

}
