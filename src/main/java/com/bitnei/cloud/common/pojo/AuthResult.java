package com.bitnei.cloud.common.pojo;

import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.cloud.report.domain.SysRealNameAuthenticationEntity;

import java.text.SimpleDateFormat;
import java.util.Date;

public class AuthResult extends AppBean{

    private SysRealNameAuthenticationEntity entity = new SysRealNameAuthenticationEntity();

    public SysRealNameAuthenticationEntity getEntity() {
        return entity;
    }

    public void setEntity(SysRealNameAuthenticationEntity entity) {
        this.entity = entity;
    }
    
}
