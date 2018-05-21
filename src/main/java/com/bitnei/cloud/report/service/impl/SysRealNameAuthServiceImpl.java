package com.bitnei.cloud.report.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.common.HttpUtil;
import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.cloud.common.pojo.UnicomURL;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.SysOwnerPeopleEntity;
import com.bitnei.cloud.report.domain.SysRealNameAuthenticationEntity;
import com.bitnei.cloud.report.enums.ResultEnum;
import com.bitnei.cloud.report.mapper.SysRealNameAuthMapper;
import com.bitnei.cloud.report.service.ISysRealNameAuthService;
import com.bitnei.cloud.service.impl.BaseService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.xml.transform.Result;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author chenyl or 13718602502@163.com
 * 企业实名认证
 */
@Service
@Transactional
@SuppressWarnings("all")
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.SysAuthCompanyTempMapper" )
public class SysRealNameAuthServiceImpl extends BaseService implements ISysRealNameAuthService {

    Logger logger = LoggerFactory.getLogger(SysRealNameAuthServiceImpl.class);

    //认证中
    public static String REAL_NAME_NO_SUBMIT = "0";

    //认证中
    public static String REAL_NAME_ING = "1";

    //认证成功
    public static String REAL_NAME_SUCCESS = "2";

    //认证失败
    public static String REAL_NAME_ERROR = "3";


    @Override
    public void refreshRealNameState() {
        List<SysRealNameAuthenticationEntity> entities =
                sysRealNameAuthMapper.selectRealNameByType("1");
        for (SysRealNameAuthenticationEntity entity : entities) {
            try {
                syncRealNameResult(entity);
            }catch (Exception e){
                logger.error("同步认证结果失败: VIN: {}",entity.getVin());
            }
        }
    }

    @Override
    public List<SysRealNameAuthenticationEntity> selectRealNameResult(SysOwnerPeopleEntity sysOwnerPeopleEntity) {
        return this.sysRealNameAuthMapper.selectListByAuthId(sysOwnerPeopleEntity.getId());
    }

    @Override
    public List<String> findByAuthIdAndStatus(String arr) {
        return this.sysRealNameAuthMapper.findByAuthIdAndStatus(arr);
    }

    @Override
    public AppBean checkInfo(String id) {
        List<SysRealNameAuthenticationEntity> list = this.sysRealNameAuthMapper.findAuthInfoByAuthId(id);
        if (list.size() > 0){
            return new AppBean(ResultEnum.RESULT_YES.getValue(), "已通过");
        }
        return new AppBean(ResultEnum.RESULT_NO.getValue(), "认证中或未未或未通过");
    }

    private void syncRealNameResult(SysRealNameAuthenticationEntity entity) {
        Map<String,Object> param = new HashMap<>();
        param.put("vin",entity.getVin());
        param.put("brandid",UnicomURL.getVehicleCompanyBrandCode());
        JSONObject jsonObject = HttpUtil.unicomHttpUrlByParam(UnicomURL.getQueryRealName(), new JSONObject(param));
        if(jsonObject == null){
            throw new RuntimeException();
        }
        if(!jsonObject.getString("ret_code").equals("0")){
            throw new RuntimeException();
        }
        String state = jsonObject.getJSONObject("response_data").getString("isrealname");
        if(state.equals(REAL_NAME_ING)){
            throw new RuntimeException();
        }
        entity.setAuthenticationResult(state);
        String desc = jsonObject.getJSONObject("response_data").getString("description");
        entity.setRemarks(desc);
        if(state.equals(REAL_NAME_SUCCESS)){
            entity.setRemarks("认证成功");
        }
        sysRealNameAuthMapper.updateByPrimaryKeySelective(entity);
    }

    @Autowired
    private SysRealNameAuthMapper sysRealNameAuthMapper;

    public SysRealNameAuthenticationEntity selectRealNameVin(String vin){
        return sysRealNameAuthMapper.selectRealNameVin(vin);
    }

    public int insertSelective(SysRealNameAuthenticationEntity record){
        return sysRealNameAuthMapper.insertSelective(record);
    }

    public int updateByPrimaryKeySelective(SysRealNameAuthenticationEntity record){
        return sysRealNameAuthMapper.updateByPrimaryKeySelective(record);
    }

    public List<SysRealNameAuthenticationEntity> selectByAuthenticationResult(String authenticationResult){
        List<SysRealNameAuthenticationEntity> result = sysRealNameAuthMapper.selectByAuthenticationResult(authenticationResult);
        return result;
    }

    public void updateSysRealNameAuthenticationEntityByPrimaryKeySelective(SysRealNameAuthenticationEntity record){
        sysRealNameAuthMapper.updateByPrimaryKeySelective(record);
    }
}
