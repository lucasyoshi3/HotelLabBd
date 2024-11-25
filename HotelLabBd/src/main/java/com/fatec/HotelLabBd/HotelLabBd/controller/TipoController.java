package com.fatec.HotelLabBd.HotelLabBd.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fatec.HotelLabBd.HotelLabBd.model.Tipo;
import com.fatec.HotelLabBd.HotelLabBd.repository.TipoRepository;

@Controller
public class TipoController {

	@Autowired
	TipoRepository tRep;
	
	@RequestMapping(name = "tipo", value = "/tipo", method = RequestMethod.GET)
	public ModelAndView tipoGet() {
		return new ModelAndView("tipo");
	}
	
	@RequestMapping(name = "tipo", value = "/tipo", method = RequestMethod.POST)
	public ModelAndView tipoPost(
			@RequestParam Map<String, String> param,
			ModelMap model){
		
		String saida = "";
		String erro = "";
		
		String id = param.get("id");
		String nome = param.get("nome");
		String preco = param.get("preco");
		
		String botao = param.get("botao");
		Tipo tipo = new Tipo();
		List<Tipo> tipos = new ArrayList<>();
		
		if(!botao.equals("listar")) {
			System.out.println(id);
			tipo.setId(Integer.parseInt(id));
		}
		
		if(botao.equals("inserir") || botao.equals("excluir")) {
			tipo.setId(Integer.parseInt(id));
			tipo.setNome(nome);
			tipo.setPreco(Double.parseDouble(preco.trim()));
		}
		
		
		try {
			if(botao.equals("inserir")) {
				tRep.save(tipo);
				saida = "Inserido com Sucesso!";
			}
			if(botao.equals("atualizar")) {
				tRep.save(tipo);
				saida = "Atualizado com Sucesso!";
			}
			if(botao.equals("excluir")) {
				tRep.delete(tipo);
				saida = "Deletado com Sucesso!";
			}
			if(botao.equals("listar")) {
				tRep.findAll();
			}
		} catch (Exception e) {
			// TODO: handle exception
			erro = e.getMessage();
		}finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("tipo", tipo);
			model.addAttribute("tipos", tipos);
		}
		
		return new ModelAndView("tipo");
	}
}
