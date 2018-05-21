package com.bitnei.cloud.common;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSONObject;
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