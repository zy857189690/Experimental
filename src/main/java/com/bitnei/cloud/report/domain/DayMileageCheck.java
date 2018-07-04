package com.bitnei.cloud.report.domain;

import com.bitnei.cloud.common.annotation.DictName;
import com.bitnei.cloud.common.annotation.LinkName;
import com.bitnei.cloud.common.bean.TailBean;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * Created by Administrator on 2018/6/6.
 */
public class DayMileageCheck  extends TailBean {
    
    private String id;
    private String ids;
    private String vid;
    private String vin;
    private Date reportDate; //统计日期
    private String firstOnlineTime;//当日首次上线时间
    private String firstStartMileage;//当日开始里程
    private String lastCommitTime;//当日最后通讯时间
    private String lastEndMileage;//当日结束里程
    private Double checkDataTotalNum;//核查数据总条数
    private Double invalidNum;//无效数据条数
    private Double abnormalNum;//异常数据条数
    private String dayOnlineMileage;//当日上线里程
    private String deductJumpMileage;//总跳变扣除里程
    private String deductCurrentMileage;//总连续电流扣除里程
    private String dayValidMileage;//当日有效里程
    private String dayGpsMileage;//当日轨迹里程
    private String validGpsDeviation;//有效里程和轨迹里程相对误差
    private String onlineValidDeviation;//上线里程和有效里程相对误差
    private String dayCheckMileage;//单日核算里程
    
    
    private String  maker;
    private String licensePlate;  //车牌 
    private String vehModelNum; //车辆型号
    private String  vehtype;  //车辆类别
    private String   veharea;  //销售区域
    private String  unit; //运营单位
    private String  unitTypeCode;
    private String  unitTypeName; //单位类型

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIds() {
        return ids;
    }

    public void setIds(String ids) {
        this.ids = ids;
    }

    public String getMaker() {
        return maker;
    }

    public void setMaker(String maker) {
        this.maker = maker;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public String getVehModelNum() {
        return vehModelNum;
    }

    public void setVehModelNum(String vehModelNum) {
        this.vehModelNum = vehModelNum;
    }

    public String getVehtype() {
        return vehtype;
    }

    public void setVehtype(String vehtype) {
        this.vehtype = vehtype;
    }

    public String getVeharea() {
        return veharea;
    }

    public void setVeharea(String veharea) {
        this.veharea = veharea;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getUnitTypeCode() {
        return unitTypeCode;
    }

    public void setUnitTypeCode(String unitTypeCode) {
        this.unitTypeCode = unitTypeCode;
    }

    public String getUnitTypeName() {
        return unitTypeName;
    }

    public void setUnitTypeName(String unitTypeName) {
        this.unitTypeName = unitTypeName;
    }


    public String getVid() {
        return vid;
    }

    public void setVid(String vid) {
        this.vid = vid;
    }

    public String getVin() {
        return vin;
    }

    public void setVin(String vin) {
        this.vin = vin;
    }

    public Date getReportDate() {
        return reportDate;
    }

    public void setReportDate(Date reportDate) {
        this.reportDate = reportDate;
    }

    public String getFirstOnlineTime() {
        return firstOnlineTime;
    }

    public void setFirstOnlineTime(String firstOnlineTime) {
        this.firstOnlineTime = firstOnlineTime;
    }

    public String getFirstStartMileage() {
        return firstStartMileage;
    }

    public void setFirstStartMileage(String firstStartMileage) {
        this.firstStartMileage = firstStartMileage;
    }

    public String getLastCommitTime() {
        return lastCommitTime;
    }

    public void setLastCommitTime(String lastCommitTime) {
        this.lastCommitTime = lastCommitTime;
    }

    public String getLastEndMileage() {
        return lastEndMileage;
    }

    public void setLastEndMileage(String lastEndMileage) {
        this.lastEndMileage = lastEndMileage;
    }

    public Double getCheckDataTotalNum() {
        return checkDataTotalNum;
    }

    public void setCheckDataTotalNum(Double checkDataTotalNum) {
        this.checkDataTotalNum = checkDataTotalNum;
    }

    public Double getInvalidNum() {
        return invalidNum;
    }

    public void setInvalidNum(Double invalidNum) {
        this.invalidNum = invalidNum;
    }

    public Double getAbnormalNum() {
        return abnormalNum;
    }

    public void setAbnormalNum(Double abnormalNum) {
        this.abnormalNum = abnormalNum;
    }

    public String getDayOnlineMileage() {
        return dayOnlineMileage;
    }

    public void setDayOnlineMileage(String dayOnlineMileage) {
        this.dayOnlineMileage = dayOnlineMileage;
    }

    public String getDeductJumpMileage() {
        return deductJumpMileage;
    }

    public void setDeductJumpMileage(String deductJumpMileage) {
        this.deductJumpMileage = deductJumpMileage;
    }

    public String getDeductCurrentMileage() {
        return deductCurrentMileage;
    }

    public void setDeductCurrentMileage(String deductCurrentMileage) {
        this.deductCurrentMileage = deductCurrentMileage;
    }

    public String getDayValidMileage() {
        return dayValidMileage;
    }

    public void setDayValidMileage(String dayValidMileage) {
        this.dayValidMileage = dayValidMileage;
    }

    public String getDayGpsMileage() {
        return dayGpsMileage;
    }

    public void setDayGpsMileage(String dayGpsMileage) {
        this.dayGpsMileage = dayGpsMileage;
    }

    public String getValidGpsDeviation() {
        return validGpsDeviation;
    }

    public void setValidGpsDeviation(String validGpsDeviation) {
        this.validGpsDeviation = validGpsDeviation;
    }

    public String getOnlineValidDeviation() {
        return onlineValidDeviation;
    }

    public void setOnlineValidDeviation(String onlineValidDeviation) {
        this.onlineValidDeviation = onlineValidDeviation;
    }

    public String getDayCheckMileage() {
        return dayCheckMileage;
    }

    public void setDayCheckMileage(String dayCheckMileage) {
        this.dayCheckMileage = dayCheckMileage;
    }
}
