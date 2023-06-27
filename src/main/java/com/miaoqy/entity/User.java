package com.miaoqy.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class User {
    @TableId(value="id",type= IdType.AUTO)
    private Integer id;
    private String username;
    private String email;
    private String password;
    private String name;
    private String phone;
    private String address;
    private Integer isadmin;
    private Integer isvalidate;
}
