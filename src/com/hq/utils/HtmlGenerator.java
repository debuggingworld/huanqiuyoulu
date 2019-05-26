package com.hq.utils;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.log4j.Logger;
import org.apache.log4j.lf5.util.StreamUtils;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;


/**
 * 页面静态化
 * @author zth
 * @Date 2019-05-26 15:43
 */
public class HtmlGenerator {
    private static Logger log = Logger.getLogger(HtmlGenerator.class);
    private static CloseableHttpClient httpClient = HttpClients.createDefault();

    /**
     * 根据 url 生成静态文件
     */
    public  static void creatHtmlPage(String url,String fileName){
        HttpGet httpGet = new HttpGet(url);
        CloseableHttpResponse response = null;
        try {
            response = httpClient.execute(httpGet);
            HttpEntity entity = response.getEntity();

            if (null != entity){
                InputStream inputStream = entity.getContent();
                FileOutputStream outputStream = new FileOutputStream(fileName);
                StreamUtils.copy(inputStream,outputStream);
                outputStream.close();
                inputStream.close();
            }
        } catch (IOException e) {
            log.error("com.hq.utils.HtmlGenerator_ERROR_页面静态化出错");
        }finally {
            try {
                response.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

}
