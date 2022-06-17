<?php
namespace app\index\controller;


use think\Controller;
use think\Db;
class Index extends BaseController
{
    public function allGoodsList(){
        $data = Db::table("shoes_goods")->select();
        return [200, $data,'请求成功'];
    }
    public function showGoodsList($num){
        $data = Db::table("shoes_condition")->alias("c")->join("shoes_goods g","c.id = g.coid")->limit($num)->select();
        if($data === 0){
            return [200,[],'未找到返回值'];
        }
        return [200, $data, '请求成功'];
    }
//    获取优惠卷信息
    public function coupon(){
        $data = Db::table("shoes_discount")->select();
        if($data === 0){
            return [200,[],'未找到返回值'];
        }
        return [200, $data, '请求成功'];
    }
//    优惠卷数量减一，并处理相应逻辑
    public function dealCouponNum($id,$user_id){
        //        num字段自减 1
        Db::table('shoes_discount')->where('id', $id)->setDec('num');
        //        查询所领取的优惠卷信息
        $res_discount = Db::name("discount")->where("id", $id)->select();
        //        赋值$discount_price
        $discount_price = $res_discount[0]["discount_price"];
        //        查询用户表
        $res_user = Db::name("user")->where("id", $user_id)->select();
        //        赋值给$user_discount
        $user_discount = $res_user[0]["discount_price"];
        //        判断数据表初始值是否为空
        if(empty($user_discount)){
            $res = $discount_price;
        }else{
            if(stripos($user_discount, $discount_price.'') !== false){
                return [200, [$discount_price], "您已领取该优惠卷，无需再领"];
            }
            $res = $user_discount.",".$discount_price;
        }
        //        更新discount_price字段
        $res_update = Db::name("user")->where("id", $user_id)->update([
            'discount_price' => $res
        ]);
        if($res_update){
            return [200,[],'更新成功'];
        }else{
            return [500,[],'更新失败'];
        }
    }
    public function getBanner(){
        $data = Db::table("shoes_banner")->select();
        if($data === 0){
            return [200,[],'未找到返回值'];
        }
        return [200,$data,'请求成功'];
    }
    public function getActivity($aid){
        $data = Db::table("shoes_activity")->alias("a")->join("shoes_goods g","g.aid = a.id")->where('aid',$aid)->limit(3)->select();
        if($data === 0){
            return [200,[],'未找到返回值'];
        }
        return [200, $data, '请求成功'];
    }
    public function searchInfo($goods_name){
        $result = $this->allGoodsList();
        $data = $result[1];
        $data2 = [];
        foreach($data as $value){
            $domain = strstr($value['goods_name'],$goods_name);
            if($domain){
                array_push($data2,$value);
            }
        }
        if(empty($data2)){
            return [200,[],'未找到返回值'];
        }
        return [200, $data2, '请求成功'];
    }
    public function classifyInfo(){
        $data = Db::table("shoes_category")->select();
        if($data === 0){
            return [200,[],'未找到返回值'];
        }
        return [200,$data,'请求成功'];
    }
}
