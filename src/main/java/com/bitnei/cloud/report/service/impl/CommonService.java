package com.bitnei.cloud.report.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.common.bean.ExcelData;
import com.bitnei.cloud.common.util.DataLoader;
import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.common.util.EasyExcel;
import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.Demo;
import com.bitnei.cloud.report.service.ICommonService;
import com.bitnei.cloud.report.service.IDemoService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import com.bitnei.commons.util.UtilHelper;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.support.RequestContext;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p/>
 * ----------------------------------------------------------------------------- <br>
 * 工程名 ： 基础框架 <br>
 * 功能： DemoService实现<br>
 * 描述： DemoService实现<br>
 * 授权 : (C) Copyright (c) 2017 <br>
 * 公司 : 北京理工新源信息科技有限公司<br>
 * ----------------------------------------------------------------------------- <br>
 * 修改历史 <br>
 * <table width="432" border="1">
 * <tr>
 * <td>版本</td>
 * <td>时间</td>
 * <td>作者</td>
 * <td>改变</td>
 * </tr>
 * <tr>
 * <td>1.0</td>
 * <td>2018-01-08 15:16:18</td>
 * <td>chenpeng</td>
 * <td>创建</td>
 * </tr>
 * </table>
 * <br>
 * <font color="#FF0000">注意: 本内容仅限于[北京理工新源信息科技有限公司]内部使用，禁止转发</font> <br>
 *
 * @author chenpeng
 * @version 1.0
 * @since JDK1.8
 */
@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.CommonMapper")
public class CommonService extends BaseService implements ICommonService {

    /**
     * 查询区域列表
     *
     * @return
     */
    @Override
    public String queryAreaList() {
        Map<String, Object> params = new HashMap<String, Object>();
        List<Map<String, Object>> list = findBySqlId("queryAreaList", params);
        if (null != list && list.size() > 0) {
            Map<String, Object> rMap = list.get(0);
            rMap.put("children", initTreeDate(list, rMap.get("id").toString()));
            rMap.put("state", "open");
            return "[" + JSONObject.toJSONString(rMap) + "]";
        }
        return null;
    }

    /**
     * 遍历数据，构建树形结构数据
     *
     * @param list
     * @param parentId
     * @return
     */
    public List<Map<String, Object>> initTreeDate(List<Map<String, Object>> list, String parentId) {
        if (null == list || list.size() == 0 || StringUtils.isEmpty(parentId)) {
            return null;
        }
        List<Map<String, Object>> rlist = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> m : list) {
            if (null != m && null != m.get("parent_id") && parentId.equals(m.get("parent_id").toString())) {
                if (null != m.get("id")) {
                    List<Map<String, Object>> slist = initTreeDate(list, m.get("id").toString());
                    if (null != slist && slist.size() > 0) {
                        m.put("children", slist);
                    }
                }
                m.put("state", "closed");
                rlist.add(m);
            }
        }
        return rlist;
    }
}
