package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.common.DateUtil;
import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.common.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.Experimentalprocess;
import com.bitnei.cloud.report.service.IExperimentalprocessService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import com.bitnei.commons.util.UtilHelper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Slf4j
@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.ExperimentalprocessMapper" )
public class ExperimentalprocessServiceImpl extends BaseService implements IExperimentalprocessService {
    @Override
    public PagerModel pageQuery() {
        DataGridOptions dataLayOptions = ServletUtil.getDataLayOptions();
        PagerModel pm = findPagerModel("pagerModel", dataLayOptions);
        return pm;
    }

    @Override
    public Map<String, Object> indById(String id) {
        return null;
    }

    @Override
    public JsonModel insert(Experimentalprocess experimentalprocess) {
        JsonModel jm =new JsonModel();
        // 新增
        String code = experimentalprocess.getCode();
        Map<String,String> map =new HashMap<>();
        map.put("codes",code);
        List<Experimentalprocess> pagerModel = findBySqlId("pagerModel", map);
        // 编辑
        if (!"-1".equals(experimentalprocess.getId())){
            if (null!=pagerModel&&pagerModel.size()>0){
                Experimentalprocess experimentalprocess1 = pagerModel.get(0);
                if (!experimentalprocess.getId().equals(experimentalprocess1.getId())){
                    jm.setFlag(false);
                    jm.setMsg("实验编号重复");
                    return jm;
                }
            }
            experimentalprocess.setCreateTime(DateUtil.getNowTime());
            super.update(experimentalprocess);

        }else {
            // 新增
            if (null!=pagerModel&&pagerModel.size()>0){
                jm.setFlag(false);
                jm.setMsg("实验编号重复");
                return jm;
            }
            String id = UtilHelper.getUUID();
            experimentalprocess.setId(id);
            experimentalprocess.setCreateTime(DateUtil.getNowTime());
            experimentalprocess.setConfirmStatus("0");
            int res = super.insert(experimentalprocess);
            jm.setMsg("新增成功");
        }
        jm.setFlag(true);
        return jm;
    }

    @Override
    public JsonModel checkUpdate(Experimentalprocess experimentalprocess) {
        Map<String,String> map =new HashMap<>();
        map.put("id",experimentalprocess.getId());
        map.put("confirmTime",DateUtil.getNowTime());
        map.put("confirmStatus","1");
        int checkUpdate = update("checkUpdate", map);
        JsonModel jm =new JsonModel();
        if (checkUpdate>0){
            jm.setFlag(true);
            jm.setMsg("复核成功");
        }else {
            jm.setFlag(false);
            jm.setMsg("复核失败");
        }
        return jm;
    }
}
