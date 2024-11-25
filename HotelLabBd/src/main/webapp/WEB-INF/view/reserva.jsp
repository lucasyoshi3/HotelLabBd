<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reserva form</title>
</head>
<body>
    <div align="center">
        <h1>Reserva</h1>
    </div>
    <br>
    <div align="center">
        <form action="reserva" method="post">
            <table>
                <!-- ID da Reserva -->
                <tr>
                    <td colspan="3">
                        <input type="number" step="1" min="0" placeholder="#Reserva" id="id" name="id"
                               value='<c:out value="${reserva.id}"/>' />
                    </td>
                    <td colspan="1">
                        <input type="submit" id="botao" name="botao" value="buscar" />
                    </td>
                </tr>
                <!-- Data de Início -->
                <tr>
                    <td colspan="4">
                        <input type="date" placeholder="Data de Início da Reserva" id="inicio" name="inicio"
                               value='<c:out value="${reserva.inicio}"/>' />
                    </td>
                </tr>
                <!-- Quantidade de Dias -->
                <tr>
                    <td colspan="4">
                        <input type="number" placeholder="Quantidade de Dias" id="qtd_dias" name="qtd_dias"
                               value='<c:out value="${reserva.quantidadeDias}"/>' />
                    </td>
                </tr>
                <!-- CPF do Cliente -->
                <tr>
                    <td colspan="4">
                        <input type="number" placeholder="Cpf do Cliente" id="clientecpf" name="clientecpf"
                               value='<c:out value="${reserva.cliente.cpf}"/>' />
                    </td>
                </tr>
                <!-- Número do Quarto -->
                <tr>
                    <td colspan="4">
                        <input type="number" placeholder="Numero do Quarto" id="quartonumero" name="quartonumero"
                               value='<c:out value="${reserva.quarto.numero}"/>' />
                    </td>
                </tr>
                <!-- Botões -->
                <tr>
                    <td><input type="submit" id="botao" name="botao" value="inserir" /></td>
                    <td><input type="submit" id="botao" name="botao" value="atualizar" /></td>
                    <td><input type="submit" id="botao" name="botao" value="excluir" /></td>
                    <td><input type="submit" id="botao" name="botao" value="listar" /></td>
                </tr>
            </table>
        </form>
    </div>

    <br /><br />

    <!-- Mensagens de Sucesso ou Erro -->
    <div align="center">
        <c:if test="${not empty saida}">
            <p><strong><c:out value="${saida}" /></strong></p>
        </c:if>
    </div>
    <div align="center">
        <c:if test="${not empty erro}">
            <p style="color: red;"><strong><c:out value="${erro}" /></strong></p>
        </c:if>
    </div>

    <!-- Exibição das Reservas -->
    <div align="center">
        <c:if test="${not empty reservas}">
            <table border="1">
                <thead>
                    <tr>
                        <th>#Id</th>
                        <th>Dt Início</th>
                        <th>Qtd Dias</th>
                        <th>Preço</th>
                        <th>Cliente CPF</th>
                        <th>Numero do Quarto</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="reserva" items="${reservas}">
                        <tr>
                            <td><c:out value="${reserva.id}"/></td>
                            <td><c:out value="${reserva.inicio}"/></td>
                            <td><c:out value="${reserva.quantidadeDias}"/></td>
                            <td><c:out value="${reserva.valor}"/></td>
                            <td><c:out value="${reserva.cliente.cpf}"/></td>
                            <td><c:out value="${reserva.quarto.numero}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</body>
</html>
