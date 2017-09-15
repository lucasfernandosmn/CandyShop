﻿using CandyShop.Application.Interfaces;
using System.Net;
using System.Web.Mvc;

namespace CandyShop.Web.Controllers
{
    public class UsuarioController : Controller
    {
        private readonly IUsuarioApplication _appUsuario;

        public UsuarioController(IUsuarioApplication usuario)
        {
            _appUsuario = usuario;
        }

        public ActionResult Index()
        {
            var response = _appUsuario.ListarUsuarios();
            if (response.Status != HttpStatusCode.OK)
            {
                return Content("Erro " + response.ContentAsString);
            }
            return View(response.Content);
        }

        public ActionResult Cadastrar()
        {
            return View();
        }

        public ActionResult Editar()
        {
            return View();
        }
    }
}