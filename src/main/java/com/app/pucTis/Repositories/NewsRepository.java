package com.app.pucTis.Repositories;

import com.app.pucTis.Entities.News;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NewsRepository extends JpaRepository<News, Long> {

}
