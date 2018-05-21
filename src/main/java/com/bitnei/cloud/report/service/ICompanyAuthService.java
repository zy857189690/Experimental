package com.bitnei.cloud.report.service;

import com.bitnei.cloud.report.domain.EnterpriseAuth;
import com.bitnei.cloud.report.domain.SysAuthenticationCompanyTempEntity;
import com.bitnei.cloud.report.domain.SysCustomerUnitEntity;
import com.bitnei.cloud.report.domain.SysRealNameAuthenticationEntity;
import com.bitnei.cloud.service.IBaseService;

import java.util.List;

/**
 * 企业认证service
 * @author chenyl or 13718602502@163.com
 */
public interface ICompanyAuthService extends IBaseService {

    /**
     * 校验准备验证的车辆，T-BOX，SIM卡相关信息
     * 校验失败抛出异常 调用者应当捕获异常获取错误信息
     * @param enterpriseAuth VIN
     * @throws Exception 错误信息 Exception.message();
     */
    void validVehicle(EnterpriseAuth enterpriseAuth) throws Exception;

    /**
     * 企业校验
     * 校验失败抛出异常 调用者应当捕获异常获取错误信息
     * @param sysCustomerUnitEntity 企业信息实体 统一社会信用代码
     * @throws Exception 错误信息 Exception.message();
     */
    void validCustomer(SysCustomerUnitEntity sysCustomerUnitEntity) throws Exception;

    /**
     * 企业实名认证
     * @param enterpriseAuth 车辆信息
     * @param sysCustomerUnitEntity 企业信息
     * @param currentId 当前数据ID 如果为新增 则为null
     * @param authenticationResult 当前数据认证结果 新增则为null
     * @return
     */
    SysRealNameAuthenticationEntity authCustomer(EnterpriseAuth enterpriseAuth,
                                                 SysCustomerUnitEntity sysCustomerUnitEntity,
                                                 String currentId,String authenticationResult,
                                                 String cover) throws Exception;

    /**
     * 针对列表页直接提交而建立的接口
     * 针对未提交的数据的处理
     * 且没有企业信息的情况
     * @param enterpriseAuth
     * @param sysCustomerUnitEntity
     * @return
     * @throws Exception
     */
    SysRealNameAuthenticationEntity authCustomer(SysAuthenticationCompanyTempEntity param,String cover) throws Exception;

    /**
     * 企业认证保存(保存临时数据 不做校验处理)
     * @param sysAuthenticationCompanyTempEntity
     */
    void saveAuthenticationCompanyTemp(SysAuthenticationCompanyTempEntity sysAuthenticationCompanyTempEntity);


    /**
     * 企业车辆绑定
     * @param enterpriseAuth 车辆信息
     * @param sysCustomerUnitEntity 企业ID
     * @throws Exception 错误信息 Exception.message();
     */
    SysRealNameAuthenticationEntity bindCar(EnterpriseAuth enterpriseAuth, SysCustomerUnitEntity sysCustomerUnitEntity) throws Exception;

    /**
     * 通过simid查询数据
     * @param id
     * @return
     */
    EnterpriseAuth findBySimCardId(String id);
    /**
     * 批量实名认证
     * @param sysCustomerUnitEntity
     * @param enterpriseAuths
     */
    void authCustomerAll(SysCustomerUnitEntity sysCustomerUnitEntity, List<EnterpriseAuth> enterpriseAuths) throws Exception;

    /**
     * 批量实名认证 保存
     * @param sysCustomerUnitEntity
     * @param enterpriseAuths
     */
    void authCustomerAllSave(SysCustomerUnitEntity sysCustomerUnitEntity, List<EnterpriseAuth> enterpriseAuths);
}
