<?php
/**
 * Created by PhpStorm.
 * User: 86180
 * Date: 2021/10/25
 * Time: 21:43
 */

namespace app\index\controller;

use think\Db;
use think\Request;

class Sale extends BaseController
{
    public function classifyList(){
        $data = Db::table("shoes_category")->select();
        if($data === 0){
            return [200,[],'未找到返回值'];
        }
        return [200, $data, '请求成功'];
    }
    public function diffBrandList($cid){
        $data = Db::table("shoes_brand")->where("cid",$cid)->select();
        if($data === 0){
            return [200,[],'未找到返回值'];
        }
        return [200, $data, '请求成功'];
    }
    public function conditionList(){
        $data = Db::table("shoes_condition")->select();
        if($data === 0){
            return [200,[],'未找到返回值'];
        }
        return [200, $data, '请求成功'];
    }
    public function timeList(){
        $data = Db::table("shoes_time")->select();
        if($data === 0){
            return [200,[],'未找到返回值'];
        }
        return [200, $data, '请求成功'];
    }
    public function freeshippingList(){
        $data = Db::table("shoes_freeshipping")->select();
        if($data === 0){
            return [200,[],'未找到返回值'];
        }
        return [200, $data, '请求成功'];
    }
    public function publishGoods(){
        $result = Request::instance();
        $data = $result->param();
        $file = $this->request->file("imgurl");
        $imgurl = $this->upload($file);
        $data["imgurl"] = $imgurl;
        $res = Db::name("goods")->insert($data);
        if($res){
            return [200,$data,'添加成功'];
        }else{
            return [200, '添加失败'];
        }
    }
    public function file(){
        return $this->fetch();
    }
}