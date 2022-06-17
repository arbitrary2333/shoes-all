<?php
/**
 * Created by PhpStorm.
 * User: 86180
 * Date: 2021/11/15
 * Time: 17:59
 */

namespace app\admin\controller;


use think\Controller;
header('content-type:text/html;charset=utf-8');
class BaseController extends Controller
{
    public function _initialize(){
//        header("Content-type: text/html; charset=utf-8");
//        header("Access-Control-Allow-Origin:*");
//        header("Access-Control-Allow-Methods:GET, POST, OPTIONS, DELETE");
//        header("Access-Control-Allow-Headers:DNT,X-Mx-ReqToken,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type, Accept-Language, Origin, Accept-Encoding");
//        foreach (getallheaders() as $name => $value) {
//            echo "$name: $value\n";
//        }
    }

    // 文件上传
    public function upload($file){
        $info = $file->move(ROOT_PATH.'public'.DS.'headpicture');
        if($info){
            $image = $info->getSaveName();
            $path = str_replace("\\","/",$image);
            $ima_path = '/headpicture/'.$path;
            return $ima_path;
        }else{
            return $file->getError();
        }
    }
}