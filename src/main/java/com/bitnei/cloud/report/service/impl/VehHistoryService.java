package com.bitnei.cloud.report.service.impl;

import com.alibaba.druid.util.StringUtils;
import com.bitnei.cloud.common.*;
import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.cloud.common.bean.ExcelData;
import com.bitnei.cloud.common.util.DataLoader;
import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.common.util.EasyExcel;
import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.service.IVehHistoryService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.RequestContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 车辆历史状态统计servive
 * @author: fanglidong
 * @date: 2018/6/4
 */
@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.VehHistoryMapper" )
public class VehHistoryService extends BaseService implements IVehHistoryService {

	@Override
	public PagerModel pageQuery() {

		DataGridOptions options = ServletUtil.getDataLayOptions();
		//添加用户信息
		options.setParams(PublicDealUtil.bulidUserForParams(options.getParams()));
		Object identityObject = options.getParams().get("identity");
		if (identityObject != null && "identity".equals(String.valueOf(identityObject))) {
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			Map tempMap = (Map)MemCacheManager.getInstance().get(request.getSession().getId() + "vehHistoryState");
			options.getParams().putAll(tempMap);
		}
		PagerModel pm = findPagerModel("pagerModel",options);
		List<Map> list = pm.getRows();
		this.cyclicData(list);
		return pm;
	}

	@Override
	public void export() {

		List list = findBySqlId("pagerModel", PublicDealUtil.bulidUserForParams(ServletUtil.getQueryParams()));
		this.cyclicData(list);
		DataLoader.loadNames(list);
		DataLoader.loadDictNames(list);

		String srcBase = RequestContext.class.getResource("/templates/").getFile();
		String srcFile = srcBase +"module/report/workCondition/vehHistory/export.xls";

		ExcelData ed = new ExcelData();
		ed.setTitle("车辆历史状态报表");
		ed.setExportTime(DateUtil.getNow());
		ed.setData(list);
		String outName = String.format("%s-导出-%s.xls", "车辆历史状态报表", DateUtil.getNow());
		EasyExcel.renderResponse(srcFile,outName,ed);
	}

	@Override
	public AppBean importQuery(HttpServletRequest request, MultipartFile file, String identity) throws Exception{
		AppBean appBean = new AppBean();
		List<Map> lisVin  =  ExcelUtil.getVehicleInformation(file);
		if (lisVin.size() == 0) {
			return new AppBean(-1, "文件内容不能为空！");
		}

		//循环处理VIN、车牌号
		List<String> vinList = new ArrayList<>();
		List<String> licensePlateList = new ArrayList<>();
		for (Map<String, String> map : lisVin) {
			String vin = map.get("vin");
			if (!StringUtils.isEmpty(vin)) {
				vinList.add(vin);
				continue;
			}
			String licensePlate = map.get("lic");
			if (!StringUtils.isEmpty(licensePlate)) {
				licensePlateList.add(licensePlate);
			}
		}
		Map<String, Object> tempMap = new HashMap<>();
		boolean sign = false;
		if (vinList.size() > 0) {
			tempMap.put("vinList",vinList);
			sign = true;
		}

		if (licensePlateList.size() > 0 ) {
			tempMap.put("licensePlateList", licensePlateList);
			sign = true;
		}

		if (sign) {
			tempMap.put("identity", identity);
		}

		HttpSession session = request.getSession();
		//清空缓存车辆信息
		MemCacheManager.getInstance().remove(session.getId() + "vehHistoryState");
		//添加缓存的车辆信息
		MemCacheManager.getInstance().set(session.getId() + "vehHistoryState", tempMap);

		return appBean;
	}

	@Override
	public void importExport(MultipartFile file, String identity) throws Exception{

		Map<String,Object> options = PublicDealUtil.bulidUserForParams(ServletUtil.getQueryParams());
		List<Map> lisVin  =  ExcelUtil.getVehicleInformation(file);

		//循环处理VIN、车牌号
		List<String> vinList = new ArrayList<>();
		List<String> licensePlateList = new ArrayList<>();

		for (Map<String, String> map : lisVin) {
			String vin = map.get("vin");
			if (!StringUtils.isEmpty(vin)) {
				vinList.add(vin);
				continue;
			}
			String licensePlate = map.get("lic");
			if (!StringUtils.isEmpty(licensePlate)) {
				licensePlateList.add(licensePlate);
			}
		}

		boolean sign = false;
		if (vinList.size() > 0) {
			options.put("vinList",vinList);
			sign = true;
		}

		if (licensePlateList.size() > 0 ) {
			options.put("licensePlateList", licensePlateList);
			sign = true;
		}

		if (sign) {
			options.put("identity", identity);
		}

		List list = findBySqlId("pagerModel",options);
		this.cyclicData(list);
		DataLoader.loadNames(list);
		DataLoader.loadDictNames(list);

		String srcBase = RequestContext.class.getResource("/templates/").getFile();
		String srcFile = srcBase +"module/report/workCondition/vehHistory/export.xls";

		ExcelData ed = new ExcelData();
		ed.setTitle("车辆历史状态报表");
		ed.setExportTime(DateUtil.getNow());
		ed.setData(list);
		String outName = String.format("%s-导出-%s.xls", "车辆历史状态报表", DateUtil.getNow());
		EasyExcel.renderResponse(srcFile,outName,ed);
	}

	/**
	 * 循环返回数据中的数据，处理位置/充电状态信息
	 * @param list
	 */
	private void cyclicData(List<Map> list){

		for (Map<String, String> map : list) {

			//处理位置问题
			String lng = String.valueOf(map.get("lng"));
			String lat = String.valueOf(map.get("lat"));
			String address = ConnectionGdApi.getAddress(lng,lat);
			map.put("location", address);

			//处理充放电状态chargeDischargeStateName
			String chargeDischargeState = String.valueOf(map.get("chargeDischargeState"));
			String chargeDischargeStateName = CommonDataTypeRetrun.findChargeDischargeState(chargeDischargeState);
			map.put("chargeDischargeStateName", chargeDischargeStateName);

			//车辆状态名称
			String vehState = String.valueOf(map.get("vehState"));
			String vehStateName = CommonDataTypeRetrun.findVehStateName(vehState);
			map.put("vehStateName", vehStateName);
		}
	}
}