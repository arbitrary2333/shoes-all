<?php
/**
 * Created by PhpStorm.
 * User: 86180
 * Date: 2021/11/13
 * Time: 21:50
 */

namespace app\index\controller;


use think\Db;

class Cart extends BaseController
{
    public function cart($user_id){
        $data = Db::name("goods")->alias("g")->join("cart c","c.goods_id = g.id")->where("user_id",$user_id)->select();
        if($data === 0){
            return [200,[],'未找到返回值'];
        }
        return [200, $data, '请求成功'];
    }
    public function switchStatus(){
        $data = input('post.');
        $res = Db::name("cart")->where("id",$data["id"])->update(['status' => $data["status"]]);
        if($res){
            return [200,[$res],'更新成功'];
        }else{
            return [200,[],'更新失败'];
        }
    }
    public function switchAllStatus(){
        $data = input("post.");
        $data_cart_all = Db::name("cart")->where("user_id", $data["user_id"])->select();
        foreach($data_cart_all as $cart){
            Db::name("cart")->where("id", $cart["id"])->update(['status' => $data["status"]]);
        }
        return [200,[],"更新成功"];
    }
    public function delCartGoods(){
        $data = input('post.');
        $res = Db::name("cart")->where("id",$data["id"])->delete();
        if($res){
            return [200,[$res],'更新成功'];
        }else{
            return [500,[],'更新失败'];
        }
    }
}