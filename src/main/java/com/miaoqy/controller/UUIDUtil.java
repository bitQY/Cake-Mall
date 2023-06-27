package com.miaoqy.controller;


import java.util.UUID;

/**
 *
 * @title: UUID虽然重复性很小但是也要防止， 一旦出了问题很难定位，故此后面加了六位随机数，降低重复概率
 * @author: wyh
 * @since: 2021-7-6 15:59:36
 */
public class UUIDUtil {

    private UUIDUtil() {
        throw new IllegalStateException("Utility class");
    }

    public static String generateUUID() {
        int mathRandom = (int) ((Math.random() * 9 + 1) * 100000);
        String strUUID = UUID.randomUUID().toString().replace("-", "") + mathRandom;
        return strUUID;
    }

    /**
     * 	生成一百次测试
     */
//	public static void main(String[] args) {
//		for (int j = 0; j < 100; j++) {
//			int mathRandom = (int) ((Math.random() * 9 + 1) * 100000);
//			String strUUID = UUID.randomUUID().toString().replace("-", "") + mathRandom;
//			System.out.println(strUUID);
//		}
//	}

}


