package com.app.pucTis.Services;

import com.app.pucTis.Dtos.ClassroomRecord;
import com.app.pucTis.Dtos.TeacherRecord;
import com.app.pucTis.Entities.Classroom;
import com.app.pucTis.Entities.Event;
import com.app.pucTis.Entities.Student;
import com.app.pucTis.Entities.Teacher;
import com.app.pucTis.Repositories.ClassroomRepository;
import com.app.pucTis.Repositories.EventRepository;
import com.app.pucTis.Repositories.StudentRepository;
import com.app.pucTis.Repositories.TeacherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class ClassroomService {
    @Autowired
    private ClassroomRepository classroomRepository;
    @Autowired
    private StudentRepository studentRepository;
    @Autowired
    private TeacherRepository teacherRepository;
    @Autowired
    private EventRepository eventRepository;

    public boolean createClassroom(ClassroomRecord classroomRecord) {
        try {
            Classroom classroom = new Classroom(classroomRecord);

            classroomRepository.save(classroom);

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean addStudentToClassroom(Long classroomId, Long studentId) {
        Classroom classroom = classroomRepository.findById(classroomId).orElse(null);
        Student student = studentRepository.findById(studentId).orElse(null);

        if (classroom != null && student != null) {
            if (student.getSchoolClass() == null || !student.getSchoolClass().equals(classroom)) {
                student.setSchoolClass(classroom);
                studentRepository.save(student);
                return true;
            }
        }
        return false;
    }

    public boolean createTeacher(TeacherRecord teacherRecord) {
        try {
            Teacher teacher = new Teacher(teacherRecord);
            teacherRepository.save(teacher);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Student> getClassroomStudents(Long classroomId) {
        Classroom classroom = classroomRepository.findById(classroomId).orElse(null);
        if (classroom != null) {
            return classroom.getStudents();
        } else {
            return null;
        }
    }

    public boolean addTeacherToClassroom(Long teacherId, Long classroomId) {
        Teacher teacher = teacherRepository.findById(teacherId).orElse(null);
        Classroom classroom = classroomRepository.findById(classroomId).orElse(null);

        if (teacher != null && classroom != null) {
            classroom.getTeachers().add(teacher);
            classroomRepository.save(classroom);
            return true;
        }
        return false;
    }

    public List<Classroom> getActiveClassrooms() {
        return classroomRepository.findByStatus(true);
    }

    public Optional<Classroom> getActiveClassroomById(Long id) {
        return classroomRepository.findByIdAndStatus(id, true);
    }

    public void activateClassroom(Long id) {
        Optional<Classroom> classroomOptional = classroomRepository.findById(id);
        classroomOptional.ifPresent(classroom -> {
            classroom.setStatus(true);
            classroomRepository.save(classroom);
        });
    }

    public void deactivateClassroom(Long id) {
        Optional<Classroom> classroomOptional = classroomRepository.findById(id);
        classroomOptional.ifPresent(classroom -> {
            classroom.setStatus(false);
            classroomRepository.save(classroom);
        });
    }

    public boolean updateClassroom(Long id, Classroom classroomRecord) {
        Optional<Classroom> optionalClassroom = classroomRepository.findById(id);
        if (optionalClassroom.isPresent()) {
            Classroom classroom = optionalClassroom.get();
            if (classroomRecord.getName() != null) {
                classroom.setName(classroomRecord.getName());
            }
            classroomRepository.save(classroom);
            return true;
        }
        return false;
    }

    public void addEventIdsToClassroom(Long classroomId, List<Long> eventIds) {
        Optional<Classroom> classroomOpt = classroomRepository.findById(classroomId);
        if (!classroomOpt.isPresent()) {
            throw new IllegalArgumentException("Classroom ID " + classroomId + " does not exist");
        }

        Classroom classroom = classroomOpt.get();
        for (Long eventId : eventIds) {
            Optional<Event> eventOpt = eventRepository.findById(eventId);
            if (!eventOpt.isPresent()) {
                throw new IllegalArgumentException("Event ID " + eventId + " does not exist");
            }

            Event event = eventOpt.get();
            if (!event.isStatus()) {
                throw new IllegalArgumentException("Event ID " + eventId + " is not active");
            }

            classroom.addEventId(eventId);
        }
        classroomRepository.save(classroom);
    }

    public void removeEventIdsFromClassroom(Long classroomId, List<Long> eventIds) {
        Optional<Classroom> classroomOpt = classroomRepository.findById(classroomId);
        if (!classroomOpt.isPresent()) {
            throw new IllegalArgumentException("Classroom ID " + classroomId + " does not exist");
        }

        Classroom classroom = classroomOpt.get();
        boolean allEventsExist = true;
        for (Long eventId : eventIds) {
            if (!eventRepository.existsById(eventId)) {
                allEventsExist = false;
                throw new IllegalArgumentException("Event ID " + eventId + " does not exist");
            }
        }

        if (allEventsExist) {
            classroom.getEventIds().removeAll(eventIds);
            classroomRepository.save(classroom);
        } else {
            throw new IllegalArgumentException("One or more event IDs do not exist");
        }
    }

    public List<Event> getEventsByClassroomId(Long classroomId) {
        Optional<Classroom> classroomOpt = classroomRepository.findById(classroomId);
        if (!classroomOpt.isPresent()) {
            throw new IllegalArgumentException("Classroom ID " + classroomId + " does not exist");
        }

        Classroom classroom = classroomOpt.get();
        List<Event> events = new ArrayList<>();
        for (Long eventId : classroom.getEventIds()) {
            Optional<Event> eventOpt = eventRepository.findById(eventId);
            eventOpt.ifPresent(events::add);
        }
        return events;
    }

}
