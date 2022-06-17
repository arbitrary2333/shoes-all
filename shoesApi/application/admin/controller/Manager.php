<?php
/**
 * Created by PhpStorm.
 * User: 86180
 * Date: 2021/11/15
 * Time: 20:04
 */

namespace app\admin\controller;


use think\Db;
use think\Request;

class Manager extends BaseController
{
    public function showlist(){
        $res = Db::name("manager")->select();
        if($res){
            return [200, $res, "请求成功"];
        }else{
            return [500,[], "请求失败"];
        }
    }
    public function add(){
        $result = Request::instance();
        $data = $result->param();
        $file = request()->file("imgurl");
        $imgurl = $this->upload($file);
        $data["imgurl"] = $imgurl;
        $res = Db::name("manager")->insert($data);
        if($res){
            return [200,[],'添加成功'];
        }else{
            return [500,[], '添加失败'];
        }
    }
    public function upt(){
        $data = input("post.");
        $id = $data["id"];
        $file = request()->file("imgurl");
        $imgurl = $this->upload($file);
        $res = Db::name("manager")->where("id",$id)->update([
            'username' => $data['username'],
            'password' => $data['password'],
            'imgurl' => $imgurl
        ]);
        if($res){
            return [200,[], "更新成功"];
        }else{
            return [500,[], "更新失败"];
        }
    }
    public function del(){
        $data = input("post.");
        $id = $data["id"];
        $res = Db::name("manager")->where("id",$id)->delete();
        if($res){
            return [200, [], "删除成功"];
        }else{
            return [500, "删除失败"];
        }
    }
}