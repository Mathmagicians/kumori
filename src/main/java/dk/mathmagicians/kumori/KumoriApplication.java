package dk.mathmagicians.kumori;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.web.client.RestTemplate;

import dk.mathmagicians.kumori.domain.ConfluencePage;

@SpringBootApplication
public class KumoriApplication {

	private static final Logger log = LoggerFactory.getLogger(KumoriApplication.class);
	
	@Value("${confluence.url}") private String confluenceUrl;

	
	public static void main(String[] args) {
		SpringApplication.run(KumoriApplication.class, args);
	}
	

	@Bean
	public RestTemplate restTemplate(RestTemplateBuilder builder) {
		return builder.build();
	}

	@Bean
	public CommandLineRunner run(RestTemplate restTemplate) throws Exception {
		return args -> {
			ConfluencePage page = restTemplate.getForObject( confluenceUrl,
					ConfluencePage.class);
			log.info(page.toString());
		};
	}

}
