package com.fatec.HotelLabBd.HotelLabBd.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.AutoConfigurationPackage;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fatec.HotelLabBd.HotelLabBd.model.Cliente;
import com.fatec.HotelLabBd.HotelLabBd.model.Quarto;
import com.fatec.HotelLabBd.HotelLabBd.model.Reserva;
import com.fatec.HotelLabBd.HotelLabBd.repository.ClienteRepository;
import com.fatec.HotelLabBd.HotelLabBd.repository.QuartoRepository;
import com.fatec.HotelLabBd.HotelLabBd.repository.ReservaRepository;

@Controller
public class ReservaController {

	@Autowired
	ReservaRepository rRep;
	
	@Autowired
	QuartoRepository qRep;
	
	@Autowired
	ClienteRepository cRep;
	
	@RequestMapping(name = "reserva", value = "/reserva", method = RequestMethod.GET)
	public ModelAndView reservaGet() {
		return new ModelAndView("reserva");
	}
	
	@RequestMapping(name = "reserva", value = "/reserva", method = RequestMethod.POST)
	public ModelAndView reservaPost(
			@RequestParam Map<String, String>param,
			ModelMap model) {
		
		String saida = "";
		String erro = "";
		List<Reserva> reservas = new ArrayList<>();
		Quarto quarto = new Quarto();
		Cliente cliente = new Cliente();
		Reserva reserva = new Reserva();
		
		int id;
		LocalDate inicio;
		int quantidadeDeDias;
//		Double valor = rRep.findValorCalculadoByReservaId()
		
//		Optional<Cliente> clienteOptional = cRep.findById(param.get("clientecpf"));
		
//		Optional<Quarto> quartoOptional = qRep.findById(Integer.parseInt(param.get("quartonumero")));
		
		String botao = param.get("botao");
		
		if(!botao.equals("listar")) {
			id = Integer.parseInt(param.get("id"));
			reserva.setId(id);
		}
		
		if(botao.equals("inserir") || botao.equals("atualizar")) {
			id = Integer.parseInt(param.get("id"));
			reserva.setId(id);
			inicio = LocalDate.parse(param.get("inicio"));
			reserva.setInicio(inicio);
			reserva.setValor(0.0);
			quantidadeDeDias = Integer.parseInt(param.get("qtd_dias"));
			reserva.setQuantidadeDias(quantidadeDeDias);
			
			Optional<Cliente> clienteOptional = cRep.findById(param.get("clientecpf"));
			cliente = clienteOptional.get();
			reserva.setCliente(cliente);
			
			Optional<Quarto> quartoOptional = qRep.findById(Integer.parseInt(param.get("quartonumero")));
			quarto = quartoOptional.get();
			reserva.setQuarto(quarto);
		}
		
		try {
			if(botao.equals("inserir")) {
				rRep.save(reserva);
				saida = "Inserido com Sucesso!";
			}
			if(botao.equals("atualizar")) {
				rRep.save(reserva);
				saida = "Atualizado com Sucesso!";
			}
			if(botao.equals("excluir")) {
				rRep.delete(reserva);
				saida = "Excluido com Sucesso!";
			}
			if(botao.equals("buscar")) {
				reserva = rRep.findById(reserva.getId()).get();
			}
			if(botao.equals("listar")) {
				reservas = rRep.findAll();
			}
		}catch (Exception e) {
			// TODO: handle exception
			erro = e.getMessage();
		}finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("reserva", reserva);
			model.addAttribute("reservas", reservas);
		}
		
		return new ModelAndView("reserva");
	}
}
