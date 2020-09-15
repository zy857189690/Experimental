package com.bitnei.cloud.report.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Formula  {

    /** 配方编号 **/
    private String id;
    /** 配方名称 **/
    private String fName;
    /** 所属项目编号 **/
    private String pId;
    /** 配方创建时间 **/
    private String fTime;
    /** 配方创建人 **/
    private String fPeople;

}
