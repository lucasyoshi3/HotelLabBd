<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Servico Form</title>
    <!-- Link para o CSS do Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="text-center">
            <h1>Servico</h1>
        </div>
        <form action="servico" method="post" class="mt-4">
            <div class="row mb-3">
                <div class="col-md-10">
                    <input type="number" class="form-control" step="1" min="0" placeholder="#Servico" id="id" name="id"
                           value='<c:out value="${servico.id}"/>' />
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary w-100" id="botao" name="botao" value="buscar">Buscar</button>
                </div>
            </div>
            <div class="mb-3">
                <input type="text" class="form-control" placeholder="Nome" id="nome" name="nome"
                       value='<c:out value="${servico.nome}"/>' />
            </div>
            <div class="mb-3">
                <textarea class="form-control" placeholder="Descrição" id="descricao" name="descricao" rows="4"
                          value='<c:out value="${servico.descricao}"/>'></textarea>
            </div>
            <div class="mb-3">
                <input type="number" class="form-control" placeholder="Valor" id="valor" name="valor"
                       value='<c:out value="${servico.valor}"/>' />
            </div>
            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-success" id="botao" name="botao" value="inserir">Inserir</button>
                <button type="submit" class="btn btn-warning" id="botao" name="botao" value="atualizar">Atualizar</button>
                <button type="submit" class="btn btn-danger" id="botao" name="botao" value="excluir">Excluir</button>
                <button type="submit" class="btn btn-info" id="botao" name="botao" value="listar">Listar</button>
            </div>
        </form>

        <div class="mt-4">
            <c:if test="${not empty saida}">
                <div class="alert alert-success" role="alert">
                    <c:out value="${saida}" />
                </div>
            </c:if>
            <c:if test="${not empty erro}">
                <div class="alert alert-danger" role="alert">
                    <c:out value="${erro}" />
                </div>
            </c:if>
        </div>

        <c:if test="${not empty servicos}">
            <div class="mt-4">
                <table class="table table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>#Id</th>
                            <th>Nome</th>
                            <th>Descrição</th>
                            <th>Valor</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="servico" items="${servicos}">
                            <tr>
                                <td><c:out value="${servico.id}"/></td>
                                <td><c:out value="${servico.nome}"/></td>
                                <td><c:out value="${servico.descricao}"/></td>
                                <td><c:out value="${servico.valor}"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </div>

    <!-- Link para o JS do Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>