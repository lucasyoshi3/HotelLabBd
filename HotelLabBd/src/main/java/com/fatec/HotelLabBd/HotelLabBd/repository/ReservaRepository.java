package com.fatec.HotelLabBd.HotelLabBd.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.fatec.HotelLabBd.HotelLabBd.model.Quarto;
import com.fatec.HotelLabBd.HotelLabBd.model.Reserva;

@Repository
public interface ReservaRepository extends JpaRepository<Reserva, Integer>{

	@Query(value = "SELECT * FROM f_quartosDisponiveis(:data, :qtdDias)", nativeQuery = true)
	public List<Quarto> verificarQuartosDisponiveis(@Param("data") LocalDate data, @Param("qtdDias")int qtdDias);
	
//	@Query("SELECT (t.preco * r.qtdDias) FROM Reserva r " +
//	           "JOIN Quarto q ON r.quarto.numero = q.numero " +
//	           "JOIN Tipo t ON q.tipo.id = t.id " +
//	           "WHERE r.id = :reservaId")
//	Double findValorCalculadoByReservaId(@Param("reservaId") Integer reservaId);
}

