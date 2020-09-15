package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.Formula;
import com.bitnei.cloud.report.service.IFormulaService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.PagerModel;
import com.bitnei.commons.util.UtilHelper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;


@Slf4j
@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.FormulaMapper" )
public class FormulaService extends BaseService implements IFormulaService {


    @Override
    public PagerModel pageQuery() {
        return null;
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
    public void insert(Formula model) {

        Formula obj = new Formula();
        BeanUtils.copyProperties(model, obj);
        String id = UtilHelper.getUUID();
        obj.setId(id);
        int res = super.insert(obj);
        if (res == 0 ){
        }
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
