package com.app.pucTis.Controllers;

import com.app.pucTis.Dtos.NotificationRecord;
import com.app.pucTis.Entities.Notification;
import com.app.pucTis.Entities.Student;
import com.app.pucTis.Repositories.NotificationRepository;
import com.app.pucTis.Repositories.StudentRepository;
import com.app.pucTis.Services.NotificationService;
import jakarta.validation.Valid;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RestController
@CrossOrigin("*")
@RequestMapping("/notification")
public class NotificationController {
    @Autowired
    private StudentRepository studentRepository;
    @Autowired
    private NotificationService notificationService;

    @PostMapping("/send")
    public ResponseEntity<String> addNotification(@Valid @RequestBody NotificationRecord notificationRecord) {
        boolean status = notificationService.createNotification(notificationRecord);

        if(status){
            return ResponseEntity.status(HttpStatus.CREATED).body("Notification added successfully");
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error");
    }
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteNotification(@PathVariable Long id) {
        boolean deleted = notificationService.deleteNotificationById(id);

        if (deleted) {
            return ResponseEntity.status(HttpStatus.OK).body("Notification deleted successfully");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Notification not found");
        }
    }
    @GetMapping("/all")
    public ResponseEntity<List<Notification>> getAllNotification(){
        return ResponseEntity.ok(notificationService.findAllNotifications());
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

}
