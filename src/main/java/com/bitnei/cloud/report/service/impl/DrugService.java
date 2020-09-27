package com.bitnei.cloud.report.service.impl;

import com.alibaba.druid.util.StringUtils;
import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.common.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.Drug;
import com.bitnei.cloud.report.service.IDrugService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import com.bitnei.commons.util.UtilHelper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Slf4j
@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.DrugMapper" )
public class DrugService extends BaseService implements IDrugService {


    @Override
    public PagerModel pageQuery() {
        DataGridOptions dataLayOptions = ServletUtil.getDataLayOptions();
        PagerModel pm = findPagerModel("pagerModel", dataLayOptions);
        return pm;
    }

    @Override
    public Drug get(String id) {

       /* //获取当权限的map
        Map<String,Object> params = DataAccessKit.getAuthMap("sys_drug", "sd");
        params.put("id",id);
        Drug entry = unique("findById", params);
        if (entry == null){
            throw new BusinessException("对象已不存在");
        }
        return Drug.fromEntry(entry);*/
       return null;
    }

    @Override
    public Drug getByName(String name,String dgauges,String dmoleculars ) {
        Map<String,Object> map =new HashMap<>();
        map.put("dnames",name);
        map.put("dgauges",dgauges);
        map.put("dmoleculars",dmoleculars);
        List<Drug> pagerModel = findBySqlId("pagerModel", map);
        if (null!=pagerModel&&pagerModel.size()>0){
         return pagerModel.get(0);
        }
        return null;
    }


    @Override
    public JsonModel insert(Drug model) {
        JsonModel jm =new JsonModel();
        Drug obj = new Drug();
        if (!StringUtils.isEmpty(model.getCode())){
            Map<String,Object> pram =new HashMap<>(16);
            pram.put("code",model.getCode());
            List<Object> pagerModel = findBySqlId("pagerModel", pram);
            if (null!=pagerModel&&pagerModel.size()>0){
                jm.setFlag(false);
                jm.setMsg(model.getCode() + "物料编号已经存在，请重新输入!");
                return jm;
            }
            Drug byName = getByName(model.getDname(), model.getDgauge(), model.getDmolecular());
            if (null!=byName){
                jm.setFlag(false);
                jm.setMsg(model.getCode() + "药品重复");
                return jm;
            }
        }else {
            jm.setFlag(false);
            jm.setMsg("物料编号为空，请重新输入!");
            return jm;
        }

        BeanUtils.copyProperties(model, obj);
        String id = UtilHelper.getUUID();
        obj.setId(id);
        int res = super.insert(obj);
        if (res == 0 ){
            jm.setFlag(false);
            jm.setMsg("新增失败请重新输入!");
            return jm;
        }
        jm.setFlag(true);
        jm.setMsg("新增成功");
        return jm;
    }

    @Override
    public void update(Drug model) {

       /* //获取当权限的map
        Map<String,Object> params = DataAccessKit.getAuthMap("sys_drug", "sd");

        Drug obj = new Drug();
        BeanUtils.copyProperties(model, obj);
        params.putAll(MapperUtil.Object2Map(obj));
        int res = super.updateByMap(params);
        if (res == 0 ){
            throw new BusinessException("更新失败");
        }*/

    }

    /**
    * 删除多个
    * @param ids
    * @return
    */
    @Override
    public int deleteMulti(String ids) {

       /* //获取当权限的map
        Map<String,Object> params = DataAccessKit.getAuthMap("sys_drug", "sd");

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
