package com.ak.service.impl;

import com.ak.entity.TTask;
import com.ak.mapper.TaskMapper;
import com.ak.service.BaseService;
import com.ak.util.HttpClientUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import org.quartz.CronTrigger;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.impl.JobDetailImpl;
import org.quartz.impl.StdSchedulerFactory;
import org.quartz.impl.triggers.CronTriggerImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * (TTask)表服务实现类
 *
 * @author RestfulToolkitXCode
 * @since 2023-03-22 17:50:11
 */
@Service
public class TaskService {
    @Autowired
    private TaskMapper mapper;
    @Autowired
    private Scheduler scheduler;

    private Logger logger = LoggerFactory.getLogger(getClass());

    public List<TTask> findList(TTask tTask) {
        return mapper.findList(tTask);
    }

    public void save(TTask taskqueryForm) {
        if (taskqueryForm.getId() == null) {
            mapper.insert(taskqueryForm);
        } else {
            mapper.update(taskqueryForm);
        }
    }

    public TTask getTask(Integer taskId) {
        return mapper.getTask(taskId);
    }

    /**
     * 系统初始加载任务
     */
    public void loadJob() throws Exception {
        List<TTask> jobList = findList(new TTask());
        if (!CollectionUtils.isEmpty(jobList)) {
            for (int i = 0; i < jobList.size(); i++) {
                TTask job = jobList.get(i);
                // 任务开启状态 执行任务调度
                if ("1".equals(job.getEnabled().toString())) {
                    try {
                        JobDetailImpl jobDetail = new JobDetailImpl();
                        // 设置任务名称
                        if (org.springframework.util.StringUtils.hasText(job.getId().toString())) {
                            jobDetail.setName(job.getId().toString());
                        } else {
                            UUID uuid = UUID.randomUUID();
                            jobDetail.setName(uuid.toString());
                        }
                        jobDetail.setGroup(Scheduler.DEFAULT_GROUP);
                        jobDetail.setKey(JobKey.jobKey(job.getId().toString()));
                        // 设置任务执行类
                        jobDetail.setJobClass(TTask.class);
                        // 添加任务参数
                        CronTriggerImpl cronTrigger = new CronTriggerImpl("cron_" + job.getId().toString(), Scheduler.DEFAULT_GROUP,
                                jobDetail.getName(), Scheduler.DEFAULT_GROUP, HttpClientUtil.CRON_MAP.get(job.getFrequency()));
                        // 调度任务
                        scheduler.scheduleJob(jobDetail, cronTrigger);
                        if (!scheduler.isStarted()) {
                            scheduler.start();
                        }
                    } catch (SchedulerException e) {
                        logger.error("JobService SchedulerException", e);
                    } catch (Exception e) {
                        logger.error("JobService Exception", e);
                    }
                }
            }
        }
    }

    public void startTask(TTask job) {
        try {
            String cronExpress = HttpClientUtil.CRON_MAP.get(job.getFrequency().toString());
            if (StringUtils.isNotEmpty(cronExpress) && cronExpress.indexOf("null") == -1) {
                JobDetailImpl jobDetail = new JobDetailImpl();
                jobDetail.setName(job.getId().toString());
                jobDetail.setGroup(Scheduler.DEFAULT_GROUP);
                jobDetail.setJobClass(TTask.class);
                jobDetail.setKey(JobKey.jobKey(job.getId().toString()));
                CronTrigger cronTrigger = new CronTriggerImpl("cron_" + job.getId().toString(), Scheduler.DEFAULT_GROUP,
                        jobDetail.getName(), Scheduler.DEFAULT_GROUP, cronExpress);
                scheduler.scheduleJob(jobDetail, cronTrigger);
                if (!scheduler.isStarted()) {
                    scheduler.start();
                }
            }
        } catch (ParseException e) {
            logger.error("JobService ParseException", e);
        } catch (Exception e) {
            logger.error("JobService Exception", e);
        }
    }

    public void endTask(String id) {
        try {
            scheduler.deleteJob(JobKey.jobKey(id));
        } catch (SchedulerException e) {
            logger.error("JobService endTask", e);
        }
    }

}

