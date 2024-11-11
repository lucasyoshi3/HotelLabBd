package com.fatec.HotelLabBd.HotelLabBd.model;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "checkin")
@Data
public class Checkin {

    @Id
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "data_checkin", nullable = false)
    private LocalDate dataCheckin;

    @Column(name = "data_checkout", nullable = false)
    private LocalDate dataCheckout;

    @Column(name = "reservado", nullable = false)
    private boolean reservado;

    @ManyToOne
    @JoinColumn(name = "clientecpf", referencedColumnName = "cpf")
    private Cliente cliente;

    @ManyToOne
    @JoinColumn(name = "quartonumero", referencedColumnName = "numero")
    private Quarto quarto;
}
