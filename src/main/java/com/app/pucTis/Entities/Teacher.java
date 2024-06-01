package com.app.pucTis.Entities;

import com.app.pucTis.Dtos.TeacherRecord;
import com.app.pucTis.Entities.Enuns.UserType;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import java.util.List;

@Entity
@Table(name = "tb_teacher")
public class Teacher {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotBlank
    @Column(nullable = false)
    private String name;
    private String code;
    @NotBlank
    @Column(nullable = false)
    @JsonIgnore
    private String password;
    @JsonIgnore
    private UserType type;
    @JsonIgnore
    private boolean status;
    @ManyToMany
    private List<Classroom> schoolClasses;
    private Boolean validPass;

    @ManyToMany
    @JoinTable(name = "teacher_liked_news", joinColumns = @JoinColumn(name = "teacher_id"), inverseJoinColumns = @JoinColumn(name = "news_id"))
    private List<News> likedNews;

    public Teacher(TeacherRecord data) {
        this.name = data.name();
        this.code = data.code();
        this.password = data.password();
        this.type = data.type();
        this.schoolClasses = data.schoolClasses();
        this.validPass = data.validPass();
        this.likedNews = data.likedNews();
        this.status = true;
    }

    public Teacher() {

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
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

    public List<Classroom> getSchoolClasses() {
        return schoolClasses;
    }

    public void setSchoolClasses(List<Classroom> schoolClasses) {
        this.schoolClasses = schoolClasses;
    }

    public String getName() {
        return name;
    }

    public String getPassword() {
        return password;
    }

    public void setValidPass(Boolean validPass) {
        this.validPass = validPass;
    }

    public Boolean getValidPass() {
        return validPass;
    }

    public List<News> getLikedNews() {
        return likedNews;
    }

    public void setLikedNews(List<News> likedNews) {
        this.likedNews = likedNews;
    }

    public void addLikeNews(News news) {
        likedNews.add(news);
    }

    public void removeLikedNews(News news) {
        likedNews.remove(news);
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
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

    public Boolean isValidPass() {
        return this.validPass;
    }

}
