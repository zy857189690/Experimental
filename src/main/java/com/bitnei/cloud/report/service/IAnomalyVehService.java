package com.bitnei.cloud.report.service;

import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

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
	 * 查询时间异常详情记录
	 * @param vid
	 * @param vin
	 * @param type
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	List pageQueryTimeException(String vid, String vin, String type, String startTime, String endTime);

	/**
	 *  时间异常导出
	 * @param vid
	 * @param vin
	 * @param type
	 * @param startTime
	 * @param endTime
	 */
	void exceptionExport(String vid,String vin,String licensePlate,String type, String startTime, String endTime) throws Exception;

}