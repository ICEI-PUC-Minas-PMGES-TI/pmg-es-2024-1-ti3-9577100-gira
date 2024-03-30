package com.app.pucTis.Entities;

import com.app.pucTis.Entities.Enuns.UserType;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.Date;

@Entity
@Table(name= "tb_news")
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of = "id")
public class News {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String description;
    private Date date;
    private String image;
    private String author;
    private int likes;

    public News(News data){
        this.id = data.id;
        this.description = data.description;
        this.date = new Date();
        this.image = data.image;
        this.author = data.author;
        this.likes = 0;
    }
    public Long getId(Long id){ return id;}
    public void setDescription(String description){this.description=description;}
    public String getDescription(String description){return description;}
    public void setDate (Date date){this.date = date;}
    public Date getDate() {return date;}

    public void setImage(String image) {this.image = image;}
    public String getImage() {return image;}
    public void setAuthor(String author){this.author = author;}
    public String getAuthor() {return author;}
    public void setLikes(){this.likes ++;}
    public int getLikes(){return likes;}
}
