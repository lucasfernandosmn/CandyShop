﻿using CandyShop.Application.Interfaces;
using CandyShop.Web.Filters;
using CandyShop.Web.Helpers;
using System.Net;
using System.Web.Mvc;

namespace CandyShop.Web.Controllers.Compra
{
    [UserFilterResult]
    public class CompraUserComumController : Controller
    {
        private readonly ICompraApplication _appCompra;

        public CompraUserComumController(ICompraApplication compra)
        {
            _appCompra = compra;
        }

        public ActionResult Index()
        {
            return View("../Compra/Index");
        }

        public ActionResult Detalhes(int idCompra, string paginaAnterior, string token)
        {
            var response = _appCompra.SelecionarCompra(idCompra, token);
            if (response.Status != HttpStatusCode.OK)
                return Content("Erro ao detalhar compra, ", response.ContentAsString);
            var a = paginaAnterior.LastWord();
            ViewBag.endereco = Session["TipoDeLogin"].ToString().Equals("User") ? "AjaxJsShop.voltarInicio()" : a.Count > 1 
                ? $"AjaxJsCompra.listarCompra{paginaAnterior.LastWord()[0]}({paginaAnterior.LastWord()[1]})"
                : $"AjaxJsCompra.listarCompra{paginaAnterior.LastWord()[0]}()";
            return View("../../Views/CompraUserComum/Detalhes", response.Content);
        }

        
    }
}