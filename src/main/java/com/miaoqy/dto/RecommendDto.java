package com.miaoqy.dto;

import com.miaoqy.entity.Goods;
import com.miaoqy.entity.Recommend;
import lombok.Data;

@Data
public class RecommendDto extends Recommend {
    private Goods goods;
}
