package com.app.pucTis.Repositories;

import com.app.pucTis.Entities.Notification;
import com.app.pucTis.Entities.Student;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface NotificationRepository extends JpaRepository<Notification, Long> {
    List<Notification> findByClassroomId(Long classroomId);
}
