package com.fatec.HotelLabBd.HotelLabBd.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.fatec.HotelLabBd.HotelLabBd.model.Tipo;

@Repository
public interface TipoRepository extends JpaRepository<Tipo, Integer>{

}
