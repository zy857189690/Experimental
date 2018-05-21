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
public class SysRealNameAuthenticationEntity {
    private String id;

    private String vin;

    private String authenticationResult;

    private String authenticationType;

    private String remarks;

    private String authenticationId;

    private String createUserId;

    private String createTime;

    private String updateUserId;

    private String updateTime;

    private String state;

    private String authenticationTime;

    private String synResult;

    private String sysTime;

    private String lineNameEn;

    private String channelId;

    public SysRealNameAuthenticationEntity(String id, String vin, String authenticationResult, String authenticationType, String remarks, String authenticationId, String createUserId, String createTime, String updateUserId, String updateTime, String state, String authenticationTime, String synResult, String sysTime, String lineNameEn, String channelId) {
        this.id = id;
        this.vin = vin;
        this.authenticationResult = authenticationResult;
        this.authenticationType = authenticationType;
        this.remarks = remarks;
        this.authenticationId = authenticationId;
        this.createUserId = createUserId;
        this.createTime = createTime;
        this.updateUserId = updateUserId;
        this.updateTime = updateTime;
        this.state = state;
        this.authenticationTime = authenticationTime;
        this.synResult = synResult;
        this.sysTime = sysTime;
        this.lineNameEn = lineNameEn;
        this.channelId = channelId;
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

    public SysRealNameAuthenticationEntity() {
        super();
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getVin() {
        return vin;
    }

    public void setVin(String vin) {
        this.vin = vin == null ? null : vin.trim();
    }

    public String getAuthenticationResult() {
        return authenticationResult;
    }

    public void setAuthenticationResult(String authenticationResult) {
        this.authenticationResult = authenticationResult == null ? null : authenticationResult.trim();
    }

    public String getAuthenticationType() {
        return authenticationType;
    }

    public void setAuthenticationType(String authenticationType) {
        this.authenticationType = authenticationType == null ? null : authenticationType.trim();
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }

    public String getAuthenticationId() {
        return authenticationId;
    }

    public void setAuthenticationId(String authenticationId) {
        this.authenticationId = authenticationId == null ? null : authenticationId.trim();
    }

    public String getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(String createUserId) {
        this.createUserId = createUserId == null ? null : createUserId.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
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

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public String getAuthenticationTime() {
        return authenticationTime;
    }

    public void setAuthenticationTime(String authenticationTime) {
        this.authenticationTime = authenticationTime;
    }

    public String getSynResult() {
        return synResult;
    }

    public void setSynResult(String synResult) {
        this.synResult = synResult;
    }

    public String getSysTime() {
        return sysTime;
    }

    public void setSysTime(String sysTime) {
        this.sysTime = sysTime;
    }
}