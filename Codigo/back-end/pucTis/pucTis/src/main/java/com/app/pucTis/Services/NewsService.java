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
import java.util.Optional;

@Service
public class NewsService {
    @Autowired
    NewsRepository newsRepository;

    @Autowired
    AdiministratorService adiministratorService;

    @Autowired
    TeacherRepository teacherRepository;

    public NewsService(NewsRepository newsRepository){
        this.newsRepository = newsRepository;

    }

    public void save(News news){
        this.newsRepository.save(news);

    }

    public News create(NewsRecord newsRecord) {
        Administrator administrator = SeesionManager.getAuthenticatedAdministrator();
        Teacher teacher = SeesionManager.getAuthenticatedTeacher();

        if (administrator != null || teacher != null) {

            News news = new News();
            news.setDate(new Date());
            news.setDescription(newsRecord.description());
            news.setImage(newsRecord.image());
            news.setAuthor(administrator != null ? administrator.getName() : teacher.getName());


            News savedNews = newsRepository.save(news);


            if (savedNews != null) {
                return savedNews;
            } else {
                throw new IllegalStateException("Failed to save news in the database");
            }
        } else {
            throw new IllegalStateException("No authenticated administrator or teacher found.");
        }
    }


    public int countLikesNews(long newsId) {
        Optional<News> optionalNews = newsRepository.findById(newsId);
            News news = optionalNews.get();
            return news.getLikes();

    }

    public int addLikeToNews(long newsId) {
        Optional<News> optionalNews = newsRepository.findById(newsId);

            News news = optionalNews.get();
            int currentLikes = news.getLikes();
            news.setLikes(currentLikes + 1);
            newsRepository.save(news);
            return currentLikes + 1;

    }

    public List<News> getAllNews(){
        return newsRepository.findAll();
    }

    public News update(Long newsId, NewsRecord newsRecord) {

        Optional<News> optionalNews = newsRepository.findById(newsId);
        if (optionalNews.isPresent()) {
            News news = optionalNews.get();

            Administrator administrator = SeesionManager.getAuthenticatedAdministrator();
            Teacher teacher = SeesionManager.getAuthenticatedTeacher();
            if (administrator != null && news.getAuthor().equals(administrator.getName()) ||
                    teacher != null && news.getAuthor().equals(teacher.getName())) {

                news.setDescription(newsRecord.description());
                news.setImage(newsRecord.image());

                return newsRepository.save(news);
            } else {
                throw new IllegalStateException("Only the author can edit this news");
            }
        } else {
            throw new IllegalArgumentException("News not found");
        }
    }


    public void deleteNews(long newsId) {

        Optional<News> optionalNews = newsRepository.findById(newsId);
        if (optionalNews.isPresent()) {

            newsRepository.deleteById(newsId);
        } else {

            throw new IllegalArgumentException("News with ID " + newsId + " not found");
        }
    }
}
