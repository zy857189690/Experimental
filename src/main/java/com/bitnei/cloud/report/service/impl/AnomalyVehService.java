package com.bitnei.cloud.report.service.impl;

import com.alibaba.druid.util.StringUtils;
import com.bitnei.cloud.common.ExcelUtil;
import com.bitnei.cloud.common.MemCacheManager;
import com.bitnei.cloud.common.PublicDealUtil;
import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.cloud.common.bean.ExcelData;
import com.bitnei.cloud.common.util.DataLoader;
import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.common.util.EasyExcel;
import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.service.IAnomalyVehService;
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
 * 异常车辆统计
 * @author: fanglidong
 * @date: 2018/6/13
 */
@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.AnomalyVehMapper" )
public class AnomalyVehService extends BaseService implements IAnomalyVehService {

	@Override
	public PagerModel pageQuery() {
		DataGridOptions options = ServletUtil.getDataLayOptions();
		//添加用户信息
		options.setParams(PublicDealUtil.bulidUserForParams(options.getParams()));
		Object identityObject = options.getParams().get("identity");
		if (identityObject != null && "identity".equals(String.valueOf(identityObject))) {
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			Map tempMap = (Map) MemCacheManager.getInstance().get(request.getSession().getId() + "vehAnomalyState");
			options.getParams().putAll(tempMap);
		}
		PagerModel pm = findPagerModel("pagerModel", options);
		return pm;
	}

	@Override
	public void export() {
		Map<String, Object> map = PublicDealUtil.bulidUserForParams(ServletUtil.getQueryParams());

		//判断是否导入查询导出，读取缓存中的数据，查询
		Object flag = map.get("adminFlag");
		if (flag != null && "1".equals(flag)) {
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			Map tempMap = (Map) MemCacheManager.getInstance().get(request.getSession().getId() + "vehAnomalyState");
			map.putAll(tempMap);
		}
		List list = findBySqlId("pagerModel", map);
		DataLoader.loadNames(list);
		DataLoader.loadDictNames(list);

		String srcBase = RequestContext.class.getResource("/templates/").getFile();
		String srcFile = srcBase +"module/report/anomaly/anomalyVeh/export.xls";

		ExcelData ed = new ExcelData();
		ed.setTitle("异常车辆统计");
		ed.setExportTime(DateUtil.getNow());
		ed.setData(list);
		String outName = String.format("%s-导出-%s.xls", "异常车辆统计", DateUtil.getNow());
		EasyExcel.renderResponse(srcFile,outName,ed);
	}

	@Override
	public AppBean importQuery(HttpServletRequest request, MultipartFile file, String identity) throws Exception {
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
		MemCacheManager.getInstance().remove(session.getId() + "vehAnomalyState");
		//添加缓存的车辆信息
		MemCacheManager.getInstance().set(session.getId() + "vehAnomalyState", tempMap);

		return appBean;
	}

}