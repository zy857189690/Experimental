package com.bitnei.cloud.common;

/**
 * @author: fanglidong
 * @date: 2018/6/7
 */
public class CommonDataTypeRetrun {

	/**
	 * 充放电状态标识转换为明细说明方法
	 * @param chargeDischargeState
	 * @return
	 */
	public static String findChargeDischargeState(String chargeDischargeState) {
		String name;
		switch (chargeDischargeState){
			case "1":
				name = "停车充电";
				break;
			case "2":
				name = "行驶充电";
				break;
			case "3":
				name = "未充电状态";
				break;
			case "4":
				name = "充电完成";
				break;
			case "254":
				name = "异常";
				break;
			case "255":
				name = "无效";
				break;
			default:
				name = "";
		}
		return name;
	}

	/**
	 * 车辆状态标识转换成车辆状态名称
	 * @param vehState
	 * @return
	 */
	public static String findVehStateName(String vehState) {
		String name;
		switch (vehState) {
			case "1":
				name = "启动";
				break;
			case "2":
				name = "熄火";
				break;
			case "3":
				name = "其他";
				break;
			case "254":
				name = "异常";
				break;
			case "255":
				name = "无效";
				break;
			default:
				name = "";
		}
		return name;
	}
}