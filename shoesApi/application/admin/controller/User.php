<?php
/**
 * Created by PhpStorm.
 * User: 86180
 * Date: 2021/11/16
 * Time: 20:01
 */

namespace app\admin\controller;


use think\Db;

class User extends BaseController
{
    public function showlist()
    {
        $res = Db::name("user")->select();
        if ($res) {
            return [200, $res, "请求成功"];
        } else {
            return [500, [], "请求失败"];
        }
    }

    public function add()
    {
        $data = input("post.");
        $res = Db::name("user")->insert($data);
        if ($res) {
            return [200, [], '添加成功'];
        } else {
            return [500, [], '添加失败'];
        }
    }

    public function upt()
    {
        $data = input("post.");
        $id = $data["id"];
        $res = Db::name("user")->where("id", $id)->update([
            'username' => $data['username'],
            'password' => $data['password'],
            'phone' => $data['phone']
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
        $res = Db::name("user")->where("id",$id)->delete();
        if($res){
            return [200, [], "删除成功"];
        }else{
            return [500, "删除失败"];
        }
    }
}