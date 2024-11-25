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

import com.fatec.HotelLabBd.HotelLabBd.model.Checkin;
import com.fatec.HotelLabBd.HotelLabBd.model.Servico;
import com.fatec.HotelLabBd.HotelLabBd.model.SolicitacoesServicos;
import com.fatec.HotelLabBd.HotelLabBd.repository.CheckinRepository;
import com.fatec.HotelLabBd.HotelLabBd.repository.ServicoRepository;
import com.fatec.HotelLabBd.HotelLabBd.repository.SolicitacaoServicoRepository;

@Controller
public class SolicitacoesServicosController {

	@Autowired
	SolicitacaoServicoRepository sRep;
	
	@Autowired
	CheckinRepository cRep;
	
	@Autowired
	ServicoRepository servicoRep;
	
	@RequestMapping(name = "solicitacoes", value = "/solicitacoes", method = RequestMethod.GET)
	public ModelAndView solicitacoesGet() {
		return new ModelAndView("solicitacoes");
	}
	
	@RequestMapping(name = "solicitacoes", value = "/solicitacoes", method = RequestMethod.POST)
	public ModelAndView solicitacoesPost(
			@RequestParam Map<String, String> param,
			ModelMap model) {
		
		String id = param.get("id");
		String quantidade = param.get("quantidade");
		String valorTotal = param.get("valorTotal");
		Checkin checkin;
		Servico servico;
		String botao = param.get("botao");
		
		SolicitacoesServicos solicitacoes = new SolicitacoesServicos();
		if(!botao.equals("listar")) {
			solicitacoes.setId(Integer.parseInt(id));
		}
		
		if(botao.equals("inserir") || botao.equals("excluir")) {
			solicitacoes.setId(Integer.parseInt(id));
			solicitacoes.setQuantidade(Integer.parseInt(quantidade));
			solicitacoes.setValorTotal(Double.parseDouble(valorTotal));
			
			checkin = cRep.findById(Integer.parseInt(param.get("checkinId"))).get();
			solicitacoes.setCheckin(checkin);
			
			servico = servicoRep.findById(Integer.parseInt(param.get("servicoId"))).get();
			solicitacoes.setServico(servico);
		}
		
		String saida = "";
		String erro = "";
		List<SolicitacoesServicos> solicitacoesServicos = new ArrayList<>();
		
		System.out.println(solicitacoes.toString());
		
		try {
			if(botao.equals("inserir")) {
				sRep.save(solicitacoes);
				saida = "Inserido com Sucesso!";
			}
			if(botao.equals("atualizar")) {
				sRep.save(solicitacoes);
				saida = "Atualizado com Sucesso!";
			}
			if(botao.equals("excluir")) {
				sRep.delete(solicitacoes);
				saida = "Excluido com Sucesso!";
			}
			if(botao.equals("listar")) {
				solicitacoesServicos = sRep.findAll();
			}
			if(botao.equals("buscar")) {
				solicitacoes = sRep.findById(solicitacoes.getId()).get();
			}
		}catch (Exception e) {
			// TODO: handle exception
			erro = e.getMessage();
		}finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("solicitacao", solicitacoes);
			model.addAttribute("solicitacoes", solicitacoesServicos);
		}
		
		
		return new ModelAndView("solicitacoes");
	}
}
