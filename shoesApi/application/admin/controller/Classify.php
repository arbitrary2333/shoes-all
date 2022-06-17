<?php
/**
 * Created by PhpStorm.
 * User: 86180
 * Date: 2021/11/18
 * Time: 22:46
 */

namespace app\admin\controller;


use think\Db;

class Classify extends BaseController
{
    public function showlist()
    {
        $res = Db::name("category")->select();
        if ($res) {
            return [200, $res, "请求成功"];
        } else {
            return [500, [], "请求失败"];
        }
    }

    public function add()
    {
        $data = input("post.");
        $file = request()->file("imgurlc");
        $imgurl = $this->upload($file);
        $data["imgurlc"] = $imgurl;
        $res = Db::name("category")->insert($data);
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
        $file = request()->file("imgurlc");
        $imgurlc = $this->upload($file);
        $res = Db::name("category")->where("id", $id)->update([
            'name' => $data['name'],
            'imgurlc' => $imgurlc
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
        $res = Db::name("category")->where("id",$id)->delete();
        if($res){
            return [200, [], "删除成功"];
        }else{
            return [500, "删除失败"];
        }
    }
}