package com.bitnei.cloud.common.pojo;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * 用于加载企业(类型,行业类型)相关map
 * 具体内容见 type-map.yml
 * @author chenyl or 13718602502@163.com
 */
@Component
@ConfigurationProperties(prefix = "constant-map",locations = "classpath:/type-map.yml")
public class ConstantMap {
    private Map<String,String> compType;

    private Map<String,String> industryType;

    private Map<String,String> sex;

    private Map<String,String> ownerCertType;

    public Map<String, String> getOwnerCertType() {
        return ownerCertType;
    }

    public void setOwnerCertType(Map<String, String> ownerCertType) {
        this.ownerCertType = ownerCertType;
    }

    public Map<String, String> getSex() {
        return sex;
    }

    public void setSex(Map<String, String> sex) {
        this.sex = sex;
    }

    public Map<String, String> getCompType() {
        return compType;
    }

    public void setCompType(Map<String, String> compType) {
        this.compType = compType;
    }

    public Map<String, String> getIndustryType() {
        return industryType;
    }

    public void setIndustryType(Map<String, String> industryType) {
        this.industryType = industryType;
    }
}
