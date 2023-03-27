package com.ak.mapper;

;import com.ak.annotation.MyBatisDao;
import com.ak.entity.TTask;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * (TTask)表数据库访问层
 *
 * @author RestfulToolkitXCode
 * @since 2023-03-22 17:50:11
 */
@Mapper
public interface TaskMapper {

    List<TTask> findList(TTask tTask);

    void insert(TTask taskqueryForm);

    void update(TTask taskqueryForm);

    TTask getTask(Integer taskId);

    void updateLastRunTime(String taskId);
}

