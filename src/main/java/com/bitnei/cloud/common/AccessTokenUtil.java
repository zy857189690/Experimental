package com.bitnei.cloud.common;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.common.pojo.ParamEntity;
import com.bitnei.cloud.common.pojo.UnicomURL;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * 获取acessToken工具
 * @author: fanglidong
 * @date: 2018/3/16
 */
@Component
public class AccessTokenUtil {

	private static Logger logger = LoggerFactory.getLogger(AccessTokenUtil.class);
	private String accessToken;
	@Autowired
	private RedisUtil redisUtil;

	/**
	 * 获取token值
	 * 从redis获取token值，如果不为空返回token值
	 * @return
	 */
	public String getAccessToken() {
		accessToken = (String) redisUtil.get(UnicomURL.getAccessToken());
		if (!StringUtils.isEmpty(accessToken)) {
			return accessToken;
		} else {
			accessToken = this.LoopGetAccessToken(0);
			return accessToken;
		}
	}

	/**
	 * 如果token值为空，则重新再联通接口获取，并存入到redis中设置时间为24时；
	 * @return
	 */
	public String LoopGetAccessToken(int loopSign) {
		accessToken = this.getAccessTokenByUnicom();
		if (!StringUtils.isEmpty(accessToken)) {
			redisUtil.set(UnicomURL.getAccessToken(), accessToken, 86400L);
		} else {
			while (loopSign < 2) {
				loopSign++;
				LoopGetAccessToken(loopSign);
			}
			logger.error("======请求token值次数大于三次");
			return null;
		}
		return accessToken;
	}

	/**
	 * 通过联通接口获取Token
	 * @return
	 */
	private String getAccessTokenByUnicom() {
		//组装request_data参数数据项
		JSONObject requestDataBody = new JSONObject();
		requestDataBody.put("username", UnicomURL.getName());
		requestDataBody.put("password", UnicomURL.getPassword());
		ParamEntity paramEntity = new ParamEntity(UnicomURL.getVerifyLogin(), "string", requestDataBody);

		logger.debug("======联通请求token参数======" + JSONObject.toJSON(paramEntity).toString());
		JSONObject jsonObjectResult = HttpUtil.unicomHttpUrl(JSONObject.toJSON(paramEntity).toString());
		logger.debug("======联通请求token返回数据======" + jsonObjectResult);

		if (jsonObjectResult != null) {
			String retCode = jsonObjectResult.getString("ret_code");
			if ("0".equals(retCode)) {
				JSONObject responseDataJson = jsonObjectResult.getJSONObject("response_data");
				if (responseDataJson != null) {
					accessToken = responseDataJson.getString("token");
					if (!StringUtils.isEmpty(accessToken)) {
						return accessToken;
					}
				}
			}
		}
		return null;
	}

}