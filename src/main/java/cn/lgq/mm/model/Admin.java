package cn.lgq.mm.model;

import lombok.Data;

import java.sql.Timestamp;

/**
 * Created by Ligq on 2017/9/14.
 */
@Data
public class Admin {

    private Long id;
    private String name;
    private String password;
    private Integer type;
    private Timestamp createTime;
    private Long creator;
    private Timestamp updateTime;
    private Long updater;

}
