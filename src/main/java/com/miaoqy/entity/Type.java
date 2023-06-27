package com.miaoqy.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class Type {
    @TableId(value="id",type= IdType.AUTO)
    private Integer id;
    private String name;
}
