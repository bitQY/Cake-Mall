package com.miaoqy.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.miaoqy.entity.*;
import com.miaoqy.mapper.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

@Controller
@Slf4j
public class IndexController {
    @Autowired
    private GoodsMapper goodsMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private TypeMapper typeMapper;
    @Autowired
    private OrderItemMapper orderItemMapper;
    @Autowired
    private OrderMapper orderMapper;
    @RequestMapping("index")
    public String index(Model model,HttpSession session){
        List<Recommend> bannergoodslist = goodsMapper.getAllRecommends(1);
        List<Recommend> hotgoodslist = goodsMapper.getAllRecommends(2);
        List<Recommend> newgoodslist = goodsMapper.getAllRecommends(3);
        List<Type> typeList = typeMapper.selectList(null);
        session.setAttribute("typeList",typeList);
        model.addAttribute("bannergoodslist",bannergoodslist);
        model.addAttribute("hotgoodslist",hotgoodslist);
        model.addAttribute("newgoodslist",newgoodslist);
        return "index";
    }

    //登录
    @RequestMapping("user_login")
    public String login(User user, HttpSession session,Model model){
        LambdaQueryWrapper<User> userQueryWrapper = new LambdaQueryWrapper<>();
        userQueryWrapper.eq(User::getUsername,user.getUsername());
        userQueryWrapper.eq(User::getPassword,user.getPassword());
        User user1 = userMapper.selectOne(userQueryWrapper);
        if(user1!=null){
            //登录成功
            session.setAttribute("loginuser",user1);
            return "user_center";
        }
        else {
            model.addAttribute("failMsg","用户名错误或者密码错误");
            return "user_login";
        }
    }

    //退出登录
    @RequestMapping("user_logout")
    public String logout(HttpSession session){
        session.removeAttribute("loginuser");
        session.invalidate();
        return "redirect:index";
    }

    //注册
    @RequestMapping("user_register")
    public String register(User user,Model model){
        int i = userMapper.insert(user);
        if (i>0){
            //注册成功，共享成功的提示信息
            model.addAttribute("msg","注册成功，请登录");
            return "user_login";
        }
        else {
            //注册失败
            model.addAttribute("failMsg","用户名重名或邮箱重复，请重新注册");
            return "user_register";
        }
    }

    //检查用户名是否存在
    @RequestMapping("checkusername")
    @ResponseBody
    public String checkusername(String username){
        LambdaQueryWrapper<User> userLambdaQueryWrapper = new LambdaQueryWrapper<>();
        userLambdaQueryWrapper.eq(User::getUsername,username);
        User user = userMapper.selectOne(userLambdaQueryWrapper);
        if (user!=null){
            return "1";
        }
        else return "0";
    }

    //显示商品信息分页
    @RequestMapping("/goods_list")
    public String good_list(Integer typeId,Model model,@RequestParam(defaultValue = "1") Integer page){
        Integer pageSize = 12;
        Page<Goods> goodsPage = new Page<>(page,pageSize);
        LambdaQueryWrapper<Goods> goodsLambdaQueryWrapper = new LambdaQueryWrapper<>();
        goodsLambdaQueryWrapper.eq(typeId !=null, Goods::getTypeId,typeId);
        goodsMapper.selectPage(goodsPage,goodsLambdaQueryWrapper);
        log.info("分页信息 {}",goodsPage);
        Type type = typeMapper.getType(typeId);
        model.addAttribute("goodsPage",goodsPage);
        model.addAttribute("type",type);
        return "goods_list";
    }

    //分页查询热销，新品
    @RequestMapping("/goods_types")
    public String goods_types(Integer typeId,Model model,@RequestParam(defaultValue = "1") Integer page){
        Integer pageSize = 12;
        PageHelper.startPage(page,pageSize);
        List<Recommend> recommendList = goodsMapper.getAllRecommends(typeId);
        PageInfo<Recommend> pageInfo = new PageInfo<>(recommendList);
        model.addAttribute("pageInfo",pageInfo);
        Type type = typeMapper.getType(typeId);
        model.addAttribute("type",type);
        return "goods_list2";
    }

    //更新个人信息
    @RequestMapping("/user_update")
    public String user_update(User user,Model model,HttpSession session){
        userMapper.updateById(user);
        model.addAttribute("msg","信息更改成功！");
        User user1 = userMapper.selectById(user.getId());
        session.setAttribute("loginuser",user1);
        return "user_center";
    }

    //更改密码
    @RequestMapping("/user_updatepwd")
    public String user_updatepwd(User user,Model model){
        userMapper.updateById(user);
        model.addAttribute("msg","密码更改成功！");
        return "user_login";
    }

    //检查密码是否为原密码
    @RequestMapping("/checkPasssword")
    @ResponseBody
    public String checkPasssword(int id,String password){
        LambdaQueryWrapper<User> userLambdaQueryWrapper = new LambdaQueryWrapper<>();
        userLambdaQueryWrapper.eq(User::getId,id);
        userLambdaQueryWrapper.eq(User::getPassword,password);
        User user1 = userMapper.selectOne(userLambdaQueryWrapper);
        if (user1==null)
            return "1";
        else {
            return "0";
        }
    }

    //详情页
    @RequestMapping("/goods_detail")
    public String goods_detail(int id,Model model){
        Goods goods = goodsMapper.getGoods(id);
        List<Type> typeList = typeMapper.selectList(null);
        model.addAttribute("typeList",typeList);
        model.addAttribute("good",goods);
        return "goods_detail";
    }


    //模糊查询
    @RequestMapping("/goods_search")
    public String goods_search(String keyword,Model model,@RequestParam(defaultValue = "1")int page){
        Integer pageSize = 12;
        Page<Goods> goodsPage = new Page<>(page,pageSize);
        LambdaQueryWrapper<Goods> goodsLambdaQueryWrapper = new LambdaQueryWrapper<>();
        goodsLambdaQueryWrapper.like(Goods::getName,keyword);
        goodsMapper.selectPage(goodsPage,goodsLambdaQueryWrapper);
        model.addAttribute("goodsPage",goodsPage);
        model.addAttribute("keyword",keyword);
        return "goods_search";
    }

    //购物车
    @RequestMapping("/goods_buy")
    @ResponseBody
    public String goods_buy(String action,Integer goodsid,HttpSession session){
        Order o = (Order) session.getAttribute("order");
        if ("add".equals(action)){
            Goods goods = goodsMapper.selectById(goodsid);
            if (o==null){
                o = new Order();
            }
            if (goods.getStock()>0){
                o.addGoods(goods);//添加到购物车Map中
                session.setAttribute("order",o);
                return "ok";
            }else {
                return "fail";
            }
        }else if ("lessen".equals(action)){
            o.lessen(goodsid);
            session.setAttribute("order",o);//重新共享order
            return "ok";
        }
        else if ("delete".equals(action)) {
            o.delete(goodsid);
            session.setAttribute("order",o);//重新共享order
            return "ok";
        }
        return null;
    }

    //查看订单详情
    @RequestMapping("/order_list")
    public String order_list(HttpSession session,Model model){
        //得到登录的用户
        User user = (User) session.getAttribute("loginuser");
        //查询订单
        List<Order> orderList = orderMapper.getOrderByUser(user.getId());
        model.addAttribute("orderList",orderList);
        return "order_list";
    }

    //提交订单
    @RequestMapping("order_confirm")
    public String order_confirm(Order order, HttpSession session,Model model){
        //获取购物车信息
        Order order1 = (Order) session.getAttribute("order");
        //给order的相关属性赋值
        order1.setPhone(order.getPhone());
        order1.setName(order.getName());
        order1.setAddress(order.getAddress());
        order1.setPaytype(order.getPaytype());
        order1.setStatus(2);//表示已支付
        //获取登录用户
        User user = (User) session.getAttribute("loginuser");
        //将user_id存储在order中
        order1.setUserId(user.getId());
        //插入订单
        orderMapper.insert(order1);
        //插入订单详情
        HashMap<Integer,OrderItem> itemHashMap = order1.getItemMap();
        for (OrderItem item : itemHashMap.values()) {
            item.setOrderId(order1.getId());
            orderItemMapper.insert(item);
        }
        model.addAttribute("msg","订单支付成功");
        return "order_success";
    }

}
