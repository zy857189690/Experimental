package com.bitnei.cloud.report.domain;

import com.bitnei.cloud.common.bean.AppBean;

public class EnterpriseAuth extends AppBean{
    private String vin;

    private String vehicleId;

    private String sysTermModelUnitId;

    private String serialNumber;

    private String iccid;

    private String sysSimManagementId;

    private String simCartNumber;

    private String imsi;

    private String imei;

    private String uuid;

    private String result;

    private String lineNameEn;

    private String channelId;

    public String getImei() {
        return imei;
    }

    public void setImei(String imei) {
        this.imei = imei;
    }

    public String getVin() {
        return vin;
    }

    public void setVin(String vin) {
        this.vin = vin == null ? null : vin.trim();
    }

    public String getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(String vehicleId) {
        this.vehicleId = vehicleId == null ? null : vehicleId.trim();
    }

    public String getSysTermModelUnitId() {
        return sysTermModelUnitId;
    }

    public void setSysTermModelUnitId(String sysTermModelUnitId) {
        this.sysTermModelUnitId = sysTermModelUnitId == null ? null : sysTermModelUnitId.trim();
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber == null ? null : serialNumber.trim();
    }

    public String getIccid() {
        return iccid;
    }

    public void setIccid(String iccid) {
        this.iccid = iccid == null ? null : iccid.trim();
    }

    public String getSysSimManagementId() {
        return sysSimManagementId;
    }

    public void setSysSimManagementId(String sysSimManagementId) {
        this.sysSimManagementId = sysSimManagementId == null ? null : sysSimManagementId.trim();
    }

    public String getSimCartNumber() {
        return simCartNumber;
    }

    public void setSimCartNumber(String simCartNumber) {
        this.simCartNumber = simCartNumber == null ? null : simCartNumber.trim();
    }

    public String getImsi() {
        return imsi;
    }

    public void setImsi(String imsi) {
        this.imsi = imsi == null ? null : imsi.trim();
    }

    public String getUuid() {
        if(this.getCode() != 0){
            return getMessage();
        }
        return "";
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getResult() {
        if(this.getCode() == 0){
            return "成功";
        }
        return "失败";
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getLineNameEn() {
        return lineNameEn;
    }

    public void setLineNameEn(String lineNameEn) {
        this.lineNameEn = lineNameEn;
    }

    public String getChannelId() {
        return channelId;
    }

    public void setChannelId(String channelId) {
        this.channelId = channelId;
    }
}