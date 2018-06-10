package com.bitnei.cloud.report.service;

import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.web.multipart.MultipartFile;

/**
 * 车辆历史状态统计servive接口
 * @author: fanglidong
 * @date: 2018/6/4
 */
public interface IVehHistoryService {

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
	AppBean importQuery(MultipartFile file, String identity) throws Exception;

	/**
	 * 导入查询导出
	 */
	void importExport(MultipartFile file, String identity) throws Exception;

}