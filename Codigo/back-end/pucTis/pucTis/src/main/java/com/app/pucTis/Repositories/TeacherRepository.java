package com.app.pucTis.Repositories;

import com.app.pucTis.Entities.News;
import com.app.pucTis.Entities.Teacher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface TeacherRepository extends JpaRepository<Teacher, Long> {
    Optional<Teacher> findByName(String name);

    Optional<Teacher> findByCode(String code);

    List<Teacher> findByStatusTrue();

    List<Teacher> findByStatus(boolean status);

    Optional<Teacher> findByIdAndStatus(Long id, boolean status);

    boolean existsByCode(String code);

    boolean existsByLikedNewsContainsAndId(News news, Long id);
}
