<?php
/**
 * Created by PhpStorm.
 * User: 86180
 * Date: 2021/11/13
 * Time: 20:32
 */

namespace app\index\controller;


use think\Db;

class Register extends BaseController
{
    public function register(){
        $data = input('post.');
        $res_username = Db::name("user")->where("username",$data["username"])->find();
        $res_phone = Db::name("user")->where("phone",$data["phone"])->find();
        if($res_username){
            return [500, '用户名已存在'];
        }else if($res_phone){
            return [500, '手机号已被注册'];
        }else{
            $res = Db::name("user")->insert($data);
            if($res){
                return [200,$res,'注册成功'];
            }else{
                return [500, '注册失败'];
            }
        }
    }
}