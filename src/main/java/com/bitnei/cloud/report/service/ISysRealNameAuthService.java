package com.bitnei.cloud.report.service;

import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.cloud.report.domain.SysOwnerPeopleEntity;
import com.bitnei.cloud.report.domain.SysRealNameAuthenticationEntity;
import com.bitnei.cloud.service.IBaseService;

import java.util.List;

/**
 * @author cyl or 13718602502@163.com
 */
public interface ISysRealNameAuthService extends IBaseService{

    public SysRealNameAuthenticationEntity selectRealNameVin(String vin);

    public int insertSelective(SysRealNameAuthenticationEntity record);

    public int updateByPrimaryKeySelective(SysRealNameAuthenticationEntity record);

    void refreshRealNameState();

    /**
     * 查询实名认证结果
     * @param sysOwnerPeopleEntity
     * @return
     */
    List<SysRealNameAuthenticationEntity> selectRealNameResult(SysOwnerPeopleEntity sysOwnerPeopleEntity);

    List<String> findByAuthIdAndStatus(String arr);

    AppBean checkInfo(String id);

    /**
     * 根据认证状态查询vin
     * @param authenticationResult
     * @return
     */
    public List<SysRealNameAuthenticationEntity> selectByAuthenticationResult(String authenticationResult);

    public void updateSysRealNameAuthenticationEntityByPrimaryKeySelective(SysRealNameAuthenticationEntity record);
}
