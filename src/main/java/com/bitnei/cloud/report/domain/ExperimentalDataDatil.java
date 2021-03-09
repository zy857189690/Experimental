package com.bitnei.cloud.report.domain;

import lombok.Data;

@Data
public class ExperimentalDataDatil {
    private String id;
    private String reportDate;
    private String explameOne;
    private String explameTwo;
    private String explameThree;
    private String experimentalId;
    private String exNo;

    private double yp1ljnd; // 样品1累计浓度
    private double yp12jnd;// 样品2累计浓度
    private double yp13jnd;

    private double totalnd;
    private double pjljnd;

    private double yp1ljndbf; // 样品1累计浓度百分比
    private double yp12jndbf;// 样品2累计浓度百分比
    private double yp13jndbf;

    private double pjbf;

    private String dosage;
}
