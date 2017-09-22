package cn.lgq.mm.model;

import lombok.Data;

import java.sql.Timestamp;

/**
 * Created by Ligq on 2017/9/14.
 */
@Data
public class Bill {

    private Long id;
    private Long masterId;
    private Long memberId;
    private Integer transType;
    private Integer amount;
    private Timestamp createTime;
    private Long creatorId;
    private transient String creatorName;

}
