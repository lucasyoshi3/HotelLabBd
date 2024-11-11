package com.fatec.HotelLabBd.HotelLabBd.repository;

import org.hibernate.annotations.Check;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.fatec.HotelLabBd.HotelLabBd.model.Checkin;

@Repository
public interface CheckinRepository extends JpaRepository<Checkin, Integer>{

}
