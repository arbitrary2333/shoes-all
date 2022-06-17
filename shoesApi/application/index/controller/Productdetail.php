<?php
/**
 * Created by PhpStorm.
 * User: 86180
 * Date: 2021/11/14
 * Time: 17:20
 */

namespace app\index\controller;


use think\Db;

class Productdetail extends BaseController
{
    public function detail($id){
        $res = Db::name("condition")->alias("c")->join("goods g","c.id = g.coid")->where("g.id",$id)->find();
        if($res){
            return [200, [$res] , "请求成功"];
        }else{
            return [200, [], "请求失败"];
        }
    }
    public function addCar(){
        $data = input("post.");
        $dataCart = Db::name("goods")->alias("g")->join("cart c","c.goods_id = g.id")->where("user_id",$data["user_id"])->select();
        foreach ($dataCart as $item) {
            if($item["goods_id"] == $data["goods_id"]){
                return [200, [], "不可重复添加商品至购物车"];
            }
        }
        $res = Db::name("cart")->insert($data);
        if($res){
            return [200, [$res], "请求成功"];
        }else{
            return [200, "请求失败"];
        }
    }
}