package com.app.pucTis.Controllers;
import com.app.pucTis.Dtos.NewsRecord;
import com.app.pucTis.Entities.News;
import com.app.pucTis.Repositories.NewsRepository;
import com.app.pucTis.Services.NewsService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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
    @Autowired
    NewsRepository newsRepository;


    @PostMapping
    public ResponseEntity<News> createNews(@RequestBody @Valid NewsRecord newsRecord){
        News news = newsService.create(newsRecord);
        return new ResponseEntity<>(news, HttpStatus.CREATED);
    }

    @PostMapping("/likes")
    public ResponseEntity<Integer> countLikes() {
        int likesCount = newsService.countLikesNews(1);
        return ResponseEntity.ok(likesCount);
    }

    @GetMapping("/getNews")
    public ResponseEntity<List<News>> getAllNews(){
        return ResponseEntity.ok(newsRepository.findAll());
    }

}
