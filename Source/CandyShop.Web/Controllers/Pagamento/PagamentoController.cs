﻿using CandyShop.Application.Interfaces;
using CandyShop.Application.ViewModels;
using CandyShop.Web.Controllers.Pagamento;
using CandyShop.Web.Filters;
using CandyShop.Web.Helpers;
using System;
using System.Net;
using System.Web.Mvc;

namespace CandyShop.Web.Controllers
{
    [AdminFilterResult]
    public class PagamentoController : PagamentoUserComumController
    {
        private readonly IPagamentoApplication _appPagamento;
        private readonly IUsuarioApplication _appUsuario;

        public PagamentoController(IPagamentoApplication pagamento, IUsuarioApplication usuario) : base(pagamento, usuario)
        {
            _appPagamento = pagamento;
            _appUsuario = usuario;
        }

        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Editar(int idPagamento, string paginaAnterior)
        {

            var result = _appPagamento.SelecionarPagamento(idPagamento);
            if (result.Status != HttpStatusCode.OK)
                return Content("Erro ao localizar produto");
            var a = paginaAnterior.LastWord();
            ViewBag.endereco = a.Count > 1 ? $"AjaxJsPagamento.listarPagamento{paginaAnterior.LastWord()[0]}({paginaAnterior.LastWord()[1]})" : $"AjaxJsPagamento.listarPagamento{paginaAnterior.LastWord()[0]}";
            ViewBag.enderecoConclusao = a.Count > 1 ? $"AjaxJsPagamento.listarPagamento{paginaAnterior.LastWord()[0]},{paginaAnterior.LastWord()[1]}" : $"AjaxJsPagamento.listarPagamento{paginaAnterior.LastWord()[0]}";
            return View(result.Content);
        }

        public ActionResult Listar()
        {
            ViewBag.tituloPagina = "Pagamentos do ultimo mês";
            ViewBag.drop = 0;
            var response = _appPagamento.ListarPagamentos();
            if (response.Status != HttpStatusCode.OK)
                return Content("Erro. " + response.ContentAsString);
            return View("Index", response.Content);
        }
        public ActionResult ListarSemana()
        {
            ViewBag.tituloPagina = $"Pagamentos da ultima semana";
            ViewBag.drop = 1;
            var response = _appPagamento.ListarPagamentosSemana();
            if (response.Status != HttpStatusCode.OK)
                return Content("Erro. " + response.ContentAsString);
            return View("Index", response.Content);
        }
        public ActionResult ListarMes(int mes)
        {
            ViewBag.tituloPagina = $"Pagamento do mês {mes}";
            ViewBag.drop = 0;
            var response = _appPagamento.ListarPagamentos(mes);
            if (response.Status != HttpStatusCode.OK)
                return Content("Erro. " + response.ContentAsString);
            return View("Index", response.Content);
        }
        public ActionResult ListarDia()
        {
            ViewBag.tituloPagina = $"Pagamentos do dia {DateTime.Now.ToShortDateString()}";
            ViewBag.drop = 1;
            var response = _appPagamento.ListarPagamentosDia();
            if (response.Status != HttpStatusCode.OK)
                return Content("Erro. " + response.ContentAsString);
            return View("Index", response.Content);
        }

        [HttpPost]
        public ActionResult EditarPagamento(PagamentoViewModel pagamento)
        {            
            var response = _appPagamento.EditarPagamento(pagamento);

            if (response.Status != HttpStatusCode.OK)
                return Content("Erro. " + response.ContentAsString);

            if (!Session["Login"].ToString().Equals(pagamento.Usuario.Cpf))
                return Content("Pagamento editado com sucesso!!");
            var user = _appUsuario.SelecionarUsuario(pagamento.Usuario.Cpf);
            if (user.Status != HttpStatusCode.OK)
                return Content("Erro ao atualizar seu saldo");
            Session["saldoUsuario"] = $"{user.Content.SaldoUsuario:C}";

            return Content("Pagamento editado com sucesso!!");
        }
    }
}