package com.app.pucTis.Repositories;

import com.app.pucTis.Entities.Administrator;
import com.app.pucTis.Entities.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface StudentRepository extends JpaRepository<Student, Long> {
    Optional<Student> findByName(String name);
}
