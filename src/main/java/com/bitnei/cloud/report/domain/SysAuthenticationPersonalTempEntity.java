package com.bitnei.cloud.report.domain;
/**
 * <p>
 * ----------------------------------------------------------------------------- <br>
 * 工程名 ： 基础框架 <br>
 * 功能： DemoMapper接口<br>
 * 描述： DemoMapper接口，在xml中引用<br>
 * 授权 : (C) Copyright (c) 2017 <br>
 * 公司 : 北京理工新源信息科技有限公司<br>
 * ----------------------------------------------------------------------------- <br>
 * 修改历史 <br>
 * <table width="432" border="1">
 * <tr>
 * <td>版本</td>
 * <td>时间</td>
 * <td>作者</td>
 * <td>改变</td>
 * </tr>
 * <tr>
 * <td>1.0</td>
 * <td>2018-01-08 15:16:18</td>
 * <td>liuhiayuan</td>
 * <td>创建</td>
 * </tr>
 * </table>
 * <br>
 * <font color="#FF0000">注意: 本内容仅限于[北京理工新源信息科技有限公司]内部使用，禁止转发</font> <br>
 *
 * @version 1.0
 *
 * @author liuhiayuan
 * @since JDK1.8
 */
public class SysAuthenticationPersonalTempEntity {
    private String id;

    private String createTime;

    private String ownerName;

    private String sex;

    private String ownerCertType;

    private String ownerCertId;

    private String ownerCertAddr;

    private String mobilePhone;

    private String address;

    private String email;

    private String vin;

    private String serialNumber;

    private String imei;

    private String simCartNumber;

    private String iccid;

    private String imsi;

    private String createUserId;

    private String updateUserId;

    private String updateTime;

    private String pic1;

    private String pic2;

    private String facePic;

    private String authenticationResult;

    private String remarks;

    private String lineNameEn;

    private String channelId;

    public SysAuthenticationPersonalTempEntity(String id, String createTime, String ownerName, String sex, String ownerCertType, String ownerCertId, String ownerCertAddr, String mobilePhone,  String email, String vin, String serialNumber, String imei, String simCartNumber, String iccid, String imsi, String createUserId, String updateUserId, String updateTime, String pic1, String pic2, String facePic, String lineNameEn, String channelId) {
        this.id = id;
        this.createTime = createTime;
        this.ownerName = ownerName;
        this.sex = sex;
        this.ownerCertType = ownerCertType;
        this.ownerCertId = ownerCertId;
        this.ownerCertAddr = ownerCertAddr;
        this.mobilePhone = mobilePhone;
        this.email = email;
        this.vin = vin;
        this.serialNumber = serialNumber;
        this.imei = imei;
        this.simCartNumber = simCartNumber;
        this.iccid = iccid;
        this.imsi = imsi;
        this.createUserId = createUserId;
        this.updateUserId = updateUserId;
        this.updateTime = updateTime;
        this.pic1 = pic1;
        this.pic2 = pic2;
        this.facePic = facePic;
        this.lineNameEn = lineNameEn;
        this.channelId = channelId;
    }

    public SysAuthenticationPersonalTempEntity() {
        super();
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName == null ? null : ownerName.trim();
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public String getOwnerCertType() {
        return ownerCertType;
    }

    public void setOwnerCertType(String ownerCertType) {
        this.ownerCertType = ownerCertType == null ? null : ownerCertType.trim();
    }

    public String getOwnerCertId() {
        return ownerCertId;
    }

    public void setOwnerCertId(String ownerCertId) {
        this.ownerCertId = ownerCertId == null ? null : ownerCertId.trim();
    }

    public String getOwnerCertAddr() {
        return ownerCertAddr;
    }

    public void setOwnerCertAddr(String ownerCertAddr) {
        this.ownerCertAddr = ownerCertAddr == null ? null : ownerCertAddr.trim();
    }

    public String getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone == null ? null : mobilePhone.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getVin() {
        return vin;
    }

    public void setVin(String vin) {
        this.vin = vin == null ? null : vin.trim();
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber == null ? null : serialNumber.trim();
    }

    public String getImei() {
        return imei;
    }

    public void setImei(String imei) {
        this.imei = imei == null ? null : imei.trim();
    }

    public String getSimCartNumber() {
        return simCartNumber;
    }

    public void setSimCartNumber(String simCartNumber) {
        this.simCartNumber = simCartNumber == null ? null : simCartNumber.trim();
    }

    public String getIccid() {
        return iccid;
    }

    public void setIccid(String iccid) {
        this.iccid = iccid == null ? null : iccid.trim();
    }

    public String getImsi() {
        return imsi;
    }

    public void setImsi(String imsi) {
        this.imsi = imsi == null ? null : imsi.trim();
    }

    public String getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(String createUserId) {
        this.createUserId = createUserId == null ? null : createUserId.trim();
    }

    public String getUpdateUserId() {
        return updateUserId;
    }

    public void setUpdateUserId(String updateUserId) {
        this.updateUserId = updateUserId == null ? null : updateUserId.trim();
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime == null ? null : updateTime.trim();
    }


    public String getPic2() {
        return pic2;
    }

    public void setPic2(String pic2) {
        this.pic2 = pic2 == null ? null : pic2.trim();
    }

    public String getPic1() {
        return pic1;
    }

    public void setPic1(String pic1) {
        this.pic1 = pic1 == null ? null : pic1.trim();
    }

    public String getFacePic() {
        return facePic;
    }

    public void setFacePic(String facePic) {
        this.facePic = facePic == null ? null : facePic.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getAuthenticationResult() {
        return authenticationResult;
    }

    public void setAuthenticationResult(String authenticationResult) {
        this.authenticationResult = authenticationResult == null ? null : authenticationResult.trim();
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }

    public String getLineNameEn() {
        return lineNameEn;
    }

    public void setLineNameEn(String lineNameEn) {
        this.lineNameEn = lineNameEn == null ? null : lineNameEn.trim();
    }

    public String getChannelId() {
        return channelId;
    }

    public void setChannelId(String channelId) {
        this.channelId = channelId == null ? null : channelId.trim();
    }


}

