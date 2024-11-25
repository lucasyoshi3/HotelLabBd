package com.fatec.HotelLabBd.HotelLabBd.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fatec.HotelLabBd.HotelLabBd.model.Checkin;
import com.fatec.HotelLabBd.HotelLabBd.model.Cliente;
import com.fatec.HotelLabBd.HotelLabBd.model.Quarto;
import com.fatec.HotelLabBd.HotelLabBd.repository.CheckinRepository;
import com.fatec.HotelLabBd.HotelLabBd.repository.ClienteRepository;
import com.fatec.HotelLabBd.HotelLabBd.repository.QuartoRepository;

@Controller
public class CheckinController {

	@Autowired
	CheckinRepository cRep;
	
	@Autowired
	ClienteRepository clienteRep;
	
	@Autowired
	QuartoRepository quartoRep;
	
	@RequestMapping(name = "checkin", value = "/checkin", method = RequestMethod.GET)
	public ModelAndView checkinGet() {
		return new ModelAndView("checkin");
	}
	
	@RequestMapping(name = "checkin", value = "/checkin", method = RequestMethod.POST)
	public ModelAndView checkinPost(
			@RequestParam Map<String, String> param,
			ModelMap model) {
		
		Checkin checkin = new Checkin();
		String saida = "";
		String erro = "";
		String botao = param.get("botao");
		
		int id;
		LocalDate dataCheckin;
		LocalDate dataCheckout;
		boolean reservado;
		
		Optional<Cliente> clienteOptional = clienteRep.findById(param.get("cpf"));
		Cliente cliente;
		
		Optional<Quarto> quartoOptional;
		Quarto quarto;
		
		if(!botao.equals("listar")) {
			id = Integer.parseInt(param.get("id"));
			checkin.setId(id);
		}
		
		if(botao.equals("inserir") || botao.equals("excluir")) {
			id = Integer.parseInt(param.get("id"));
			checkin.setId(id);
			
			dataCheckin = LocalDate.parse(param.get("data_checkin"));
			checkin.setDataCheckin(dataCheckin);
			
			dataCheckout = LocalDate.parse(param.get("data_checkout"));
			checkin.setDataCheckout(dataCheckout);
			
			reservado = Boolean.parseBoolean(param.get("reservado"));
			checkin.setReservado(reservado);
			
			cliente = clienteOptional.get();
			checkin.setCliente(cliente);
			
			quartoOptional = quartoRep.findById(Integer.parseInt(param.get("numero")));
			quarto = quartoOptional.get();
			checkin.setQuarto(quarto);
		}
		
		List<Checkin> checkins = new ArrayList<>();
		
		try {
			if(botao.equals("inserir")) {
				cRep.save(checkin);
				saida = "Inserido com Sucesso!";
			}
			if(botao.equals("excluir")) {
				cRep.delete(checkin);
				saida = "Excluido com Sucesso!";
			}
			if(botao.equals("atualizar")) {
				cRep.save(checkin);
				saida = "Atualizado com Sucesso!";
			}
			if(botao.equals("listar")) {
				checkins = cRep.findAll();
			}
			if(botao.equals("buscar")) {
				checkin = (cRep.findById(checkin.getId()).get());
			}
		}catch (Exception e) {
			// TODO: handle exception
			erro = e.getMessage();
		}finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("checkin", checkin);
			model.addAttribute("checkins", checkins);
		}
		
		return new ModelAndView("checkin");
	}
}
