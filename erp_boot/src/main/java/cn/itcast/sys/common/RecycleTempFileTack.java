package cn.itcast.sys.common;

import java.io.File;

import org.springframework.scheduling.annotation.Scheduled;

import cn.itcast.bus.utils.AppFileUtils;

//@Component
//@EnableScheduling   //开启定时任务
public class RecycleTempFileTack {

    @Scheduled(cron = "0 38 * * * ? ")
    public void recycleTempFile(){
        File file = new File(AppFileUtils.PATH);
        System.out.println("清除临时文件");
        deleteFile(file); //遍历删除图片
    }

    /**
     * 删除图片
     * @param file
     */
    public static void deleteFile(File file) {
        if (file!= null){
            File[] files = file.listFiles();
            if (files!=null && files.length>0){
                for (File f : files) {
                    if (f.isFile()){
                        if (f.getName().endsWith(Constant.FILE_UPLOAD_TEMP_SUFFIX)){
                            f.delete();
                        }
                    }else {
                        deleteFile(f);
                    }
                }
            }
        }

    }
}
