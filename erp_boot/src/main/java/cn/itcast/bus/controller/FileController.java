package cn.itcast.bus.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cn.itcast.bus.utils.AppFileUtils;
import cn.itcast.bus.utils.RandomUtils;
import cn.itcast.sys.common.Constant;
import cn.itcast.sys.common.DataGrid;

/**
 * @Author: badbad
 * @Date: 2019/9/26 19:21
 * @Version 1.0
 */
@Controller
@RequestMapping("file")
public class FileController {

    /**
           * 文件上传
     * @param mf
     * @return
     */
    @ResponseBody
    @RequestMapping("uploadFile")
    public DataGrid uploadFile(MultipartFile mf) throws IOException {

        //文件上传的父目录
        String parentPath= AppFileUtils.PATH;
        //得到当前日期作为文件夹名称
        String dirName= RandomUtils.getCurrentDateForString();
        //构造文件夹对象
        File dirFile=new File(parentPath,dirName);
        if(!dirFile.exists()) {
            dirFile.mkdirs();//创建文件夹
        }
        //得到文件原名
        String oldName=mf.getOriginalFilename();
        //根据文件原名得到新名   -- 这个文件名加了临时文件后缀
        String newName= RandomUtils.createFileNameUseTime(oldName, Constant.FILE_UPLOAD_TEMP_SUFFIX);
        File dest=new File(dirFile,newName);
        //上传文件
        mf.transferTo(dest);

        //接着把文件夹名和带有临时文件的后缀的新名进行拼接，返回去
        Map<String,Object> map = new HashMap<>();
        map.put("src",dirName+"/"+newName);
        /**layui文件上传返回的格式
         * code:
         * msg:
         * data:
         *    {
         *      src:
         *    }
         *    所以用一个map构建返回去，把src装进入
         */
        return new DataGrid(map);

    }

    /**
          * 不下载只显示
     */
    @RequestMapping("downloadShowFile")
    public ResponseEntity<Object> downloadShowFile(String path, HttpServletResponse response) {
        //这个下载文件的方法
        //第三个参数就是设置文件名
        //然后设置到附件文件名字上面
        //我们是只是根据相对路径，再拼接上绝对路径，来查看图片而已，所以
        //没必要设置文件名，设置为空字符串即可

        //如果我们需要设置文件名，就把文件名传过去即可
        //文件名要加上文件后缀
        //例如 String fileName = "客户数据表.xlsx";
        return AppFileUtils.downloadFile(response, path, "");
    }
}