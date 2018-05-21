package com.bitnei.cloud.report.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.common.HttpUtil;
import com.bitnei.cloud.common.pojo.ConstantMap;
import com.bitnei.cloud.common.pojo.UnicomURL;
import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.EnterpriseAuth;
import com.bitnei.cloud.report.domain.SysAuthenticationCompanyTempEntity;
import com.bitnei.cloud.report.domain.SysCustomerUnitEntity;
import com.bitnei.cloud.report.domain.SysRealNameAuthenticationEntity;
import com.bitnei.cloud.report.mapper.EnterpriseAuthMapper;
import com.bitnei.cloud.report.mapper.SysAuthCompanyTempMapper;
import com.bitnei.cloud.report.mapper.SysCustomerUnitMapper;
import com.bitnei.cloud.report.mapper.SysRealNameAuthMapper;
import com.bitnei.cloud.report.service.ICompanyAuthService;
import com.bitnei.cloud.report.util.Assert;
import com.bitnei.cloud.report.util.CoverException;
import com.bitnei.cloud.report.util.NeedUpdateException;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.util.UtilHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;

import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.logging.SimpleFormatter;

/**
 * @author chenyl or 13718602502@163.com
 * 企业实名认证
 */
@Service
@Transactional
@SuppressWarnings("all")
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.EnterpriseAuthMapper")
public class CompanyAuthServiceImpl extends BaseService implements ICompanyAuthService {

    @Autowired
    EnterpriseAuthMapper enterpriseAuthMapper;

    @Autowired
    SysCustomerUnitMapper sysCustomerUnitEntityMapper;

    @Autowired
    SysRealNameAuthMapper sysRealNameAuthMapper;

    @Autowired
    SysAuthCompanyTempMapper sysAuthCompanyTempMapper;

    @Autowired
    ConstantMap constantMap;

    Logger logger = LoggerFactory.getLogger(CompanyAuthServiceImpl.class.getSimpleName());

    //认证
    public static String REAL_NAME_NO_SUBMIT = "0";

    //认证中
    public static String REAL_NAME_ING = "1";

    //认证成功
    public static String REAL_NAME_SUCCESS = "2";

    //认证失败
    public static String REAL_NAME_ERROR = "3";

    /**
     * 企业认证
     *
     * @param enterpriseAuth
     * @param sysCustomerUnitEntity
     */
    @Override
    public SysRealNameAuthenticationEntity authCustomer(
            EnterpriseAuth enterpriseAuth,
            SysCustomerUnitEntity sysCustomerUnitEntity,
            String currentId,String authenticationResult,
            String cover) throws Exception {

        try {
            //校验车辆相关信息
            validVehicle(enterpriseAuth);
            //如果没有客户信息 补充客户信息
            validCustomer(sysCustomerUnitEntity);
            //开始认证流程
            SysRealNameAuthenticationEntity auth = auth(enterpriseAuth, sysCustomerUnitEntity,cover);
            //移除临时表关系 在编辑后重新提交的情况下
            if(REAL_NAME_NO_SUBMIT.equals(authenticationResult)){
                sysAuthCompanyTempMapper.deleteByPrimaryKey(currentId);
            }
            return auth;
        } catch (Exception e) {
            e.printStackTrace();
            if (e instanceof NeedUpdateException) {
                //系统存在异常数据 强制结束(必填属性在数据库中为NULL)
                throw new RuntimeException("系统存在异常数据!");
            }
            throw e;
        }
    }

    /**
     * 针对在列表页直接提交的数据(未提交的临时数据)
     * @param enterpriseAuth
     * @return
     * @throws Exception
     */
    public SysRealNameAuthenticationEntity authCustomer(SysAuthenticationCompanyTempEntity param,String cover) throws Exception {
        //获取企业信息
        SysAuthenticationCompanyTempEntity entity = sysAuthCompanyTempMapper.findPrimaryKey(param.getId());
        //组装
        EnterpriseAuth enterpriseAuth = new EnterpriseAuth();
        SysCustomerUnitEntity sysCustomerUnitEntity = new SysCustomerUnitEntity();
        BeanUtils.copyProperties(entity,enterpriseAuth);
        BeanUtils.copyProperties(entity,sysCustomerUnitEntity);
        //实名认证
        return authCustomer(enterpriseAuth,sysCustomerUnitEntity,entity.getId(),REAL_NAME_NO_SUBMIT,cover);
    }


    /**
     * 保存临时数据 添加页面的保存
     *
     * @param sysAuthenticationCompanyTempEntity
     */
    @Override
    public void saveAuthenticationCompanyTemp(SysAuthenticationCompanyTempEntity entity) {
        try {
            entity.setId(uuid36());
            entity.setCreateTime(DateUtil.getNow());
            entity.setUpdateTime(DateUtil.getNow());
            //保存临时数据
            sysAuthCompanyTempMapper.insert(entity);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("保存失败!");
        }
    }

    /**
     * 绑定车辆信息
     *
     * @param enterpriseAuth        车辆信息
     * @param sysCustomerUnitEntity 企业ID
     * @throws Exception
     */
    @Override
    public SysRealNameAuthenticationEntity bindCar(EnterpriseAuth enterpriseAuth, SysCustomerUnitEntity sysCustomerUnitEntity) throws Exception {
        try {
            //校验车辆相关信息
            validVehicle(enterpriseAuth);
            //校验车辆是否游离
            SysRealNameAuthenticationEntity realNameVin =
                    sysRealNameAuthMapper.selectRealNameVin(enterpriseAuth.getVin());
            //如果存在数据且绑定了人关系 直接抛出异常
            SysRealNameAuthenticationEntity saveAuthInfo = null;
            if (realNameVin != null &&
                    realNameVin.getAuthenticationType() != null) {
                if(realNameVin.getAuthenticationResult().equals(REAL_NAME_ING) ||
                        realNameVin.getAuthenticationResult().equals(REAL_NAME_SUCCESS))
                throw new RuntimeException("该车已经存在绑定关系!");
            }
            saveAuthInfo = realNameVin;
            if (realNameVin == null) {
                //同步车辆
                saveAuthInfo = syncVehicle(enterpriseAuth,realNameVin);
            }else if(realNameVin.getSynResult().equals("0")){
                saveAuthInfo = syncVehicle(enterpriseAuth,realNameVin);
            }
            //校验企业是否通过认证
            List<SysRealNameAuthenticationEntity> realNameAuthenticationEntities =
                    sysRealNameAuthMapper.selectRealNameComp(sysCustomerUnitEntity.getId());
            Assert.isTrue((realNameAuthenticationEntities == null ||
                    realNameAuthenticationEntities.size() == 0), "当前企业未通过实名认证");
            //用户信息无需校验
            sysCustomerUnitEntity = sysCustomerUnitEntityMapper.findByPrimaryKey(sysCustomerUnitEntity);
            //调用联通同步接口
            bindCarRequest(enterpriseAuth,sysCustomerUnitEntity,saveAuthInfo);
            return saveAuthInfo;
        } catch (Exception e) {
            e.printStackTrace();
            if (e instanceof NeedUpdateException) {
                //系统存在异常数据 强制结束(必填属性在数据库中为NULL)
                throw new RuntimeException("系统存在异常数据!");
            }
            throw new RuntimeException(e.getMessage());
        }
    }

    private void bindCarRequest(EnterpriseAuth enterpriseAuth, SysCustomerUnitEntity sysCustomerUnitEntity,SysRealNameAuthenticationEntity saveAuthInfo) {
        //车辆相关信息
        Map<String, Object> syncVehRequest = createSyncVehRequest(enterpriseAuth);
        syncVehRequest.put("brandid",UnicomURL.getVehicleCompanyBrandCode());
        //绑定企业信息
        syncVehRequest.put("vin",enterpriseAuth.getVin());
        syncVehRequest.put("iccid",enterpriseAuth.getIccid());
        syncVehRequest.put("comname",sysCustomerUnitEntity.getName());
        syncVehRequest.put("licensecode",sysCustomerUnitEntity.getCreditCode());
        syncVehRequest.put("username",sysCustomerUnitEntity.getContact());
        syncVehRequest.put("ownercerttype",sysCustomerUnitEntity.getOwnerCertType());
        syncVehRequest.put("ownercertid",sysCustomerUnitEntity.getOwnerCertId());
        syncVehRequest.put("servnumber",enterpriseAuth.getSimCartNumber());
        JSONObject authResult = HttpUtil.unicomHttpUrlByParam(UnicomURL.getEnterpriseBindVehicle(),
                new JSONObject(syncVehRequest));

        SysRealNameAuthenticationEntity entity = saveAuthInfo(enterpriseAuth, sysCustomerUnitEntity, saveAuthInfo);
        entity.setAuthenticationResult(REAL_NAME_SUCCESS);
        entity.setRemarks("成功");
        if(authResult == null || !authResult.getString("ret_code").equals("0")){
            //绑定失败
            entity.setAuthenticationResult(REAL_NAME_ERROR);
            if(authResult !=null){
                entity.setRemarks(authResult.getString("ret_msg"));
            }else{
                entity.setRemarks("车辆绑定失败");
            }
            //绑定失败，直接返回
            sysRealNameAuthMapper.updateByPrimaryKey(entity);
            return;
        }
        //绑定成功 查询认证结果
        Map<String, Object> resultRequest = new HashMap<>();
        resultRequest.put("vin",enterpriseAuth.getVin());
        resultRequest.put("brandid", UnicomURL.getVehicleCompanyBrandCode());
        JSONObject realResult = HttpUtil.unicomHttpUrlByParam(UnicomURL.getQueryRealName(), new JSONObject(resultRequest));
        if(realResult == null || !realResult.getString("ret_code").equals("0")){
            //绑定失败
            entity.setAuthenticationResult(REAL_NAME_ERROR);
            if(authResult !=null){
                entity.setRemarks(realResult.getString("ret_msg"));
            }else{
                entity.setRemarks("车辆绑定失败");
            }
        }
        if(realResult != null && realResult.getString("ret_code").equals("0")){
            JSONObject response_data = realResult.getJSONObject("response_data");
            String isrealname = response_data.getString("isrealname");
            if(!isrealname.equals(REAL_NAME_SUCCESS)){
                entity.setAuthenticationResult(isrealname);
                //TODO 联通接口异常 不覆盖备注信息
                //entity.setRemarks(response_data.getString("description"));
            }
        }

        sysRealNameAuthMapper.updateByPrimaryKey(entity);
    }

    @Override
    public EnterpriseAuth findBySimCardId(String id) {
        return this.enterpriseAuthMapper.findBySimCardId(id);
    }

    /**
     * 批量实名认证
     * TODO 需要优化 车辆批量认证
     * 使用对象引用操作数据 List<EnterpriseAuth> enterpriseAuths 所有要处理的数据
     * tip：这里调用使用批量更新的接口
     *      请勿调用 auth(,)接口(虽然这样比较简单)。
     *
     * @param sysCustomerUnitEntity
     * @param enterpriseAuths
     */
    @Override
    public void authCustomerAll(SysCustomerUnitEntity sysCustomerUnitEntity, List<EnterpriseAuth> enterpriseAuths) throws Exception{
        //新需求 无需查询 但是需要校验企业信息
        validCustomer(sysCustomerUnitEntity);
        //sysCustomerUnitEntity = sysCustomerUnitEntityMapper.findByPrimaryKey(sysCustomerUnitEntity);
        //开始校验车辆
        List<EnterpriseAuth> successEnterpriseAuth = new ArrayList<>();
        List<EnterpriseAuth> errorEnterpriseAuth = new ArrayList<>();
        //同步车辆数据
        List<EnterpriseAuth> errorData = new ArrayList<>();
        for (EnterpriseAuth enterpriseAuth : enterpriseAuths) {
            try {
                //空数据
                if(allfieldIsNUll(enterpriseAuth)){
                    errorData.add(enterpriseAuth);
                    continue;
                }
                //开始校验车辆
                validVehicle(enterpriseAuth);
                successEnterpriseAuth.add(enterpriseAuth);
            } catch (Exception e) {
                enterpriseAuth.setCode(-1);
                enterpriseAuth.setMessage(e.getMessage());
                errorEnterpriseAuth.add(enterpriseAuth);
            }
        }
        //移除错误数据
        enterpriseAuths.removeAll(errorData);

        //开始分组 每组最多同步200条
        int groupCount = 200, successCount = successEnterpriseAuth.size();
        List<List<EnterpriseAuth>> groupSyncVehRequest = new ArrayList<>();
        for (int index = 0; index < successCount; index += groupCount) {
            if (index + groupCount > successCount) {
                groupSyncVehRequest.add(successEnterpriseAuth.subList(index, successCount));
            } else {
                groupSyncVehRequest.add(successEnterpriseAuth.subList(index, index + groupCount));
            }
        }

        //开始同步 200条
        for (int count = 0; count < groupSyncVehRequest.size(); count++) {
            syncVehicle(successEnterpriseAuth,errorEnterpriseAuth,groupSyncVehRequest.get(count));
        }

        //开始认证 需要对成功的再次分组
        successCount = successEnterpriseAuth.size();
        if(successCount == 0){
            //已经没有可以处理的数据了 直接返回
        }
        //清空接口请求参数
        groupSyncVehRequest.clear();
        for (int index = 0; index < successCount; index += groupCount) {
            if (index + groupCount > successCount) {
                groupSyncVehRequest.add(successEnterpriseAuth.subList(index, successCount));
            } else {
                groupSyncVehRequest.add(successEnterpriseAuth.subList(index, index + groupCount));
            }
        }
        //开始认证 200条
        for (int count = 0; count < groupSyncVehRequest.size(); count++) {
            authAll(successEnterpriseAuth,errorEnterpriseAuth,groupSyncVehRequest.get(count),sysCustomerUnitEntity);
        }

        //认证完毕 数据已经存在于传入的enterpriseAuths（引用）。
    }

    @Override
    public void authCustomerAllSave(SysCustomerUnitEntity sysCustomerUnitEntity, List<EnterpriseAuth> enterpriseAuths) {
        //新需求无需查询
        //sysCustomerUnitEntity = sysCustomerUnitEntityMapper.findByPrimaryKey(sysCustomerUnitEntity);
        List<EnterpriseAuth> nullObject = new ArrayList<>();
        for(EnterpriseAuth enterpriseAuth:enterpriseAuths){
            if(allfieldIsNUll(enterpriseAuth)){
                nullObject.add(enterpriseAuth);
                continue;
            }
            SysAuthenticationCompanyTempEntity entity = new SysAuthenticationCompanyTempEntity();
            BeanUtils.copyProperties(sysCustomerUnitEntity,entity);
            BeanUtils.copyProperties(enterpriseAuth,entity);
            entity.setId(uuid36());
            entity.setCreateTime(DateUtil.getNow());
            entity.setUpdateTime(DateUtil.getNow());
            sysAuthCompanyTempMapper.insert(entity);
        }
        enterpriseAuths.removeAll(nullObject);
    }

    /**
     * 批量实名认证与单企业实名认证相同
     * TODO 批量实名认证 需要优化
     * 维护 successEnterpriseAuth errorEnterpriseAuth
     * 注意!!!
     * tip：这里调用使用批量更新的接口
     *      请勿调用 auth(,)接口(虽然这样比较简单)。
     * @param successEnterpriseAuth
     * @param errorEnterpriseAuth
     * @param enterpriseAuths
     */
    private void authAll(List<EnterpriseAuth> success, List<EnterpriseAuth> error,
                         List<EnterpriseAuth> enterpriseAuths,SysCustomerUnitEntity sysCustomerUnitEntity) {
        //已经通过校验的车辆 无需判断 直接执行实名认证接口
        //校验游离车辆
        //请求参数
        List<Object> requestData = new ArrayList<>();
        //认证企业信息
        Map<String, Object> realNameMap = createRealNameMap(sysCustomerUnitEntity, null);
        List<EnterpriseAuth> result = new ArrayList();
        for(EnterpriseAuth enterpriseAuth : enterpriseAuths){
            SysRealNameAuthenticationEntity authenticationEntity =
                    sysRealNameAuthMapper.selectRealNameVin(enterpriseAuth.getVin());
            //如果存在数据且绑定了人关系 直接抛出异常
            if (authenticationEntity != null &&
                    authenticationEntity.getAuthenticationType() != null) {
                enterpriseAuth.setCode(-1);
                enterpriseAuth.setMessage("该车已存在绑定关系");
                result.add(enterpriseAuth);
            }else{
                //可以使用的车辆
                requestData.add(createSyncVehRequest(enterpriseAuth));
            }
        }

        error.addAll(result);
        success.removeAll(result);

        //如果没有可认证的车辆直接返回
        if(success.size() == 0){
            return;
        }

        realNameMap.put("vehicles", new JSONArray(requestData));
        JSONObject syncVehicle = HttpUtil.unicomHttpUrlByParam(UnicomURL.getEnterpriseBatchRealNameReg(), new JSONObject(realNameMap));
        if (syncVehicle == null || !syncVehicle.getString("ret_code").equals("0")) {
            //接口调用出错 全部失败
            error.addAll(enterpriseAuths);
            //写入失败数据
            for(int index=0;index<enterpriseAuths.size();index++){
                EnterpriseAuth enterpriseAuth = enterpriseAuths.get(index);
                enterpriseAuth.setCode(-1);
                enterpriseAuth.setMessage(syncVehicle.getString("ret_msg"));
            }
            success.removeAll(enterpriseAuths);
            return;
        }
        //开始分组 成功与失败
        JSONArray jsonArray = syncVehicle.getJSONObject("response_data").getJSONArray("vehicleback");
        Iterator<Object> iterator = jsonArray.iterator();
        while (iterator.hasNext()){
            JSONObject next = (JSONObject) iterator.next();
            String ret_code = next.getString("retcode");
            EnterpriseAuth enterpriseAuth = findObject(success, next.getString("vin"));
            if(!ret_code.equals("0")){
                //失败
                error.add(enterpriseAuth);
                success.remove(enterpriseAuth);
                enterpriseAuth.setCode(-1);
                enterpriseAuth.setMessage(next.getString("message"));
                success.remove(enterpriseAuth);
                continue;
            }
            enterpriseAuth.setMessage(next.getString("rcode"));
            //保存认证数据
            sysRealNameAuthMapper.insert(saveAuthInfo(enterpriseAuth,sysCustomerUnitEntity,null));
        }

    }


    private void syncVehicle(List<EnterpriseAuth> success, List<EnterpriseAuth> error,
                             List<EnterpriseAuth> syncVehRequest) {
        Map<String, Object> request = new HashMap<>();
        //组装请求参数
        List requestData = new ArrayList();
        for(int index=0;index < syncVehRequest.size();index++){
            requestData.add(createSyncVehRequest(syncVehRequest.get(index)));
        }
        request.put("vehicles", new JSONArray(requestData));
        JSONObject jsonObject = new JSONObject(request);
        JSONObject syncVehicle = HttpUtil.unicomHttpUrlByParam(UnicomURL.getSyncVehicle(), jsonObject);
        if (syncVehicle == null || syncVehicle.getString("ret_code").equals("1")) {
            //接口调用出错 全部失败
            error.addAll(syncVehRequest);
            //写入失败数据
            for(int index=0;index<syncVehRequest.size();index++){
                EnterpriseAuth enterpriseAuth = syncVehRequest.get(index);
                enterpriseAuth.setCode(-1);
                enterpriseAuth.setMessage("车辆同步失败");
            }
            success.removeAll(syncVehRequest);
            return;
        }
        //开始分组成功与失败
        JSONArray jsonArray = syncVehicle.getJSONObject("response_data").getJSONArray("vcbacks");
        Iterator<Object> iterator = jsonArray.iterator();
        while (iterator.hasNext()){
            JSONObject next = (JSONObject) iterator.next();
            String ret_code = next.getString("retcode");
            EnterpriseAuth enterpriseAuth = findObject(success, next.getString("vin"));
            if(ret_code.equals("1")){
                //失败
                error.add(enterpriseAuth);
                success.remove(enterpriseAuth);
                enterpriseAuth.setCode(-1);
                enterpriseAuth.setMessage(next.getString("message"));
                success.remove(enterpriseAuth);
            }
        }

    }

    private EnterpriseAuth findObject(List<EnterpriseAuth> enterpriseAuths,String vin){
        for(EnterpriseAuth enterpriseAuth:enterpriseAuths){
            if(enterpriseAuth.getVin().equals(vin)){
                return enterpriseAuth;
            }
        }
        return null;
    }

    /**
     * 认证流程
     *
     * @param enterpriseAuth
     * @param sysCustomerUnitEntity 所有信息 信息已在校验通过后填充
     */
    private SysRealNameAuthenticationEntity auth(EnterpriseAuth enterpriseAuth, SysCustomerUnitEntity sysCustomerUnitEntity,String cover) {
        //保存数据
        //1.根据VIN获取数据 如果不存在数据 直接绑定人车关系
        SysRealNameAuthenticationEntity authenticationEntity =
                sysRealNameAuthMapper.selectRealNameVin(enterpriseAuth.getVin());

        //如果存在数据且绑定了人关系 直接抛出异常
        SysRealNameAuthenticationEntity saveAuthInfo = null;
        if (authenticationEntity != null &&
                authenticationEntity.getAuthenticationType() != null) {
            String authenticationResult = authenticationEntity.getAuthenticationResult();
            //如果为认证失败 可编辑
            if(!authenticationResult.equals(REAL_NAME_ERROR)){
                throw new RuntimeException("该车已经存在绑定关系!");
            }
            //认证失败的数据 如果更换企业需要用户确认是否覆盖
            //cover == null 则为需要提示
            if(cover == null && !authenticationEntity.getAuthenticationId().equals(sysCustomerUnitEntity.getId())){
                throw new CoverException("当前车辆已经绑定了企业,是否覆盖该企业?");
            }
        }
        saveAuthInfo = authenticationEntity;
        try {
            //流程1
            if (authenticationEntity == null) {
                //同步车辆
                saveAuthInfo = syncVehicle(enterpriseAuth,authenticationEntity);
            }else if(authenticationEntity.getSynResult().equals("0")){
                saveAuthInfo = syncVehicle(enterpriseAuth,authenticationEntity);
            }
            //实名认证
            saveAuthInfo = saveDataAndRealName(enterpriseAuth, sysCustomerUnitEntity, saveAuthInfo);
        } catch (Exception e) {
            throw e;
        }
        return saveAuthInfo;
    }

    private SysRealNameAuthenticationEntity saveDataAndRealName(EnterpriseAuth enterpriseAuth, SysCustomerUnitEntity sysCustomerUnitEntity, SysRealNameAuthenticationEntity saveAuthInfo) {
        //保存数据 开始实名认证
        try{
            realName(enterpriseAuth, sysCustomerUnitEntity);
        }catch (Exception e){
            if(e instanceof NeedUpdateException){
                NeedUpdateException needUpdateException = (NeedUpdateException) e;
                //保存数据
                saveAuthInfo.setAuthenticationResult(needUpdateException.getCode());
                saveAuthInfo.setRemarks(needUpdateException.getMessage());
                saveAuthInfo = saveAuthInfo(enterpriseAuth, sysCustomerUnitEntity,saveAuthInfo);
                sysRealNameAuthMapper.updateByPrimaryKey(saveAuthInfo);
                return saveAuthInfo;
            }
            throw e;
        }
        return saveAuthInfo;
    }

    /**
     * 实名认证
     *
     * @param enterpriseAuth
     * @param sysCustomerUnitEntity
     */
    private void realName(EnterpriseAuth enterpriseAuth, SysCustomerUnitEntity sysCustomerUnitEntity) {
        logger.debug("开始调用实名认证接口");
        Map<String, Object> param = createRealNameRequest(enterpriseAuth, sysCustomerUnitEntity);
        JSONObject authResult = HttpUtil.unicomHttpUrlByParam(UnicomURL.getEnterpriseRealNameReg(),
                new JSONObject(param));
        //接口调用失败
        if (authResult == null) {
            logger.error("调用实名认证接口({})失败 VIN: {}", UnicomURL.getEnterpriseRealNameReg(), enterpriseAuth.getVin());
            throw new RuntimeException("联通车辆同步接口请求失败!");
        }

        String resultCode = authResult.getString("ret_code");
        String message = authResult.getString("ret_msg");
        NeedUpdateException exception = new NeedUpdateException(message);
        //无论成功与否 都保存数据
        if (!resultCode.equals("0")) {
            exception.setCode(REAL_NAME_ERROR);
            throw exception;
        }
        //通过了 判断是是否为转入人工审核
        if(authResult.getJSONObject("response_data").getString("code").equals("1")){
            exception.setCode(REAL_NAME_ING);
            exception.setRmak(authResult.getJSONObject("response_data").getString("message"));
            logger.info("实名认证(VIN：{},NAME: {})转入人工审核",
                    enterpriseAuth.getVin(),sysCustomerUnitEntity.getContact());
            throw exception;
        }
        exception.setCode(REAL_NAME_SUCCESS);
        logger.info("实名认证(VIN：{},NAME: {})成功", enterpriseAuth.getVin(),sysCustomerUnitEntity.getContact());
        throw exception;
    }

    /**
     * 绑定车辆与认证人信息
     * @param enterpriseAuth
     * @param sysCustomerUnitEntity
     * @return
     */
    private Map<String, Object> createRealNameRequest(EnterpriseAuth enterpriseAuth, SysCustomerUnitEntity sysCustomerUnitEntity) {
        Map<String, Object> param = new HashMap<>();
        param.put("vin", enterpriseAuth.getVin());
        param.put("iccid", enterpriseAuth.getIccid());
        param.put("imei", enterpriseAuth.getImei());
        param.put("imsi", enterpriseAuth.getImsi());
        param.put("msisdn", enterpriseAuth.getSimCartNumber());
        param.put("brandid", UnicomURL.getVehicleCompanyBrandCode());
        param.put("sex",sysCustomerUnitEntity.getSex());
        createRealNameMap(sysCustomerUnitEntity, param);
        return param;
    }

    /**
     * 绑定认证人信息
     * @param sysCustomerUnitEntity
     * @param param
     */
    private Map<String, Object> createRealNameMap(SysCustomerUnitEntity sysCustomerUnitEntity, Map<String, Object> param) {
        if(param == null){
            param = new HashMap<>();
        }
        param.put("pic1", sysCustomerUnitEntity.getPic1());//TODO 身份证 图片引入和传入
        param.put("pic2", sysCustomerUnitEntity.getPic2());//TODO 身份证 图片引入和传入
        param.put("facepic", sysCustomerUnitEntity.getFactPic());//TODO 身份证 图片引入和传入
        param.put("servnumber", sysCustomerUnitEntity.getContactInfo());
        param.put("comname", sysCustomerUnitEntity.getName());
        param.put("comaddress", sysCustomerUnitEntity.getCusReplace());
        param.put("comtype", sysCustomerUnitEntity.getComType());
        param.put("industryType", sysCustomerUnitEntity.getIndustryType());
        param.put("licensecode", sysCustomerUnitEntity.getCreditCode());
        param.put("username", sysCustomerUnitEntity.getContact());
        param.put("ownercerttype", sysCustomerUnitEntity.getOwnerCertType());
        param.put("ownercertid", sysCustomerUnitEntity.getOwnerCertId());
        param.put("phoneNum",sysCustomerUnitEntity.getContactInfo());
        param.put("enterpic", sysCustomerUnitEntity.getEnterPic());//TODO 图片引入和传入
        param.put("authpic", sysCustomerUnitEntity.getAuthPic());//TODO 图片引入和传入
        param.put("brandid", UnicomURL.getVehicleCompanyBrandCode());
        param.put("brand", UnicomURL.getVehicleCompanyBrandCode());
        param.put("sex",sysCustomerUnitEntity.getSex());
        return param;
    }

    /**
     * 创建车辆同步参数
     *
     * @param enterpriseAuth
     * @return
     */
    private Map<String, Object> createSyncVehRequest(EnterpriseAuth enterpriseAuth) {
        Map<String, Object> requserData = new HashMap<>();
        requserData.put("vin", enterpriseAuth.getVin());
        requserData.put("iccid", enterpriseAuth.getIccid());
        requserData.put("imei", enterpriseAuth.getImei());
        requserData.put("imsi", enterpriseAuth.getImsi());
        requserData.put("msisdn", enterpriseAuth.getSimCartNumber());
        requserData.put("brand", UnicomURL.getVehicleCompanyBrandCode());
        return requserData;
    }

    /**
     * 同步车辆信息
     *
     * @param enterpriseAuth
     */
    private SysRealNameAuthenticationEntity syncVehicle(EnterpriseAuth enterpriseAuth, SysRealNameAuthenticationEntity authenticationEntity) {
        Map<String, Object> request = new HashMap<>();
        List<Map<String, Object>> vehicles = new ArrayList<>();
        vehicles.add(createSyncVehRequest(enterpriseAuth));
        request.put("vehicles", vehicles);

        JSONObject jsonObject = new JSONObject(request);
        JSONObject syncVehicle = HttpUtil.unicomHttpUrlByParam(UnicomURL.getSyncVehicle(), jsonObject);

        //接口调用失败
        if (syncVehicle == null) {
            logger.error("调用同步车辆接口({})失败 VIN: {}", UnicomURL.getSyncVehicle(), enterpriseAuth.getVin());
            throw new RuntimeException("联通车辆同步接口请求失败!");
        }

        String resultCode = syncVehicle.getString("ret_code");
        //接口调用失败
        if (!resultCode.equals("0")) {
            logger.error("同步车辆({})失败", enterpriseAuth.getVin());
            throw new RuntimeException(syncVehicle.getString("ret_msg"));
        }
        JSONObject vabacks = (JSONObject) syncVehicle.getJSONObject("response_data").getJSONArray("vcbacks").get(0);
        if(!vabacks.getString("retcode").equals("0")){
            throw new RuntimeException(vabacks.getString("message"));
        }
        //同步成功后插入同步信息
        if(authenticationEntity!=null){
            return updateSyncVehRealName(enterpriseAuth,authenticationEntity, syncVehicle.getString("timestamp"));
        }
        return insertSyncVehRealName(enterpriseAuth, syncVehicle.getString("timestamp"));
    }

    private SysRealNameAuthenticationEntity updateSyncVehRealName(EnterpriseAuth enterpriseAuth, SysRealNameAuthenticationEntity authenticationEntity, String timestamp) {
        authenticationEntity.setSysTime(timestamp);
        authenticationEntity.setSynResult("1");
        sysRealNameAuthMapper.updateByPrimaryKeySelective(authenticationEntity);
        return authenticationEntity;
    }

    /**
     * 插入同步后实名认证的数据
     * @param enterpriseAuth
     * @param syncVehicle
     */
    private SysRealNameAuthenticationEntity insertSyncVehRealName(EnterpriseAuth enterpriseAuth, String timestamp) {
        SysRealNameAuthenticationEntity realNameAuth = new SysRealNameAuthenticationEntity();
        realNameAuth.setId(uuid36());
        realNameAuth.setVin(enterpriseAuth.getVin());
        realNameAuth.setState("1");
        realNameAuth.setCreateTime(timestamp);
        realNameAuth.setSysTime(timestamp);
        realNameAuth.setUpdateTime(timestamp);
        realNameAuth.setSynResult("1");
        realNameAuth.setChannelId(enterpriseAuth.getChannelId());
        realNameAuth.setLineNameEn(enterpriseAuth.getLineNameEn());
        sysRealNameAuthMapper.insert(realNameAuth);
        return  realNameAuth;
    }

    /**
     * 保存信息 认证关系
     *
     * @param enterpriseAuth
     * @param sysCustomerUnitEntity
     */
    public SysRealNameAuthenticationEntity saveAuthInfo(EnterpriseAuth enterpriseAuth, SysCustomerUnitEntity sysCustomerUnitEntity,SysRealNameAuthenticationEntity realNameAuth) {
        if(realNameAuth == null){
            realNameAuth = new SysRealNameAuthenticationEntity();
            realNameAuth.setId(uuid36());
            realNameAuth.setCreateTime(DateUtil.getNow());
        }
        realNameAuth.setVin(enterpriseAuth.getVin());
        //see 数据库DDL
        realNameAuth.setAuthenticationType("2");
        realNameAuth.setAuthenticationId(sysCustomerUnitEntity.getId());
//        //补充操作人信息
//        WebUser user = ServletUtil.getUser();
//        realNameAuth.setCreateUserId(user.getId());
        realNameAuth.setUpdateTime(DateUtil.getNow());
        realNameAuth.setAuthenticationTime(DateUtil.getNow());
//        realNameAuth.setUpdateUserId(user.getId());
        realNameAuth.setLineNameEn(enterpriseAuth.getLineNameEn());
        realNameAuth.setChannelId(enterpriseAuth.getChannelId());
        return realNameAuth;
    }

    /**
     * 校验VIN对应的车辆 终端 SIM卡绑定关系
     *
     * @param enterpriseAuth VIN
     * @throws Exception
     */
    @Override
    public void validVehicle(EnterpriseAuth authInfo) throws Exception {
        EnterpriseAuth enterpriseAuth = enterpriseAuthMapper.selectByExample(authInfo);
        //根据VIN无法查询到车辆
        Assert.isTrue(enterpriseAuth == null, "未发现VIN对应的车辆");
        //无终端
        Assert.isTrue(StringUtils.isEmpty(authInfo.getSerialNumber()), "未发现终端相关信息");
        //无SIM卡
        Assert.isTrue(StringUtils.isEmpty(authInfo.getIccid()), "未发现SIM卡相关信息");

        //数据存在校验是否经过篡改
        //比对终端
        Assert.isTrue(enterpriseAuth.getSerialNumber(), authInfo.getSerialNumber(),
                "当前输入的终端信息与系统不一致! 当前系统终端编号: " + enterpriseAuth.getSerialNumber());
        Assert.isTrue(enterpriseAuth.getImei(), authInfo.getImei(),
                "当前输入的IMEI与系统不一致! 当前系统IMEI: " + enterpriseAuth.getImei());

        //MSISDN
        Assert.isTrue(enterpriseAuth.getSimCartNumber(), authInfo.getSimCartNumber(),
                "当前输入的移动用户号码（MSISDN）与系统不一致! 当前系统移动用户号码（MSISDN）: " + enterpriseAuth.getSimCartNumber());

        //ICCID
        Assert.isTrue(enterpriseAuth.getIccid(), authInfo.getIccid(),
                "当前输入的ICCID与系统不一致! 当前系统ICCID: " + enterpriseAuth.getIccid());
    }

    /**
     * 根据 统一社会信用代码 校验实体信息
     *
     * @param sysCustomerUnitEntity 企业信息实体 统一社会信用代码
     * @throws Exception
     */
    @Override
    public void validCustomer(SysCustomerUnitEntity sysCustomerUnitEntity) throws Exception {
        SysCustomerUnitEntity customerUnit =
                sysCustomerUnitEntityMapper.selectCustomerByCode(sysCustomerUnitEntity);
        //1.无此企业 保存企业信息
        if (customerUnit == null) {
            saveCustomerUnit(sysCustomerUnitEntity);
            logger.info("validCustomer()： 根据统一企业代码({})未发现企业信息,保存企业信息。",
                    sysCustomerUnitEntity.getCreditCode());
            return;
        }
        //记录ID
        sysCustomerUnitEntity.setId(customerUnit.getId());
        //2.处理企业是否存在认证中或认证通过的车辆 如果不存在更新
        List<SysRealNameAuthenticationEntity> realNameAuthenticationEntities =
                sysRealNameAuthMapper.selectRealName(customerUnit.getId());
        if (realNameAuthenticationEntities == null || realNameAuthenticationEntities.size() == 0) {
            sysCustomerUnitEntity.setUpdateTime(DateUtil.getNow());
            sysCustomerUnitEntityMapper.updateByCreditCode(sysCustomerUnitEntity);
            logger.info("validCustomer()： 根据统一企业代码({})发现企业信息但是未申请申明认证,更新企业信息。",
                    sysCustomerUnitEntity.getCreditCode());
            return;
        }
        logger.info("validCustomer()： 此企业提交了实名认证,开始比对数据。",
                sysCustomerUnitEntity.getCreditCode());
        //3.存在认证的车辆 开始强制校验
        //异常数据统一社会信用代码重复
        sysCustomerUnitEntity.setId(customerUnit.getId());
        //存在数据 判断是否被篡改
        String message = "当前输入的%s与系统不一致! 系统为: [ %s ]";
        //负责人姓名
        Assert.isTrue(customerUnit.getContact(), sysCustomerUnitEntity.getContact(),
                String.format(message, "负责人姓名", customerUnit.getContact()));
        //性别
        Assert.isTrue(customerUnit.getSex(), sysCustomerUnitEntity.getSex(),
                String.format(message, "性别", constantMap.getSex().get(customerUnit.getSex())));
        //证件类型
        Assert.isTrue(customerUnit.getOwnerCertType(), sysCustomerUnitEntity.getOwnerCertType(),
                String.format(message, "证件类型", constantMap.getOwnerCertType().get(customerUnit.getOwnerCertType())));
        //证件号码
        Assert.isTrue(customerUnit.getOwnerCertId(), sysCustomerUnitEntity.getOwnerCertId(),
                String.format(message, "证件号码", customerUnit.getOwnerCertId()));
        //联系电话
        Assert.isTrue(customerUnit.getContactInfo(), sysCustomerUnitEntity.getContactInfo(),
                String.format(message, "联系电话", customerUnit.getContactInfo()));

        //企业名称
        Assert.isTrue(customerUnit.getName(), sysCustomerUnitEntity.getName(),
                String.format(message, "企业名称", customerUnit.getName()));
        //企业地址
        Assert.isTrue(customerUnit.getCusReplace(), sysCustomerUnitEntity.getCusReplace(),
                String.format(message, "企业地址", customerUnit.getCusReplace()));
        //企业类型
        Assert.isTrue(customerUnit.getComType(), sysCustomerUnitEntity.getComType(),
                String.format(message, "企业类型", constantMap.getCompType().get(customerUnit.getComType())));
        //行业类型
        Assert.isTrue(customerUnit.getIndustryType(), sysCustomerUnitEntity.getIndustryType(),
                String.format(message, "行业类型", constantMap.getIndustryType().get(customerUnit.getIndustryType())));

        //填充所有信息
        BeanUtils.copyProperties(customerUnit, sysCustomerUnitEntity);

    }

    /**
     * 保存企业信息
     *
     * @param sysCustomerUnitEntity
     */
    private void saveCustomerUnit(SysCustomerUnitEntity sysCustomerUnitEntity) {
        sysCustomerUnitEntity.setId(uuid36());
        sysCustomerUnitEntity.setState("1");
        sysCustomerUnitEntity.setCreateTime(DateUtil.getNow());
        sysCustomerUnitEntity.setUpdateTime(DateUtil.getNow());
        sysCustomerUnitEntityMapper.insert(sysCustomerUnitEntity);
    }

    private String uuid36() {
        return UtilHelper.getUUID();
    }

    /**
     * 获取对象所有字段是否为null
     * @param o
     * @return
     */
    public static boolean allfieldIsNUll(Object o){
        try{
            for(Field field:o.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object object = field.get(o);
                if(object instanceof CharSequence){
                    if(!ObjectUtils.isEmpty((String)object)){
                        return false;
                    }
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return true;
    }

}
