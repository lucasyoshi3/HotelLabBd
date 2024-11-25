package com.fatec.HotelLabBd.HotelLabBd.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.util.JRLoader;

@Controller
public class RelatoriosController {

	@RequestMapping(name = "relatorio", value = "/relatorio", method = RequestMethod.GET)
	public ModelAndView relatorioGet() {
		return new ModelAndView("relatorio");
	}
	
	@RequestMapping(name = "relatorio", value = "/relatorio", method = RequestMethod.POST)
	public ModelAndView relatorioPost(
	        @RequestParam Map<String, String> param,
	        ModelMap model,
	        HttpServletResponse response) throws IOException {
	    String erro = "";
	    
	    String botao = param.get("botao");
	    String jasper = "WEB-INF/report/Blank_A4.jasper";
	    
	    HashMap<String, Object> parametro = new HashMap<>();
	    
	    byte[] bytes = null;
	    
	    try {
	        
	        if (botao.equals("cliente")) {
	            String diaDeterminado = param.get("diaDeterminado");
	            parametro.put("diaDeterminado", diaDeterminado);  
	        }
	        if (botao.equals("hospedagem")) {
	        	String inicio = param.get("inicio");
	        	String fim = param.get("fim");
	        	parametro.put("inicio", inicio);
	        	parametro.put("fim", fim);
	        }
	        if(botao.equals("quarto")) {
	        	String diaQuarto = param.get("diaQuarto");
	        	parametro.put("diaQuarto", diaQuarto);
	        }
	    } catch (Exception e) {
	        erro = "Erro ao processar parâmetros: " + e.getMessage();
	        model.addAttribute("erro", erro);
	        return new ModelAndView("relatorio"); 
	    }

	    try {
	    	InputStream jasperStream = null;
	    	if(botao.equals("cliente")) {
	    		jasperStream = getClass().getResourceAsStream("/report/Blank_A4.jasper");
	    	}
	    	if(botao.equals("hospedgem")) {
	    		jasperStream = getClass().getResourceAsStream("/report/hospedagem.jasper");
	    	}
	    	if(botao.equals("quarto")) {
	    		jasperStream = getClass().getResourceAsStream("/report/quarto.jasper");
	    	}
	        if (jasperStream == null) {
	            throw new FileNotFoundException("Relatório não encontrado no caminho especificado.");
	        }
	    	
	        
	        JasperReport relatorio = (JasperReport) JRLoader.loadObject(jasperStream);

	        bytes = JasperRunManager.runReportToPdf(relatorio, parametro);


	        response.setContentType("application/pdf");
	        response.setHeader("Content-Disposition", "attachment; filename=relatorio.pdf");
	        response.setContentLength(bytes.length);

	        
	        response.getOutputStream().write(bytes);
	        response.getOutputStream().flush();
	        response.getOutputStream().close();
	        	       
	        return null; 

	    } catch (JRException e) {
	        erro = "Erro ao gerar o relatório: " + e.getMessage();
	        e.printStackTrace();
	        model.addAttribute("erro", erro);
	    } catch (Exception e) {
	        erro = "Erro inesperado: " + e.getMessage();
	        e.printStackTrace();
	        model.addAttribute("erro", erro);
	    }
	    return new ModelAndView("relatorio");
	}
}
