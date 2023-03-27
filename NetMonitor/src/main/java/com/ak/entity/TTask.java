package com.ak.entity;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;

import com.ak.timmer.FeatchResultJob;
import com.ak.util.HttpClientUtil;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.util.StringUtils;

import java.io.Serializable;
import java.util.List;

/**
 * (TTask)表实体类
 *
 * @author RestfulToolkitXCode
 * @since 2023-03-22 17:50:11
 */
@Data
@SuppressWarnings("serial")
public class TTask implements Job {
    public final static String API_KEY = "1e846c0540563296d8b6046ac3dddde2";
    /**
     * 劫持检测url
     */
    String apiUrl = "https://api.boce.com/v3/task/create/hijack?key=" + API_KEY;

    public static final int STATUS_NORMAL = 0;
    public static final int STATUS_RUNNING = 1;
    public static final int STATUS_FINISHED = 2;

    private Integer id;

    private String name;

    private String url;

    private String nodes;

    private Integer frequency;

    private String user;

    private Integer group;

    private Integer status = 0;

    private Integer enabled = 1;

    /**
     * 仅供展示的字段
     */
    private String frequencyCN;
    private String statusCN;
    private String enabledCN;
    private String nodesName;

    private Date lastRunTime;
    private Date updateTime;

    private Date createTime;

    private String jobClass;        // 任务类

    public String getStatusCN() {
        if (STATUS_NORMAL == status) {
            return "待运行";
        } else if (STATUS_RUNNING == status) {
            return "运行中";
        } else {
            return "运行完成";
        }
    }

    public String getEnabledCN() {
        return enabled == 1 ? "正常" : "停止";
    }

    @Override
    public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {

        // 1. 创建HttpClient实例
        CloseableHttpClient httpClient = HttpClients.createDefault();
        // 2. 创建GET请求方法实例
        List<NameValuePair> params = new ArrayList<>();
        String reqUrl = apiUrl + "&node_ids=" + nodes + "&host" + url;
        HttpEntity entity = HttpClientUtil.getResponse(reqUrl, params);
        if (entity != null) {
            try {
                String result = EntityUtils.toString(entity);
                JSONObject resultJson = JSONObject.parseObject(result);
                Object data = resultJson.get("data");
                String taskId = data == null ? "" : ((JSONObject) data).get("id").toString();
                if (StringUtils.hasText(taskId)) {
                    FeatchResultJob.taskIdList.add(id + "," + taskId);
                }
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
    }
}

