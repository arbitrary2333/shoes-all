<?php
/**
 * Created by PhpStorm.
 * User: 86180
 * Date: 2021/11/12
 * Time: 23:15
 */

namespace app\index\controller;


use think\Db;

class Login extends BaseController
{
    public function login(){
        $data = input('post.');
        $res = Db::name("user")->where('phone','=',$data["phone"])->find();
        if($res){
            if($data["password"] == $res["password"]){
                $v = 1; // 自己定义的 需要hash 的value 值
                $key = mt_rand(); // 这里用 随机串作为key
                $hash = md5($key . $v . mt_rand() . time());
                $obj = (object)[];
                $obj->id = $res["id"];
                $obj->username = $res["username"];
                $obj->token = $hash;
                return [200, $obj, "登录成功"];
            }else{
                return [200, "登录失败"];
            }
        }else{
            return [200, "登录失败"];
        }
    }
}