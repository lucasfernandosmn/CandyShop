﻿var AjaxJsCompra = (function ($) {
    var url = {};

    var init = function (config) {
        url = config;
    };

    var inserirCompra = function () {
        var listaProdutos = [];
        var produto;
        var produtos = $('.collection li');
        var i = 0;
        $.each(produtos, function () {
            produto = {
                Produto: { IdProduto: $('span:eq('+ i + ')').attr('data-Id')},
                QtdeCompra: $('p:eq('+ i +')').attr('data-Quantidade')
            };
            listaProdutos.push(produto);
            i++;
        });

        var compra = { Itens: listaProdutos };
        $.post(url.inserirCompra, compra)
            .done(function (message) {
                $.get(url.padrao)
                    .done(function (data) {
                        $('body').slideUp(function () {
                            $('body').hide().html(data).slideDown(function () {
                                Materialize.toast(message, 3000);
                            });
                        });
                    }).fail(function (xhr) {
                        console.log(xhr.responseText);
                    });
            })
            .fail(function (xhr) {
                console.log(xhr.responseText);
            });
    }

    var historicoCompra = function () {
        chamaPagina(url.historicoCompra);
    };
    var listarCompraMes = function (mes) {
        var parametro = { mes: mes };
        chamaPaginaComIdentificador(url.listarCompraMes, parametro);
    };
    var listarCompraSemana = function () {
        chamaPagina(url.listarCompraSemana);
    };

    var listarCompraDia = function () {
        chamaPagina(url.listarCompraDia);
    };

    return {
        init: init,
        historicoCompra: historicoCompra,
        listarCompraSemana: listarCompraSemana,
        listarCompraMes: listarCompraMes,
        listarCompraDia: listarCompraDia,
        inserirCompra: inserirCompra
    };
})(jQuery);