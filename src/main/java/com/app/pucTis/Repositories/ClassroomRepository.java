package com.app.pucTis.Repositories;

import com.app.pucTis.Entities.Classroom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface ClassroomRepository extends JpaRepository<Classroom, Long> {

    Optional<Classroom> findByIdAndStatus(Long id, boolean b);

    List<Classroom> findByStatus(boolean b);

    Optional<Classroom> findByIdAndStatusIsTrue(Long classroomId);

    List<Classroom> findByTeachers_Id(Long teacherId);
}
