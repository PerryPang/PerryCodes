package com.ak.entity;

import com.baomidou.mybatisplus.extension.activerecord.Model;
import lombok.Data;
import java.io.Serializable;

/**
 * (TTaskResult)表实体类
 *
 * @author RestfulToolkitXCode
 * @since 2023-03-25 18:13:23
 */
@Data
@SuppressWarnings("serial")
public class TTaskResult extends Model<TTaskResult> {
    
    private Integer id;
    //被劫持的点位数
    private Integer hijackNum;
    //远程系统任务ID
    private String remoteid;
    
    private Integer maxNode;
    //存储接口返回的结果
    private String result;

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

