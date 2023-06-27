package com.miaoqy.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.miaoqy.entity.Order;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface OrderMapper extends BaseMapper<Order> {
    @Select("select * from `order` where user_id=#{id} order by datetime desc")
    @Results(
            value = {@Result(property = "id",column = "id"),
            @Result(property = "itemList",column = "id",
            many = @Many(select = "com.miaoqy.mapper.OrderItemMapper.getOrderItem"))
            }
    )
    List<Order> getOrderByUser(Integer id);
}
