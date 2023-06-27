package com.miaoqy.dto;

import com.miaoqy.entity.Order;
import com.miaoqy.entity.OrderItem;
import com.miaoqy.entity.Recommend;
import com.miaoqy.entity.User;
import lombok.Data;

import java.util.List;

@Data
public class OrderDto extends Order {
    private User user;
    private List<OrderItemDto> orderItemDtoList;
}
