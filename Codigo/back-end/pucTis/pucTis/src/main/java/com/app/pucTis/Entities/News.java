package com.app.pucTis.Entities;

import com.app.pucTis.Dtos.NewsRecord;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import java.util.Date;

@Entity
@Table(name = "tb_news")
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of = "id")
public class News {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotBlank
    @Column(nullable = false)
    private String description;
    private Date date;
    private String image;
    @NotBlank
    @Column(nullable = false)
    private String author;
    private int likes;
    @JsonIgnore
    private boolean status;

    public News(NewsRecord data) {
        this.date = new Date();
        this.id = data.id();
        this.description = data.description();
        this.image = data.image();
        this.author = data.author();
        this.likes = 0;
        this.status = true;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public int getLikes() {
        return likes;
    }

    public boolean isStatus() {
        return this.status;
    }

    public boolean getStatus() {
        return this.status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public void addImage(String imageUrl) {
        this.image = imageUrl;
    }

    public void addLike() {
        this.likes++;
    }

    public void removeLike() {
        if (this.likes > 0) {
            this.likes--;
        }
    }


}
