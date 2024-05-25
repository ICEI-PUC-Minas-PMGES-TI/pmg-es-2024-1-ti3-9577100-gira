package com.app.pucTis.Entities;

public class LoginRequest {
    private String name;
    private String code;
    private String password;

    public String getUsername() {
        return name;
    }

    public void setUsername(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCode() {return code;}

    public void setCode(String code) {this.code = code;}
}