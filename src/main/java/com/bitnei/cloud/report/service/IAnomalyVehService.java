package com.bitnei.cloud.report.service;

import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;

/**
 * @author: fanglidong
 * @date: 2018/6/13
 */
public interface IAnomalyVehService {

	/**
	 * 分页查询
	 * @return
	 */
	PagerModel pageQuery();

	/**
	 * 导出
	 */
	void export();

	/**
	 * 导入查询
	 * @param file
	 * @param identity
	 * @return
	 * @throws Exception
	 */
	AppBean importQuery(HttpServletRequest request, MultipartFile file, String identity) throws Exception;

	/**
	 * 查询异常记录详情
	 * @param vin
	 * @param type
	 * @return
	 */
	PagerModel recordDatagrid(String vin,String type);
}