package com.bitnei.cloud.report.service;

import com.bitnei.commons.datatables.PagerModel;

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

}