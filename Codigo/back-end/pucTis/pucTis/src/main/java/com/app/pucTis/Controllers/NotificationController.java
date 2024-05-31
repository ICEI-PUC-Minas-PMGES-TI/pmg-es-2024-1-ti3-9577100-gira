package com.app.pucTis.Controllers;

import com.app.pucTis.Dtos.NotificationRecord;
import com.app.pucTis.Entities.Notification;
import com.app.pucTis.Repositories.StudentRepository;
import com.app.pucTis.Services.NotificationService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.ResponseEntity.BodyBuilder;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Optional;

@RestController
@CrossOrigin("*")
@RequestMapping("/notification")
public class NotificationController {

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private StudentRepository studentRepository;

    @PostMapping("/send")
    public ResponseEntity<String> addNotification(@Valid @RequestBody NotificationRecord notificationRecord) {
        boolean status = notificationService.createNotification(notificationRecord);

        if (status) {
            return ResponseEntity.status(HttpStatus.CREATED).body("Notification added successfully");
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error");
    }

    @GetMapping
    public ResponseEntity<List<Notification>> getAllNotifications() {
        List<Notification> notifications = notificationService.findAllNotifications();
        return ResponseEntity.ok(notifications);
    }

    @PutMapping("/activate/{id}")
    public ResponseEntity<String> activateNotification(@PathVariable Long id) {
        boolean updated = notificationService.activateNotificationById(id);

        if (updated) {
            return ResponseEntity.status(HttpStatus.OK).body("Notification activated successfully");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Notification not found");
        }
    }

    @GetMapping("/id/{id}")
    public ResponseEntity<Notification> getActiveNotificationById(@PathVariable Long id) {
        Optional<Notification> notification = notificationService.findActiveNotificationById(id);

        return notification.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).body(null));
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteNotification(@PathVariable Long id) {
        boolean updated = notificationService.deleteNotificationById(id);

        if (updated) {
            return ResponseEntity.status(HttpStatus.OK).body("Notification status updated to false successfully");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Notification not found");
        }
    }

    @GetMapping("/classNotificationId/{classroomId}")
    public ResponseEntity<List<Notification>> getClassroomNotifications(@PathVariable Long classroomId) {
        List<Notification> notifications = notificationService.getNotificationsByClassroomId(classroomId);

        if (!notifications.isEmpty()) {
            return ResponseEntity.status(HttpStatus.OK).body(notifications);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    @PutMapping("/edit/{id}")
    public ResponseEntity<String> editNotification(@PathVariable Long id, @RequestBody NotificationRecord editRequest) {
        boolean edited = notificationService.editNotification(id, editRequest.getMessage());

        if (edited) {
            return ResponseEntity.status(HttpStatus.OK).body("Notification edited successfully");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Notification not found");
        }
    }

    @GetMapping("/class/{classroomId}")
    public ResponseEntity<?> getNotificationsByClassroomId(@PathVariable Long classroomId) {
        List<Notification> notifications = notificationService.getNotificationsByClassroomId(classroomId);

        if (!notifications.isEmpty()) {
            return ResponseEntity.ok(notifications);
        } else {
            return ((BodyBuilder) ResponseEntity.notFound())
                    .body("Nenhuma notificação encontrada para o id da sala fornecido.");
        }
    }

    @GetMapping("/student/{studentId}")
    public ResponseEntity<?> getNotificationsByStudentId(@PathVariable Long studentId) {
        List<Notification> notifications = notificationService.getNotificationsByStudentId(studentId);

        if (notifications != null && !notifications.isEmpty()) {
            return ResponseEntity.ok(notifications);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body("No active notifications found for the student's classroom");
        }
    }

}
