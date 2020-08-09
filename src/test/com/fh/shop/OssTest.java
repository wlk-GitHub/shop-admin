package com.fh.shop;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import org.junit.Test;

import java.io.FileInputStream;
import java.io.InputStream;


public class OssTest {

        @Test
        public void  test1(){
            // Endpoint以杭州为例，其它Region请按实际情况填写。
            String endpoint = "http://oss-cn-beijing.aliyuncs.com";
            // 云账号AccessKey有所有API访问权限，建议遵循阿里云安全最佳实践，创建并使用RAM子账号进行API访问或日常运维，请登录 https://ram.console.aliyun.com 创建。
            String accessKeyId = "LTAI4GJhsV8uwN35MgfhvYsh";
            String accessKeySecret = "kJlRdV9KRFNGY54mEWWe6ZaD1u4x6J";

            OSS ossClient = null;
            try {
                // 创建OSSClient实例。
                ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);
                // 上传文件流。
                InputStream inputStream  = new FileInputStream("C:/Users/Administrator/Desktop/邵老师/20200430162618_a54JC.jpeg");
                ossClient.putObject("wlkwlk", "abc.jpeg", inputStream);
            } catch (Exception e) {
                e.printStackTrace();
            }finally {
                if(null != ossClient){
                    // 关闭OSSClient。
                    ossClient.shutdown();
                }
            }

        }

        @Test
        public void test2(){
            // Endpoint以杭州为例，其它Region请按实际情况填写。
            String endpoint = "http://oss-cn-beijing.aliyuncs.com";
            // 阿里云主账号AccessKey拥有所有API的访问权限，风险很高。强烈建议您创建并使用RAM账号进行API访问或日常运维，请登录 https://ram.console.aliyun.com 创建RAM账号。
            String accessKeyId = "LTAI4GJhsV8uwN35MgfhvYsh";
            String accessKeySecret = "kJlRdV9KRFNGY54mEWWe6ZaD1u4x6J";
            String bucketName = "wlkwlk";

            //路径加上文件名
            String objectName = "2020-07-14/52b49051be204a01a9bc824a295e905a.jpeg";

            OSS ossClient = null;

            try {
                // 创建OSSClient实例。
                 ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

                // 删除文件。如需删除文件夹，请将ObjectName设置为对应的文件夹名称。如果文件夹非空，则需要将文件夹下的所有object删除后才能删除该文件夹。
                ossClient.deleteObject(bucketName, objectName);

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
