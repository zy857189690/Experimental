package com.bitnei.cloud.report.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Drug  {

    /** 物料编号 **/
    private String id;
    /** 药品名称 **/
    private String dName;
    /** 规格 **/
    private String dGauge;
    /** 药品分子量 **/
    private Double dMolecular;

}
