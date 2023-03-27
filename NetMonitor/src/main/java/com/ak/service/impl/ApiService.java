package com.ak.service.impl;

import com.ak.entity.TTask;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.BasicHttpEntity;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import sun.net.www.http.HttpClient;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Perry
 * @ClassName ApiService.java
 * @Description
 * @createTime 2023年03月25日
 *  
 */
public class ApiService {

    private final static String API_KEY = "1e846c0540563296d8b6046ac3dddde2";
    /**
     * 劫持检测url
     */
    String apiUrl = "https://api.boce.com/v3/task/create/hijack";

    public void executeTask(TTask task) throws IOException {
        // 1. 创建HttpClient实例
        CloseableHttpClient httpClient = HttpClients.createDefault();
        // 2. 创建GET请求方法实例
        HttpPost httpGet = new HttpPost(apiUrl);
        List<NameValuePair> params = new ArrayList<>();
        params.add(new BasicNameValuePair("key",API_KEY));
        params.add(new BasicNameValuePair("node_ids",task.getNodes()));
        params.add(new BasicNameValuePair("host",task.getUrl()));
        HttpEntity entity = new UrlEncodedFormEntity(params,"UTF-8");
        httpGet.setEntity(entity);
        // 3. 调用HttpClient实例来执行GET请求方法，得到response
        CloseableHttpResponse response = httpClient.execute(httpGet);
        // 4. 读response，判断是否访问成功 2xx表示 成功。
        int status = response.getStatusLine().getStatusCode();
        if (status >= 200 && status < 300) {
            // 对得到后的实例可以进行处理，例如读取回复体，读取html
            entity = response.getEntity();
            System.out.println(response);
            System.out.println("=======================");
            String html = EntityUtils.toString(entity);
            System.out.println(html);
        } else {
            throw new ClientProtocolException("Unexpected response status: " + status);
        }

        // 6. 释放连接
        response.close();
        httpClient.close();
    }
}
