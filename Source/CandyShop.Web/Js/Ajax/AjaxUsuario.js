﻿var obj;
var AjaxJsUsuario = (function ($) {
    var url = {};

    var init = function (config) {
        url = config;
    };

    var cadastroUsuario = function () {
        chamaPaginaUsuarios(url.cadastroUsuario);
    };
    var listaUsuario = function (page) {
        chamaPaginaUsuarios(url.listaUsuario, page);
    };
    var editarUsuario = function (cpf, telaAnterior) {
        atualizaToken();
        chamaPaginaComIdentificador(url.editarUsuario, { cpf: cpf, telaAnterior: telaAnterior, token: obj.access_token });
    };

    var CadastraEmail = function () {
        CadastraEmailUsuario();
    };
        
        
    var detalheUsuario = function (cpf, telaAnterior) {
        atualizaToken();
        chamaPaginaComIdentificador(url.detalheUsuario, { cpf : cpf, telaAnterior: telaAnterior, token: obj.access_token });
    };
    var concluirCadastroUsuario = function (imgBase64) {
        //montantando o objeto que vai chegar no controller
        var usuario = {
            
            Cpf: $("#cpf").val(),
            NomeUsuario: $("#Nome").val(),
            Imagem: imgBase64,
            Classificacao: $("#Classificacao").val(),
            Email: $("#EmailCadastro").val()
        };
        atualizaToken();
        concluirAcao(url.concluirCadastroUsuario, { usuario: usuario, token: obj.access_token }, url.cadastroUsuario);
    };
    var concluirEdicaoUsuario = function (imgBase64, removerImagem, tela) {
        var usuario = {
            Cpf: $("#Cpf").val(),
            NomeUsuario: $("#Nome").val(),
            SaldoUsuario: $("#SaldoUsuario").val().replace("R$ ", "").replace(".", ""),
            SenhaUsuario: $("#Password").val(),
            Ativo: $("input[name='status']:checked").val(),
            Imagem: imgBase64,
            Classificacao: $("#Classificacao").val(),
            Email: $("#cadastraEmail").val(),
            RemoverImagem: removerImagem
        };
        atualizaToken();
        concluirAcaoEdicaoUsuario(url.concluirEdicaoUsuario, { usuario: usuario, token: obj.access_token }, tela);
    };
    var desativarUsuario = function (cpf, telaAnterior) {
        atualizaToken();
        chamaPaginaComIdentificador(url.desativarUsuario, { cpf: cpf, telaAnterior: telaAnterior, token: obj.access_token });
    };
    var desativarUsuarioConfirmado = function (cpf) {
        var usuario = { Cpf: cpf };
        atualizaToken();
        concluirAcaoEdicaoUsuario(url.desativarUsuarioConfirmado, { usuario: usuario, token: obj.access_token }, url.listarUsuarioInativo);
    };
    var listarUsuarioInativo = function () {
        chamaPaginaUsuarios(url.listarUsuarioInativo);
    };
    var listarUsuarioEmDivida = function () {
        chamaPaginaUsuarios(url.listarUsuarioEmDivida);
    };
    var listarUsuarioPorNome = function () {
        var usuario = { Nome: $("#nomeUsuario").val() };
        atualizaToken();
        chamaPaginaComIdentificador(url.listarUsuarioPorNome, { nome: usuario.Nome, token: obj.access_token });
    };
    var logOff = function () {
        $.get(url.logOff).done(function (data) {
            $("body").slideUp(1000, function () {
                if (localStorage.getItem("listaProdutos") != null) {
                    localStorage.removeItem("listaProdutos");
                }
                $("body").hide().html(data).slideDown(1000, function () {
                    Materialize.toast("LogOff feito com sucesso", 4000);
                });
            });
        }).fail(function (xhr) {
            console.log(xhr.responseText);
        });
    };
   
    var trocarSenha = function () {
        var senhas = { NovaSenha: $("#novaSenha").val(), ConfirmaNovaSenha: $("#confirmaNovaSenha").val() };
        
        atualizaToken();
        $.post(url.trocarSenha, { senhas: senhas, token: obj.access_token })
            .done(function (message) {
                Materialize.toast(message, 4000);
            })
            .fail(function (xhr) {
                console.log(xhr.responseText);
            });
    };

    return {
        init: init,
        concluirCadastroUsuario: concluirCadastroUsuario,
        listaUsuario: listaUsuario,
        cadastroUsuario: cadastroUsuario,
        concluirEdicaoUsuario: concluirEdicaoUsuario,
        editarUsuario: editarUsuario,
        detalheUsuario: detalheUsuario,
        desativarUsuario: desativarUsuario,
        desativarUsuarioConfirmado: desativarUsuarioConfirmado,
        listarUsuarioInativo: listarUsuarioInativo,
        listarUsuarioEmDivida: listarUsuarioEmDivida,
        listarUsuarioPorNome: listarUsuarioPorNome,
        logOff: logOff,
        trocarSenha: trocarSenha,
        CadastraEmail: CadastraEmail

    };
})(jQuery);

function CadastraEmailUsuario() {
    atualizaToken();

    var usuario = {
        Email: $("#email").val()
    };

    $.post("UsuarioComum/CadastraEmail",
            {
                token: obj.access_token,
                usuario: usuario
            })
        .done(function() {
            //msg mostrada apos o sucesso de recuperar a senha 
            Materialize.toast("Email Cadastrado com sucesso", 4000);
            //recarega a pagina depois que a solicitação for aceita
         
            $.get("Home")
                .done(function (data) {
                    $("body").slideUp(2500, function () {
                        $("body").hide().html(data).slideDown(1000);
                    });
                }).fail(function (xhr) {
                    Materialize.toast(xhr.responseText, 4000);
                });
        })
        .fail(function () {
            Materialize.toast("Você não está autorizado, contate os administradores", 3000);
            
        });
}

function chamaPaginaUsuarios(endereco, pagina) {
    atualizaToken();
    $.ajax({
        url: endereco,
        type: "GET",
        data: {
            token: obj.access_token,
            pagina: pagina
        },
        success: function (dataSucess) {
            $("#DivGrid").slideUp(function () {
                $("#DivGrid").hide().html(dataSucess).slideDown(function () {
                    Materialize.toast(dataSucess.data, 3000);
                });
            });
        },
        error: function (xhr) {
            Materialize.toast("Você não está autorizado, contate os administradores", 3000);
            console.log(xhr.responseText);
        }
    });
}

function concluirAcaoEdicaoUsuario(endereco, objeto, tela) {
    $.ajax({
        url: endereco,
        type: "POST",
        data: objeto,
        success: function (message) {
            chamaPaginaUsuarios(tela);
            Materialize.toast(message, 4000);
        }
    });
}

function atualizaToken() {
    obj = localStorage.getItem("tokenCandyShop") ? JSON.parse(localStorage.getItem("tokenCandyShop")) : [];
    if (obj == [])
        Materialize.modal("Há algo de errado com suas validações", 2000);
}