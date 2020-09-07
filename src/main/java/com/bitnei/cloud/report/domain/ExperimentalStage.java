package com.bitnei.cloud.report.domain;

import lombok.Data;

@Data
public class ExperimentalStage {

    /** id **/
    private String id;
    /** 实验编号 **/
    private String reportCode;
    /** 报告人 **/
    private String reportUserName;
    /** 报告时间 **/
    private String reportTime;
    /** 理论配方 **/
    private String theoreticalFormula;
    /** 实际配方 **/
    private String actualFormula;
    /** 报告内容 **/
    private String reportContent;
    /** 报告图片 **/
    private String reportImg [];
    /** 报告状态 **/
    private String status;
    private String updateTime;

    private String reportImgs;
}
