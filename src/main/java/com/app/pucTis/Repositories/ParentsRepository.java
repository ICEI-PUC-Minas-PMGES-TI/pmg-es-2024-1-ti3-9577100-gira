package com.app.pucTis.Repositories;

import com.app.pucTis.Entities.Parents;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface ParentsRepository extends JpaRepository<Parents, Long> {
    Optional<Parents> findByName(String name);

    Optional<Parents> findByCode(String code);

    boolean existsByCode(String code);

    Optional<Parents> findByIdAndStatus(Long id, boolean b);

    List<Parents> findByStatus(boolean b);
}
