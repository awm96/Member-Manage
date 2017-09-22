package cn.lgq.mm.model;

import lombok.Data;

import java.sql.Date;
import java.sql.Timestamp;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * Created by Ligq on 2017/9/14.
 */
@Data
public class Member {

    private Long id;
    private String name;
    private String idCardNo;
    private String mobile;
    private String password;
    private Integer sex;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthday;
    private Integer level;
    private Integer storedAmount;
    private Integer consumeAmount;
    private Integer integralAmount;
    private Timestamp lastTransTime;
    private Timestamp createTime;
    private Long creatorId;
    private transient String creatorName;
    private Timestamp updateTime;
    private Long updaterId;
    private transient String updaterName;

}
