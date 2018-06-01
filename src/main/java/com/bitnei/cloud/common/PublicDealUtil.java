package com.bitnei.cloud.common;

import com.bitnei.commons.bean.WebUser;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 公共处理类
 * Created by DFY on 2018/5/31.
 */
public class PublicDealUtil {

    /**
     * TODO 未完成待陈鹏完善用户session信息
     * 处理参数map，加入用户信息参数
     * @param param
     * @param user
     * @return
     */
    public static Map<String, Object> dealParamUser(Map<String, Object> param, WebUser user) {
        if (null == param) {
            param = new HashMap<String, Object>();
        }
        if (null != user) {
            param.put("userId", user.getId());
            param.put("isLeader", user);
            param.put("userUnitPath", user);
            param.put("areaPath", user);
            param.put("unitTypeCode", user);
        }
        return param;
    }

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
}
