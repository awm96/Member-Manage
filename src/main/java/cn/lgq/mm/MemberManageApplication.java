package cn.lgq.mm;

import cn.lgq.mm.filter.AdminInterceptor;
import cn.lgq.mm.filter.MemberInterceptor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * Spring Boot 程序启动入口
 */
@Configuration
@EnableTransactionManagement
@SpringBootApplication
@EnableAsync
@MapperScan("cn.lgq.mm.dao")
public class MemberManageApplication extends WebMvcConfigurerAdapter {

	public static void main(String[] args) {
		SpringApplication.run(MemberManageApplication.class, args);
	}

	/**
	 * 添加自定义拦截器
	 */
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new MemberInterceptor()).addPathPatterns("/member/**");
		registry.addInterceptor(new AdminInterceptor()).addPathPatterns("/**")
				.excludePathPatterns("/", "/index.html", "/login/**", "/error");
	}

	@Override
	public void addViewControllers( ViewControllerRegistry registry ) {
		registry.addViewController( "/" ).setViewName( "/index" );
		registry.setOrder( Ordered.HIGHEST_PRECEDENCE );
	}
}
