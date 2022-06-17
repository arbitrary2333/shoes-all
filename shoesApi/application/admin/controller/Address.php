<?php
/**
 * Created by PhpStorm.
 * User: 86180
 * Date: 2021/11/16
 * Time: 22:27
 */

namespace app\admin\controller;


use think\Db;

class Address extends BaseController
{
    public function showlist()
    {
        $res = Db::name("user")->alias("u")->join("address a","a.uid = u.id")->select();
        if ($res) {
            return [200, $res, "请求成功"];
        } else {
            return [500, [], "请求失败"];
        }
    }

    public function add()
    {
        $data = input("post.");
        $res = Db::name("address")->insert($data);
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
        $res = Db::name("address")->where("id", $id)->update([
            'consignee_name' => $data['consignee_name'],
            'consignee_address' => $data['consignee_address'],
            'phone' => $data['phone'],
            'uid' => $data['uid']
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
        $res = Db::name("address")->where("id",$id)->delete();
        if($res){
            return [200, [], "删除成功"];
        }else{
            return [500, "删除失败"];
        }
    }
}