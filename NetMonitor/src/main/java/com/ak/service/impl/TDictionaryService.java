package com.ak.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ak.mapper.TDictionaryMapper;
import com.ak.entity.TDictionary;
import com.ak.service.ITDictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * (TDictionary)表服务实现类
 *
 * @author RestfulToolkitXCode
 * @since 2023-03-24 15:16:29
 */
@Service("tDictionaryService")
public class TDictionaryService implements ITDictionaryService {
    @Autowired
    private TDictionaryMapper dictionaryMapper;
    public List<TDictionary> selectList(String type) {
        return dictionaryMapper.selectList(type);
    }
}

