package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.common.JsonModel;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.Dosage;
import com.bitnei.cloud.report.service.IDosageService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.PagerModel;
import com.bitnei.commons.util.UtilHelper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.DosageMapper" )
public class DosageService extends BaseService implements IDosageService {


    @Override
    public PagerModel pageQuery() {
        return null;
    }

    @Override
    public Dosage get(String id) {

       /* //获取当权限的map
        Map<String,Object> params = DataAccessKit.getAuthMap("sys_dosage", "sdo");
        params.put("id",id);
        Dosage entry = unique("findById", params);
        if (entry == null){
            throw new BusinessException("对象已不存在");
        }
        return Dosage.fromEntry(entry);*/
       return null;
    }




    @Override
    public JsonModel insert(Dosage model) {

        Dosage obj = new Dosage();
        BeanUtils.copyProperties(model, obj);
        String id = UtilHelper.getUUID();
        obj.setId(id);
        int res = super.insert(obj);
        if (res == 0 ){
        }
        return null;
    }

    @Override
    public void update(Dosage model) {

        //获取当权限的map

       /* Dosage obj = new Dosage();
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
/*
        //获取当权限的map
        Map<String,Object> params = DataAccessKit.getAuthMap("sys_dosage", "sdo");

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



    @Override
    public void batchImport(MultipartFile file) {

       /* String messageType = "DOSAGE"+ WsMessageConst.BATCH_IMPORT_SUFFIX;

        new ExcelBatchHandler<Dosage>(file, messageType, GroupExcelImport.class) {

            *//**
             * 复杂的校验，一般hibernate不能实现校验的，可以在这里进行处理
             *
             * @param model
             * @return
             *//*
            @Override
            public List<String> extendValidate(Dosage model) {
                return null;
            }

            *//**
             *  保存实体
             *
             * @param model
             * @return
             *//*
            @Override
            public void saveObject(Dosage model) {
            	insert(model);
            }
        }.work();*/

    }

    @Override
    public void batchUpdate(MultipartFile file) {

/*
        String messageType = "DOSAGE"+ WsMessageConst.BATCH_UPDATE_SUFFIX;

        new ExcelBatchHandler<Dosage>(file, messageType, GroupExcelUpdate.class) {

            *//**
             * 复杂的校验，一般hibernate不能实现校验的，可以在这里进行处理
             *
             * @param model
             * @return
             *//*
            @Override
            public List<String> extendValidate(Dosage model) {
                return null;
            }

            *//**
             *  保存实体
             *
             * @param model
             * @return
             *//*
            @Override
            public void saveObject(Dosage model) {
                update(model);
            }
        }.work();*/

    }



}
