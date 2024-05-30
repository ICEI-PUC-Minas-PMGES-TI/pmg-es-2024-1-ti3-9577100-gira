package com.app.pucTis.Repositories;

import com.app.pucTis.Entities.Classroom;
import com.app.pucTis.Entities.Parents;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ClassroomRepository extends JpaRepository<Classroom, Long> {

    Optional<Classroom> findByIdAndStatus(Long id, boolean b);

    List<Classroom> findByStatus(boolean b);
}
