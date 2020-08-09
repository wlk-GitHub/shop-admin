package com.fh.common;

public enum ResponseEnum {

    USERNAME_IS_NOT_EXIST(1006, "用户名不存在"),
    USER_PASSWORD_IS_ERROR(1005, "密码错误"),
    USERNAME_PASSWORD_IS_NULL(1004, "用户名或者密码为空"),
    REG_MAIL_IS_EXIST(1003,"邮箱已存在"),
    REG_PHONE_IS_EXIST(1002,"手机号已存在"),
    REG_MEMBER_IS_EXIST(1001,"会员名已存在"),
   REG_MEMBER_IS_NULL(1000,"注册会员信息为空了");

    private int code;
    private String msg;

    private ResponseEnum(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}
