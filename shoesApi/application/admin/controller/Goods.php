<?php
/**
 * Created by PhpStorm.
 * User: 86180
 * Date: 2021/11/16
 * Time: 15:22
 */

namespace app\admin\controller;

use think\Db;
use think\Request;

class Goods extends BaseController
{
    public function getBrand(){
        $data = Db::name('brand')->select();
        if($data){
            return [200, $data, "请求成功"];
        }else{
            return [500, "请求错误"];
        }
    }
    public function showlist(){
        $data = Db::name('goods')->alias('g')
            ->join('category c','g.cid= c.id')
            ->join('brand b','g.bid= b.id')
            ->join('activity a','g.aid=a.id ')
            ->join('condition co','g.coid=co.id')
            ->join('time t','g.tid=t.id')
            ->join('freeshipping f','g.fsid=f.id')
            ->field('g.id,g.goods_name,g.newprice,g.oldprice,g.imgurl,g.size,c.name,b.brand_name,a.activity_name,co.condition_name,
            t.time_name,f.freeshipping_name,g.cid,g.bid,g.aid,g.coid,g.tid,g.fsid')
            ->select();
        if($data){
            return [200, $data,'请求成功'];
        }else{
            return [500, "请求失败"];
        }
    }
    public function add(){
        $data = input("post.");
        $file = request()->file("imgurl");
        $imgurl = $this->upload($file);
        $data["imgurl"] = $imgurl;
        $res = Db::name("goods")->insert($data);
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
        $res = Db::name("goods")->where("id",$id)->update([
            'goods_name' => $data['goods_name'],
            'newprice' => $data['newprice'],
            'oldprice' => $data['oldprice'],
            'imgurl' => $imgurl,
            'size' => $data['size'],
            'cid' => $data['cid'],
            'bid' => $data['bid'],
            'aid' => $data['aid'],
            'coid' => $data['coid'],
            'tid' => $data['tid'],
            'fsid' => $data['fsid'],
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
        $res = Db::name("goods")->where("id",$id)->delete();
        if($res){
            return [200, [], "删除成功"];
        }else{
            return [500, "删除失败"];
        }
    }
}