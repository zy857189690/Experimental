package com.bitnei.cloud.common.pojo;

import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.common.util.DateUtil;

import java.util.Date;

/**
 * 请求参数实体
 * @author: fanglidong
 * @date: 2018/3/17
 */
public class ParamEntity {

	/**
	 * 交易号/序列号(序列号：yyyymmddhh24missSSS+发起方标识+7位随机数)--必填
	 */
	private String serial_number;

	/**
	 * 请求时间戳(格式为yyyy-mm-dd hh:24mi:ss 例如2017-08-28 10:51:22)--必填
	 */
	private String timestamp;

	/**
	 * 返回数据格式：json--必填
	 */
	private String ret_type;

	/**
	 * 调用接口服务名称--必填
	 */
	private String service_name;

	/**
	 * 发起平台类型(默认值:CUNT)--非必填
	 */
	private String platform_type;

	/**
	 * 令牌--必填
	 */
	private String token;

	/**
	 * 业务请求参数--必填
	 */
	private JSONObject request_data;

	public ParamEntity() {}

	public ParamEntity(String service_name,String token, JSONObject request_data) {
		this.serial_number = this.combinationSerialNumber();
		this.timestamp = this.formatTimestamp();
		this.ret_type = "json";
		this.service_name = service_name;
		this.platform_type = "CUNT";
		this.token = token;
		this.request_data = request_data;
	}

	public String getSerial_number() {
		return serial_number;
	}

	public void setSerial_number(String serial_number) {
		this.serial_number = serial_number;
	}

	public String getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}

	public String getRet_type() {
		return ret_type;
	}

	public void setRet_type(String ret_type) {
		this.ret_type = ret_type;
	}

	public String getService_name() {
		return service_name;
	}

	public void setService_name(String service_name) {
		this.service_name = service_name;
	}

	public String getPlatform_type() {
		return platform_type;
	}

	public void setPlatform_type(String platform_type) {
		this.platform_type = platform_type;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public JSONObject getRequest_data() {
		return request_data;
	}

	public void setRequest_data(JSONObject request_data) {
		this.request_data = request_data;
	}

	private String combinationSerialNumber(){
		String dataTime = DateUtil.formatTime(new Date(), "yyyyMMddHHmmssSSS");
		Integer randomNumber = (int)(Math.random() * 9 + 1) * 1000000;
		return dataTime + UnicomURL.getIdentification() + randomNumber;
	}

	private String formatTimestamp(){
		return DateUtil.getNow();
	}
}