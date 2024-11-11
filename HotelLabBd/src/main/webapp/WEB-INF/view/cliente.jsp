<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cliente Form</title>
</head>
<body>
    <div align="center">
        <h1>Cliente</h1>
    </div>
    <br>
    <div align="center">
        <form action="cliente" method="post">
            <table>
                <tr>
                    <td colspan="3">
                        <input type="number" step="1" min="0" placeholder="#Cliente" id="cpf" name="cpf"
                               value='<c:out value="${cliente.cpf}"/>' />
                    </td>
                    <td colspan="1">
                        <input type="submit" id="botao" name="botao" value="Buscar" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <input type="text" placeholder="Nome" id="nome" name="nome"
                               value='<c:out value="${cliente.nome}"/>' />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <input type="text" placeholder="Telefone" id="telefone" name="telefone"
                               value='<c:out value="${cliente.telefone}"/>' />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <input type="text" placeholder="Cidade" id="cidade" name="cidade"
                               value='<c:out value="${cliente.cidade}"/>' />
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
        <c:if test="${not empty clientes}">
            <table border="1">
                <thead>
                    <tr>
                        <th>#Cpf</th>
                        <th>Nome</th>
                        <th>Telefone</th>
                        <th>Cidade</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="cliente" items="${clientes}">
                        <tr>
                            <td><c:out value="${cliente.cpf}"/></td>
                            <td><c:out value="${cliente.nome}"/></td>
                            <td><c:out value="${cliente.telefone}"/></td>
                            <td><c:out value="${cliente.cidade}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</body>
</html>