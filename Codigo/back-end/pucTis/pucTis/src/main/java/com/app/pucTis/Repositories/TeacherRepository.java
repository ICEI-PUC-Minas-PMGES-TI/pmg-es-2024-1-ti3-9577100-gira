package com.app.pucTis.Repositories;

import com.app.pucTis.Entities.Administrator;
import com.app.pucTis.Entities.Parents;
import com.app.pucTis.Entities.Teacher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TeacherRepository extends JpaRepository<Teacher, Long> {
    Optional<Teacher> findByName(String name);
    Optional<Teacher> findByCode(String code);

    boolean existsByCode(String code);
}
