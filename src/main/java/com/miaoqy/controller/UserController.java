package com.miaoqy.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.miaoqy.dto.OrderDto;
import com.miaoqy.dto.OrderItemDto;
import com.miaoqy.entity.*;
import com.miaoqy.mapper.*;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin")
public class UserController {
    @Autowired
    private TypeMapper typeMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private GoodsMapper goodsMapper;
    @Autowired
    private RecommendMapper recommendMapper;
    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private OrderItemMapper orderItemMapper;

    @RequestMapping("/type")
    public String type(Model model){
        List<Type> typeList = typeMapper.selectList(null);
        model.addAttribute("list",typeList);
        return "admin/type_list";
    }

    @RequestMapping("/typeUpdate")
    public String typeUpdate(Type type){
        typeMapper.updateById(type);
        return "redirect:type";
    }

    @RequestMapping("/typeDelete")
    public String typeDelete(int id){
        typeMapper.deleteById(id);
        return "redirect:type";
    }

    @RequestMapping("typeAdd")
    public String typeAdd(Type type){
        typeMapper.insert(type);
        return "redirect:type";
    }

    @RequestMapping("/user")
    public String user(@RequestParam(defaultValue = "1") int page, Model model,String username,String email){
        int pageSize = 5;
        Page<User> userPage = new Page<>(page,pageSize);
        LambdaQueryWrapper<User> userLambdaQueryWrapper = new LambdaQueryWrapper<>();
        userLambdaQueryWrapper.like(username!=null,User::getUsername,username);
        userLambdaQueryWrapper.like(email!=null,User::getEmail,email);
        userMapper.selectPage(userPage,userLambdaQueryWrapper);
        model.addAttribute("userPage",userPage);
        model.addAttribute("username",username);
        model.addAttribute("email",email);
        return "admin/user_list";
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

    //重置密码
    @RequestMapping("/userUpdatePassword")
    public String userUpdatePassword(User user,Model model){
        userMapper.updateById(user);
        model.addAttribute("msg","修改成功");
        return "forword:admin/user";
    }

    //修改用户信息
    @RequestMapping("/userUpdate")
    public String userUpdate(User user){
        userMapper.updateById(user);
        return "redirect:user";
    }

    //删除用户
    @RequestMapping("/userdelete")
    public String userdelete(int id){
        userMapper.deleteById(id);
        return "redirect:user";
    }

    //添加用户
    @RequestMapping("/userAdd")
    public String userAdd(User user){
        userMapper.insert(user);
        return "redirect:user";
    }

    //导出用户

    // 添加导出用户表为 Excel 的接口
        @RequestMapping(value = "/export", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
        public ResponseEntity<byte[]> exportUsersToExcel() {
            try {
                List<User> userList = userMapper.selectList(null);
                Workbook workbook = createExcelWorkbook(userList);
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                workbook.write(outputStream);

                byte[] excelBytes = outputStream.toByteArray();

                HttpHeaders headers = new HttpHeaders();
                headers.setContentType(MediaType.parseMediaType("application/vnd.ms-excel"));
                headers.setContentDispositionFormData("attachment", "users.xlsx");

                return ResponseEntity.ok()
                        .headers(headers)
                        .contentLength(excelBytes.length)
                        .body(excelBytes);
            } catch (Exception e) {
                // 处理异常
                e.printStackTrace();
                return ResponseEntity.badRequest().build();
            }
        }

        // 创建 Excel 表格并填充数据
        private Workbook createExcelWorkbook(List<User> userList) {
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("Users");

            // 创建表头
            Row headerRow = sheet.createRow(0);
            headerRow.createCell(0).setCellValue("ID");
            headerRow.createCell(1).setCellValue("Username");
            headerRow.createCell(2).setCellValue("Email");
            headerRow.createCell(3).setCellValue("Name");
            headerRow.createCell(4).setCellValue("Phone");
            headerRow.createCell(5).setCellValue("Address");

            // 填充数据
            int rowNum = 1;
            for (User user : userList) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(user.getId());
                row.createCell(1).setCellValue(user.getUsername());
                row.createCell(2).setCellValue(user.getEmail());
                row.createCell(3).setCellValue(user.getName());
                row.createCell(4).setCellValue(user.getPhone());
                row.createCell(5).setCellValue(user.getAddress());
            }

            return workbook;
        }

    //查询商品
    @RequestMapping("/goods")
    public String goods(@RequestParam(defaultValue = "0")int type,@RequestParam(defaultValue = "1") int page,Model model,HttpSession session){
        int pageSize = 10;
        List<Type> typeList = typeMapper.selectList(null);
        session.setAttribute("typeList",typeList);
        if (type==0) {
            PageHelper.startPage(page, pageSize);
            List<Goods> goodsList = goodsMapper.getAllgoods();
            PageInfo<Goods> pageInfo = new PageInfo<>(goodsList);
            model.addAttribute("pageInfo", pageInfo);
            model.addAttribute("type",type);
            return "admin/goods_list";
        }
        PageHelper.startPage(page,pageSize);
        List<Recommend> recommendList = goodsMapper.getAllRecommends(type);
        PageInfo<Recommend> pageInfo = new PageInfo<>(recommendList);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("type",type);
        return "admin/goods_list2";
    }

    //修改条幅，热销，新品
    @RequestMapping("/goodsrecommend")
    public String goodsrecommend(int id,String method,int typeTarget,int page,int type){
        if (method.equals("add")){
            Recommend recommend = new Recommend();
            recommend.setGoods_id(id);
            recommend.setType(typeTarget);
            recommendMapper.insert(recommend);
        } else if (method.equals("remove")) {
            LambdaQueryWrapper<Recommend> recommendLambdaQueryWrapper = new LambdaQueryWrapper<>();
            recommendLambdaQueryWrapper.eq(Recommend::getType,typeTarget);
            recommendLambdaQueryWrapper.eq(Recommend::getGoods_id,id);
            recommendMapper.delete(recommendLambdaQueryWrapper);
        }
        return "redirect:goods?type="+type+"&page="+page;
    }

    //修改商品1.1
    @RequestMapping("/goodsedit")
    public String goodsedit(int id,int page,int type,Model model){
        Goods goods = goodsMapper.selectById(id);
        model.addAttribute("g",goods);
        model.addAttribute("page",page);
        model.addAttribute("type",type);
        return "admin/goods_edit";
    }

    //修改商品1.2
    @RequestMapping("/goodsupdate")
    public String goodsupdate(MultipartFile cover1, MultipartFile image11, MultipartFile image21, Goods g,int page,int type1,HttpSession session){
        if (!cover1.isEmpty()){
                    /*
        为映射数据库和保存地址准备
         */
            String filePath = session.getServletContext().getRealPath("/picture/");
            String fileName=cover1.getOriginalFilename();//获取文件名
            String suffixName=fileName.substring(fileName.lastIndexOf("."));//获取后缀名

            fileName= UUIDUtil.generateUUID()+suffixName;//新图片名

            g.setCover("/picture/"+fileName);

            File dest=new File(filePath+fileName); //创建新文件

            if(!dest.getParentFile().exists()){
                dest.getParentFile().mkdirs();
            }
            try {
                cover1.transferTo(dest); //保存图片

            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        if (!image11.isEmpty()){
            /*
        为映射数据库和保存地址准备
         */
            String filePath = session.getServletContext().getRealPath("/picture/");
            String fileName1=image11.getOriginalFilename();//获取文件名
            String suffixName1=fileName1.substring(fileName1.lastIndexOf("."));//获取后缀名

            fileName1= UUIDUtil.generateUUID()+suffixName1;//新图片名


            g.setImage1("/picture/"+fileName1);
            File dest1=new File(filePath+fileName1); //创建新文件

            if(!dest1.getParentFile().exists()){
                dest1.getParentFile().mkdirs();
            }
            try {
                image11.transferTo(dest1);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        if (!image21.isEmpty()){
        /*
        为映射数据库和保存地址准备
         */
            String filePath = session.getServletContext().getRealPath("/picture/");
            String fileName2=image21.getOriginalFilename();//获取文件名
            String suffixName2=fileName2.substring(fileName2.lastIndexOf("."));//获取后缀名

            fileName2= UUIDUtil.generateUUID()+suffixName2;//新图片名

            g.setImage2("/picture/"+fileName2);
            File dest2=new File(filePath+fileName2); //创建新文件

            if(!dest2.getParentFile().exists()){
                dest2.getParentFile().mkdirs();
            }
            try {
                image21.transferTo(dest2);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        goodsMapper.updateById(g);
        return "redirect:goods?type="+type1+"&page="+page;
    }

    //添加商品
    @RequestMapping("/goodsadd")
    public String  upload(MultipartFile cover, MultipartFile image1, MultipartFile image2, String name, Float price, String intro, Integer stock, Integer type_id, HttpSession session){
        /*
    文件不能为空
     */
        Goods g = new Goods();
        g.setName(name);
        g.setPrice(price);
        g.setStock(stock);
        g.setIntro(intro);
        g.setTypeId(type_id);
        if(cover.isEmpty()||image1.isEmpty()||image2.isEmpty()){
            System.out.println("文件不能为空");
            return "fileerror";
        }
        /*
        为映射数据库和保存地址准备
         */
        String filePath = session.getServletContext().getRealPath("/picture/");
        String fileName=cover.getOriginalFilename();//获取文件名
        String fileName1=image1.getOriginalFilename();//获取文件名
        String fileName2=image2.getOriginalFilename();//获取文件名
        String suffixName=fileName.substring(fileName.lastIndexOf("."));//获取后缀名
        String suffixName1=fileName1.substring(fileName1.lastIndexOf("."));//获取后缀名
        String suffixName2=fileName2.substring(fileName2.lastIndexOf("."));//获取后缀名
        //String filePath="E://Idea workspace//demoweb2//src//main//resources//static//images//image//";

        fileName= UUIDUtil.generateUUID()+suffixName;//新图片名
        fileName1= UUIDUtil.generateUUID()+suffixName1;//新图片名
        fileName2= UUIDUtil.generateUUID()+suffixName2;//新图片名

        g.setCover("/picture/"+fileName);
        g.setImage1("/picture/"+fileName1);
        g.setImage2("/picture/"+fileName2);
        File dest=new File(filePath+fileName); //创建新文件
        File dest1=new File(filePath+fileName1); //创建新文件
        File dest2=new File(filePath+fileName2); //创建新文件

        if(!dest.getParentFile().exists()){
            dest.getParentFile().mkdirs();
            dest1.getParentFile().mkdirs();
            dest2.getParentFile().mkdirs();
        }
        try {
            cover.transferTo(dest); //保存图片
            image1.transferTo(dest1);
            image2.transferTo(dest2);
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println(g);
        goodsMapper.insert(g);

        PageHelper.startPage(1,8);
        List<Goods> list = goodsMapper.selectList(null);
        PageInfo<Goods> page = new PageInfo<>(list);
        return "redirect:goods?page="+page.getPages()+"&type=0";
    }

    //删除商品
    @RequestMapping("/goodsdelete")
    @ResponseBody
    public String goodsdelete(int gid){
        int i = goodsMapper.deleteById(gid);
        if (i!=0) {
            return "ok";
        }
        return "0";
    }


    //查询订单
    @RequestMapping("order")
    public String order(@RequestParam(defaultValue = "0") int status,@RequestParam(defaultValue = "1")int page,Model model){
        int pageSize = 8;
        Page<Order> orderPage = new Page<>(page,pageSize);
        Page<OrderDto> orderDtoPage = new Page<>(page,pageSize);
        LambdaQueryWrapper<Order> orderLambdaQueryWrapper = new LambdaQueryWrapper<>();
        orderLambdaQueryWrapper.eq(status!=0,Order::getStatus,status);
        orderMapper.selectPage(orderPage,orderLambdaQueryWrapper);
        BeanUtils.copyProperties(orderPage,orderDtoPage,"records");

        List<OrderDto> collect = orderPage.getRecords().stream().map((item) -> {
            OrderDto orderDto = new OrderDto();
            BeanUtils.copyProperties(item, orderDto);
            int userId = item.getUserId();
            User user = userMapper.selectById(userId);

            int id = item.getId();
            LambdaQueryWrapper<OrderItem> orderItemLambdaQueryWrapper = new LambdaQueryWrapper<>();
            orderItemLambdaQueryWrapper.eq(OrderItem::getOrderId, id);
            List<OrderItem> orderItemList = orderItemMapper.selectList(orderItemLambdaQueryWrapper);

            List<OrderItemDto> orderItemDtoList = orderItemList.stream().map((item1) -> {
                OrderItemDto orderItemDto = new OrderItemDto();
                orderItemDto.setId(item1.getId());
                orderItemDto.setPrice(item1.getPrice());
                orderItemDto.setAmount(item1.getAmount());
                orderItemDto.setGoodsId(item1.getGoodsId());
                orderItemDto.setOrderId(item1.getOrderId());
                Integer goodsId = item1.getGoodsId();
                Goods goods = goodsMapper.selectById(goodsId);
                orderItemDto.setGoods(goods);
                return orderItemDto;
            }).collect(Collectors.toList());

            orderDto.setUser(user);
            orderDto.setOrderItemDtoList(orderItemDtoList);
            return orderDto;

        }).collect(Collectors.toList());
        orderDtoPage.setRecords(collect);
        model.addAttribute("orderDtoPage",orderDtoPage);
        model.addAttribute("status",status);
        return "admin/order_list";
    }

    //修改订单状态
    @RequestMapping("/orderUpdate")
    public String orderUpdate(int id,int page,int status,Model model){
        Order order = orderMapper.selectById(id);
        order.setStatus(status);
        orderMapper.updateById(order);
        return "redirect:order?page="+page;
    }

    //删除订单
    @RequestMapping("/orderDelete")
    @ResponseBody
    public String orderDelete(int oid){
        int delete1 = orderMapper.deleteById(oid);
        LambdaQueryWrapper<OrderItem> orderItemLambdaQueryWrapper = new LambdaQueryWrapper<>();
        orderItemLambdaQueryWrapper.eq(OrderItem::getOrderId,oid);
        orderItemMapper.delete(orderItemLambdaQueryWrapper);
//        if (delete1!=0&&delete2!=0){
            return "ok";
//        }
//        return "0";
    }

    //退出
    @RequestMapping("/user_logout")
    public String user_logout(HttpSession session){
        session.removeAttribute("loginuser");
        session.invalidate();
        return "redirect:../index";
    }


}
