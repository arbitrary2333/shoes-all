<?php
/**
 * Created by PhpStorm.
 * User: 86180
 * Date: 2021/11/7
 * Time: 15:10
 */

namespace app\index\model;


use think\Model;

class Goods extends Model
{
    public function addsave($data){
        return $this->save($data);
    }
}