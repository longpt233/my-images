package demo;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Slf4j
@EntityScan("demo.domain")
@EnableJpaRepositories("demo.repository")
@EnableTransactionManagement
@ComponentScan(basePackages = {"demo"})
@Configuration
public class DemoConfiguration {
}
