package com.fatec.HotelLabBd.HotelLabBd.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fatec.HotelLabBd.HotelLabBd.model.Quarto;
import com.fatec.HotelLabBd.HotelLabBd.model.Tipo;
import com.fatec.HotelLabBd.HotelLabBd.repository.QuartoRepository;
import com.fatec.HotelLabBd.HotelLabBd.repository.TipoRepository;

@Controller
public class QuartoController {
	
	@Autowired
	QuartoRepository qRep;
	
	@Autowired
	TipoRepository tRep;
	
	@RequestMapping(name = "servico", value = "/quarto", method = RequestMethod.GET)
	public ModelAndView quartoGet() {
		return new ModelAndView("quarto");
	}
	
	@RequestMapping(name = "servico", value = "/quarto", method = RequestMethod.POST)
	public ModelAndView quartoPost(
			@RequestParam Map<String, String> param,
			ModelMap model) {
		
		String saida = "";
		String erro = "";
		List<Quarto> quartos = new ArrayList<>();
		
		String numero = param.get("numero");
		String andar = param.get("andar");
		String descricao = param.get("descricao");
		String tipoid = param.get("tipoid");
		
		String botao = param.get("botao");
		
		Quarto quarto = new Quarto();
		Tipo tipo = new Tipo();
		
		if(!botao.equals("listar")) {
			quarto.setNumero(Integer.parseInt(numero));
		}
		
		if(botao.equals("inserir") || botao.equals("atualizar")) {
			quarto.setNumero(Integer.parseInt(numero));
			quarto.setAndar(Integer.parseInt(andar));
			quarto.setDescricao(descricao);
			Optional<Tipo> tipoOptional = tRep.findById(Integer.parseInt(tipoid));
			tipo = tipoOptional.get();
			quarto.setTipo(tipo);
//			quarto.setTipo(tRep.findById(tipo.getId()).get());
		}
		
		
		try {
			if(botao.equals("inserir")) {
				qRep.save(quarto);
				saida = "Inserido com Sucesso!";
			}
			if(botao.equals("atualizar")) {
				qRep.save(quarto);
				saida = "Atualizado com Sucesso!";
			}
			if(botao.equals("excluir")) {
				qRep.delete(quarto);
				saida = "Deletado com Sucesso!";
			}
			if(botao.equals("buscar")) {
				quarto = qRep.findById(quarto.getNumero()).get();
			}
			if(botao.equals("listar")) {
				quartos = qRep.findAll();
			}
		} catch (Exception e) {
			// TODO: handle exception
			erro = e.getMessage();
		}finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("quarto", quarto);
			model.addAttribute("quartos", quartos);
		}
		
		return new ModelAndView("quarto");
	}
}
