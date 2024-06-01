package com.app.pucTis.Services;

import com.app.pucTis.Dtos.NotificationRecord;
import com.app.pucTis.Entities.Administrator;
import com.app.pucTis.Entities.Notification;
import com.app.pucTis.Entities.Student;
import com.app.pucTis.Entities.Teacher;
import com.app.pucTis.Repositories.NotificationRepository;
import com.app.pucTis.Repositories.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class NotificationService {

    @Autowired
    private NotificationRepository notificationRepository;

    @Autowired
    private StudentRepository studentRepository;

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
        return notificationRepository.findByClassroomIdAndStatus(classroomId, true);
    }

    public boolean createNotification(NotificationRecord data) {

        Notification notification = new Notification();
        Teacher teacher = SeesionManager.getAuthenticatedTeacher();

        Administrator administrator = SeesionManager.getAuthenticatedAdministrator();

        if (administrator != null || teacher != null) {
            notification.setClassroomId(data.classroomId());
            notification.setSenderName(administrator != null ? administrator.getName() : teacher.getName());
            notification.setDate(LocalDate.now());
            notification.setMessage(data.message());
            notification.setStatus(true);
            notificationRepository.save(notification);
            return true;
        }
        return false;
    }

    public boolean deleteNotificationById(Long id) {
        Optional<Notification> notificationOptional = notificationRepository.findById(id);
        if (notificationOptional.isPresent()) {
            Notification notification = notificationOptional.get();
            notification.setStatus(false);
            notificationRepository.save(notification);
            return true;
        } else {
            return false;
        }
    }

    public List<Notification> findAllNotifications() {
        return notificationRepository.findByStatusTrue();
    }

    public boolean updateNotificationStatusById(Long id, boolean status) {
        Optional<Notification> notificationOptional = notificationRepository.findById(id);
        if (notificationOptional.isPresent()) {
            Notification notification = notificationOptional.get();
            notification.setStatus(status);
            notificationRepository.save(notification);
            return true;
        } else {
            return false;
        }
    }

    public boolean activateNotificationById(Long id) {
        return updateNotificationStatusById(id, true);
    }

    public Optional<Notification> findActiveNotificationById(Long id) {
        return notificationRepository.findByIdAndStatusTrue(id);
    }

    public List<Notification> getNotificationsByStudentId(Long studentId) {
        Student student = studentRepository.findById(studentId).orElse(null);

        if (student != null && student.getSchoolClass() != null) {
            Long classroomId = student.getSchoolClass().getId();
            return notificationRepository.findByClassroomIdAndStatus(classroomId, true);
        }

        return null;
    }

}
