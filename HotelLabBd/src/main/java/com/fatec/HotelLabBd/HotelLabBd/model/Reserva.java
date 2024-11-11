package com.fatec.HotelLabBd.HotelLabBd.model;

import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "reserva")
@Data
public class Reserva {

	@Id
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "inicio",nullable = false)
    private LocalDate inicio;

    @Column(name = "qtd_dias", nullable = false)
    private int quantidadeDias;

    @Column(name = "valor", nullable = false)
    private Double valor;

    @ManyToOne
    @JoinColumn(name = "clientecpf", referencedColumnName = "cpf")
    private Cliente cliente;

    @ManyToOne
    @JoinColumn(name = "quartonumero", referencedColumnName = "numero")
    private Quarto quarto;
	
}
