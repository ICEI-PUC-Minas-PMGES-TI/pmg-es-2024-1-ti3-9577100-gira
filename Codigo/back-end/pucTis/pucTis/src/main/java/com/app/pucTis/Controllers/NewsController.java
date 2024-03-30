package com.app.pucTis.Controllers;
import com.app.pucTis.Dtos.NewsRecord;
import com.app.pucTis.Entities.News;
import com.app.pucTis.Services.NewsService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin("*")
@RequestMapping("/news")
public class NewsController {
    @Autowired
    private NewsService newsService;


    @PostMapping
    public ResponseEntity<News> createNews(@RequestBody @Valid NewsRecord newsRecord){
        News news = newsService.create(newsRecord);
        return new ResponseEntity<>(news, HttpStatus.CREATED);
    }


}
