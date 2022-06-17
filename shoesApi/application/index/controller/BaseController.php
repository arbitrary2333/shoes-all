<?php
/**
 * Created by PhpStorm.
 * User: 86180
 * Date: 2021/10/17
 * Time: 13:05
 */

namespace app\index\controller;


use think\Controller;
use think\Db;
header('content-type:text/html;charset=utf-8');
class BaseController extends Controller
{
    //  跨域：对所有用户
    public function _initialize(){
//        header("Content-type: text/html; charset=utf-8");
//        header("Access-Control-Allow-Origin:*");
//        header("Access-Control-Allow-Methods:GET, POST, OPTIONS, DELETE");
//        header("Access-Control-Allow-Headers:DNT,X-Mx-ReqToken,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type, Accept-Language, Origin, Accept-Encoding");
    }

    // 文件上传
    public function upload($file){
        $info = $file->move(ROOT_PATH.'public'.DS.'uploads');
        if($info){
            $image = $info->getSaveName();
            $path = str_replace("\\","/",$image);
            $ima_path = '/uploads/'.$path;
            return $ima_path;
        }else{
            return $file->getError();
        }
    }

    //  随即订单编号生成
    function create_trade_no($prefix){
        return $prefix . date('YmdHis', time()) . substr(microtime(), 2, 6) . sprintf('%03d', rand(0, 999));
    }
}