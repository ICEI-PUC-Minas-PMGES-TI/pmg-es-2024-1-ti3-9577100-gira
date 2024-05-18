package com.app.pucTis.Services;

import com.app.pucTis.Dtos.NotificationRecord;
import com.app.pucTis.Entities.Administrator;
import com.app.pucTis.Entities.Notification;
import com.app.pucTis.Entities.Teacher;
import com.app.pucTis.Repositories.NotificationRepository;
import org.aspectj.weaver.ast.Not;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class NotificationService {

    @Autowired
    private NotificationRepository notificationRepository;

    public boolean editNotification(Long id, String newMessage) {
        Optional<Notification> optionalNotification = notificationRepository.findById(id);

        if (optionalNotification.isPresent()) {
            Notification notification = optionalNotification.get();
            notification.setMessage(newMessage);
            notificationRepository.save(notification);
            return true;
        } else {
            return false;
        }
    }

    public List<Notification> getNotificationsByClassroomId(Long classroomId) {
        return notificationRepository.findByClassroomId(classroomId);
    }

    public boolean createNotification(NotificationRecord data) {

        Administrator administrator = SeesionManager.getAuthenticatedAdministrator();
        Teacher teacher = SeesionManager.getAuthenticatedTeacher();
        Notification notification = new Notification();
        if (administrator != null || teacher != null) {
            // notification.setSenderId(administrator != null ? administrator.getId() :
            // teacher.getId());
            notification.setClassroomId(data.classroomId());
            notification.setSenderName(administrator != null ? administrator.getName() : teacher.getName());
            notification.setDate(LocalDate.now());
            notification.setMessage(data.message());
            Notification not = notificationRepository.save(notification);
            return true;
        }
        return false;
    }

    public boolean deleteNotificationById(Long id) {
        if (notificationRepository.existsById(id)) {
            notificationRepository.deleteById(id);
            return true;
        } else {
            return false;
        }
    }

    public List<Notification> findAllNotifications() {
        return notificationRepository.findAll();
    }

}
