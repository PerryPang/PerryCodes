package com.ak.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
;import org.apache.ibatis.annotations.Mapper;
import com.ak.entity.TDictionary;

import java.util.List;

/**
 * (TDictionary)表数据库访问层
 *
 * @author RestfulToolkitXCode
 * @since 2023-03-24 15:16:19
 */
@Mapper
public interface TDictionaryMapper{

    List<TDictionary> selectList(String type);
}

