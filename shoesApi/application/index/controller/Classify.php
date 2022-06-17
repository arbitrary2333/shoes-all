<?php
/**
 * Created by PhpStorm.
 * User: 86180
 * Date: 2021/10/24
 * Time: 22:42
 */

namespace app\index\controller;


use think\Db;

class Classify extends BaseController
{
    //  分类接口所有info
    public function classifyAllInfo(){
        $data_brand = Db::table("shoes_brand")->select();
        $data_category = Db::table("shoes_category")->select();
        $data_goods_r = Db::table("shoes_goods")->where("rid",1)->select();
        $result = [];
        $id = 0;
        foreach($data_category as $value){
            $res = (object)[];
            $id += 1;
            $res->id = $id;
            $res->title = $value["name"];
            $res->info = (object)[];
            $res->info->recommend = [];
            $res->info->brand = [];
            foreach ($data_goods_r as $item_g) {
                if($item_g["cid"] == $value["id"]){
                    $recommend = (object)[];
                    $recommend->id = $item_g["id"];
                    $recommend->img = $item_g["imgurl"];
                    $recommend->name = $item_g["goods_name"];
                    array_push($res->info->recommend,$recommend);
                }
            }
            foreach ($data_brand as $item_b) {
                if($item_b["cid"] == $value["id"]){
                    $brand = (object)[];
                    $brand->id = $item_b["id"];
                    $brand->img = $item_b["imgurlb"];
                    $brand->name = $item_b["brand_name"];
                    array_push($res->info->brand,$brand);
                }
            }
            array_push($result,$res);
        }
        return [200, $result, '请求成功'];
    }
}