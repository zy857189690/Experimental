package com.bitnei.cloud.common.pojo;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 联通数据项数据
 * @author: fanglidong
 * @date: 2018/3/16
 */
@Component
@ConfigurationProperties(prefix = "unicom",locations = "classpath:/unicom.yml")
public class UnicomURL {

	/**
	 * 用户名
	 */
	private static String name;

	/**
	 * 密码
	 */
	private static String password;

	/**
	 * redis中accessToken值中的key
	 */
	private static String accessToken;

	/**
	 * 请求联通接口公共URL部分
	 */
	private static String commonURL;

	/**
	 * 发起方标识
	 */
	private static String identification;

	/**
	 * 获取Token接口服务名称
	 */
	private static String verifyLogin;

	/**
	 * 认证结果查询接口服务名称
	 */
	private static String queryRealName;

	/**
	 * 更换T-Box接口服务名称
	 */
	private static String changeTbox;

	/**
	 * 个人实名认证接口服务名称
	 */
	private static String personalRealNameReg;

	/**
	 * 企业实名认证接口服务名称
	 */
	private static String enterpriseRealNameReg;

	/**
	 * 个人车辆绑定接口服务名称
	 */
	private static String personalBindVehicle;

	/**
	 * 企业车辆绑定接口服务名称
	 */
	private static String enterpriseBindVehicle;

	/**
	 * 车辆批量同步实时接口服务名称
	 */
	private static String syncVehicle;

	/**
	 * 企业批量实名认证接口服务名称
	 */
	private static String enterpriseBatchRealNameReg;

	/**
	 * 车辆企业编码
	 */
	private static String vehicleCompanyBrandCode;

	public static String getName() {
		return name;
	}

	public static void setName(String name) {
		UnicomURL.name = name;
	}

	public static String getPassword() {
		return password;
	}

	public static void setPassword(String password) {
		UnicomURL.password = password;
	}

	public static String getAccessToken() {
		return accessToken;
	}

	public static void setAccessToken(String accessToken) {
		UnicomURL.accessToken = accessToken;
	}

	public static String getIdentification() {
		return identification;
	}

	public static void setIdentification(String identification) {
		UnicomURL.identification = identification;
	}

	public static String getVerifyLogin() {
		return verifyLogin;
	}

	public static void setVerifyLogin(String verifyLogin) {
		UnicomURL.verifyLogin = verifyLogin;
	}

	public static String getCommonURL() {
		return commonURL;
	}

	public static void setCommonURL(String commonURL) {
		UnicomURL.commonURL = commonURL;
	}

	public static String getQueryRealName() {
		return queryRealName;
	}

	public static void setQueryRealName(String queryRealName) {
		UnicomURL.queryRealName = queryRealName;
	}

	public static String getChangeTbox() {
		return changeTbox;
	}

	public static void setChangeTbox(String changeTbox) {
		UnicomURL.changeTbox = changeTbox;
	}

	public static String getPersonalRealNameReg() {
		return personalRealNameReg;
	}

	public static void setPersonalRealNameReg(String personalRealNameReg) {
		UnicomURL.personalRealNameReg = personalRealNameReg;
	}

	public static String getEnterpriseRealNameReg() {
		return enterpriseRealNameReg;
	}

	public static void setEnterpriseRealNameReg(String enterpriseRealNameReg) {
		UnicomURL.enterpriseRealNameReg = enterpriseRealNameReg;
	}

	public static String getPersonalBindVehicle() {
		return personalBindVehicle;
	}

	public static void setPersonalBindVehicle(String personalBindVehicle) {
		UnicomURL.personalBindVehicle = personalBindVehicle;
	}

	public static String getEnterpriseBindVehicle() {
		return enterpriseBindVehicle;
	}

	public static void setEnterpriseBindVehicle(String enterpriseBindVehicle) {
		UnicomURL.enterpriseBindVehicle = enterpriseBindVehicle;
	}

	public static String getSyncVehicle() {
		return syncVehicle;
	}

	public static void setSyncVehicle(String syncVehicle) {
		UnicomURL.syncVehicle = syncVehicle;
	}

	public static String getEnterpriseBatchRealNameReg() {
		return enterpriseBatchRealNameReg;
	}

	public static void setEnterpriseBatchRealNameReg(String enterpriseBatchRealNameReg) {
		UnicomURL.enterpriseBatchRealNameReg = enterpriseBatchRealNameReg;
	}

	public static String getVehicleCompanyBrandCode() {
		return vehicleCompanyBrandCode;
	}

	public static void setVehicleCompanyBrandCode(String vehicleCompanyBrandCode) {
		UnicomURL.vehicleCompanyBrandCode = vehicleCompanyBrandCode;
	}
}