package elec5619.group3.besocialos.config;

import elec5619.group3.besocialos.model.Post;
import elec5619.group3.besocialos.model.User;
import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;
import java.util.Properties;

@Configuration
@EnableTransactionManagement
public class HibernateConfig {

    @Bean
    public LocalSessionFactoryBean sessionFactory() {
        LocalSessionFactoryBean sessionFactoryBean = new LocalSessionFactoryBean();
        sessionFactoryBean.setDataSource(dataSource());
        sessionFactoryBean.setAnnotatedClasses(User.class, Post.class);
        sessionFactoryBean.setHibernateProperties(hibernateProperties());
        return sessionFactoryBean;
    }

    @Bean
    public DataSource dataSource() {
        BasicDataSource dataSource = new BasicDataSource();
        dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");

        dataSource.setUrl("jdbc:mysql://aana0jzx3bfxwq.c2wvvizukegb.ap-southeast-2.rds.amazonaws.com:3306/ebdb");
        dataSource.setUsername("root");
        dataSource.setPassword("besocialosroot");

        if(Config.getConfig().isTest()){
            dataSource.setDriverClassName("org.h2.Driver");
            dataSource.setUrl("jdbc:h2:mem:testdb;MODE=MYSQL;DB_CLOSE_DELAY=-1");
            dataSource.setUsername("root");
            dataSource.setPassword("besocialosroot");
            return dataSource;
        }

//        dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
//        dataSource.setUrl("jdbc:mysql://localhost:3308/besocialos");
//        dataSource.setUsername("root");
//        dataSource.setPassword("besocialosroot");
        return dataSource;
    }

    @Bean
    public HibernateTransactionManager transactionManager() {
        HibernateTransactionManager transactionManager = new HibernateTransactionManager();
        transactionManager.setSessionFactory(sessionFactory().getObject());
        return transactionManager;
    }

    protected Properties hibernateProperties() {
        Properties hibernateProperties = new Properties();
        if(Config.getConfig().isTest()){
            hibernateProperties.setProperty(
                    "hibernate.dialect", "org.hibernate.dialect.H2Dialect");
        }
        hibernateProperties.setProperty(
                "hibernate.dialect", "org.hibernate.dialect.MySQL55Dialect");
        hibernateProperties.setProperty(
                "hibernate.id.new_generator_mappings", "false");
        hibernateProperties.setProperty(
                "hibernate.hbm2ddl.auto", "create-drop");

        return hibernateProperties;
    }
}