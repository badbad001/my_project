package cn.itcast;

import org.activiti.spring.boot.SecurityAutoConfiguration;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(exclude = SecurityAutoConfiguration.class)
@MapperScan("cn.itcast.*.mapper")
public class ErpBootApplication {

    public static void main(String[] args) {
        SpringApplication.run(ErpBootApplication.class, args);
    }

}
