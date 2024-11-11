package com.fatec.HotelLabBd.HotelLabBd.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.fatec.HotelLabBd.HotelLabBd.model.Servico;

@Repository
public interface ServicoRepository extends JpaRepository<Servico, Integer>{

}
