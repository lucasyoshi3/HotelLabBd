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

import com.fatec.HotelLabBd.HotelLabBd.model.Servico;
import com.fatec.HotelLabBd.HotelLabBd.repository.ServicoRepository;

@Controller
public class ServicoController {

	@Autowired
	ServicoRepository sRep;
	
	@RequestMapping(name = "servico", value="/servico", method=RequestMethod.GET)
	public ModelAndView servicoGet() {
		return new ModelAndView("servico");
	}
	
	@RequestMapping(name = "servico", value = "/servico", method = RequestMethod.POST)
	public ModelAndView servicoPost(
			@RequestParam Map<String, String> param,
			ModelMap model) {
		
		String saida = "";
		String erro = "";
		
		String id = param.get("id");
		String nome = param.get("nome");
		String descricao = param.get("descricao");
		
		String botao = param.get("botao");
		
		String valorStr = param.get("valor");
		Double valor = null;

		if (valorStr != null && !valorStr.trim().isEmpty()) {
		    try {
		        valor = Double.valueOf(valorStr);
		    } catch (NumberFormatException e) {
		        erro = "O campo 'valor' deve ser um número válido.";
		        model.addAttribute("erro", erro);
		        return new ModelAndView("servico");
		    }
		}
		
		
		Servico servico = new Servico();
		
		if(!botao.equals("listar")) {
			servico.setId(Integer.parseInt(id));
		}
		
		if(botao.equals("inserir") || botao.equals("atualizar")) {
			servico.setId(Integer.parseInt(id));
			servico.setNome(nome);
			servico.setDescricao(descricao);
			servico.setValor(valor);
			
		}
		
		List<Servico> servicos = new ArrayList<>(); 
		
		try {
			if(botao.equals("inserir")) {
				sRep.save(servico);
				saida = "Inserido com Sucesso!";
			}
			if(botao.equals("atualizar")) {
				sRep.save(servico);
				saida = "Atualizado com Sucesso";
			}
			if(botao.equals("excluir")) {
				sRep.delete(servico);
				saida = "Exluido com Sucesso!";
			}
			if(botao.equals("buscar")) {
				servico = sRep.findById(servico.getId()).get();
			}
			if(botao.equals("listar")) {
				servicos = sRep.findAll();
			}
		} catch (Exception e) {
			// TODO: handle exception
			erro = e.getMessage();
		}finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("servico", servico);
			model.addAttribute("servicos", servicos);
		}
		
		return new ModelAndView("servico");
	}
}
