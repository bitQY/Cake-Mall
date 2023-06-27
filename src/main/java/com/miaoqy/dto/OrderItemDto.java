package com.miaoqy.dto;

import com.miaoqy.entity.Goods;
import com.miaoqy.entity.OrderItem;
import lombok.Data;

@Data
public class OrderItemDto extends OrderItem {
    private Goods goods;
}
