package com.app.pucTis.Repositories;

import com.app.pucTis.Entities.Administrator;
import com.app.pucTis.Entities.News;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface AdministratorRepository extends JpaRepository<Administrator, Long> {
    Optional<Administrator> findAdministratorById(Long id);

    Optional<Administrator> findByName(String name);

    Optional<Administrator> findByCode(String code);

    boolean existsByCode(String code);

    List<Administrator> findByStatus(boolean b);

    Optional<Administrator> findByIdAndStatus(Long id, boolean b);

    boolean existsByLikedNewsContainsAndId(News news, Long id);

}
