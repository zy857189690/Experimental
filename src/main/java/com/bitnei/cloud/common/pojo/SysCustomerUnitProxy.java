package com.bitnei.cloud.common.pojo;

import com.bitnei.cloud.common.SpringUtil;
import com.bitnei.cloud.report.domain.SysCustomerUnitEntity;

/**
 * @author chenyl or 13718602502@163.com
 * 一个SysCustomerUnit代理，用于在无数据字典下的常量返回
 * 或者在Ibatisz中作为类型返回
 */
public class SysCustomerUnitProxy extends SysCustomerUnitEntity{

    /**
     * 使用spring容器中的bean
     */
    private ConstantMap constantMap = SpringUtil.getBean(ConstantMap.class);

    @Override
    public String getComType() {
        return constantMap.getCompType().get(super.getComType());
    }

    @Override
    public String getIndustryType() {
        String industryType = super.getIndustryType();
        if(industryType!=null){
            return constantMap.getIndustryType().get(industryType.replace("_","."));
        }
        return null;
    }

    @Override
    public String getSex() {
        return constantMap.getSex().get(super.getSex());
    }

    @Override
    public String getOwnerCertType() {
        return constantMap.getOwnerCertType().get(super.getOwnerCertType());
    }
}
