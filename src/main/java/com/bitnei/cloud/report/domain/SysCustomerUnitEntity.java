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
public class SysCustomerUnitEntity {
    private String id;

    private String name;

    private String superiorUnitId;

    private String cusReplace;

    private String contact;

    private String contactInfo;

    private String creditCode;

    private String unitTypeId;

    private String state;

    private String createTime;

    private String updateTime;

    private String productBrand;

    private String comType;

    private String industryType;

    private String sex;

    private String ownerCertType;

    private String ownerCertId;

    private String ownerCertAddr;

    private String ownerAddress;

    private String email;

    private String pic1;

    private String pic2;

    private String enterPic;
    private String authPic;
    private String factPic;

    public String getFactPic() {
        return factPic;
    }

    public void setFactPic(String factPic) {
        this.factPic = factPic;
    }

    public String getEnterPic() {
        return enterPic;
    }

    public void setEnterPic(String enterPic) {
        this.enterPic = enterPic;
    }

    public String getAuthPic() {
        return authPic;
    }

    public void setAuthPic(String authPic) {
        this.authPic = authPic;
    }

    public String getPic1() {
        return pic1;
    }

    public void setPic1(String pic1) {
        this.pic1 = pic1;
    }

    public String getPic2() {
        return pic2;
    }

    public void setPic2(String pic2) {
        this.pic2 = pic2;
    }



    public SysCustomerUnitEntity() {
        super();
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public SysCustomerUnitEntity(String id, String name, String superiorUnitId, String cusReplace, String contact, String contactInfo, String creditCode, String unitTypeId, String state, String createTime, String updateTime, String productBrand, String comType, String industryType, String sex, String ownerCertType, String ownerCertId, String ownerCertAddr, String ownerAddress, String email, String pic1, String pic2, String enterPic, String authPic, String factPic) {
        this.id = id;
        this.name = name;
        this.superiorUnitId = superiorUnitId;
        this.cusReplace = cusReplace;
        this.contact = contact;
        this.contactInfo = contactInfo;
        this.creditCode = creditCode;
        this.unitTypeId = unitTypeId;
        this.state = state;
        this.createTime = createTime;
        this.updateTime = updateTime;
        this.productBrand = productBrand;
        this.comType = comType;
        this.industryType = industryType;
        this.sex = sex;
        this.ownerCertType = ownerCertType;
        this.ownerCertId = ownerCertId;
        this.ownerCertAddr = ownerCertAddr;
        this.ownerAddress = ownerAddress;
        this.email = email;
        this.pic1 = pic1;
        this.pic2 = pic2;
        this.enterPic = enterPic;
        this.authPic = authPic;
        this.factPic = factPic;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getSuperiorUnitId() {
        return superiorUnitId;
    }

    public void setSuperiorUnitId(String superiorUnitId) {
        this.superiorUnitId = superiorUnitId == null ? null : superiorUnitId.trim();
    }

    public String getCusReplace() {
        return cusReplace;
    }

    public void setCusReplace(String cusReplace) {
        this.cusReplace = cusReplace == null ? null : cusReplace.trim();
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact == null ? null : contact.trim();
    }

    public String getContactInfo() {
        return contactInfo;
    }

    public void setContactInfo(String contactInfo) {
        this.contactInfo = contactInfo == null ? null : contactInfo.trim();
    }

    public String getCreditCode() {
        return creditCode;
    }

    public void setCreditCode(String creditCode) {
        this.creditCode = creditCode == null ? null : creditCode.trim();
    }

    public String getUnitTypeId() {
        return unitTypeId;
    }

    public void setUnitTypeId(String unitTypeId) {
        this.unitTypeId = unitTypeId == null ? null : unitTypeId.trim();
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime == null ? null : updateTime.trim();
    }

    public String getProductBrand() {
        return productBrand;
    }

    public void setProductBrand(String productBrand) {
        this.productBrand = productBrand == null ? null : productBrand.trim();
    }

    public String getComType() {
        return comType;
    }

    public void setComType(String comType) {
        this.comType = comType == null ? null : comType.trim();
    }

    public String getIndustryType() {
        return industryType;
    }

    public void setIndustryType(String industryType) {
        this.industryType = industryType == null ? null : industryType.trim();
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

    public String getOwnerAddress() {
        return ownerAddress;
    }

    public void setOwnerAddress(String ownerAddress) {
        this.ownerAddress = ownerAddress == null ? null : ownerAddress.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }
}