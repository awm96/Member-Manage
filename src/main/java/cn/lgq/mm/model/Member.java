package cn.lgq.mm.model;

import lombok.Data;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * Created by Ligq on 2017/9/14.
 */
@Data
public class Member {

    private Long id;
    private String name;
    private String idCardNo;
    private String password;
    private Integer sex;
    private Date birthday;
    private Integer level;
    private Integer storedAmount;
    private Integer consumeAmount;
    private Integer integralAmount;
    private Timestamp lastTransTime;
    private Timestamp createTime;
    private Long creatorId;
    private Timestamp updateTime;
    private Long updaterId;

}
