package com.ak.util;

import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Perry
 * @ClassName HttpClientUtil.java
 * @Description
 * @createTime 2023年03月25日
 *  
 */
public class HttpClientUtil {
    public static final Map<String, String> CRON_MAP = new HashMap<>();

    static {
        CRON_MAP.put("5", "0 * * * * ?");
        CRON_MAP.put("6", "0 0/3 * * * ?");
        CRON_MAP.put("7", "0 0/5 * * * ?");
        CRON_MAP.put("8", "0 0/10 * * * ?");
        CRON_MAP.put("9", "0 0/16 * * * ?");
        CRON_MAP.put("10", "0 0/30 * * * ?");
        CRON_MAP.put("11", "0 0 * * * ?");
        CRON_MAP.put("12", "0 0 0/2 * * ?");
        CRON_MAP.put("13", "0 0 0/3 * * ?");
        CRON_MAP.put("14", "0 0 0/6 * * ?");
        CRON_MAP.put("15", "0 0 0/12 * * ?");
        CRON_MAP.put("16", "0 0 0 * * ?");
        CRON_MAP.put("17", "0 0 0 0/2 * ?");
    }

    public static HttpEntity getResponse(String url, List<NameValuePair> params){
        // 1. 创建HttpClient实例
        CloseableHttpClient httpClient = HttpClients.createDefault();
        // 2. 创建GET请求方法实例
        HttpPost httpGet = new HttpPost(url);
        try {
            HttpEntity entity = new UrlEncodedFormEntity(params,"UTF-8");
            httpGet.setEntity(entity);
            // 3. 调用HttpClient实例来执行GET请求方法，得到response
            CloseableHttpResponse response = httpClient.execute(httpGet);
            // 4. 读response，判断是否访问成功 2xx表示 成功。
            int status = response.getStatusLine().getStatusCode();
            if (status >= 200 && status < 300) {
                // 对得到后的实例可以进行处理，例如读取回复体，读取html
                return response.getEntity();
            } else {
                // 调用失败的处理
            }
            // 6. 释放连接
            response.close();
            httpClient.close();
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    public static HttpEntity getResponseGet(String url){
        // 1. 创建HttpClient实例
        CloseableHttpClient httpClient = HttpClients.createDefault();
        // 2. 创建GET请求方法实例
        HttpGet httpGet = new HttpGet(url);
        try {
            // 3. 调用HttpClient实例来执行GET请求方法，得到response
            CloseableHttpResponse response = httpClient.execute(httpGet);
            // 4. 读response，判断是否访问成功 2xx表示 成功。
            int status = response.getStatusLine().getStatusCode();
            if (status >= 200 && status < 300) {
                // 对得到后的实例可以进行处理，例如读取回复体，读取html
                return response.getEntity();
            } else {
                // 调用失败的处理
            }
            // 6. 释放连接
            response.close();
            httpClient.close();
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return null;
    }
}
