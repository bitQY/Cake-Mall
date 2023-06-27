package com.miaoqy.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.miaoqy.entity.Goods;
import com.miaoqy.entity.Recommend;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface GoodsMapper extends BaseMapper<Goods> {
    //根据id查询商品
    @Select("select * from goods where id = #{id}")
    @Results(id = "typeMap",value = {
            @Result(property = "type",column = "typeId",
                    one = @One(select = "com.miaoqy.mapper.TypeMapper.getType"))
    })
    Goods getGoods(Integer id);


    //根据type查询商品 1.轮播图 2.热销产品 3.新品推荐
    @Select("select * from recommend where type=#{type}")
    @Results(id = "recommendMap",value = {
            @Result(property = "goods_id",column = "goods_id"),
            @Result(property = "goods",column = "goods_id",
                    one = @One(select = "com.miaoqy.mapper.GoodsMapper.getGoods"))
    })

    List<Recommend> getAllRecommends(int type);


    @Select("select * from goods")
    @Results(id="goodsMap",value = {
            @Result(property = "type",column = "type_id",
                    one = @One(select = "com.miaoqy.mapper.TypeMapper.getType")),
            @Result(property = "id",column = "id"),
            @Result(property = "recommend",column = "id",
            one = @One(select = "com.miaoqy.mapper.RecommendMapper.getRecommend"))
    })
    List<Goods> getAllgoods();



}
