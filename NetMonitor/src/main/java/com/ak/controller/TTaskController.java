package com.ak.controller;


import com.ak.entity.TDictionary;
import com.ak.entity.TTask;
import com.ak.service.impl.TDictionaryService;
import com.ak.service.impl.TaskService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;
import java.util.concurrent.atomic.AtomicReference;

/**
 * (TTask)表控制层
 *
 * @author RestfulToolkitXCode
 * @since 2023-03-22 17:50:11
 */
@Controller
@RequestMapping(value = "task")
public class TTaskController {
    /**
     * 服务对象
     */
    @Autowired
    private TaskService taskService;

    @Autowired
    private TDictionaryService dictionaryService;

    /**
     * 分页查询所有数据
     *
     * @return 所有数据
     */
    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public ModelAndView home() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("home");
        return mv;
    }

    /**
     * 分页查询所有数据
     *
     * @param taskqueryForm 查询实体
     * @return 所有数据
     */
    @RequestMapping("/list")
    public ModelAndView selectAll(TTask taskqueryForm) {
        List<TTask> result = this.taskService.findList(taskqueryForm);
        List<TDictionary> dataList = dictionaryService.selectList("frequency");
        if (!CollectionUtils.isEmpty(result)) {
            result.forEach(t -> {
                Integer frequencyId = t.getFrequency();
                TDictionary data = findFromList(dataList, frequencyId);
                t.setFrequencyCN(data.getName());
            });
        }
        ModelAndView mv = new ModelAndView();

        mv.addObject("allTask", result);
        mv.addObject("dataSize", result.size());
        mv.addObject("queryForm", taskqueryForm);
        mv.setViewName("tasks_list");
        return mv;
    }

    private TDictionary findFromList(List<TDictionary> dataList, Integer frequencyId) {
        TDictionary result = new TDictionary();
        if (CollectionUtils.isEmpty(dataList) || frequencyId == null) {
            return result;
        }
        for (int i = 0; i < dataList.size(); i++) {
            result = dataList.get(i);
            if (result.getId().equals(frequencyId)) {
                break;
            }
        }
        return result;
    }

    @RequestMapping(value = {"form"})
    public String form(Integer taskId, Model model) {
        if (taskId != null) {
            TTask task = taskService.getTask(taskId);
            addNodesName(task);
            model.addAttribute("taskForm", task);
        }
        List<TDictionary> dataList = dictionaryService.selectList("frequency");
        model.addAttribute("typeList", dataList);
        return "picture-add";
    }

    private void addNodesName(TTask task) {
        List<TDictionary> dataList = dictionaryService.selectList("node");
        String nodesId = task.getNodes();
        if (!StringUtils.hasText(nodesId)) {
            return;
        }
        List<String> idList = Arrays.asList(nodesId.split(","));
        AtomicReference<StringBuffer> nodesName = new AtomicReference<>(new StringBuffer());
        dataList.forEach(d -> {
            if (idList.contains(d.getId().toString())) {
                nodesName.get().append(d.getName() + ",");
            }
        });
        task.setNodesName(nodesName.get().toString());
    }

    @RequestMapping(value = {"selectPoint"})
    public ModelAndView selectPoint(String nodeIds) {
        List<TDictionary> dataList = dictionaryService.selectList("node");
        List<String> groupList = new ArrayList<>();
        Map<String, List<TDictionary>> group2Map = new HashMap<>();
        dataList.forEach(t -> {
            String key = t.getGroup2();
            List<TDictionary> group2List = group2Map.get(key);
            if (group2List == null) {
                group2List = new ArrayList<>();
                group2List.add(t);
                group2Map.put(key, group2List);
            } else {
                group2List.add(t);
            }
            if (!groupList.contains(t.getGroup())) {
                groupList.add(t.getGroup());
            }
        });
        ModelAndView mv = new ModelAndView();
        mv.addObject("dataList", dataList);
        // 以地区分钟的数据集合
        mv.addObject("group2Map", group2Map);
        // 以运营商分组的集合
        mv.addObject("groups", groupList);
        mv.setViewName("selectPoint");
        return mv;
    }

    /**
     * 添加任务
     *
     * @param taskqueryForm 查询实体
     * @return 所有数据
     */
    @RequestMapping("/save")
    @ResponseBody
    public String save(TTask taskqueryForm) {
        Date now = new Date();
        taskqueryForm.setEnabled(0);// 默认不启动
        taskqueryForm.setCreateTime(now);
        taskqueryForm.setUpdateTime(now);
        taskqueryForm.setLastRunTime(now);
        this.taskService.save(taskqueryForm);
        return "success";
    }

    /**
     * 添加任务
     *
     * @return 所有数据
     */
    @RequestMapping("/changeEnabled")
    @ResponseBody
    public String changeEnabled(Integer taskId, Integer status) {
        if (taskId != null && (status == 1 || status == 0)) {
            TTask task = taskService.getTask(taskId);
            task.setEnabled(status);
            taskService.save(task);
            if(status == 1){
                taskService.startTask(task);
            }else{
                taskService.endTask(task.getId().toString());
            }
            return JSONObject.toJSONString(task);
        } else {
            return null;
        }
    }
}

