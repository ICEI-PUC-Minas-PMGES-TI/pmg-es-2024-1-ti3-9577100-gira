package com.app.pucTis.Repositories;

import com.app.pucTis.Entities.Notification;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface NotificationRepository extends JpaRepository<Notification, Long> {
    List<Notification> findByClassroomId(Long classroomId);

    List<Notification> findByStatusTrue();

    Optional<Notification> findByIdAndStatusTrue(Long id);

    List<Notification> findByClassroomIdAndStatusTrue(Long classroomId);

    List<Notification> findByClassroomIdAndStatus(Long classroomId, boolean status);
}
