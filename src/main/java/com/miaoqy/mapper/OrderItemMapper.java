package com.miaoqy.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.miaoqy.entity.OrderItem;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface OrderItemMapper extends BaseMapper<OrderItem> {

    @Select("select * from orderitem where order_id = #{id}")
    @Results(
            value ={@Result(property = "goodsId",column = "goods_id"),
                    @Result(property = "goods",column = "goods_id",
                            one = @One(select = "com.miaoqy.mapper.GoodsMapper.getGoods"))
            }
    )
    List<OrderItem> getOrderItem(Integer id);
}
