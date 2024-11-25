<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tipo</title>
</head>
<body>
    <div align="center">
        <h1>Tipo</h1>
    </div>
    <br>
    <div align="center">
        <form action="tipo" method="post">
            <table>
                <tr>
                    <td colspan="3">
                        <input type="number" step="1" min="0" placeholder="#Tipo" id="id" name="id"
                               value='<c:out value="${tipo.id}"/>' />
                    </td>
                    <td colspan="1">
                        <input type="submit" id="botao" name="botao" value="buscar" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <input type="text" placeholder="Nome" id="nome" name="nome"
                               value='<c:out value="${tipo.nome}"/>' />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <input type="text" placeholder="Preco" id="preco" name="preco"
                               value='<c:out value="${tipo.preco}"/>' />
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
        <c:if test="${not empty tipos}">
            <table border="1">
                <thead>
                    <tr>
                        <th>#Id</th>
                        <th>Nome</th>
                        <th>Preco</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="tipo" items="${tipos}">
                        <tr>
                            <td><c:out value="${tipo.id}"/></td>
                            <td><c:out value="${tipo.nome}"/></td>
                            <td><c:out value="${tipo.preco}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</body>
</html>