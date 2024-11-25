<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gerar Relatório</title>
</head>
<body>
    <div align="center">
        <h1>Gerar Relatório</h1>
    </div>

    <br>

   
    <div align="center">
        <form action="relatorio" method="post">
            <table>
                <tr>
                
                    <td colspan="3">
                        <p>Dados dos clientes, quartos, tipo e valor, das reservas de um determinado dia.</p>
                        <input type="date" id="diaDeterminado" name="diaDeterminado" placeholder="Data" />
                    </td>
                    <td colspan="1">
                  
                        <input type="submit" id="botao" name="botao" value="cliente" />
                    </td>
                </tr>
                 <tr>
                	
                    <td colspan="3">
                        <p>Dados dos quartos, tipo, valor dos quartos disponíveis em um determinado dia.</p>
                        <input type="date" id="diaQuarto" name="diaQuarto" placeholder="Data" />
                    </td>
                    <td colspan="1">
                  
                        <input type="submit" id="botao" name="botao" value="quarto" />
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <p>Dados do cliente, da hospedagem, serviços consumidos e o valor total</p>
                        <input type="date" id="inicio" name="inicio" placeholder="Data" />
                        <input type="date" id="fim" name="fim" placeholder="Data" />
                    </td>
                    <td colspan="1">
                  
                        <input type="submit" id="botao" name="botao" value="hospedagem" />
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <br><br>

    <!-- Exibição de erros -->
    <div align="center">
        <c:if test="${not empty erro}">
            <div style="color: red;">
                <strong>Erro:</strong> <c:out value="${erro}" />
            </div>
        </c:if>
    </div>

</body>
</html>