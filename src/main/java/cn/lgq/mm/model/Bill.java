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
    private transient String memberName;
    private transient String memberIdCardNo;
    private transient String memberMobile;
    private Integer transType;
    private Integer amount;
    private Integer processFlag;
    private Timestamp createTime;
    private Long creatorId;
    private transient String creatorName;

    public Bill() {}

    public Bill(Long memberId, Integer transType, Integer amount, Long creatorId) {
        this.memberId = memberId;
        this.transType = transType;
        this.amount = amount;
        this.creatorId = creatorId;
    }
}
