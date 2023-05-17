package config;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.zaxxer.hikari.HikariDataSource;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = {"kr.co.project"})
@MapperScan(basePackages = {"kr.co.project"}, annotationClass = Mapper.class)
@EnableTransactionManagement
public class MvcConfig implements WebMvcConfigurer {
	@Override
	public void configureViewResolvers(ViewResolverRegistry reg) {
		reg.jsp("/WEB-INF/jsp/", ".jsp");
	}
	
	@Bean
	public HikariDataSource dataSource() {
		HikariDataSource dataSource = new HikariDataSource();
		dataSource.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
		dataSource.setJdbcUrl("jdbc:log4jdbc:oracle:thin:@15.164.210.161:1521:xe");
		dataSource.setUsername("system");
		dataSource.setPassword("qwer1234");
		return dataSource;
	}
	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
		sqlSessionFactory.setDataSource(dataSource());
		return sqlSessionFactory.getObject();
	}
	@Bean
	public SqlSessionTemplate sst() throws Exception {
		return new SqlSessionTemplate(sqlSessionFactory());
	}
	
	// 정적페이지
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/index.do").setViewName("index");
	}
	
	// 정적리소스(html, css, js, 이미지....)
	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}
	
	// 파일첨부
	@Bean
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver resolver = new CommonsMultipartResolver();
		resolver.setDefaultEncoding("utf-8");
		resolver.setMaxUploadSize(1024*1024*3);
		return resolver;
	}
	
	// 트랜잭션 설정
	@Bean
	public PlatformTransactionManager transactionManager() {
		DataSourceTransactionManager tm = new DataSourceTransactionManager();
		tm.setDataSource(dataSource());
		return tm;
	}

	
	
	
	
	
	
	
	
	
	
	
	
}
