package com.app.pucTis.Services;

import com.app.pucTis.Dtos.NewsRecord;
import com.app.pucTis.Entities.*;
import com.app.pucTis.Exceptions.AlreadyDislikedException;
import com.app.pucTis.Exceptions.SaveNewsException;
import com.app.pucTis.Exceptions.UnauthorizedUserException;
import com.app.pucTis.Repositories.*;
import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.crossstore.ChangeSetPersister;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class NewsService {

    private final NewsRepository newsRepository;
    private final AuthenticationService authenticationService;
    private final AdiministratorRepository administratorRepository;
    private final TeacherRepository teacherRepository;
    private final ParentsRepository parentsRepository;

    @Autowired
    public NewsService(NewsRepository newsRepository,
                       AuthenticationService authenticationService,
                       AdiministratorRepository administratorRepository,
                       TeacherRepository teacherRepository,
                       ParentsRepository parentsRepository) {
        this.newsRepository = newsRepository;
        this.authenticationService = authenticationService;
        this.administratorRepository = administratorRepository;
        this.teacherRepository = teacherRepository;
        this.parentsRepository = parentsRepository;
    }

    public News create(NewsRecord newsRecord) {
        Object authenticatedUser = authenticationService.getAuthenticatedUser();
        authenticationService.validateAuthorizedUser(authenticatedUser);
        News news = createNews(newsRecord, authenticatedUser);
        return saveNews(news);
    }

    private News createNews(NewsRecord newsRecord, Object user) {

        News news = new News(newsRecord);
        news.setDate(new Date());
        news.setDescription(newsRecord.description());
        news.setImage(newsRecord.image());
        news.setAuthor(getAuthorName(user));
        return news;
    }

    private String getAuthorName(Object user) {
        if (user instanceof Administrator) {
            return ((Administrator) user).getName();
        } else if (user instanceof Teacher) {
            return ((Teacher) user).getName();
        } else if (user instanceof Parents) {
            return ((Parents) user).getName();
        }
        return null;
    }

    private News saveNews(News news) {
        try {
            return newsRepository.save(news);
        } catch (Exception e) {
            throw new SaveNewsException("Failed to save news in the database", e);
        }
    }

    public List<News> getAllNews() {
        return newsRepository.findAll();
    }

    public News update(Long newsId, NewsRecord newsRecord) throws ChangeSetPersister.NotFoundException {
        Optional<News> optionalNews = newsRepository.findById(newsId);
        if (optionalNews.isPresent()) {
            News news = optionalNews.get();
            Object authenticatedUser = authenticationService.getAuthenticatedUser();
            authenticationService.validateAuthorizedUser(authenticatedUser);

            String authorName = news.getAuthor();
            if ((authenticatedUser instanceof Administrator && ((Administrator) authenticatedUser).getName().equals(authorName)) ||
                    (authenticatedUser instanceof Teacher && ((Teacher) authenticatedUser).getName().equals(authorName))) {
                news.setDescription(newsRecord.description());
                news.setImage(newsRecord.image());
                return newsRepository.save(news);
            } else {
                throw new IllegalStateException("Only the author can edit this news");
            }
        } else {
            throw new ChangeSetPersister.NotFoundException();
        }
    }

    public void deleteNews(long newsId) throws ChangeSetPersister.NotFoundException {
        Optional<News> optionalNews = newsRepository.findById(newsId);
        if (optionalNews.isPresent()) {
            newsRepository.deleteById(newsId);
        } else {
            throw new ChangeSetPersister.NotFoundException();
        }
    }

    public int countLikesNews(long newsId) throws ChangeSetPersister.NotFoundException {
        Optional<News> optionalNews = newsRepository.findById(newsId);
        if (optionalNews.isEmpty()) {
            throw new ChangeSetPersister.NotFoundException();
        }
        return optionalNews.get().getLikes();
    }

    public int removeLikeFromNews(long newsId) throws ChangeSetPersister.NotFoundException {
        Optional<News> optionalNews = newsRepository.findById(newsId);
        if (optionalNews.isEmpty()) {
            throw new ChangeSetPersister.NotFoundException();
        }

        News news = optionalNews.get();
        Object authenticatedUser = authenticationService.getAuthenticatedUser();
        authenticationService.validateAuthorizedUser(authenticatedUser);

        if (hasUserLikedNews(authenticatedUser, news)) {
            news.setLikes(news.getLikes() - 1);
            removeLikeFromUser(authenticatedUser, news);
            newsRepository.save(news);
        } else {
            throw new AlreadyDislikedException("User has not liked this news.");
        }

        return news.getLikes();
    }
    public int toggleLike(long newsId) throws ChangeSetPersister.NotFoundException {
        Optional<News> optionalNews = newsRepository.findById(newsId);

        if (optionalNews.isEmpty()) {
            throw new ChangeSetPersister.NotFoundException();
        }

        News news = optionalNews.get();
        Object authenticatedUser = authenticationService.getAuthenticatedUser();
        authenticationService.validateAuthorizedUser(authenticatedUser);


        boolean hasLiked = hasUserLikedNews(authenticatedUser, news);

        if (hasLiked) {
            news.setLikes(news.getLikes() - 1);
            removeLikeFromUser(authenticatedUser, news);
            System.out.println("Removed like from news ID " + newsId + " by user " + authenticatedUser.getClass().getSimpleName());
        } else {
            news.setLikes(news.getLikes() + 1);
            addLikeToUser(authenticatedUser, news);
            System.out.println("Added like to news ID " + newsId + " by user " + authenticatedUser.getClass().getSimpleName());
        }

        newsRepository.save(news);
        System.out.println("Updated likes count for news ID " + newsId + ": " + news.getLikes());

        return news.getLikes();
    }





    private boolean hasUserLikedNews(Object user, News news) {

        if (user instanceof Administrator) {
            return ((Administrator) user).getLikedNews().contains(news);
        } else if (user instanceof Teacher) {
            return ((Teacher) user).getLikedNews().contains(news);
        } else if (user instanceof Parents) {
            return ((Parents) user).getLikedNews().contains(news);
        }
        return false;
    }

    private void addLikeToUser(Object user, News news) {

        synchronized (this) {
            if (user instanceof Administrator) {
                ((Administrator) user).addLikeNews(news);
                administratorRepository.save((Administrator) user);
            } else if (user instanceof Teacher) {
                ((Teacher) user).addLikeNews(news);
                teacherRepository.save((Teacher) user);
            } else if (user instanceof Parents) {
                ((Parents) user).addLikeNews(news);
                parentsRepository.save((Parents) user);
            }
        }
    }

    private void removeLikeFromUser(Object user, News news) {
        synchronized (this) {
            if (user instanceof Administrator) {
                ((Administrator) user).removeLikedNews(news);
                administratorRepository.save((Administrator) user);
            } else if (user instanceof Teacher) {
                ((Teacher) user).removeLikedNews(news);
                teacherRepository.save((Teacher) user);
            } else if (user instanceof Parents) {
                ((Parents) user).removeLikedNews(news);
                parentsRepository.save((Parents) user);
            }
        }
    }





}
