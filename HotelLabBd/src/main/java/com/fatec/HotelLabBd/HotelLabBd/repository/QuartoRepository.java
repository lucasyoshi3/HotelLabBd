package com.fatec.HotelLabBd.HotelLabBd.repository;

import java.time.LocalDate;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.fatec.HotelLabBd.HotelLabBd.model.Quarto;

@Repository
public interface QuartoRepository extends JpaRepository<Quarto, Integer>{


}
