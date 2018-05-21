package com.bitnei.cloud.report.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.common.HttpUtil;
import com.bitnei.cloud.common.bean.ExcelData;
import com.bitnei.cloud.common.pojo.UnicomURL;
import com.bitnei.cloud.common.util.DataLoader;
import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.common.util.EasyExcel;
import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.*;
import com.bitnei.cloud.report.mapper.EnterpriseAuthMapper;
import com.bitnei.cloud.report.mapper.SysAuthPersonalTempMapper;
import com.bitnei.cloud.report.mapper.SysOwnerPeopleMapper;
import com.bitnei.cloud.report.mapper.SysRealNameAuthMapper;
import com.bitnei.cloud.report.service.ICompanyAuthService;
import com.bitnei.cloud.report.service.IPeopleAuthService;
import com.bitnei.cloud.report.util.Assert;
import com.bitnei.cloud.report.util.CoverException;
import com.bitnei.cloud.report.util.ValidateException;
import com.bitnei.cloud.report.util.NeedUpdateException;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import com.bitnei.commons.util.UtilHelper;
import jodd.json.impl.ObjectJsonSerializer;
import org.apache.shiro.crypto.hash.Hash;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.support.RequestContext;

import java.util.*;

@Service
@Transactional
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.SysAuthPersonalTempMapper")
public class PeopleAuthService extends BaseService implements IPeopleAuthService{

    @Autowired
    ICompanyAuthService iCompanyAuthService;

    @Autowired
    SysAuthPersonalTempMapper sysAuthPersonalTempMapper;

    @Autowired
    SysOwnerPeopleMapper sysOwnerPeopleMapper;

    @Autowired
    EnterpriseAuthMapper enterpriseAuthMapper;

    @Autowired
    SysRealNameAuthMapper sysRealNameAuthMapper;



    /**
     * 个人实名认证分页查询
     * @return
     */
    @Override
    public PagerModel pageQuery() {

        DataGridOptions options = ServletUtil.getDataLayOptions();
        PagerModel pm = findPagerModel("findPersonalAuth",options);
        return pm;

    }

    /**
     * 个人实名认证保存(临时表)
     * @param o
     * @return
     */
    @Override
    public int insert(Object o) {
        SysAuthenticationPersonalTempEntity sysAuthenticationPersonalTempEntity = (SysAuthenticationPersonalTempEntity)o;
        sysAuthenticationPersonalTempEntity.setId(UtilHelper.getUUID());
        sysAuthenticationPersonalTempEntity.setCreateTime(DateUtil.getNow());
        sysAuthenticationPersonalTempEntity.setUpdateTime(DateUtil.getNow());
        //TODO 添加当前用户信息
        return super.insert(sysAuthenticationPersonalTempEntity);
    }


    /**
     * 个人实名认证
     * @param sysOwnerPeopleEntity
     * @param enterpriseAuth
     */
    @Override
    public SysRealNameAuthenticationEntity authPersonal(String cover,EnterpriseAuth enterpriseAuth,SysOwnerPeopleEntity sysOwnerPeopleEntity){
        try{

            //车辆验证
            validVehicle(enterpriseAuth);
            //验证人
            validPersonal(sysOwnerPeopleEntity);

            SysRealNameAuthenticationEntity realNameAuthenticationEntity=sysRealNameAuthMapper.selectRealNameVin(enterpriseAuth.getVin());
            JSONObject syncResult=null;
            JSONObject authResult=null;
            if(realNameAuthenticationEntity==null){
                //sys_real没有数据,同步,实名
                syncResult=sync(enterpriseAuth);
                authResult=auth(enterpriseAuth,sysOwnerPeopleEntity);
                SysRealNameAuthenticationEntity saveAuthInfo=saveAuthInfo(enterpriseAuth,sysOwnerPeopleEntity,syncResult.getString("timestamp"),authResult);
                sysRealNameAuthMapper.insert(saveAuthInfo);
                return saveAuthInfo;
            }else if(realNameAuthenticationEntity!=null){
               if(!"1".equals(realNameAuthenticationEntity.getSynResult())){
                   syncResult=sync(enterpriseAuth);
                   realNameAuthenticationEntity.setSynResult("1");
                   realNameAuthenticationEntity.setSysTime(syncResult.getString("timestamp"));
                   realNameAuthenticationEntity.setUpdateTime(DateUtil.getNow());
//                   realNameAuthenticationEntity.setAuthenticationType("1");
                   //TODO 添加修改人信息
                   sysRealNameAuthMapper.updateByPrimaryKeySelective(realNameAuthenticationEntity);
               }
               if((realNameAuthenticationEntity.getAuthenticationResult().equals("1")||realNameAuthenticationEntity.getAuthenticationResult().equals("2"))&&realNameAuthenticationEntity.getAuthenticationResult()!=null){
                   throw new RuntimeException("车辆已存在认证信息");
               }else if(realNameAuthenticationEntity.getAuthenticationResult()!=null&&(realNameAuthenticationEntity.getAuthenticationResult().equals("0")||realNameAuthenticationEntity.getAuthenticationResult().equals("3"))&&!cover.equals("Cover")){
                   if(!sysOwnerPeopleEntity.getId().equals(realNameAuthenticationEntity.getAuthenticationId())){
                       throw new CoverException("该车辆已存在未通过的认证信息，是否要覆盖？");
                   }
               }else if(realNameAuthenticationEntity.getAuthenticationResult()==null||cover.equals("Cover")){
                   authResult=auth(enterpriseAuth,sysOwnerPeopleEntity);
                   if(authResult.getString("ret_code").equals("0")){
                       realNameAuthenticationEntity.setAuthenticationResult(authResult.getJSONObject("response_data").getString("code"));
                       realNameAuthenticationEntity.setRemarks(authResult.getJSONObject("response_data").getString("message"));
                   }else if(!authResult.getString("ret_code").equals("0")){
                       realNameAuthenticationEntity.setAuthenticationResult("3");
                       realNameAuthenticationEntity.setRemarks(authResult.getString("ret_msg"));
                   }
                   realNameAuthenticationEntity.setAuthenticationTime(authResult.getString("timestamp"));
                   realNameAuthenticationEntity.setUpdateTime(DateUtil.getNow());
                   realNameAuthenticationEntity.setAuthenticationType("1");
                   realNameAuthenticationEntity.setAuthenticationId(sysOwnerPeopleEntity.getId());
                   //TODO 添加修改人信息
                   sysRealNameAuthMapper.updateByPrimaryKeySelective(realNameAuthenticationEntity);
               }
            }
            return realNameAuthenticationEntity;
        }catch (Exception e){
            if(e instanceof CoverException){
                //抛出覆盖异常
                throw new CoverException(e.getMessage());
            }
            if(e instanceof ValidateException||e instanceof NeedUpdateException){
                //与系统数据验证存在异常
                throw new ValidateException(e.getMessage());
            }
            throw new RuntimeException(e.getMessage());
        }
    }


    /**
     * 个人车辆绑定
     * @param sysOwnerPeopleEntity
     * @param enterpriseAuth
     */
    @Override
    public void savePersonalBinding(String cover,EnterpriseAuth enterpriseAuth,SysOwnerPeopleEntity sysOwnerPeopleEntity){
        try{
            //车辆验证
            validVehicle(enterpriseAuth);
            //验证人
            validPersonal(sysOwnerPeopleEntity);
            SysRealNameAuthenticationEntity realNameAuthenticationEntity=sysRealNameAuthMapper.selectRealNameVin(enterpriseAuth.getVin());

            JSONObject syncResult=null;
            JSONObject bindResult=null;
            JSONObject authResult=null;
            if(realNameAuthenticationEntity==null){
                syncResult=sync(enterpriseAuth);
                SysRealNameAuthenticationEntity saveAuthInfo=saveAuthInfo(enterpriseAuth,sysOwnerPeopleEntity,syncResult.getString("timestamp"),null);
                sysRealNameAuthMapper.insert(saveAuthInfo);
                bindResult=personalBinding(enterpriseAuth,sysOwnerPeopleEntity);
                //如果个人绑定成功，走实名结果查询
                if(bindResult.getString("ret_code").equals("0")){
                    authResult=queryResult(enterpriseAuth,sysOwnerPeopleEntity);
                }
                if(authResult!=null){
                    if(authResult.getJSONObject("response_data")!=null){
                        saveAuthInfo.setAuthenticationResult(authResult.getJSONObject("response_data").getString("isrealname"));
                    }else{
                        saveAuthInfo.setAuthenticationResult("3");
                    }
                    saveAuthInfo.setAuthenticationTime(authResult.getString("timestamp"));
                }else{
                    saveAuthInfo.setAuthenticationResult("3");
                    saveAuthInfo.setAuthenticationTime(DateUtil.getNow());
                }
                saveAuthInfo.setAuthenticationType("1");
                saveAuthInfo.setAuthenticationId(sysOwnerPeopleEntity.getId());
                saveAuthInfo.setRemarks(bindResult.getString("ret_msg"));
                saveAuthInfo.setUpdateTime(DateUtil.getNow());
                saveAuthInfo.setLineNameEn(enterpriseAuth.getLineNameEn());
                saveAuthInfo.setChannelId(enterpriseAuth.getChannelId());
                //TODO 添加修改人信息
                sysRealNameAuthMapper.updateByPrimaryKeySelective(saveAuthInfo);
            }else if(realNameAuthenticationEntity!=null){
                if(!"1".equals(realNameAuthenticationEntity.getSynResult())){
                    syncResult=sync(enterpriseAuth);
                    realNameAuthenticationEntity.setSynResult("1");
                    realNameAuthenticationEntity.setSysTime(syncResult.getString("timestamp"));
                    realNameAuthenticationEntity.setUpdateTime(DateUtil.getNow());
//                    realNameAuthenticationEntity.setAuthenticationType("1");
                    //TODO 添加修改人信息
                    realNameAuthenticationEntity.setLineNameEn(enterpriseAuth.getLineNameEn());
                    realNameAuthenticationEntity.setChannelId(enterpriseAuth.getChannelId());
                    sysRealNameAuthMapper.updateByPrimaryKeySelective(realNameAuthenticationEntity);
                }
                if(realNameAuthenticationEntity.getAuthenticationResult()!=null) {
                    if (realNameAuthenticationEntity.getAuthenticationResult().equals("1") || realNameAuthenticationEntity.getAuthenticationResult().equals("2")) {
                        throw new RuntimeException("车辆已存在绑定信息");
                    } else if (((realNameAuthenticationEntity.getAuthenticationResult().equals("0") || realNameAuthenticationEntity.getAuthenticationResult().equals("3"))) && !cover.equals("Cover")) {
                        if(!sysOwnerPeopleEntity.getId().equals(realNameAuthenticationEntity.getAuthenticationId())){
                            throw new CoverException("该车辆已存在未通过的认证信息是否要覆盖？");
                        }
                    }
                }
                bindResult=personalBinding(enterpriseAuth,sysOwnerPeopleEntity);
                //如果个人绑定成功，走实名结果查询
                if(bindResult.getString("ret_code").equals("0")){
                    authResult=queryResult(enterpriseAuth,sysOwnerPeopleEntity);
                }
                if(authResult!=null){
                    if(authResult.getJSONObject("response_data")!=null){
                        realNameAuthenticationEntity.setAuthenticationResult(authResult.getJSONObject("response_data").getString("isrealname"));
                    }else{
                        realNameAuthenticationEntity.setAuthenticationResult("3");
                    }
                    realNameAuthenticationEntity.setAuthenticationTime(authResult.getString("timestamp"));
                }else{
                    realNameAuthenticationEntity.setAuthenticationResult("3");
                    realNameAuthenticationEntity.setAuthenticationTime(DateUtil.getNow());
                }
                realNameAuthenticationEntity.setAuthenticationType("1");
                realNameAuthenticationEntity.setAuthenticationId(sysOwnerPeopleEntity.getId());
                realNameAuthenticationEntity.setUpdateTime(DateUtil.getNow());
                realNameAuthenticationEntity.setRemarks(bindResult.getString("ret_msg"));
                //TODO 添加修改人信息
                realNameAuthenticationEntity.setLineNameEn(enterpriseAuth.getLineNameEn());
                realNameAuthenticationEntity.setChannelId(enterpriseAuth.getChannelId());
                sysRealNameAuthMapper.updateByPrimaryKeySelective(realNameAuthenticationEntity);
            }

        }catch (Exception e){
            if(e instanceof CoverException){
                //抛出覆盖异常
                throw new CoverException(e.getMessage());
            }
            if(e instanceof ValidateException || e instanceof NeedUpdateException){
                //与系统数据验证存在异常
                throw new ValidateException(e.getMessage());
            }
            throw new RuntimeException(e.getMessage());
        }
    }

    /**
     * 根据 个人身份证号码 校验实体信息
     * @param sysOwnerPeopleEntity 个人信息实体
     * @throws Exception
     */
    @Override
    public void validPersonal(SysOwnerPeopleEntity sysOwnerPeopleEntity) throws Exception {
        int num =unique("findUser",sysOwnerPeopleEntity.getOwnerCertId());
        if(num!=0){
            //验证时否有认证中和认证通过的信息
            int nums=unique("findUsers",sysOwnerPeopleEntity.getOwnerCertId());
            if(nums>0&&nums<=4){
                //个人车主信息验证
                List<SysOwnerPeopleEntity> ownpeoples = sysOwnerPeopleMapper.findOwnerByOwnerCert(sysOwnerPeopleEntity);
                //无次个人车主
                Assert.isTrue(ownpeoples.size() == 0,"无此个人车主",1);
                SysOwnerPeopleEntity ownerPeople=ownpeoples.get(0);
                sysOwnerPeopleEntity.setId(ownerPeople.getId());
                //存在数据 判断是否被篡改
                String message = "当前输入的%s与系统不一致! 系统为: [ %s ]";
                //个人车主姓名
                Assert.isTrue(ownerPeople.getOwnerName(),sysOwnerPeopleEntity.getOwnerName(),
                        String.format(message,"姓名",ownerPeople.getOwnerName()),1);
                //性别
                Assert.isTrue(ownerPeople.getSex(),sysOwnerPeopleEntity.getSex(),
                        String.format(message,"性别",ownerPeople.getSex()),1);
                //证件类型
                Assert.isTrue(ownerPeople.getOwnerCertType(),sysOwnerPeopleEntity.getOwnerCertType(),
                        String.format(message,"证件类型",ownerPeople.getOwnerCertType()),1);
                //证件号码
                Assert.isTrue(ownerPeople.getOwnerCertId(),sysOwnerPeopleEntity.getOwnerCertId(),
                        String.format(message,"证件号码",ownerPeople.getOwnerCertId()),1);
                //联系电话
                Assert.isTrue(ownerPeople.getMobilePhone(),sysOwnerPeopleEntity.getMobilePhone(),
                        String.format(message,"联系电话",ownerPeople.getMobilePhone()),1);

                BeanUtils.copyProperties(ownerPeople,sysOwnerPeopleEntity);
            }else if(nums>4){
                throw new ValidateException("个人账户下已有5辆车处于实名认证或认证中，不能有绑定更多车辆!");
            }else if(nums==0){
                //修改个人信息
                sysOwnerPeopleMapper.updateByCertId(sysOwnerPeopleEntity);
                String id=unique("findid",sysOwnerPeopleEntity.getOwnerCertId());
                sysOwnerPeopleEntity.setId(id);
            }
        }else {
            //保存个人信息
            sysOwnerPeopleEntity.setId(uuid36());
            sysOwnerPeopleEntity.setCreateTime(DateUtil.getNow());
            sysOwnerPeopleEntity.setOwnerType(4);
            sysOwnerPeopleMapper.insert(sysOwnerPeopleEntity);
        }
   }

    /**
     * 校验VIN对应的车辆 终端 SIM卡绑定关系
     *
     * @param authInfo
     * @throws Exception
     */
    @Override
    public void validVehicle(EnterpriseAuth authInfo) throws Exception {
        EnterpriseAuth enterpriseAuth = enterpriseAuthMapper.selectByExample(authInfo);
        //根据VIN无法查询到车辆
        Assert.isTrue(enterpriseAuth == null, "未发现VIN对应的车辆",1);
        //无终端
        Assert.isTrue(StringUtils.isEmpty(enterpriseAuth.getSysTermModelUnitId()), "未发现终端相关信息",1);
        //无SIM卡
        Assert.isTrue(StringUtils.isEmpty(enterpriseAuth.getIccid()), "未发现SIM卡相关信息",1);

        //数据存在校验是否经过篡改
        //比对终端
        Assert.isTrue(enterpriseAuth.getSerialNumber(), authInfo.getSerialNumber(),
                "当前输入的终端信息与系统不一致! 当前系统终端编号: " + enterpriseAuth.getSerialNumber(),1);
        Assert.isTrue(enterpriseAuth.getImei(), authInfo.getImei(),
                "当前输入的IMEI与系统不一致! 当前系统IMEI: " + enterpriseAuth.getImei(),1);

        //MSISDN
        Assert.isTrue(enterpriseAuth.getSimCartNumber(), authInfo.getSimCartNumber(),
                "当前输入的移动用户号码（MSISDN）与系统不一致! 当前系统移动用户号码（MSISDN）: " + enterpriseAuth.getSimCartNumber(),1);

        //ICCID
        Assert.isTrue(enterpriseAuth.getIccid(), authInfo.getIccid(),
                "当前输入的ICCID与系统不一致! 当前系统ICCID: " + enterpriseAuth.getIccid(),1);
    }

    @Override
    public List<SysRealNameAuthenticationEntity> checkAuthInfo(String id) {
        return this.sysRealNameAuthMapper.findAuthInfoByAuthId(id);
    }


    /**
     *
     * 同步接口调用
     * @param enterpriseAuth
     *
     */
    private JSONObject sync(EnterpriseAuth enterpriseAuth){
        JSONObject syncResult=null;
        HashMap param = new HashMap();
        HashMap map = new HashMap();
        ArrayList list = new ArrayList();
        map.put("vin", enterpriseAuth.getVin());
        map.put("brand", UnicomURL.getVehicleCompanyBrandCode());
        map.put("iccid", enterpriseAuth.getIccid());
        map.put("imsi", enterpriseAuth.getImsi());
        map.put("imei", enterpriseAuth.getImei());
        map.put("msisdn", enterpriseAuth.getSimCartNumber());
        list.add(0, map);
        param.put("vehicles", list);
        syncResult = HttpUtil.unicomHttpUrlByParam(UnicomURL.getSyncVehicle(), new JSONObject(param));
        if(syncResult==null){
            throw new RuntimeException("同步接口调用失败");
        }else{
            JSONObject object=(JSONObject)syncResult.getJSONObject("response_data").getJSONArray("vcbacks").get(0);
            String retcode=object.getString("retcode");
            if(retcode.equals("1")){
                throw new RuntimeException("同步失败:"+object.getString("message"));
            }else{
                return syncResult;
            }
        }
    }


    /**
     *
     * 实名认证接口调用
     * @param enterpriseAuth
     * @param sysOwnerPeopleEntity
     */
    private JSONObject auth(EnterpriseAuth enterpriseAuth,SysOwnerPeopleEntity sysOwnerPeopleEntity){
        JSONObject authResult=null;
        HashMap authmap=new HashMap();
        authmap.put("vin",enterpriseAuth.getVin());
        authmap.put("brandid", UnicomURL.getVehicleCompanyBrandCode());
        authmap.put("iccid",enterpriseAuth.getIccid());
        authmap.put("imsi",enterpriseAuth.getImsi());
        authmap.put("msisdn",enterpriseAuth.getSimCartNumber());
        authmap.put("imei",enterpriseAuth.getImei());
        authmap.put("username",sysOwnerPeopleEntity.getOwnerName());
        authmap.put("gender",sysOwnerPeopleEntity.getSex());
        authmap.put("ownercerttype",sysOwnerPeopleEntity.getOwnerCertType());
        authmap.put("ownercertid",sysOwnerPeopleEntity.getOwnerCertId());
        authmap.put("ownercertaddr",sysOwnerPeopleEntity.getOwnerCertAddr());
        authmap.put("pic1",sysOwnerPeopleEntity.getPic1());
        authmap.put("pic2",sysOwnerPeopleEntity.getPic2());
        authmap.put("facepic",sysOwnerPeopleEntity.getFacePic());
        authmap.put("servnumber",sysOwnerPeopleEntity.getMobilePhone());
        authmap.put("email",sysOwnerPeopleEntity.getEmail());
        authResult= HttpUtil.unicomHttpUrlByParam(UnicomURL.getPersonalRealNameReg(),new JSONObject(authmap) );
        if(authResult==null){
            throw new RuntimeException("实名认证接口调用失败");
        }
        return authResult;
    }

    /**
     *
     * 个人车辆绑定接口调用
     * @param enterpriseAuth
     * @param sysOwnerPeopleEntity
     */
    private JSONObject personalBinding(EnterpriseAuth enterpriseAuth,SysOwnerPeopleEntity sysOwnerPeopleEntity){
        JSONObject bindingResult=null;
        HashMap bindmap=new HashMap();
        bindmap.put("vin",enterpriseAuth.getVin());
        bindmap.put("iccid",enterpriseAuth.getIccid());
        bindmap.put("imsi",enterpriseAuth.getImsi());
        bindmap.put("msisdn",enterpriseAuth.getSimCartNumber());
        bindmap.put("imei",enterpriseAuth.getImei());
        bindmap.put("username",sysOwnerPeopleEntity.getOwnerName());
        bindmap.put("ownercerttype",sysOwnerPeopleEntity.getOwnerCertType());
        bindmap.put("ownercertid",sysOwnerPeopleEntity.getOwnerCertId());
        bindmap.put("servnumber",sysOwnerPeopleEntity.getMobilePhone());
        bindmap.put("brandid", UnicomURL.getVehicleCompanyBrandCode());
        bindingResult=HttpUtil.unicomHttpUrlByParam(UnicomURL.getPersonalBindVehicle(),new JSONObject(bindmap));
        if(bindmap==null){
            throw new RuntimeException("个人车辆绑定接口调用失败");
        }
        return bindingResult;
    };

    /**
     * 认证结果查询接口调用
     * @param enterpriseAuth
     * @param sysOwnerPeopleEntity
     */
    private JSONObject queryResult(EnterpriseAuth enterpriseAuth,SysOwnerPeopleEntity sysOwnerPeopleEntity){
        JSONObject queryResult=null;
        HashMap querymap=new HashMap();
        querymap.put("vin",enterpriseAuth.getVin());
        querymap.put("imei",enterpriseAuth.getImei());
        querymap.put("brandid", UnicomURL.getVehicleCompanyBrandCode());
        queryResult=HttpUtil.unicomHttpUrlByParam(UnicomURL.getQueryRealName(),new JSONObject(querymap));
        if(querymap==null){
            throw new RuntimeException("实名结果查询失败");
        }
        return queryResult;
    };

    /**
     * 保存信息 认证关系
     * @param enterpriseAuth
     * @param sysOwnerPeopleEntity
     */
    public SysRealNameAuthenticationEntity saveAuthInfo(EnterpriseAuth enterpriseAuth, SysOwnerPeopleEntity sysOwnerPeopleEntity,String synctimestamp,JSONObject authResult){
        SysRealNameAuthenticationEntity realNameAuth = new SysRealNameAuthenticationEntity();
        realNameAuth.setId(uuid36());
        realNameAuth.setVin(enterpriseAuth.getVin());
        realNameAuth.setCreateTime(DateUtil.getNow());
        realNameAuth.setUpdateTime(DateUtil.getNow());
        realNameAuth.setState("1");
        realNameAuth.setSynResult("0");
        realNameAuth.setSysTime(synctimestamp);
        if(authResult!=null) {
            if (authResult.getString("ret_code").equals("0")) {
                realNameAuth.setAuthenticationResult(authResult.getJSONObject("response_data").getString("code"));
                realNameAuth.setRemarks(authResult.getJSONObject("response_data").getString("message"));
            } else if (!authResult.getString("ret_code").equals("0")) {
                realNameAuth.setAuthenticationResult("3");
                realNameAuth.setRemarks(authResult.getString("ret_msg"));
            }
            realNameAuth.setAuthenticationTime(authResult.getString("timestamp"));
            realNameAuth.setAuthenticationType("1");
            realNameAuth.setAuthenticationId(sysOwnerPeopleEntity.getId());
        }
        //TODO 添加操作人信息
        return realNameAuth;
    }

    /**
     * 获取id方法
     */
    private String uuid36() {
        return UtilHelper.getUUID().toString();
    }

    /**
     * 导出
     */
    @Override
    public void export() {

        List list = findBySqlId("findPersonalAuth",ServletUtil.getQueryParams());
        DataLoader.loadNames(list);
        DataLoader.loadDictNames(list);

        String srcBase = RequestContext.class.getResource("/templates/").getFile();
        String srcFile = srcBase +"module/report/PeopleAuth/export.xls";

        ExcelData ed = new ExcelData();
        ed.setTitle("个人实名认证");
        ed.setExportTime(DateUtil.getNow());
        ed.setData(list);
        String outName = String.format("%s-导出-%s.xls", "个人实名认证", DateUtil.getShortDate());
        EasyExcel.renderResponse(srcFile,outName,ed);

    }

    /**
     * 修改个人实名认证
     * @param enterpriseAuth
     * @param sysOwnerPeopleEntity
     */
    public void updatePeopleAuth(EnterpriseAuth enterpriseAuth, SysOwnerPeopleEntity sysOwnerPeopleEntity){
        sysRealNameAuthMapper.deleteByPrimaryKey(sysOwnerPeopleEntity.getId());
        authPersonal(null,enterpriseAuth,sysOwnerPeopleEntity);
    }


    /**
     * 页面提交
     * @param id
     */
    public void submitPeopleAuth(String id,String cover){
        SysAuthenticationPersonalTempEntity authenticationPersonalTempEntity=sysAuthPersonalTempMapper.selectByPrimaryKey(id);
        EnterpriseAuth enterpriseAuth=new EnterpriseAuth();
        SysOwnerPeopleEntity sysOwnerPeopleEntity=new SysOwnerPeopleEntity();
        BeanUtils.copyProperties(authenticationPersonalTempEntity,enterpriseAuth);
        BeanUtils.copyProperties(authenticationPersonalTempEntity,sysOwnerPeopleEntity);
        authPersonal(cover,enterpriseAuth,sysOwnerPeopleEntity);
        sysAuthPersonalTempMapper.deleteByPrimaryKey(id);
    }

    /**
     *根据证件号查询个人信息
     * @param id
     */
     public SysOwnerPeopleEntity selectByOwnerCert(String id){
         return sysOwnerPeopleMapper.selectByOwnerCert(id);
     };
}