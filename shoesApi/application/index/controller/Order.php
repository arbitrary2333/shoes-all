<?php
/**
 * Created by PhpStorm.
 * User: 86180
 * Date: 2021/11/14
 * Time: 21:27
 */

namespace app\index\controller;


use think\Db;

class Order extends BaseController
{
    public function consigneeInfo($uid){
        $res = Db::name("address")->where("uid",$uid)->select();
        if($res){
            return [200, $res, "请求成功"];
        }else{
            return [200, "请求失败"];
        }
    }
    public function commitOrder(){
        $data = input("post.");
        $order_sn = $this->create_trade_no("Shoes");
        $order_insert = [
            'order_sn' => $order_sn,
            'consignee_address' => $data["consignee_address"],
            'consignee_name' => $data["consignee_name"],
            'consignee_phone' => $data["consignee_phone"],
            'user_id' => $data["user_id"],
            'order_amount' => $data["totalPrice"]
        ];
        $order_res = Db::name("order")->insert($order_insert);

        $order_select = Db::name("order")->where("order_sn", $order_sn)->select();
        $order_id = $order_select[0]["id"];
        $order_goods_insert = [];
        $order_goods_info = $data["productInfo"];
        foreach($order_goods_info as $goods){
            $single = [
                'order_id' => $order_id,
                'goods_id' => $goods['goods_id'],
                'goods_price' => $goods['newprice']
            ];
            array_push($order_goods_insert, $single);
        }

        $order_goods_res = Db::name("order_goods")->insertAll($order_goods_insert);

        foreach($order_goods_info as $goods){
            Db::name("cart")->where("user_id", $data["user_id"])->where("goods_id", $goods["goods_id"])->delete();
//            Db::name("goods")->where("id", $goods["goods_id"])->delete();
        }

        $res_user = Db::name("user")->where('id', $data["user_id"])->select();

        if(strpos($res_user[0]['discount_price'], $data['discount'].'') == 0){
            $all_discount_price = $data['discount'].',';
        }else if(strpos($res_user[0]['discount_price'], $data['discount'].'') == (strlen($res_user[0]['discount_price']) - 2)){
            $all_discount_price = ','.$data['discount'];
        }else{
            $all_discount_price = $data['discount'].',';
        }

        $discount_price_upt = str_replace($all_discount_price, "", $res_user[0]['discount_price']);

        Db::name("user")->where("id", $data["user_id"])->update([
            'discount_price' => $discount_price_upt
        ]);
        if($order_res && $order_goods_res){
            return [200, [$res_user[0]['discount_price'], $data['discount']], "成功"];
        }else{
            return [500, "失败"];
        }
    }
    public function searchOrder(){
        $data = input("post.");
        $user_id = $data["user_id"];
        $res_order = Db::name("order")->where("user_id", $user_id)->select();
        $order_id = [];
        foreach($res_order as $key=>&$order){
            array_push($order_id, $order["id"]);
        }
        $res_order_goods = Db::name("goods")->alias("g")->join("order_goods og", "og.goods_id = g.id")->
        where("order_id", "in", $order_id)->select();
        if(count($res_order_goods,1)){
            return [200, $res_order_goods, "请求成功"];
        }else{
            return [500, [], "请求失败"];
        }

    }
    public function searchBaby(){
        $data = input("post.");
        $res = Db::name("goods")->where("uid",$data["uid"])->select();
        if($res){
            return [200, $res, "请求成功"];
        }else{
            return [500, [], "请求失败"];
        }
    }
    public function user($id){
        $res = Db::name("user")->where("id",$id)->select();
        if ($res) {
            return [200, $res, "请求成功"];
        } else {
            return [500, [], "请求失败"];
        }
    }
    public function addConsignee(){
        $data = input("post.");
        $res = Db::name("address")->insert($data);
        if($res){
            return [200, [], "请求成功"];
        }else{
            return [500, [], "请求失败"];
        }
    }
}