package cn.lgq.mm.vo;

import java.util.TreeMap;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * Created by Ligq on 2017/9/26.
 */
@Data
@Component
@ConfigurationProperties("system.regulation")
public class SystemRegulation {

  private TreeMap<Integer, Integer> storePresentRule;
  private Double consumeReturnRatio;
}
