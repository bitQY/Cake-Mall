package com.miaoqy.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.miaoqy.entity.Type;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface TypeMapper extends BaseMapper<Type> {
    @Select("select * from type where id = #{id}")
    Type getType(Integer id);
}
