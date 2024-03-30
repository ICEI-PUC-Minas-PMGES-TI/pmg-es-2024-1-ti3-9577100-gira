package com.app.pucTis.Services;

import com.app.pucTis.Dtos.NewsRecord;
import com.app.pucTis.Entities.Administrator;
import com.app.pucTis.Entities.News;
import com.app.pucTis.Entities.Teacher;
import com.app.pucTis.Repositories.AdiministratorRepository;
import com.app.pucTis.Repositories.NewsRepository;
import com.app.pucTis.Repositories.TeacherRepository;
import org.apache.tomcat.util.net.openssl.ciphers.Authentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class NewsService {
    @Autowired
    NewsRepository newsRepository;

    @Autowired
    AdiministratorService adiministratorService;

    @Autowired
    TeacherRepository teacherRepository;

    public void save(News news){
        this.newsRepository.save(news);

    }

    public News create(NewsRecord newsRecord) {
        Administrator administrator = SeesionManager.getAuthenticatedAdministrator();
        Teacher teacher = SeesionManager.getAuthenticatedTeacher();
        News news = new News();
        if (administrator != null || teacher != null) {

            news.setDescription(newsRecord.description());
            news.setDate(new Date());
            news.setImage(newsRecord.image());
            news.setAuthor(administrator != null ? administrator.getName() : teacher.getName());
            this.newsRepository.save(news);
        }
        return news;
    }

    public List<News> getAllNews(){
        return newsRepository.findAll();
    }
}
