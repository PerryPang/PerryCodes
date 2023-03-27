package com.ak.timmer;

import com.ak.entity.TTask;
import com.ak.service.impl.TaskService;
import com.ak.util.HttpClientUtil;
import com.alibaba.fastjson.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.util.StringUtils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Perry
 * @ClassName TimmerTest.java
 * @Description
 * @createTime 2023年03月25日
 *  
 */
public class TimmerTest {
    //测试方法
    public static void main(String[] args) {
        //全类名一定要与你要执行的方法相对应
// 1. 创建HttpClient实例
        CloseableHttpClient httpClient = HttpClients.createDefault();
        // 2. 创建GET请求方法实例
        List<NameValuePair> params = new ArrayList<>();
        params.add(new BasicNameValuePair("node_ids","31,32"));
        params.add(new BasicNameValuePair("host","www.baidu.com"));
        HttpEntity entity = HttpClientUtil.getResponse("https://api.boce.com/v3/task/create/hijack?key="+ TTask.API_KEY,params);
        if(entity != null){
            try {
                String result = EntityUtils.toString(entity);
                JSONObject resultJson = JSONObject.parseObject(result);
                System.out.println(resultJson);
                Object data = resultJson.get("data");
                String taskId = data ==null?"":((JSONObject)data).get("id").toString();
                if(StringUtils.hasText(taskId)){
                    System.out.println(taskId);
                }
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

    }


}
