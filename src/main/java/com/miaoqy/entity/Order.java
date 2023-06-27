package com.miaoqy.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Data
@TableName("`order`")
public class Order {
    @TableId(value="id",type= IdType.AUTO)
    private int id;
    private Float total = 0.0f;
    private Integer amount = 0;
    private int status;//1未付款/2已付款/3已发货/4已完成
    private int paytype;//付款方式,1微信/2支付宝/3货到付款
    private String name;
    private String phone;
    private String address;
    private String datetime;
    private int userId;
    //联表：新增user
    @TableField(exist = false)
    private User user;
    @TableField(exist = false)
    private List<OrderItem> itemList = new ArrayList<>();

    //对应订单详情
    public List<OrderItem> getItemList() {
        return itemList;
    }

    public void setItemList(List<OrderItem> itemList) {
        this.itemList = itemList;
    }

    //模拟购物车功能
    @TableField(exist = false)
    HashMap<Integer, OrderItem> itemMap = new HashMap<Integer, OrderItem>();


    //购物车添加商品
    public void addGoods(Goods g) {
        if (itemMap.containsKey(g.getId())) {//若购物车中包含该商品
            OrderItem item = itemMap.get(g.getId());
            int c = item.getAmount() + 1;
            item.setAmount(c);

        } else {
            OrderItem item = new OrderItem(g.getPrice(), 1, g.getId(), this.id, g);
            itemMap.put(g.getId(), item);
        }
        amount++;//商品总数增加
        total = total + g.getPrice();//订单总金额增加
    }

    //购物车减少商品
    public void lessen(int goodsid) {
        if (itemMap.containsKey(goodsid)) {//若购物车中包含该商品
            OrderItem item = itemMap.get(goodsid);
            int c = item.getAmount() - 1;
            item.setAmount(c);
            amount--;
            total = total - item.getPrice();
            //若商品总数<=0,则删除该商品
            if (item.getAmount() <= 0) {
                itemMap.remove(goodsid);
            }
        }

    }

    //购物车中删除商品
    public void delete(int goodsid) {
        if (itemMap.containsKey(goodsid)) {
            OrderItem item = itemMap.get(goodsid);
            amount = amount - item.getAmount();
            total = total - item.getAmount() * item.getPrice();
            itemMap.remove(goodsid);
        }
    }

}