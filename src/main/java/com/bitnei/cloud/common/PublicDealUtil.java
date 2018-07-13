package com.bitnei.cloud.common;

import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.commons.bean.WebUser;
import org.springframework.util.StringUtils;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 公共处理类
 * Created by DFY on 2018/5/31.
 */
public class PublicDealUtil {

    /**
     * 遍历数据，构建树形结构数据
     *
     * @param list
     * @param parentId
     * @return
     */
    public static List<Map<String, Object>> initTreeDate(List<Map<String, Object>> list, String parentId) {
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
                        m.put("state", "closed");
                    } else {
                        m.put("state", "open");
                    }
                }
                rlist.add(m);
            }
        }
        return rlist;
    }

    /**
     * 判断、取值
     *
     * @param obj
     * @return
     */
    public static String getMapValueString(Object obj) {
        if (null != obj) {
            return obj.toString();
        }
        return "";
    }

    /**
     * 获取过去第几天的日期(- 操作) 或者 未来 第几天的日期( + 操作)
     *
     * @param past
     * @return
     */
    public static String getPastDate(int past) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) - past);
        Date today = calendar.getTime();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String result = format.format(today);
        return result;
    }

    /**
     * 给查询参数加入当前用户信息
     *
     * @param param
     * @return
     */
    public static Map<String, Object> bulidUserForParams(Map<String, Object> param) {
        if (null != param) {
            WebUser user = ServletUtil.getUser();
            Map<String, Object> map = user.getExtData();
            param.put("userId", user.getId());
            param.put("isLeader", map.getOrDefault("roleType", ""));
            param.put("areaPath", map.getOrDefault("areaPath", ""));
            param.put("userUnitPath", map.getOrDefault("unitPath", ""));
            param.put("unitTypeCode", map.getOrDefault("unitTypeCode", ""));
        }
        return param;
    }
}
