package com.bitnei.cloud.report.service.impl;

import com.bitnei.cloud.common.util.DateUtil;
import com.bitnei.cloud.common.util.ServletUtil;
import com.bitnei.cloud.orm.annation.Mybatis;
import com.bitnei.cloud.report.domain.SysAuthenticationCompanyTempEntity;
import com.bitnei.cloud.report.mapper.SysRealNameAuthMapper;
import com.bitnei.cloud.report.service.ISysAuthCompanyTempService;
import com.bitnei.cloud.service.impl.BaseService;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.PagerModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author chenyl or 13718602502@163.com
 * 企业实名认证
 */
@Service
@Transactional
@SuppressWarnings("all")
@Mybatis(namespace = "com.bitnei.cloud.report.mapper.SysAuthCompanyTempMapper" )
public class SysAuthCompanyTempServiceImpl extends BaseService implements ISysAuthCompanyTempService{

    private static String REAL_NAME_NOT_SUBMIT = "0";

    @Autowired
    SysRealNameAuthMapper sysRealNameAuthMapper;

    @Override
    public PagerModel pagerQuery() {
        DataGridOptions options = ServletUtil.getDataLayOptions();
        PagerModel pm = findPagerModel("pagerModel",options);
        return pm;
    }

    @Override
    public SysAuthenticationCompanyTempEntity findByPk(String id) {
        return unique("findPrimaryKey",id);
    }

    /**
     * 编辑操作，如果当前数据存在于实名认证表 则删除这条数据
     * @param sysAuthenticationCompanyTempEntity
     */
    @Override
    public void updateRealName(SysAuthenticationCompanyTempEntity entity) {
        if(!REAL_NAME_NOT_SUBMIT.equals(entity.getAuthenticationResult())){
            //非未提交的数据 存在于实名认证表中，删除这条数据
            sysRealNameAuthMapper.deleteByPrimaryKey(entity.getId());
            entity.setCreateTime(DateUtil.getNow());
            entity.setUpdateTime(DateUtil.getNow());
            super.insert(entity);
        }
        entity.setUpdateTime(DateUtil.getNow());
        super.update(entity);
    }
}
