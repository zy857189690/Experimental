package com.bitnei.cloud.report.domain;

import com.bitnei.cloud.common.bean.TailBean;



public class DayVehInfo extends TailBean {
    /**
     * 1、报表生成日期
     */
    private String reportDate;
    /**
     * 2、车牌号
     */
    private String licensePlate;
    /**
     * 3、车辆vin
     */
    private String vin;
    /**
     * 4、车辆种类
     */
    private String vehTypeId;
    /**
     * 5、车辆名称（车型型号）
     */
    private String vehModelName;
    /**
     * 6、车辆型号（公告号）
     */
    private String modelNoticeId;
    /**
     * 7、终端零件号
     */
    private String termPartFirmwareNumbers;
    /**
     * 8、条形码编码
     */
    private String termBarCode;
    /**
     * 9、终端厂商自定义编号
     */
    private String termVendorCode;
    /**
     * 10、车辆厂商
     */
    private String manuUnitId;
    /**
     * 11、运营单位
     */
    private String useUintId;
    /**
     * 12、上牌区域
     */
    private String sysDivisionId;
    /**
     * 13、激活时间（录入时间）
     */
    private String entryDate;
    /**
     * 14、销售日期
     */
    private String saleTime;
    /**
     * 15、日活跃总时间（h）
     */
    private Double dailyActiveTotalTime;
    /**
     * 16、日总行驶时间（h）
     */
    private Double runTimeSum;
    /**
     * 17、日行驶次数
     */
    private Double runTimes;
    /**
     * 18、日总行驶里程（km）
     */
    private Double runKm;
    /**
     * 19、单次运行最大里程
     */
    private Double runKmMax;
    /**
     * 20、仪表总里程
     */
    private Double lastMeterMileage;
    /**
     * 21、GPS总里程
     */
    private Double lastGpsMileage;
    /**
     * 22、当日累计耗电量
     */
    private Double chargeConsume;
    /**
     * 23、实际百公里耗电量
     */
    private Double chargeCon100km;
    /**
     * 24、百公里额定耗电量
     */
    private Double ratedChargeCon100km;
    /**
     * 25、单次充电后最大耗电量
     */
    private Double chargeSconsumeMax;
    /**
     * 26、充电总次数
     */
    private Double chargeTimes;
    /**
     * 27、快充次数
     */
    private Double fastTimes;
    /**
     * 28、慢充次数
     */
    private Double lowTmes;
    /**
     * 29、充电总时长
     */
    private Double chargeTimeSum;
    /**
     * 30、单次最长充电时间
     */
    private Double chargeTimeMax;
    /**
     * 31、单次充电后最大行驶里程
     */
    private Double singleChargeMaxMileage;
    /**
     * 32、日最高速度
     */
    private Double runSpeedMax;
    /**
     * 33、日平均速度
     */
    private Double runSpeedAvg;
    /**
     * 34、数据最后上传时间（登出时间）
     */
    private String lastCommunTime	;

    public Double getLastMeterMileage() {
        return lastMeterMileage;
    }

    public void setLastMeterMileage(Double lastMeterMileage) {
        this.lastMeterMileage = lastMeterMileage;
    }

    public Double getLastGpsMileage() {
        return lastGpsMileage;
    }

    public void setLastGpsMileage(Double lastGpsMileage) {
        this.lastGpsMileage = lastGpsMileage;
    }

    public Double getChargeConsume() {
        return chargeConsume;
    }

    public void setChargeConsume(Double chargeConsume) {
        this.chargeConsume = chargeConsume;
    }

    public Double getChargeCon100km() {
        return chargeCon100km;
    }

    public void setChargeCon100km(Double chargeCon100km) {
        this.chargeCon100km = chargeCon100km;
    }

    public Double getRatedChargeCon100km() {
        return ratedChargeCon100km;
    }

    public void setRatedChargeCon100km(Double ratedChargeCon100km) {
        this.ratedChargeCon100km = ratedChargeCon100km;
    }

    public Double getChargeSconsumeMax() {
        return chargeSconsumeMax;
    }

    public void setChargeSconsumeMax(Double chargeSconsumeMax) {
        this.chargeSconsumeMax = chargeSconsumeMax;
    }

    public Double getFastTimes() {
        return fastTimes;
    }

    public void setFastTimes(Double fastTimes) {
        this.fastTimes = fastTimes;
    }

    public Double getLowTmes() {
        return lowTmes;
    }

    public void setLowTmes(Double lowTmes) {
        this.lowTmes = lowTmes;
    }

    public String getVehModelName() {
        return vehModelName;
    }

    public void setVehModelName(String vehModelName) {
        this.vehModelName = vehModelName;
    }

    public String getModelNoticeId() {
        return modelNoticeId;
    }

    public void setModelNoticeId(String modelNoticeId) {
        this.modelNoticeId = modelNoticeId;
    }

    public String getReportDate() {
        return reportDate;
    }

    public void setReportDate(String reportTime) {
        this.reportDate = reportTime;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public String getVin() {
        return vin;
    }

    public void setVin(String vin) {
        this.vin = vin;
    }

    public String getVehTypeId() {
        return vehTypeId;
    }

    public void setVehTypeId(String vehTypeId) {
        this.vehTypeId = vehTypeId;
    }

    public String getTermPartFirmwareNumbers() {
        return termPartFirmwareNumbers;
    }

    public void setTermPartFirmwareNumbers(String termPartFirmwareNumbers) {
        this.termPartFirmwareNumbers = termPartFirmwareNumbers;
    }

    public String getTermBarCode() {
        return termBarCode;
    }

    public void setTermBarCode(String termBarCode) {
        this.termBarCode = termBarCode;
    }

    public String getTermVendorCode() {
        return termVendorCode;
    }

    public void setTermVendorCode(String termVendorCode) {
        this.termVendorCode = termVendorCode;
    }

    public String getManuUnitId() {
        return manuUnitId;
    }

    public void setManuUnitId(String manuUnitId) {
        this.manuUnitId = manuUnitId;
    }

    public String getUseUintId() {
        return useUintId;
    }

    public void setUseUintId(String useUintId) {
        this.useUintId = useUintId;
    }

    public String getSysDivisionId() {
        return sysDivisionId;
    }

    public void setSysDivisionId(String sysDivisionId) {
        this.sysDivisionId = sysDivisionId;
    }

    public String getEntryDate() {
        return entryDate;
    }

    public void setEntryDate(String entryDate) {
        this.entryDate = entryDate;
    }

    public String getSaleTime() {
        return saleTime;
    }

    public void setSaleTime(String saleTime) {
        this.saleTime = saleTime;
    }

    public Double getDailyActiveTotalTime() {
        return dailyActiveTotalTime;
    }

    public void setDailyActiveTotalTime(Double dailyActiveTotalTime) {
        this.dailyActiveTotalTime = dailyActiveTotalTime;
    }

    public Double getRunTimeSum() {
        return runTimeSum;
    }

    public void setRunTimeSum(Double runTimeSum) {
        this.runTimeSum = runTimeSum;
    }

    public Double getRunTimes() {
        return runTimes;
    }

    public void setRunTimes(Double runTimes) {
        this.runTimes = runTimes;
    }

    public Double getRunKm() {
        return runKm;
    }

    public void setRunKm(Double runKm) {
        this.runKm = runKm;
    }

    public Double getRunKmMax() {
        return runKmMax;
    }

    public void setRunKmMax(Double runKmMax) {
        this.runKmMax = runKmMax;
    }

    public Double getChargeTimes() {
        return chargeTimes;
    }

    public void setChargeTimes(Double chargeTimes) {
        this.chargeTimes = chargeTimes;
    }

    public Double getChargeTimeSum() {
        return chargeTimeSum;
    }

    public void setChargeTimeSum(Double chargeTimeSum) {
        this.chargeTimeSum = chargeTimeSum;
    }

    public Double getChargeTimeMax() {
        return chargeTimeMax;
    }

    public void setChargeTimeMax(Double chargeTimeMax) {
        this.chargeTimeMax = chargeTimeMax;
    }

    public Double getSingleChargeMaxMileage() {
        return singleChargeMaxMileage;
    }

    public void setSingleChargeMaxMileage(Double singleChargeMaxMileage) {
        this.singleChargeMaxMileage = singleChargeMaxMileage;
    }

    public Double getRunSpeedMax() {
        return runSpeedMax;
    }

    public void setRunSpeedMax(Double runSpeedMax) {
        this.runSpeedMax = runSpeedMax;
    }

    public Double getRunSpeedAvg() {
        return runSpeedAvg;
    }

    public void setRunSpeedAvg(Double runSpeedAvg) {
        this.runSpeedAvg = runSpeedAvg;
    }

    public String getLastCommunTime() {
        return lastCommunTime;
    }

    public void setLastCommunTime(String lastCommunTime) {
        this.lastCommunTime = lastCommunTime;
    }
}
