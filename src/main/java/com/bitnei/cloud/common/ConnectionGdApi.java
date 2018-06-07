package com.bitnei.cloud.common;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSONObject;
import jodd.cache.Cache;
import jodd.cache.LRUCache;
import org.apache.commons.lang3.math.NumberUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * @author: fanglidong
 * @date: 2018/6/7
 */

@Component
@ConfigurationProperties(prefix = "gdApi")
public class ConnectionGdApi {

	private static final Logger logger = LoggerFactory.getLogger(ConnectionGdApi.class);

	/** 未知定位地址 */
	private static final String UNKNOWN_ADDRESS = "";
	/** 地址信息大小 **/
	private static final int ADDRESS_CACHE_SIZE = 1024*1024*20;
	/** 地址缓存 **/
	private static Cache<String,String> addressCacheService = new LRUCache<>(ADDRESS_CACHE_SIZE);

	private static String webApiUrl;
	private static String webApiKey;

	public static String getWebApiUrl() {
		return webApiUrl;
	}

	public static void setWebApiUrl(String webApiUrl) {
		ConnectionGdApi.webApiUrl = webApiUrl;
	}

	public static String getWebApiKey() {
		return webApiKey;
	}

	public static void setWebApiKey(String webApiKey) {
		ConnectionGdApi.webApiKey = webApiKey;
	}

	/**
	 * 通过坐标查询相应的地址
	 * @param location
	 * @return
	 */
	public static JSONObject queryAreaNameByLnglat(String location) {
		return queryAreaNameByLnglat(location, "", "", "", "", "", "", "", "", "");
	}

	/**
	 * 通过坐标查询地址
	 *
	 * @param location   坐标-必填
	 * @param poitype    返回附近POI类型-非必填
	 * @param radius     搜索半径-非必填、默认1000
	 * @param extensions 返回结果控制-非必填、默认base
	 * @param batch      批量查询控制-非必填、默认false
	 * @param roadlevel  道路等级-非必填
	 * @param sig        数字签名-非必填
	 * @param output     返回数据格式类型-非必填、默认JSON
	 * @param callback   回调函数-非必填
	 * @param homeorcorp 是否优化POI返回顺序-非必填、默认0
	 * @return
	 */
	public static JSONObject queryAreaNameByLnglat(String location, String poitype, String radius, String extensions, String batch, String roadlevel, String sig, String output, String callback, String homeorcorp) {
		if (StringUtils.isEmpty(location)) {
			return null;
		}
		String param = "&location=" + location + "&poitype=" + poitype + "&radius=" + radius + "&extensions=" + extensions + "&batch=" + batch
				+ "&roadlevel=" + roadlevel + "&sig=" + sig + "&output=" + output + "&callback=" + callback + "&homeorcorp=" + homeorcorp;
		return sendGet(getWebApiUrl(), param);
	}

	/**
	 * 请求高德api
	 *
	 * @param baseUrl
	 * @param param
	 * @return
	 */
	public static JSONObject sendGet(String baseUrl, String param) {
		HttpURLConnection connection = null;
		try {
			String connectUrl = baseUrl + "?key=" + getWebApiKey() + param;
			return HttpUtil.httpGet(connectUrl);
		} catch (Exception e) {
			logger.error("捕获异常: " + e);
		}
		return null;
	}

	public static String getAddress(String lng,String lat){

		if (org.springframework.util.StringUtils.isEmpty(lng) || org.springframework.util.StringUtils.isEmpty(lat) || NumberUtils.toDouble(lng,0)==0 ||  NumberUtils.toDouble(lat,0)==0){
			return UNKNOWN_ADDRESS;
		}
		String location = String.format("%s,%s",lng,lat);

		//首先判断缓存中有无信息，如果有，直接从缓存里读取，否则将通过接口去读取
		String address = addressCacheService.get(location);
		if (!StringUtil.isEmpty(address)){
			return address;
		}

		//通过高德API获取地址
		JSONObject result = queryAreaNameByLnglat(location);
		if (null != result && result.get("infocode").toString().equals("10000")) {
			address = JSONObject.parseObject(result.get("regeocode").toString()).get("formatted_address").toString();
			addressCacheService.put(location,address);
			return address;
		}
		else {
			return UNKNOWN_ADDRESS;
		}
	}
}