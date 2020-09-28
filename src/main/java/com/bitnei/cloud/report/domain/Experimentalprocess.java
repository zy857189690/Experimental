package com.bitnei.cloud.report.domain;

import lombok.Data;

@Data
public class Experimentalprocess {
    /** id **/
    private String id;
    /** 实验编号 **/
    private String code;
    /** 实验名称 **/
    private String  experimentalName;
    /** 实验人 **/
    private String experimenter;
    /** 配方id **/
    private String formulaId;


    /** 所属项目编号 **/
    private String pid;
    /** 实验记录时间 **/
    private String createTime;
    /** 复核时间 **/
    private String confirmTime;
    /** 复核状态 0 未复核 1复核 **/
    private String confirmStatus;
    /** 实验方案 **/
    private String experimentalScheme;
    /** 实验过程 **/
    private String procedures;
    /** 实验观察/结果 **/
    private String result;
    /** 结果分析（及下一步实验计划) **/
    private String analysis;

    private String formulaName;
}
