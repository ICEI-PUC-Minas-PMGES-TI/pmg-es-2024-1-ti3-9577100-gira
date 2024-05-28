package com.app.pucTis.Entities;


import com.app.pucTis.Dtos.AdiministratorRecord;
import com.app.pucTis.Entities.Enuns.UserType;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "tb_administrator")
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of = "id")
public class Administrator {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String code;
    private String password;
    private UserType type;
    private Boolean validPass;
    @ManyToMany
    @JoinTable(name="administrator_liked_news",
            joinColumns = @JoinColumn(name = "administrator_id"),
            inverseJoinColumns = @JoinColumn(name = "news_id"))
    private List<News> likedNews = new ArrayList<>();


    public Administrator(AdiministratorRecord data){
        this.name = data.name();
        this.code = data.code();
        this.password = data.password();
        this.type = data.type();
        this.validPass = data.validPass();
        this.likedNews = data.likedNews() != null ? data.likedNews() : new ArrayList<>();    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public UserType getType() {
        return type;
    }

    public void setType(UserType type) {
        this.type = type;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setValidPass(Boolean validPass) {
        this.validPass = validPass;
    }

    public Boolean getValidPass() {
        return validPass;
    }

    public List<News> getLikedNews() {return likedNews;}

    public void setLikedNews(List<News> likedNews) {this.likedNews = likedNews;}
    public  void addLikeNews(News news){likedNews.add(news);}

    public void removeLikedNews(News news) {likedNews.remove(news);}

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
