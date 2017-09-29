package cn.lgq.mm.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.sql.Date;
import java.sql.Timestamp;
import lombok.Data;

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
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date birthday;
    private Integer level;
    private Integer storedAmount;
    private Integer consumeAmount;
    private Integer integralAmount;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Timestamp lastTransTime;
    private Long referrerId;
    private transient String referrerName;
    private Integer recommendNum;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Timestamp createTime;
    private Long creatorId;
    private transient String creatorName;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Timestamp updateTime;
    private Long updaterId;
    private transient String updaterName;

}
