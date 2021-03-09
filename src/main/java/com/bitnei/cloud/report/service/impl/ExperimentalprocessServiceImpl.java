package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.common.DateUtil;
import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.common.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.Experimentalprocess;
import com.bitnei.cloud.report.mapper.Demo1Mapper;
import com.bitnei.cloud.report.service.IExperimentalprocessService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Slf4j
@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.ExperimentalprocessMapper")
public class ExperimentalprocessServiceImpl extends BaseService implements IExperimentalprocessService {

    @Autowired
    private Demo1Mapper demo1Mapper;
    @Autowired
    private RawDataServiceImpl rawDataService;

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


        JsonModel jm = new JsonModel();

        Map<String, String> map = new HashMap<>();
        map.put("id", experimentalprocess.getId());
        // 拟合状态修改
        map.put("status", "1");

        map.put("oneCoefficient", experimentalprocess.getOneCoefficient());
        map.put("oneCoefficientAgain", experimentalprocess.getOneCoefficientAgain());
        map.put("parameter", experimentalprocess.getParameter());

        map.put("secondaryCoefficient", experimentalprocess.getSecondaryCoefficient());
        map.put("secondaryCoefficientAgain", experimentalprocess.getSecondaryCoefficientAgain());
        map.put("parameterAgain", experimentalprocess.getParameterAgain());

        super.update("updateNh", map);
        jm.setFlag(true);
        jm.setMsg("拟合成功");
       /* // 新增
        String code = experimentalprocess.getCode();
       // Map<String,String> map =new HashMap<>();
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
        jm.setFlag(true);*/
        return jm;
    }

    @Override
    public JsonModel checkUpdate(Experimentalprocess experimentalprocess) {
        Map<String, String> map = new HashMap<>();
        map.put("id", experimentalprocess.getId());
        map.put("confirmTime", DateUtil.getNowTime());
        map.put("confirmStatus", "1");
        int checkUpdate = update("checkUpdate", map);
        JsonModel jm = new JsonModel();
        if (checkUpdate > 0) {
            jm.setFlag(true);
            jm.setMsg("复核成功");
        } else {
            jm.setFlag(false);
            jm.setMsg("复核失败");
        }
        return jm;
    }

    @Override
    public List<Map<String, Object>> findNhBy(String id) {
        Map<String, String> pram = new HashMap<>();
        List<Map<String, Object>> re = new ArrayList<>();
        pram.put("id", id);
        // 原始数据
        List<Map<String, Object>> result = rawDataService.findBySqlId("findById", pram);
        // 位置孔位
        List<Map<String, Object>> maps = demo1Mapper.findById(pram);
        Experimentalprocess experimentalProcess = findById(id);

        Map<String, Object> mapGs = new HashMap<>();
        // 原始数据
        double secondaryCoefficient = Double.parseDouble(experimentalProcess.getSecondaryCoefficient());
        double oneCoefficient = Double.parseDouble(experimentalProcess.getOneCoefficient());
        double parameter = Double.parseDouble(experimentalProcess.getParameter());
        double secondaryCoefficientAgain = Double.parseDouble(experimentalProcess.getSecondaryCoefficientAgain());
        double oneCoefficientAgain = Double.parseDouble(experimentalProcess.getOneCoefficientAgain());
        double parameterAgain = Double.parseDouble(experimentalProcess.getParameterAgain());

        mapGs.put("secondaryCoefficient", experimentalProcess.getSecondaryCoefficient());
        mapGs.put("oneCoefficient", experimentalProcess.getOneCoefficient());
        mapGs.put("parameter", experimentalProcess.getParameter());
        mapGs.put("secondaryCoefficientAgain", experimentalProcess.getSecondaryCoefficientAgain());
        mapGs.put("oneCoefficientAgain", experimentalProcess.getOneCoefficientAgain());
        mapGs.put("parameterAgain", experimentalProcess.getParameterAgain());
        Map<String, Object> map = result.get(0);
        // 96 个原始数据  h_no23
        for (int i = 1; i <= 96; i++) {
            String s = String.format("%02d", i);
            String key = "v_no" + s;
            Double v = Double.parseDouble(map.get(key).toString());
            double v1 = secondaryCoefficient * v * v + oneCoefficient * v + parameter;
            if (v1 <= 40) {
                v1 = secondaryCoefficientAgain * v * v + oneCoefficientAgain * v + parameterAgain;
            }
            map.put(key, v1 + "");
        }
        re.add(map);
        re.add(maps.get(0));
        re.add(mapGs);
        return re;

    }
}
