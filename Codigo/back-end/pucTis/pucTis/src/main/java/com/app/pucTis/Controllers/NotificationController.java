package com.app.pucTis.Controllers;

import com.app.pucTis.Dtos.NotificationRecord;
import com.app.pucTis.Entities.Notification;
import com.app.pucTis.Entities.Student;
import com.app.pucTis.Repositories.NotificationRepository;
import com.app.pucTis.Repositories.StudentRepository;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RestController
@CrossOrigin("*")
@RequestMapping("/notifications")
public class NotificationController {

    @Autowired
    private StudentRepository studentRepository;
    @Autowired
    private NotificationRepository notificationRepository;

    @PostMapping("/{studentId}")
    public ResponseEntity<String> addNotificationToStudent(@PathVariable Long studentId, @Valid @RequestBody NotificationRecord notificationRecord) {
        Student student = studentRepository.findById(studentId).orElse(null);
        if (student == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Student not found");
        }

        Notification notification = new Notification(notificationRecord);
        notification.setRecipient(student);
        notification.setDate(LocalDate.now());

        notificationRepository.save(notification);

        return ResponseEntity.status(HttpStatus.CREATED).body("Notification added successfully");
    }

    @PutMapping("/{notificationId}")
    public ResponseEntity<String> editNotification(@PathVariable Long notificationId, @Valid @RequestBody String newMessage, @RequestBody NotificationRecord notificationRecord) {
        Optional<Notification> optionalNotification = notificationRepository.findById(notificationId);
        if (!optionalNotification.isPresent()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Notification not found");
        }

        Notification notification = optionalNotification.get();
        notification.setMessage(newMessage);
        notificationRepository.save(notification);

        return ResponseEntity.status(HttpStatus.OK).body("Notification edited successfully");
    }

    @GetMapping
    public ResponseEntity<List<Notification>> getAllNotifications() {
        List<Notification> notifications = notificationRepository.findAll();
        return ResponseEntity.ok(notifications);
    }

    @GetMapping("/id/{studentId}")
    public ResponseEntity<List<Notification>> getNotificationsByStudentId(@PathVariable Long studentId) {
        Student student = studentRepository.findById(studentId).orElse(null);
        if (student == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        List<Notification> notifications = notificationRepository.findByRecipient(student);
        return ResponseEntity.ok(notifications);
    }

    @DeleteMapping("/delete/{notificationId}")
    public ResponseEntity<String> deleteNotification(@PathVariable Long notificationId) {
        Optional<Notification> optionalNotification = notificationRepository.findById(notificationId);
        if (!optionalNotification.isPresent()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Notification not found");
        }

        Notification notification = optionalNotification.get();
        notificationRepository.delete(notification);

        return ResponseEntity.status(HttpStatus.OK).body("Notification deleted successfully");
    }
}