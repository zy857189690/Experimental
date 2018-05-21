package com.bitnei.cloud.common.pojo;

import com.bitnei.cloud.common.SpringUtil;
import com.bitnei.cloud.report.domain.SysAuthenticationCompanyTempEntity;

public class SysAuthenticationCompanyTempProxy extends SysAuthenticationCompanyTempEntity {
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
