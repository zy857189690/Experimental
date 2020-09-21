package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.common.DateUtil;
import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.common.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.Dosage;
import com.bitnei.cloud.report.domain.Drug;
import com.bitnei.cloud.report.domain.Formula;
import com.bitnei.cloud.report.service.IDosageService;
import com.bitnei.cloud.report.service.IDrugService;
import com.bitnei.cloud.report.service.IFormulaService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import com.bitnei.commons.util.UtilHelper;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Slf4j
@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.FormulaMapper")
public class FormulaService extends BaseService implements IFormulaService {

    @Autowired
    private IDosageService dosageService;

    @Autowired
    private IDrugService drugService;

    @Override
    public PagerModel pageQuery() {
        DataGridOptions dataLayOptions = ServletUtil.getDataLayOptions();
        PagerModel pm = findPagerModel("pagerModel", dataLayOptions);
        return pm;
    }

    @Override
    public Formula get(String id) {

       /* //获取当权限的map
        Map<String,Object> params = DataAccessKit.getAuthMap("sys_formula", "sf");
        params.put("id",id);
        Formula entry = unique("findById", params);
        if (entry == null){
            throw new BusinessException("对象已不存在");
        }
        return Formula.fromEntry(entry);*/
        return null;
    }


    @Override
    @Transactional
    public JsonModel insert(Formula model) {
        JsonModel jm = new JsonModel();
        Map<String, Object> map = new HashMap<>(16);
        map.put("code", model.getCode());
        List<Formula> pagerModel = findBySqlId("pagerModel", map);
        if (null != pagerModel && pagerModel.size() > 0) {
            Formula formula = pagerModel.get(0);
            if (!formula.getId().equals(model.getId()) || "-1".equals(model.getId())) {
                jm.setFlag(false);
                jm.setMsg("配方编号已存在");
                return jm;
            }
        }
        // 修改操作
        if (!"-1".equals(model.getId())) {
            dosageService.deleteMulti(model.getId());
            deleteMulti(model.getId());
        }

        Formula obj = new Formula();
        BeanUtils.copyProperties(model, obj);
        String id = UtilHelper.getUUID();
        obj.setId(id);
        obj.setFtime(DateUtil.getNowTime());
        int res = super.insert(obj);
        if (StringUtils.isNotEmpty(model.getDrugname01()) && StringUtils.isNotEmpty(model.getDrugquality01())) {
            String[] split = model.getDrugname01().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality01());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality01()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }
        if (StringUtils.isNotEmpty(model.getDrugname02()) && StringUtils.isNotEmpty(model.getDrugquality02())) {
            String[] split = model.getDrugname02().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality02());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality02()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname03()) && StringUtils.isNotEmpty(model.getDrugquality03())) {
            String[] split = model.getDrugname03().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality03());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality03()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname04()) && StringUtils.isNotEmpty(model.getDrugquality04())) {
            String[] split = model.getDrugname04().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality04());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality04()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname05()) && StringUtils.isNotEmpty(model.getDrugquality05())) {
            String[] split = model.getDrugname05().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality05());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality05()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }


        if (StringUtils.isNotEmpty(model.getDrugname06()) && StringUtils.isNotEmpty(model.getDrugquality06())) {
            String[] split = model.getDrugname06().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality06());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality06()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname07()) && StringUtils.isNotEmpty(model.getDrugquality07())) {
            String[] split = model.getDrugname07().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality07());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality07()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname08()) && StringUtils.isNotEmpty(model.getDrugquality08())) {
            String[] split = model.getDrugname08().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality08());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality08()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname09()) && StringUtils.isNotEmpty(model.getDrugquality09())) {
            String[] split = model.getDrugname09().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality09());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality09()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname10()) && StringUtils.isNotEmpty(model.getDrugquality10())) {
            String[] split = model.getDrugname10().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality10());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality10()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }


        if (StringUtils.isNotEmpty(model.getDrugname11()) && StringUtils.isNotEmpty(model.getDrugquality11())) {
            String[] split = model.getDrugname11().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality11());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality11()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname12()) && StringUtils.isNotEmpty(model.getDrugquality12())) {
            String[] split = model.getDrugname12().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality12());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality12()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname13()) && StringUtils.isNotEmpty(model.getDrugquality13())) {
            String[] split = model.getDrugname13().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality13());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality13()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname14()) && StringUtils.isNotEmpty(model.getDrugquality14())) {
            String[] split = model.getDrugname14().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality14());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality14()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname15()) && StringUtils.isNotEmpty(model.getDrugquality15())) {
            String[] split = model.getDrugname15().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality15());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality15()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }


        if (StringUtils.isNotEmpty(model.getDrugname16()) && StringUtils.isNotEmpty(model.getDrugquality16())) {
            String[] split = model.getDrugname16().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality16());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality16()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname17()) && StringUtils.isNotEmpty(model.getDrugquality17())) {
            String[] split = model.getDrugname17().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality17());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality17()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname18()) && StringUtils.isNotEmpty(model.getDrugquality18())) {
            String[] split = model.getDrugname18().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality18());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality18()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname19()) && StringUtils.isNotEmpty(model.getDrugquality19())) {
            String[] split = model.getDrugname19().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality19());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality19()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname20()) && StringUtils.isNotEmpty(model.getDrugquality20())) {
            String[] split = model.getDrugname20().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null != drug) {
                Dosage dosage = new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality20());
                dosage.setDmolar(Double.parseDouble(model.getDrugquality20()) / Double.parseDouble(drug.getDmolecular()));
                dosageService.insert(dosage);
            }
        }

        if (res == 0) {
            jm.setFlag(false);
            jm.setMsg("新增失败");
            return jm;
        }
        jm.setFlag(true);
        jm.setMsg("新增成功");
        return jm;
    }

    @Override
    public void update(Formula model) {

        //获取当权限的map
     /*   Map<String,Object> params = DataAccessKit.getAuthMap("sys_formula", "sf");

        Formula obj = new Formula();
        BeanUtils.copyProperties(model, obj);
        params.putAll(MapperUtil.Object2Map(obj));
        int res = super.updateByMap(params);
        if (res == 0 ){
            throw new BusinessException("更新失败");
        }*/
    }

    /**
     * 删除多个
     *
     * @param ids
     * @return
     */
    @Override
    public int deleteMulti(String id) {
        return super.delete(id);
    }

    @Override
    public Map<String, Object> findFormulaById(String id) {
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        List<Map<String, Object>> obj = findBySqlId("findFormulaById", map);
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> formulaMap = obj.get(0);
        result.put("id", formulaMap.get("id"));
        result.put("code", formulaMap.get("code"));
        result.put("fname", formulaMap.get("f_name"));
        result.put("pid", formulaMap.get("p_id"));
        result.put("ftime", formulaMap.get("f_time"));
        result.put("fpeople", formulaMap.get("f_people"));
        for (int i = 0; i < obj.size(); i++) {
            int j = i;
            String name = obj.get(i).get("d_name") + "," + obj.get(i).get("d_gauge") + "," + obj.get(i).get("d_molecular");
            String s = String.format("%02d", ++j);
            String key = "drugname" + s;
            String value = "drugquality" + s;
            result.put(key, name);
            result.put(value, obj.get(i).get("d_quality"));
        }
        return result;
    }

}
