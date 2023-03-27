package com.ak.timmer;

import com.ak.entity.TTask;
import com.ak.entity.TTaskResult;
import com.ak.mapper.TaskMapper;
import com.ak.mapper.TaskResultMapper;
import com.ak.util.HttpClientUtil;
import com.alibaba.fastjson.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.util.EntityUtils;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * 获取任务执行结果
 * @author Perry
 * @ClassName FeatchResultJob.java
 * @Description
 * @createTime 2023年03月25日
 *  
 */
public class FeatchResultJob implements Job {
    private final static String CRON = "0/5 * * * * ?";
    private final static String URL = "https://task.boce.com/v3/task/hijack/:id?key="+ TTask.API_KEY;
    /**
     * （本地任务ID，远程任务ID）形式保存
     */
    public static List<String> taskIdList = new ArrayList<>();

    @Autowired
    private TaskResultMapper resultMapper;

    @Autowired
    private TaskMapper taskMapper;
    @Override
    public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
        if(!taskIdList.isEmpty()){
            List<String> finishedList = new ArrayList<>();
            taskIdList.forEach(taskId->{
                String[] taskIdArray = taskId.split(",");
                String url = URL.replace(":id",taskIdArray[1]);
                HttpEntity entity = HttpClientUtil.getResponseGet(url);
                if(entity != null){
                    try {
                        String result = EntityUtils.toString(entity);
                        JSONObject resultJson = JSONObject.parseObject(result);
                        String done = resultJson.get("done").toString();
                        if("true".equals(done)){
                            // 遍历后存储数据
                            TTaskResult taskResult = new TTaskResult();
                            taskResult.setResult(result);
                            taskResult.setRemoteid(resultJson.get("id").toString());
                            taskResult.setHijackNum(Integer.parseInt(resultJson.get("hijack_num").toString()));
                            taskResult.setMaxNode(Integer.parseInt(resultJson.get("max_node").toString()));
                            resultMapper.insert(taskResult);

                            /**更新最近运行时间*/
                            taskMapper.updateLastRunTime(taskIdArray[0]);
                            // 删除任务节点
                            finishedList.add(taskId);
                        }
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                }
            });
            taskIdList.removeAll(finishedList);
        }
    }
}
