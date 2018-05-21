package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.SysOwnerPeopleEntity;
import com.bitnei.cloud.report.domain.SysRealNameAuthenticationEntity;
import com.bitnei.cloud.report.enums.ResultEnum;
import com.bitnei.cloud.report.enums.SysOwnerPeopleEnum;
import com.bitnei.cloud.report.mapper.SysOwnerPeopleMapper;
import com.bitnei.cloud.report.service.IPersonCarOwnerService;
import com.bitnei.cloud.report.service.ISysRealNameAuthService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import com.bitnei.commons.util.UtilHelper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

/**
 * <p>
 * ----------------------------------------------------------------------------- <br>
 * 工程名 ： 基础框架 <br>
 * 功能： 个人车主实现<br>
 * 描述： 个人车主实现<br>
 * 授权 : (C) Copyright (c) 2017 <br>
 * 公司 : 北京理工新源信息科技有限公司<br>
 * ----------------------------------------------------------------------------- <br>
 * 修改历史 <br>
 * <table width="432" border="1">
 * <tr>
 * <td>版本</td>
 * <td>时间</td>
 * <td>作者</td>
 * <td>改变</td>
 * </tr>
 * <tr>
 * <td>1.0</td>
 * <td>2018-01-08 15:16:18</td>
 * <td>liuhaiyuan</td>
 * <td>创建</td>
 * </tr>
 * </table>
 * <br>
 * <font color="#FF0000">注意: 本内容仅限于[北京理工新源信息科技有限公司]内部使用，禁止转发</font> <br>
 *
 * @version 1.0
 *
 * @author liuhaiyuan
 * @since JDK1.8
 */
@Service
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.SysOwnerPeopleMapper" )
public class PersonCarOwnerService extends BaseService implements IPersonCarOwnerService {

    @Autowired
    private SysOwnerPeopleMapper sysOwnerPeopleMapper;

    @Autowired
    private ISysRealNameAuthService iSysRealNameAuthService;
    @Override
    public PagerModel pageQuery() {
        DataGridOptions options = ServletUtil.getDataLayOptions();
        PagerModel pm = findPagerModel("pagerModel",options);
        return pm;
    }
    /**
     * 新增
     * @param sysOwnerPeopleEntity
     * @return
     */
    @Override
    public AppBean saveOrUpdate(SysOwnerPeopleEntity sysOwnerPeopleEntity) {
        if (sysOwnerPeopleEntity!=null){
            if (StringUtils.isBlank(sysOwnerPeopleEntity.getId())){
                sysOwnerPeopleEntity.setId(UtilHelper.getUUID());
                sysOwnerPeopleEntity.setCreateTime(DateUtil.getNow());
                sysOwnerPeopleEntity.setUpdateTime(DateUtil.getNow());
                sysOwnerPeopleEntity.setOwnerType(SysOwnerPeopleEnum.PERSON_OWNER.getValue());
                List<SysOwnerPeopleEntity> list = this.findOwnerByOwnerCert(sysOwnerPeopleEntity);
                if (list.size()>0){
                    return new AppBean(ResultEnum.RESULT_NO.getValue(), "身份重复");
                }
                //todo 添加创建人更新人的信息
                int insertCount = super.insert(sysOwnerPeopleEntity);
                if (insertCount > 0){
                    return new AppBean(ResultEnum.RESULT_YES.getValue(),"保存成功");
                }
                return new AppBean(ResultEnum.RESULT_NO.getValue(), "保存失败");
            }else{
                sysOwnerPeopleEntity.setUpdateTime(DateUtil.getNow());
                //todo 添加更新人的信息
                //判断证件号
                List<SysOwnerPeopleEntity> list = this.findOwnerByOwnerCertForUpdate(sysOwnerPeopleEntity);
                if (list.size()>0){
                    return new AppBean(ResultEnum.RESULT_NO.getValue(), "身份重复");
                }
                //判断实名认证
                List<SysRealNameAuthenticationEntity> realNameList = this.iSysRealNameAuthService.selectRealNameResult(sysOwnerPeopleEntity);
                if (realNameList.size()>0){
                    return new AppBean(ResultEnum.RESULT_NO.getValue(), "当前车主正在认证中或者已通过不能编辑");
                }
                int updateCount = super.update(sysOwnerPeopleEntity);
                if (updateCount > 0){
                    return new AppBean(ResultEnum.RESULT_YES.getValue(),"更新成功");
                }
                return new AppBean(ResultEnum.RESULT_NO.getValue(), "更新失败");
            }
        }
        return new AppBean(ResultEnum.RESULT_NO.getValue(), "保存失败");
    }

    @Override
    public AppBean del(String ids) {
        String[] arr = ids.split(",");
        int len = arr.length;
        if (len<0){
            return new AppBean(ResultEnum.RESULT_NO.getValue(), "请选择数据");
        }
        //查找所有的车主的认证结果
        StringBuffer sb = new StringBuffer("(");

        for (int i=0;i<arr.length;i++){
            if (i<arr.length-1){
                sb.append("'"+arr[i]+"',");
            }else {
                sb.append("'"+arr[i]+"'");
            }
        }
        sb.append(")");
        List<String> list = this.iSysRealNameAuthService.findByAuthIdAndStatus(sb.toString());
        int count = 0;
        for (String id:arr){
            if (list.contains(id)){
                continue;
            }
            int r = super.delete(id);
            count += r;
        }
        return new AppBean(ResultEnum.RESULT_YES.getValue(), "删除 "+ count +" 条记录，"+(len-count)+" 正在认证中或已通过不能被删除");
    }

    @Override
    public List<SysOwnerPeopleEntity> findOwnerByOwnerCert(SysOwnerPeopleEntity sysOwnerPeopleEntity) {
        return this.sysOwnerPeopleMapper.findOwnerByOwnerCert(sysOwnerPeopleEntity);
    }

    @Override
    public List<SysOwnerPeopleEntity> findOwnerByOwnerCertForUpdate(SysOwnerPeopleEntity sysOwnerPeopleEntity) {
        return this.sysOwnerPeopleMapper.findOwnerByOwnerCertForUpdate(sysOwnerPeopleEntity);
    }

}
