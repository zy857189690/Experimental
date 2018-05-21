package com.bitnei.cloud.common;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.common.pojo.ParamEntity;
import com.bitnei.cloud.common.pojo.UnicomURL;
import jodd.http.HttpRequest;
import jodd.http.HttpResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * http 请求工具类
 * @author: fanglidong
 * @date: 2018/3/16
 */
public class HttpUtil {

	private static Logger logger = LoggerFactory.getLogger(HttpUtil.class);

	/**
	 * 封装请求联通接口POST方法
	 * @param serviceName 服务标识
	 * @param requestData 组装的request_data数据
	 * @return
	 */
	public static JSONObject unicomHttpUrlByParam(String serviceName, JSONObject requestData){
		if (StringUtils.isEmpty(serviceName) || requestData == null) {
			return null;
		}
		AccessTokenUtil accessTokenUtil = SpringUtil.getBean(AccessTokenUtil.class);
		String accessToken = accessTokenUtil.getAccessToken();
		ParamEntity paramEntity = new ParamEntity(serviceName,accessToken , requestData);

		logger.debug("======请求联通接口参数======" + JSONObject.toJSON(paramEntity).toString());
		JSONObject jsonObjectResult = HttpUtil.unicomHttpUrl(JSONObject.toJSON(paramEntity).toString());
		logger.debug("======请求联通接口返回数据======" + jsonObjectResult);
		if (jsonObjectResult != null) {
			String retCode = jsonObjectResult.getString("ret_code");

			/*
			 * (1)若ret_code为10E000029，表示token已过期，请先登录;
			 * (2)重新调取获取accessToken值的方法;
			 * (3)再次重新调取自身请求方法;
			 */
			if (!StringUtils.isEmpty(retCode) && "10E000029".equals(retCode)) {
				accessTokenUtil.LoopGetAccessToken(0);
				return unicomHttpUrlByParam(serviceName,requestData);
			}
			return jsonObjectResult;
		}
		return null;
	}

	/**
	 * 拼装POST调用联通地址URL
	 * @param param 请求参数
	 * @return
	 */
	public static JSONObject unicomHttpUrl(String param) {
		return httpPost(UnicomURL.getCommonURL(), param);
	}

	/**
	 * POST请求方法（jodd）
	 * @param url
	 * @param param
	 * @return
	 */
	private static JSONObject httpPost(String url,String param) {
		JSONObject jsonResult = null;
		HttpRequest httpRequest = HttpRequest.post(url).bodyText(param,"application/json","UTF-8");
		HttpResponse httpResponse = httpRequest.send();
		if (httpResponse.statusCode() == 200) {
			String str;
			str = httpResponse.charset("UTF-8").bodyText();
			if (StringUtils.isEmpty(str)) {
				return null;
			}
			jsonResult = JSONObject.parseObject(str);
		}
		return jsonResult;
	}


}