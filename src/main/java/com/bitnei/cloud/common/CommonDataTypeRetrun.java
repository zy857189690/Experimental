/*
package com.bitnei.cloud.common;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

*/
/**
 * @author: fanglidong
 * @date: 2018/6/7
 *//*

public class CommonDataTypeRetrun {

	*/
/**
	 * 充放电状态标识转换为明细说明方法
	 * @param chargeDischargeState
	 * @return
	 *//*

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

	*/
/**
	 * 车辆状态标识转换成车辆状态名称
	 * @param vehState
	 * @return
	 *//*

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


	*/
/**
	 * 循环返回数据中的数据，处理位置/充电状态信息
	 * @param list
	 * @param type
	 * @return
	 *//*

	public static List cyclicData(List list, String type){
		List newList = new ArrayList<>();
		//type--4 为时间异常详细，其他异常类型取值Hbase中
		if ("4".equals(type)) {
			for (Object object : list) {
				Map<String, String> mapTemp = (Map<String, String>) object;
				Object mapObject = mapTemp.get("lngLat");
				if (mapObject != null&&!mapObject.equals("")) {
					String[] arrays = String.valueOf(mapObject).split(",");
					//处理位置问题
					String lng = arrays[0];
					String lat = arrays[1];
					String address = ConnectionGdApi.getAddress(lng, lat);
					mapTemp.put("location", address);
				}
			}
			newList = list;
		} else {
			for (Object object : list){
				AbnormalDetail abnormalDetail = (AbnormalDetail) object;
				Map<String, String> map = new HashMap<>();
				String lng = abnormalDetail.getLon();
				String lat = abnormalDetail.getLat();
				String address = ConnectionGdApi.getAddress(lng,lat);
				map.put("location", address);
				map.put("reportDate", DateUtil.formatTime(DateUtil.strToDate_ex(abnormalDetail.getUploadTime()), DateUtil.FULL_ST_FORMAT));
				newList.add(map);
			}
		}
		return newList;
	}

	*/
/**
	 * 返回异常Excel Title 名
	 * @param type
	 * @return
	 *//*

	public static String returnTitle(String type){
		String name;
		//1：速度，2：里程，3：经纬度，4：时间，5：电压，6：电流，7： soc
		switch (type) {
			case "1":
				name = "速度异常车辆统计";
				break;
			case "2":
				name = "里程异常车辆统计";
				break;
			case "3":
				name = "经纬度异常车辆统计";
				break;
			case "4":
				name = "时间异常车辆统计";
				break;
			case "5":
				name = "电压异常车辆统计";
				break;
			case "6":
				name = "电流异常车辆统计";
				break;
			case "7":
				name = "soc异常车辆统计";
				break;
			default:
				name = "null";
		}
		return name;
	}
}*/
