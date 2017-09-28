package cn.lgq.mm;

import cn.lgq.mm.filter.AdminInterceptor;
import cn.lgq.mm.filter.MemberInterceptor;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.collect.Maps;
import freemarker.ext.beans.BeansWrapper;
import freemarker.ext.beans.BeansWrapperBuilder;
import freemarker.template.TemplateHashModel;
import freemarker.template.TemplateModelException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.Map;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.format.Formatter;
import org.springframework.format.FormatterRegistry;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.freemarker.FreeMarkerViewResolver;

/**
 * Spring Boot 程序启动入口
 */
@Configuration
@EnableTransactionManagement
@SpringBootApplication
@EnableAsync
@EnableScheduling
public class MemberManageApplication extends WebMvcConfigurerAdapter {

    public static void main(String[] args) {
        SpringApplication.run(MemberManageApplication.class, args);
    }

  /**
   * 添加请求参数Timestamp类型转换器
   */
  @Override
    public void addFormatters(FormatterRegistry registry) {
      registry.addFormatter(new Formatter<Timestamp>(){
        private final DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        @Override
        public String print(Timestamp object, Locale locale) {
          return df.format(object);
        }
        @Override
        public Timestamp parse(String text, Locale locale) throws ParseException {
          if (StringUtils.isNotBlank(text)) {
            return new Timestamp(df.parse(text).getTime());
          }
          return null;
        }
      });
      super.addFormatters(registry);
    }

  /**
     * 添加自定义拦截器
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new MemberInterceptor()).addPathPatterns("/member/**")
                .excludePathPatterns("/member/login");
        AdminInterceptor adminInterceptor = new AdminInterceptor(new String[] {"/manage/admin"});
        registry.addInterceptor(adminInterceptor).addPathPatterns("/manage/**")
                .excludePathPatterns("/manage/login");
    }

    /**
     * 注册首页view
     */
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("/index");
        registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
    }

    /**
     * 添加Freemarker自定义静态类支持
     *
     * @param viewResolver spring autoconfig自动生成的viewResolver
     * @return 原viewResolver
     */
    @Bean
    public FreeMarkerViewResolver getFreeMarkerViewResolver(
            @Autowired FreeMarkerViewResolver viewResolver,
            @Autowired ObjectMapper objectMapper) {
        Map<String, Object> classMap = Maps.newHashMap();
        classMap.put("_ExceptionUtils", this.getTemplateHashModel(ExceptionUtils.class));
        classMap.put("_Constants", this.getTemplateHashModel(Constants.class));
        classMap.put("_ObjectMapper", objectMapper);
        viewResolver.setAttributesMap(classMap);
        return viewResolver;
    }

    private TemplateHashModel getTemplateHashModel(Class<?> clazz) {
        BeansWrapper wrapper = new BeansWrapperBuilder(freemarker.template.Configuration.getVersion())
                .build();
        TemplateHashModel staticModels = wrapper.getStaticModels();
        TemplateHashModel fileStatics = null;
        try {
            fileStatics = (TemplateHashModel) staticModels.get(clazz.getName());
        } catch (TemplateModelException e) {
            e.printStackTrace();
        }
        return fileStatics;
    }
}
