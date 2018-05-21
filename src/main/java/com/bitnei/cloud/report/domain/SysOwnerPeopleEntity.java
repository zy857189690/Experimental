package com.bitnei.cloud.report.domain;

import java.util.Date;
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
public class SysOwnerPeopleEntity {
    /**
     * 主键
     */
    private String id;

    /**
     *
     */
    private String ownerName;

    private String address;

    private String email;

    private String fax;

    private String mobilePhone;

    private String telPhone;

    private Short isMsgNotice;

    private Date addTime;

    private String uintId;

    private String addUserId;
    /**
     * 类型：1员工2车辆负责人3单位联系人4个人车主
     */
    private Integer ownerType;
    /**
     * 部门id
     */
    private String departmentId;
    /**
     * 岗位id
     */
    private String postId;
    /**
     * 工号
     */
    private String jobNumber;
    /**
     * 创建时间
     */
    private String createTime;
    /**
     * 性别：男：Ｍ；女：F
     */
    private String sex;
    /**
     * 证件类型
     */
    private String ownerCertType;
    /**
     * 证件号码
     */
    private String ownerCertId;
    /**
     * 所有人证件地址
     */
    private String ownerCertAddr;
    /**
     * 证件正面
     */
    private String pic1;
    /**
     * 证件背面
     */
    private String pic2;
    /**
     * 手持证件照
     */
    private String facePic;
    /**
     * 更新人
     */
    private String updateUserId;
    /**
     * 更新时间
     */
    private String updateTime;

    public SysOwnerPeopleEntity(String id, String ownerName, String address, String email, String fax, String mobilePhone, String telPhone, Short isMsgNotice, Date addTime, String uintId, String addUserId, Integer ownerType, String departmentId, String postId, String jobNumber, String createTime, String sex, String ownerCertType, String ownerCertId, String ownerCertAddr, String pic1, String pic2, String facePic, String updateUserId, String updateTime) {
        this.id = id;
        this.ownerName = ownerName;
        this.address = address;
        this.email = email;
        this.fax = fax;
        this.mobilePhone = mobilePhone;
        this.telPhone = telPhone;
        this.isMsgNotice = isMsgNotice;
        this.addTime = addTime;
        this.uintId = uintId;
        this.addUserId = addUserId;
        this.ownerType = ownerType;
        this.departmentId = departmentId;
        this.postId = postId;
        this.jobNumber = jobNumber;
        this.createTime = createTime;
        this.sex = sex;
        this.ownerCertType = ownerCertType;
        this.ownerCertId = ownerCertId;
        this.ownerCertAddr = ownerCertAddr;
        this.pic1 = pic1;
        this.pic2 = pic2;
        this.facePic = facePic;
        this.updateUserId = updateUserId;
        this.updateTime = updateTime;
    }

    public SysOwnerPeopleEntity() {
        super();
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName == null ? null : ownerName.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax == null ? null : fax.trim();
    }

    public String getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone == null ? null : mobilePhone.trim();
    }

    public String getTelPhone() {
        return telPhone;
    }

    public void setTelPhone(String telPhone) {
        this.telPhone = telPhone == null ? null : telPhone.trim();
    }

    public Short getIsMsgNotice() {
        return isMsgNotice;
    }

    public void setIsMsgNotice(Short isMsgNotice) {
        this.isMsgNotice = isMsgNotice;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public String getUintId() {
        return uintId;
    }

    public void setUintId(String uintId) {
        this.uintId = uintId == null ? null : uintId.trim();
    }

    public String getAddUserId() {
        return addUserId;
    }

    public void setAddUserId(String addUserId) {
        this.addUserId = addUserId == null ? null : addUserId.trim();
    }

    public Integer getOwnerType() {
        return ownerType;
    }

    public void setOwnerType(Integer ownerType) {
        this.ownerType = ownerType;
    }

    public String getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId == null ? null : departmentId.trim();
    }

    public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId == null ? null : postId.trim();
    }

    public String getJobNumber() {
        return jobNumber;
    }

    public void setJobNumber(String jobNumber) {
        this.jobNumber = jobNumber == null ? null : jobNumber.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
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

    public String getFacePic() {
        return facePic;
    }

    public void setFacePic(String facePic) {
        this.facePic = facePic;
    }

    public String getUpdateUserId() {
        return updateUserId;
    }

    public void setUpdateUserId(String updateUserId) {
        this.updateUserId = updateUserId;
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }

    @Override
    public String toString() {
        return "[ownerName:"+ownerName+"]";
    }
}