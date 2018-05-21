package com.bitnei.cloud.report.enums;

public class SysRealNameAuthEnum {

    public enum PersonAuth {
        //认证结果:0未申请 :1认证中 :2已通过 :3未通过
        APPLY_NO("0"),
        APPLY_AUTHING("1"),
        APPLY_PASS("2"),
        APPLY_NO_PASS("3");

        private String value;
        PersonAuth(String value){
            this.value = value;
        }
        public String getValue() {
            return value;
        }
    }

    public enum EnterpriseAuth {
        // :1个人认证 :2企业认证
        AUTH_PERSONAL("1"),
        AUTH_ENTERPRISE("2");

        private String value;
        EnterpriseAuth(String value){
            this.value = value;
        }
        public String getValue() {
            return value;
        }
    }

}
