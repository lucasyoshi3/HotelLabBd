<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quarto Form</title>
</head>
<body>
    <div align="center">
        <h1>Quarto</h1>
    </div>
    <br>
    <div align="center">
        <form action="quarto" method="post">
            <table>
                <tr>
                    <td colspan="3">
                        <input type="number" step="1" min="0" placeholder="#Numero Quarto" id="numero" name="numero"
                               value='<c:out value="${quarto.numero}"/>' />
                    </td>
                    <td colspan="1">
                        <input type="submit" id="botao" name="botao" value="buscar" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <input type="number" placeholder="Andar" id="andar" name="andar"
                               value='<c:out value="${quarto.andar}"/>' />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <input type="text" placeholder="Descricao" id="descricao" name="descricao"
                               value='<c:out value="${quarto.descricao}"/>' />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <input type="number" placeholder="Id do tipo do quarto" id="tipoid" name="tipoid"
                               value='<c:out value="${quarto.tipo.id}"/>' />
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
        <c:if test="${not empty quartos}">
            <table border="1">
                <thead>
                    <tr>
                        <th>#Numero</th>
                        <th>Andar</th>
                        <th>Descricao</th>
                        <th>Tipo</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="quarto" items="${quartos}">
                        <tr>
                            <td><c:out value="${quarto.numero}"/></td>
                            <td><c:out value="${quarto.andar}"/></td>
                            <td><c:out value="${quarto.descricao}"/></td>
                            <td><c:out value="${quarto.tipo.id}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</body>
</html>