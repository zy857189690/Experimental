package com.bitnei.cloud.report.enums;

public enum SysOwnerPeopleEnum {

    /**
     *类型：1员工2车辆负责人3单位联系人4个人车主
     */
    STAFF(1),
    VEH_DUTY(2),
    UNIT_LINKMAN(3),
    PERSON_OWNER(4);

    private Integer value;
    SysOwnerPeopleEnum(Integer value){
        this.value = value;
    }
    public Integer getValue() {
        return value;
    }
}
