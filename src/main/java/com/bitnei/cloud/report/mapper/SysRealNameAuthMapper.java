package com.bitnei.cloud.report.mapper;

import com.bitnei.cloud.report.domain.SysRealNameAuthenticationEntity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

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
public interface SysRealNameAuthMapper {
    int deleteByPrimaryKey(String id);

    int insert(SysRealNameAuthenticationEntity record);

    int insertSelective(SysRealNameAuthenticationEntity record);

    SysRealNameAuthenticationEntity selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(SysRealNameAuthenticationEntity record);

    int updateByPrimaryKey(SysRealNameAuthenticationEntity record);

    /**
     * 根据VIN获取绑定信息
     * @param vin
     * @return
     */
    SysRealNameAuthenticationEntity selectRealNameVin(String vin);

    /**
     * 判断车辆是否游离
     */
    SysRealNameAuthenticationEntity selectRealNameFreeVeh(String vin);

    /**
     * 获取认证过的企业(个人)信息
     * @param authenticationId
     * @return
     */
    List<SysRealNameAuthenticationEntity> selectRealNameComp(String authenticationId);

    /**
     * 根据状态获取认证信息
     * @param authenticationResult
     * @return
     */
    List<SysRealNameAuthenticationEntity> selectRealNameByType(String authenticationResult);

    /**
     * 获取认证中或者认证通过的车辆
     * @param authenticationId
     * @return
     */
    List<SysRealNameAuthenticationEntity> selectRealName(String authenticationId);

    List<SysRealNameAuthenticationEntity> selectListByAuthId(String authenticationId);

    List<String> findByAuthIdAndStatus(@Param("authenticationId") String authenticationId);

    public List<SysRealNameAuthenticationEntity> selectByAuthenticationResult(String authenticationResult);

    /**
     * 通过id 获取已通过认证的信息
     * @param authenticationId
     * @return
     */
    List<SysRealNameAuthenticationEntity> findAuthInfoByAuthId(String authenticationId);
}