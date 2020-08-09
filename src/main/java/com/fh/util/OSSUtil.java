package com.fh.util;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;

import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.UUID;

    public class OSSUtil {

    public static final String ENDPOINT = "http://oss-cn-beijing.aliyuncs.com";
    public static final String ACCESSKEYID = "LTAI4GJhsV8uwN35MgfhvYsh";
    public static final String ACCESSKEYSECRET = "kJlRdV9KRFNGY54mEWWe6ZaD1u4x6J";
    public static final String BUCKET = "wlkwlk";
    public static final String URL = "http://wlkwlk.oss-cn-beijing.aliyuncs.com/";




    public static String uploadFile(InputStream is,String fileName) {
        OSS ossClient = null;
        try {
            // 创建OSSClient实例。
            ossClient = new OSSClientBuilder().build(ENDPOINT, ACCESSKEYID, ACCESSKEYSECRET);
            String suffix = FileUtil.getSuffix(fileName);
            String uploadFileName = UUID.randomUUID().toString().replace("-", "") + suffix;
            String pathName = DateUtil.date2str(new Date(), DateUtil.Y_M_D);
            String objectName = pathName+"/"+uploadFileName;
            ossClient.putObject(BUCKET, objectName, is);

            return URL+objectName;

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } finally {

            if(null != is){
                try {
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

                if (null != ossClient) {
                // 关闭OSSClient。
                ossClient.shutdown();
              }
            }
        }


        public static void deleteFile (String path){


            //路径加上文件名
            String objectName = path.replace(URL, "");

            OSS ossClient = null;

            try {
                // 创建OSSClient实例。
                ossClient = new OSSClientBuilder().build(ENDPOINT, ACCESSKEYID, ACCESSKEYSECRET);

                // 删除文件。如需删除文件夹，请将ObjectName设置为对应的文件夹名称。如果文件夹非空，则需要将文件夹下的所有object删除后才能删除该文件夹。
                ossClient.deleteObject(BUCKET, objectName);

                // 关闭OSSClient。
                ossClient.shutdown();
            } catch (Exception e) {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
            finally {
                if (null != ossClient){
                    ossClient.shutdown();
                }
            }
        }




    }

