package com.fatec.HotelLabBd.HotelLabBd.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "quarto")
@Data
public class Quarto {

	@Id
	@Column(name = "numero", nullable = false)
	private int numero;
	
	@Column(name = "andar", nullable = false)
	private int andar;
	
	@Column(name = "descricao", length = 200, nullable = false)
	private String descricao;
	
	@ManyToOne	
	@JoinColumn(name = "tipoid", nullable = false)
	private Tipo tipo;
}
