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

import com.fatec.HotelLabBd.HotelLabBd.model.Cliente;
import com.fatec.HotelLabBd.HotelLabBd.repository.ClienteRepository;

@Controller
public class ClienteController {

	@Autowired
	private ClienteRepository cRep;
	
	@RequestMapping(name = "cliente", value = "/cliente", method = RequestMethod.GET)
	public ModelAndView clienteGet(ModelMap model) {
		return new ModelAndView("cliente");
	}
	
	@RequestMapping(name = "cliente", value = "/cliente", method = RequestMethod.POST)
	public ModelAndView clientePost(
			@RequestParam Map<String,String> params,
			ModelMap model) {
		
		String cpf = params.get("cpf");
		String nome = params.get("nome");
		String telefone = params.get("telefone");
		String cidade = params.get("cidade");
		String botao = params.get("botao");
		
		Cliente cliente = new Cliente();
		
		if(!botao.equals("Listar")) {
			cliente.setCpf(cpf);
			
		}
		
		if(botao.equals("inserir") || botao.equals("atualizar")) {
			cliente.setCpf(cpf);
			cliente.setNome(nome);
			cliente.setTelefone(telefone);
			cliente.setCidade(cidade);
			
		}
		
		String saida = "";
		String erro = "";
		List<Cliente> clientes = new ArrayList<>();
		
		try {
			if(botao.equals("inserir")) {
				cRep.save(cliente);
				saida = "Inserido com sucesso!";
			}
			if(botao.equals("atualizar")) {
				cRep.save(cliente);
				saida = "Atualizado com sucesso!";
			}
			if(botao.equals("excluir")) {
				cRep.delete(cliente);
				saida = "Excluido com secesso!";
			}
			if(botao.equals("Buscar")) {
				cliente = cRep.findById(cliente.getCpf()).get();
			}
			if(botao.equals("listar")) {
				clientes = cRep.findAll();
			}
		} catch (Exception e) {
			// TODO: handle exception
			erro = e.getMessage();
		}finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("cliente", cliente);
			model.addAttribute("clientes", clientes);
		}
		
		return new ModelAndView("cliente");
	}
}
