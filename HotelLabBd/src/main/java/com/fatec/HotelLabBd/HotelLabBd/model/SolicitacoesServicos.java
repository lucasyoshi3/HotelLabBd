package com.fatec.HotelLabBd.HotelLabBd.model;

import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "solicitacoesServicos")
@Data
public class SolicitacoesServicos {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "quantidade", nullable = false)
    private int quantidade;

    @Column(name = "valorTotal", nullable = false)
    private Double valorTotal;

    @ManyToOne
    @JoinColumn(name = "servicoid", referencedColumnName = "id")
    private Servico servico;

    @ManyToOne
    @JoinColumn(name = "checkinid", referencedColumnName = "id")
    private Checkin checkin;
}
