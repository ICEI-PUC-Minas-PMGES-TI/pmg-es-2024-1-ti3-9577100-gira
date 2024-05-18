package com.app.pucTis.Repositories;

import com.app.pucTis.Entities.Classroom;
import com.app.pucTis.Entities.Parents;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface SchoolClassRepository extends JpaRepository<Classroom, Long> {
}
