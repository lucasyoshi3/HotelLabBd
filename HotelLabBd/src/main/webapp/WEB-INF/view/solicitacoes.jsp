<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Solicitar Servicos</title>
</head>
<body>
    <div align="center">
        <h1>Solicitar</h1>
    </div>
    <br>
    <div align="center">
        <form action="solicitacoes" method="post">
            <table>
                <tr>
                    <td colspan="3">
                        <input type="number" step="1" min="0" placeholder="#Solicitacao" id="id" name="id"
                               value='<c:out value="${solicitacoesServicos.id}"/>' />
                    </td>
                    <td colspan="1">
                        <input type="submit" id="botao" name="botao" value="Buscar" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <input type="number" placeholder="Quantidade" id="quantidade" name="quantidade"
                               value='<c:out value="${solicitacoesServicos.quantidade}"/>' />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <input type="number" placeholder="Valor Total" id="valorTotal" name="valorTotal"
                               value='<c:out value="${solicitacoesServicos.valorTotal}"/>' />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <input type="number" placeholder="Servico id" id="servicoId" name="servicoId"
                               value='<c:out value="${solicitacoesServicos.servico.id}"/>' />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <input type="number" placeholder="Checkin id" id="checkinId" name="checkinId"
                               value='<c:out value="${solicitacoesServicos.checkin.id}"/>' />
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
        <c:if test="${not empty solicitacoes}">
            <table border="1">
                <thead>
                    <tr>
                        <th>#Solicitacao</th>
                        <th>quantidade</th>
                        <th>valorTotal</th>
                        <th>servico</th>
                        <th>checkin</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="solicitacoesServicos" items="${solicitacoes}">
                        <tr>
                            <td><c:out value="${solicitacoesServicos.id}"/></td>
                            <td><c:out value="${solicitacoesServicos.quantidade}"/></td>
                            <td><c:out value="${solicitacoesServicos.valorTotal}"/></td>
                            <td><c:out value="${solicitacoesServicos.servico.id}"/></td>
                            <td><c:out value="${solicitacoesServicos.checkin.id}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</body>
</html>