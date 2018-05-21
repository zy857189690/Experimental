package com.bitnei.cloud.report.service;

import com.bitnei.cloud.report.domain.EnterpriseAuth;
import com.bitnei.cloud.report.domain.SysOwnerPeopleEntity;
import com.bitnei.cloud.report.domain.SysRealNameAuthenticationEntity;
import com.bitnei.cloud.service.IBaseService;
import com.bitnei.commons.datatables.PagerModel;

import java.util.List;

public interface IPeopleAuthService extends IBaseService {


    /**
     * 分页查询
     * @return
     */
    PagerModel pageQuery();

    /**
     * 个人实名认证
     * @param cover
     * @param enterpriseAuth
     * @param sysOwnerPeopleEntity
     */
    SysRealNameAuthenticationEntity authPersonal(String cover, EnterpriseAuth enterpriseAuth, SysOwnerPeopleEntity sysOwnerPeopleEntity);

    /**
     * 个人车辆绑定
     * @param cover
     * @param enterpriseAuth
     * @param sysOwnerPeopleEntity
     */
    void savePersonalBinding(String cover,EnterpriseAuth enterpriseAuth, SysOwnerPeopleEntity sysOwnerPeopleEntity);

    /**
     * 个人信息校验
     * @param sysOwnerPeopleEntity
     * @throws Exception 错误信息 Exception.message();
     */
    void validPersonal(SysOwnerPeopleEntity sysOwnerPeopleEntity) throws Exception;

    /**
     * 车辆信息校验
     * @param enterpriseAuth
     * @throws Exception 错误信息 Exception.message();
     */
    void validVehicle(EnterpriseAuth enterpriseAuth) throws Exception;

    List<SysRealNameAuthenticationEntity> checkAuthInfo(String id);

    /**
     * 导出
     */
    void export();


    /**
     * 修改个人实名认证
     * @param enterpriseAuth
     * @param sysOwnerPeopleEntity
     */
    void updatePeopleAuth(EnterpriseAuth enterpriseAuth,SysOwnerPeopleEntity sysOwnerPeopleEntity) throws Exception;


    /**
     * 页面提交
     * @param id
     */
    void submitPeopleAuth(String id,String cover);

    /**
     *根据证件号查询个人信息
     * @param id
     */
     SysOwnerPeopleEntity selectByOwnerCert(String id);

}