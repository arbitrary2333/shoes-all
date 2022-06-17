<?php
/**
 * Created by PhpStorm.
 * User: 86180
 * Date: 2021/11/14
 * Time: 14:16
 */

namespace app\index\controller;


use think\Db;

class Classifylist extends BaseController
{
    public function diffClassify($cid){
        $data = Db::table("shoes_category")->alias("c")->join("shoes_goods g","c.id = g.cid")->select();
        $data2 = [];
        foreach($data as $value){
            if($value['cid'] == $cid){
                array_push($data2,$value);
            }
        }
        if(empty($data2)){
            return [200,[],'未找到返回值'];
        }
        return [200, $data2, '请求成功'];
    }
    public function diffActivity($aid){
        $data = Db::name("goods")->where("aid",$aid)->select();
        if(empty($data)){
            return [200,[],'未找到返回值'];
        }
        return [200, $data, '请求成功'];
    }
    public function diffBrand($bid){
        $data = Db::name("goods")->where("bid",$bid)->select();
        if(empty($data)){
            return [200,[],'未找到返回值'];
        }
        return [200, $data, '请求成功'];
    }
}