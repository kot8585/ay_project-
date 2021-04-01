package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class AyProjectApplication extends SpringBootServletInitializer{

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) { //war배포를 위한 소스
		return builder.sources(AyProjectApplication.class);
	}
	
	public static void main(String[] args) {
		SpringApplication.run(AyProjectApplication.class, args);
	}

}
