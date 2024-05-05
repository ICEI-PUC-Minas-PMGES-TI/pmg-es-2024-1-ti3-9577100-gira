package com.app.pucTis.Repositories;

import com.app.pucTis.Entities.Event;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EventRepository  extends JpaRepository<Event, Long> {
}
