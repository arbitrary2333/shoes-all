<?php
/**
 * Created by PhpStorm.
 * User: 86180
 * Date: 2020/10/7
 * Time: 18:03
 */

namespace app\index\model;


use think\Model;

class Index extends Model
{
//    protected $autoWriteTimestamp = true;
    public function addsave($data){
        return $this->save($data);
    }
}