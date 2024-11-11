package com.fatec.HotelLabBd.HotelLabBd.model;

import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "tipo")
@Data
public class Tipo {

	@Id
	@Column(name = "id", nullable = false)
	private int id;
	
	@Column(name = "nome", nullable = false)
	private String nome;
	
	@Column(nullable = false)
    private Double preco;
}
