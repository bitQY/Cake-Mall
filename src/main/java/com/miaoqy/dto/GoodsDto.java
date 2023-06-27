package com.miaoqy.dto;

import com.miaoqy.entity.Goods;
import com.miaoqy.entity.Recommend;
import com.miaoqy.entity.Type;
import lombok.Data;

import java.util.List;

@Data
public class GoodsDto extends Goods {
    private Type type;
    private Recommend recommend;
}
