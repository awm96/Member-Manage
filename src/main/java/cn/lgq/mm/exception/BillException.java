package cn.lgq.mm.exception;

/**
 * Created by Ligq on 2017/9/28.
 * 交易异常
 */
public class BillException extends RuntimeException {
  public BillException(String msg) {
    super(msg);
  }
}
