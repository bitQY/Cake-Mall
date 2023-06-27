package com.miaoqy.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("orderitem")
public class OrderItem {
    @TableId(value="id",type= IdType.AUTO)
    private Integer id;
    private float price;
    private Integer amount;
    private Integer goodsId;
    private Integer orderId;
    //联表查询 新增属性
    @TableField(exist = false)
    private Goods goods;

    //新建构造方法
    public OrderItem() {}

    public OrderItem(float price, Integer amount, Integer goods_id, Integer order_id, Goods goods) {
        this.price = price;
        this.amount = amount;
        this.goodsId = goods_id;
        this.orderId = order_id;
        this.goods = goods;
    }

}