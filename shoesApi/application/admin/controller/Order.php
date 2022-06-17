<?php
/**
 * Created by PhpStorm.
 * User: 86180
 * Date: 2021/11/18
 * Time: 23:30
 */

namespace app\admin\controller;


use think\Db;

class Order extends BaseController
{
    public function showlist(){
        $data = Db::name("order")->alias("o")
            ->join("user u", "o.user_id = u.id")
            ->field("o.id, o.order_sn, o.order_amount, u.username, o.consignee_name, o.consignee_phone, o.consignee_address")
            ->select()->toArray();
        $data_order_goods = Db::name("goods")->alias("g")->join("order_goods og", "og.goods_id = g.id")->select();
        foreach($data as $key=>&$order){
            $data_goods = [];
            foreach($data_order_goods as $goods){
                if($order["id"] == $goods["order_id"]){
                    array_push($data_goods,$goods);
                }
            }
            $order['order_goods'] = $data_goods;
        }
        if($data){
            return [200, $data,'请求成功'];
        }else{
            return [500, "请求失败"];
        }
    }
    public function upt(){
        $data = input("post.");
        $id = $data["id"];
        $res = Db::name("order")->where("id", $id)->update([
            'consignee_name' => $data['consignee_name'],
            'consignee_phone' => $data['consignee_phone'],
            'consignee_address' => $data['consignee_address']
        ]);
        if ($res) {
            return [200, [], "更新成功"];
        } else {
            return [500, [], "更新失败"];
        }
    }
    public function del()
    {
        $data = input("post.");
        $id = $data["id"];
        $res = Db::name("order")->where("id",$id)->delete();
        $res_order_goods = Db::name("order_goods")->where("order_id", $id)->delete();
        if($res && $res_order_goods){
            return [200, [], "删除成功"];
        }else{
            return [500, "删除失败"];
        }
    }
}