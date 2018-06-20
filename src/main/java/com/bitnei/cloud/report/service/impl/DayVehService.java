package com.bitnei.cloud.report.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.App;
import com.bitnei.cloud.common.MemCacheManager;
import com.bitnei.cloud.common.PublicDealUtil;
import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.cloud.common.bean.ExcelData;
import com.bitnei.cloud.common.util.DataLoader;
import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.common.util.EasyExcel;
import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.DayVehInfo;
import com.bitnei.cloud.report.service.IDayVehService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import com.github.pagehelper.PageRowBounds;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContext;
import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.common.ExcelUtil;
import com.bitnei.cloud.common.bean.AppBean;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.DayVehMapper")
public class DayVehService extends BaseService implements IDayVehService {
    @Override
    public String queryVehTypeList() {
        List<Map<String, Object>> list = findBySqlId("queryVehTypeList", null);
        if (null != list && list.size() > 0) {
            Map<String, Object> rMap = new HashMap<String, Object>();
            rMap.put("id", "0");
            rMap.put("text", "全部");
            rMap.put("parent_id", "-1");
            rMap.put("state", "open");
            rMap.put("children", PublicDealUtil.initTreeDate(list, rMap.get("id").toString()));
            return "[" + JSONObject.toJSONString(rMap) + "]";
        }
        return null;
    }

    /**
     * 查询车辆型号下拉列表
     * @return
     */
    @Override
    public String queryVehModelList() {
        List<Map<String, Object>> list = findBySqlId("queryVehModelList", null);
        return JSONObject.toJSONString(list);
    }

    /**
     * 查询区域列表
     *
     * @return
     */
    @Override
    public String queryAreaList() {
        List<Map<String, Object>> list = findBySqlId("queryAreaList", null);
        if (null != list && list.size() > 0) {
            Map<String, Object> rMap = list.get(0);
            rMap.put("children", PublicDealUtil.initTreeDate(list, rMap.get("id").toString()));
            rMap.put("state", "open");
            return "[" + JSONObject.toJSONString(rMap) + "]";
        }
        return null;
    }

    /**
     * 查询单位树形下拉列表
     * @return
     */
    @Override
    public String queryUnitList() {
        List<Map<String, Object>> list = findBySqlId("queryUnitList", null);
        if (null != list && list.size() > 0) {
            Map<String, Object> rMap = list.get(0);
            rMap.put("children", PublicDealUtil.initTreeDate(list, rMap.get("id").toString()));
            rMap.put("state", "open");
            return "[" + JSONObject.toJSONString(rMap) + "]";
        }
        return null;
    }

    @Override
//    public PagerModel pageQuery() {
//
//        DataGridOptions options = ServletUtil.getDataLayOptions();
//        //加用户信息（权限）
//        options.setParams(PublicDealUtil.bulidUserForParams(options.getParams()));
//        // 判断是条件查询还是导入查询
//        PagerModel pm = null;
//        if("0".equals(options.getParams().get("adminFlag"))){
//            pm = findPagerModel("pagerModel",options);
//        }else {
//            /**
//             * 从缓存中获取excel车辆数据放入options中。
//             */
//            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
//            List<Map> lisVin = (List<Map>) MemCacheManager.getInstance().get(request.getSession().getId() + "InstantVeh");
//            //循环处理VIN、车牌号
//            List<String> vinList = new ArrayList<>();
//            List<String> licensePlateList = new ArrayList<>();
//            for (Map<String, String> map : lisVin) {
//                String vin = map.get("vin");
//                if (!StringUtils.isEmpty(vin)) {
//                    vinList.add(vin);
//                    continue;
//                }
//                String licensePlate = map.get("lic");
//                if (!StringUtils.isEmpty(licensePlate)) {
//                    licensePlateList.add(licensePlate);
//                }
//            }
//            boolean sign = false;
//            if (vinList.size() > 0 ) {
//                options.getParams().put("vinList",vinList);
//                sign = true;
//            }
//
//            if (licensePlateList.size() > 0 ) {
//                options.getParams().put("licensePlateList", licensePlateList);
//                sign = true;
//            }
//
//            if (sign) {
//                options.getParams().put("identity", "importType");
//            }
//            pm = findPagerModel("pagerModel",options);
//        }
//        return pm;
//    }
    public PagerModel pageQuery() {
        DataGridOptions options = ServletUtil.getDataLayOptions();
        //添加用户信息
        options.setParams(PublicDealUtil.bulidUserForParams(options.getParams()));
        Object identityObject = options.getParams().get("identity");
        if (identityObject != null && "identity".equals(String.valueOf(identityObject))) {
            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
            Map tempMap = (Map)MemCacheManager.getInstance().get(request.getSession().getId() + "InstantVeh");
            options.getParams().putAll(tempMap);
        }
        PagerModel pm = findPagerModel("pagerModel",options);
        List<Map> list = pm.getRows();
        return pm;
    }

    @Override
    public void export() {

        List list = findBySqlId("pagerModel",PublicDealUtil.bulidUserForParams(ServletUtil.getQueryParams()));
        DataLoader.loadNames(list);
        DataLoader.loadDictNames(list);

        String srcBase = RequestContext.class.getResource("/templates/").getFile();
        String srcFile = srcBase +"module/report/workCondition/dayVeh/export.xls";

        ExcelData ed = new ExcelData();
        ed.setTitle("单车日报");
        ed.setExportTime(DateUtil.getNow());
        ed.setData(list);
        String outName = String.format("%s-导出-%s.xls", "单车日报", DateUtil.getShortDate());
        EasyExcel.renderResponse(srcFile,outName,ed);

    }

    @Override
    public AppBean importQuery(MultipartFile file, String identity) throws Exception{
        AppBean appBean = new AppBean();
        List<Map> lisVin  =  ExcelUtil.getVehicleInformation(file);//获取excel中车辆的信息数
        if (lisVin.size() == 0) {
            return new AppBean(-1, "文件内容不能为空！");
        }

        DataGridOptions options = ServletUtil.getDataLayOptions();
        //加用户信息（权限）
        options.setParams(PublicDealUtil.bulidUserForParams(options.getParams()));

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
        if (vinList.size() > 0 ) {
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
        /**
         * list中存放的就是导入文件查询到的许多辆车辆的信息
         * 这个list可以先条件查询后，再合并导入条件查询。
         */
        List<Map> list = pm.getRows();
        //this.cyclicData(list);
        appBean.setMessage(JSONObject.toJSONString(pm));
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
        if (vinList.size() > 0 ) {
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
        /**
         * list返回的仍然是按条件查询的数据
         */
        List list = findBySqlId("pagerModel",options);
        //PagerModel pm = findPagerModel("pagerModel",options);
        //ArrayList list = new ArrayList();
        //List<Map> listMap = pm.getRows();
        //list.addAll(listMap);
        //this.cyclicData(list);
        DataLoader.loadNames(list);
        DataLoader.loadDictNames(list);

        String srcBase = RequestContext.class.getResource("/templates/").getFile();
        String srcFile = srcBase +"module/report/workCondition/dayVeh/export.xls";

        ExcelData ed = new ExcelData();
        ed.setTitle("单车日报表");
        ed.setExportTime(DateUtil.getNow());
        ed.setData(list);
        String outName = String.format("%s-导出-%s.xls", "单车日报表", DateUtil.getNow());
        EasyExcel.renderResponse(srcFile,outName,ed);
    }

    public String getDate(int d){
        int dateNum = 0;
        String outDate;
        dateNum += d;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DAY_OF_MONTH,-(dateNum));//比当前时间提前dateNum天
        date = calendar.getTime();
        outDate = sdf.format(date);
        System.out.print(outDate);
        return outDate;
    }
}
