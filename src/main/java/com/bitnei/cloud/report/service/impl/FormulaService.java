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
        Formula obj = new Formula();
        BeanUtils.copyProperties(model, obj);
        String id = UtilHelper.getUUID();
        obj.setId(id);
        obj.setFtime(DateUtil.getNowTime());
        int res = super.insert(obj);

        if (StringUtils.isNotEmpty(model.getDrugname01())){
            String[] split = model.getDrugname01().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality01());
                dosage.setDmolar(model.getDrugquality01()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname02())){
            String[] split = model.getDrugname02().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality02());
                dosage.setDmolar(model.getDrugquality02()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname03())){
            String[] split = model.getDrugname03().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality03());
                dosage.setDmolar(model.getDrugquality03()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname04())){
            String[] split = model.getDrugname04().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality04());
                dosage.setDmolar(model.getDrugquality04()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname05())){
            String[] split = model.getDrugname05().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality05());
                dosage.setDmolar(model.getDrugquality05()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }


        if (StringUtils.isNotEmpty(model.getDrugname06())){
            String[] split = model.getDrugname06().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality06());
                dosage.setDmolar(model.getDrugquality06()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname07())){
            String[] split = model.getDrugname07().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality07());
                dosage.setDmolar(model.getDrugquality07()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname08())){
            String[] split = model.getDrugname08().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality08());
                dosage.setDmolar(model.getDrugquality08()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname09())){
            String[] split = model.getDrugname09().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality09());
                dosage.setDmolar(model.getDrugquality09()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname10())){
            String[] split = model.getDrugname10().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality10());
                dosage.setDmolar(model.getDrugquality10()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }


        if (StringUtils.isNotEmpty(model.getDrugname11())){
            String[] split = model.getDrugname11().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality11());
                dosage.setDmolar(model.getDrugquality11()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname12())){
            String[] split = model.getDrugname12().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality12());
                dosage.setDmolar(model.getDrugquality12()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname13())){
            String[] split = model.getDrugname13().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality13());
                dosage.setDmolar(model.getDrugquality13()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname14())){
            String[] split = model.getDrugname14().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality14());
                dosage.setDmolar(model.getDrugquality14()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname15())){
            String[] split = model.getDrugname15().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality15());
                dosage.setDmolar(model.getDrugquality15()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }


        if (StringUtils.isNotEmpty(model.getDrugname16())){
            String[] split = model.getDrugname16().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality16());
                dosage.setDmolar(model.getDrugquality16()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname17())){
            String[] split = model.getDrugname17().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality17());
                dosage.setDmolar(model.getDrugquality17()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname18())){
            String[] split = model.getDrugname18().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality18());
                dosage.setDmolar(model.getDrugquality18()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname19())){
            String[] split = model.getDrugname19().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality19());
                dosage.setDmolar(model.getDrugquality19()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }

        if (StringUtils.isNotEmpty(model.getDrugname20())){
            String[] split = model.getDrugname20().split(",");
            Drug drug = drugService.getByName(split[0]);
            if (null!=drug){
                Dosage dosage=new Dosage();
                dosage.setId(UtilHelper.getUUID());
                dosage.setDrugid(drug.getId());
                dosage.setFormulaid(obj.getId());
                dosage.setDquality(model.getDrugquality20());
                dosage.setDmolar(model.getDrugquality20()/drug.getDmolecular());
                dosageService.insert(dosage);
            }
        }


        if (res == 0) {
        }
        return null;
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
    public int deleteMulti(String ids) {

      /*  //获取当权限的map
        Map<String,Object> params = DataAccessKit.getAuthMap("sys_formula", "sf");

        String[] arr = ids.split(",");
        int count = 0;
        for (String id:arr){
            params.put("id",id);
            int r = super.deleteByMap(params);
            count+=r;
        }
        return count;*/
        return 0;
    }

}
