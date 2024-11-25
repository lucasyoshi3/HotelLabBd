<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Checkin e Checkout</title>
</head>
<body>
    <div align="center">
        <h1>Checkin</h1>
    </div>
    <br>
    <div align="center">
        <form action="checkin" method="post">
            <table>
                <tr>
                    <td colspan="3">
                        <input type="number" step="1" min="0" placeholder="#Checkin" id="id" name="id"
                               value='<c:out value="${checkin.id}"/>' />
                    </td>
                    <td colspan="1">
                        <input type="submit" id="botao" name="botao" value="Buscar" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <input type="date" placeholder="Data Checkin" id="data_checkin" name="data_checkin"
                               value='<c:out value="${checkin.dataCheckin}"/>' />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <input type="date" placeholder="Data Checkout" id="data_checkout" name="data_checkout"
                               value='<c:out value="${checkin.dataCheckout}"/>' />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
    					<label>
        					<input type="checkbox" id="reservado" name="reservado"
               				<c:if test="${checkin.reservado}">checked</c:if> />
        					Reservado
    					</label>
					</td>
                </tr>
                 <tr>
                    <td colspan="4">
                        <input type="number" placeholder="Cpf do Cliente" id="cpf" name="cpf"
                               value='<c:out value="${checkin.cliente.cpf}"/>' />
                    </td>
                </tr>
                 <tr>
                    <td colspan="4">
                        <input type="number" placeholder="Numero do Quarto" id="numero" name="numero"
                               value='<c:out value="${checkin.quarto.numero}"/>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="submit" id="botao" name="botao" value="inserir" />
                    </td>
                    <td>
                        <input type="submit" id="botao" name="botao" value="atualizar" />
                    </td>
                    <td>
                        <input type="submit" id="botao" name="botao" value="excluir" />
                    </td>
                    <td>
                        <input type="submit" id="botao" name="botao" value="listar" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <br /><br />
    <div align="center">
        <c:if test="${not empty saida}">
            <c:out value="${saida}" />
        </c:if>
    </div>
    <div align="center">
        <c:if test="${not empty erro}">
            <c:out value="${erro}" />
        </c:if>
    </div>
    <div align="center">
        <c:if test="${not empty checkins}">
            <table border="1">
                <thead>
                    <tr>
                        <th>#IdCheckin</th>
                        <th>Data Checkin</th>
                        <th>Data Checkout</th>
                        <th>Cpf do cliente</th>
                        <th>Numero do Quarto</th>
                        <th>Reservado</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="checkin" items="${checkins}">
                        <tr>
                            <td><c:out value="${checkin.id}"/></td>
                            <td><c:out value="${checkin.dataCheckin}"/></td>
                            <td><c:out value="${checkin.dataCheckout}"/></td>
                            <td><c:out value="${checkin.cliente.cpf}"/></td>
                            <td><c:out value="${checkin.quarto.numero}"/></td>
                             <td><c:out value="${checkin.reservado}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</body>
</html>