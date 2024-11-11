package com.fatec.HotelLabBd.HotelLabBd.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "cliente")
@Data
public class Cliente {

	@Id
	@Column(name = "cpf", length = 11, nullable = false)
	private String cpf;
	
	@Column(name = "nome", length = 100, nullable = false)
	private String nome;
	
	@Column(name = "telefone", length = 11, nullable = false)
	private String telefone;
	
	@Column(name = "cidade", length = 100, nullable = false)
	private String cidade;
}
