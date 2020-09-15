package com.bitnei.cloud.report.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Dosage  {

    /** 配方编号 **/
    private String id;
    /** 药品名称 **/
    private String dName;
    /** 药品质量 **/
    private Double dQuality;
    /** 药品物质的量 **/
    private Double dMolar;

}
