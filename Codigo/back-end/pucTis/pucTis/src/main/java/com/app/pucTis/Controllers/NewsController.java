package com.app.pucTis.Controllers;
import com.app.pucTis.Dtos.NewsRecord;
import com.app.pucTis.Entities.News;
import com.app.pucTis.Repositories.NewsRepository;
import com.app.pucTis.Services.NewsService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@CrossOrigin("*")
@RequestMapping("/news")
public class NewsController {
    @Autowired
    private NewsService newsService;


    @PostMapping
    public ResponseEntity<News> createNews(@Valid @RequestBody NewsRecord newsRecord) {
        News news = newsService.create(newsRecord);
        if (news != null) {
            return new ResponseEntity<>(news, HttpStatus.CREATED);
        } else {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/likes")
    public ResponseEntity<Integer> countLikes() {
        int likesCount = newsService.countLikesNews(1);
        return ResponseEntity.ok(likesCount);
    }

    @GetMapping("/all")
    public ResponseEntity<List<News>> getNews(){
        List<News> newsList = newsService.getAllNews();
        if(newsList.isEmpty())
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        return new ResponseEntity<>(newsList,HttpStatus.OK);
    }

    @PutMapping("/{id}")
    public ResponseEntity<News> updateNews(@PathVariable("id") Long newsId, @RequestBody @Valid NewsRecord newsRecord) {
        News updatedNews = newsService.update(newsId, newsRecord);
        return ResponseEntity.ok(updatedNews);
    }

    @DeleteMapping("/{newsId}")
    public ResponseEntity<Void> deleteNews(@PathVariable long newsId) {
        try {
            newsService.deleteNews(newsId);
            return ResponseEntity.noContent().build();
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }



}
