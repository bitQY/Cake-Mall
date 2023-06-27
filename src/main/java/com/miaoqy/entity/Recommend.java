package com.miaoqy.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class Recommend {
    @TableId(value="id",type= IdType.AUTO)
    private Integer id;
    private Integer type;
    private Integer goods_id;
    //联表
    @TableField(exist = false)
    private Goods goods;
    @TableField(exist = false)
    private Type types;
}
