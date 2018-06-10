package com.bitnei.cloud.report.service.impl;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.common.CommonDataTypeRetrun;
import com.bitnei.cloud.common.ConnectionGdApi;
import com.bitnei.cloud.common.ExcelUtil;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.RequestContext;

import java.util.ArrayList;
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
		PagerModel pm = findPagerModel("pagerModel",options);
		List<Map> list = pm.getRows();
		this.cyclicData(list);
		return pm;
	}

	@Override
	public void export() {

		List list = findBySqlId("pagerModel",ServletUtil.getQueryParams());
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
	public AppBean importQuery(MultipartFile file, String identity) throws Exception{
		AppBean appBean = new AppBean();
		List<Map> lisVin  =  ExcelUtil.getVehicleInformation(file);
		if (lisVin.size() == 0) {
			return new AppBean(-1, "文件内容不能为空！");
		}

		DataGridOptions options = ServletUtil.getDataLayOptions();

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
		if (vinList.size() > 0 || licensePlateList.size() > 0 ) {
			options.getParams().put("vinList",vinList);
			sign = true;
		}

		if (licensePlateList.size() > 0 ) {
			options.getParams().put("licensePlateList", licensePlateList);
			sign = true;
		}

		if (sign) {
			options.getParams().put("identity", identity);
		}

		PagerModel pm = findPagerModel("pagerModel",options);
		List<Map> list = pm.getRows();
		this.cyclicData(list);
		appBean.setMessage(JSONObject.toJSONString(pm));
		return appBean;
	}

	@Override
	public void importExport(MultipartFile file, String identity) throws Exception{

		DataGridOptions options = ServletUtil.getDataLayOptions();
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
		if (vinList.size() > 0 || licensePlateList.size() > 0 ) {
			options.getParams().put("vinList",vinList);
			sign = true;
		}

		if (licensePlateList.size() > 0 ) {
			options.getParams().put("licensePlateList", licensePlateList);
			sign = true;
		}

		if (sign) {
			options.getParams().put("identity", identity);
		}

		List list = findBySqlId("pagerModel",ServletUtil.getQueryParams());
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