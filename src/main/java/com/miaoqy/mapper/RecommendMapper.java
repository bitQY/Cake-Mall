package com.miaoqy.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.miaoqy.entity.Recommend;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface RecommendMapper extends BaseMapper<Recommend> {

    @Select("select * from recommend where goods_id = #{goods_id}")
    Recommend getRecommend(int goods_id);
}
