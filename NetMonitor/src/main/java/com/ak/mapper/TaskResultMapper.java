package com.ak.mapper;

import com.ak.entity.TTask;
import com.ak.entity.TTaskResult;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

;

/**
 * (TTask)表数据库访问层
 *
 * @author RestfulToolkitXCode
 * @since 2023-03-22 17:50:11
 */
@Mapper
public interface TaskResultMapper {

    void insert(TTaskResult taskqueryForm);

}

