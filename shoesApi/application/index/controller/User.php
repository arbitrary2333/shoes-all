<?php
/**
 * Created by PhpStorm.
 * User: 86180
 * Date: 2021/10/16
 * Time: 13:20
 */

namespace app\index\controller;


use think\Controller;
use think\Db;
header('content-type:text/html;charset=utf-8');

class User extends BaseController
{
    public function listApi(){
        $data = Db::table("shoes_user")->select();
        if($data === 0){
            return [200,[],'未找到返回值'];
        }
        return [200, $data, '请求成功'];
    }
    public function addApi(){

    }
    public function uptApi(){

    }
    public function delApi(){

    }
}