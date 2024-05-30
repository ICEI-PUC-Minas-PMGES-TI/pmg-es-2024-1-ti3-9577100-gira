package com.app.pucTis.Repositories;

import com.app.pucTis.Entities.Classroom;
import com.app.pucTis.Entities.Event;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface EventRepository  extends JpaRepository<Event, Long> {
    List<Event> findByClassroomId(Long classroomId);
    
    Event findByIdAndStatusIsTrue(Long id);

    @Query("SELECT e FROM Event e WHERE e.status = true")
    List<Event> findAllActiveEvents();
}
