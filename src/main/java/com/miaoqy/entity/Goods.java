package com.miaoqy.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class Goods {
    @TableId(value="id",type= IdType.AUTO)
    private Integer id;
    private String name;
    private String cover;
    private String image1;
    private String image2;
    private Float price;
    private String intro;
    private Integer stock;
    private Integer typeId;
    @TableField(exist = false)
    private Type type;
    @TableField(exist = false)
    private Recommend recommend;

}