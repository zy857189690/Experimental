package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.Drug;
import com.bitnei.cloud.report.service.IDrugService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.PagerModel;
import com.bitnei.commons.util.MapperUtil;
import com.bitnei.commons.util.UtilHelper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;


@Slf4j
@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.DrugMapper" )
public class DrugService extends BaseService implements IDrugService {


    @Override
    public PagerModel pageQuery() {
        return null;
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
    public void insert(Drug model) {

        Drug obj = new Drug();
        BeanUtils.copyProperties(model, obj);
        String id = UtilHelper.getUUID();
        obj.setId(id);
        int res = super.insert(obj);
        if (res == 0 ){
        }
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
