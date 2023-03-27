package com.ak.entity;

import com.baomidou.mybatisplus.extension.activerecord.Model;
import lombok.Data;
import java.io.Serializable;

/**
 * (TDictionary)表实体类
 *
 * @author RestfulToolkitXCode
 * @since 2023-03-24 15:16:19
 */
@Data
@SuppressWarnings("serial")
public class TDictionary extends Model<TDictionary> {
    
    private Integer id;
    
    private String group;
    
    private String group2;
    
    private String name;
    
    private String code;
    
    private String type;
    
    private Integer enabled;

    /**
     * 获取主键值
     *
     * @return 主键值
     */
    @Override
    public Serializable pkVal() {
        return this.id;
    }
    }

