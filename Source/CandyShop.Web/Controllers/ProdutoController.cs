﻿using CandyShop.Application.Interfaces;
using CandyShop.Application.ViewModels;
using CandyShop.Web.Filters;
using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Net;
using System.Web.Mvc;


namespace CandyShop.Web.Controllers
{
    public class ProdutoController : Controller
    {
        private readonly IProdutoApplication _appProduto;
        private readonly string _pathProduto;

        public ProdutoController(IProdutoApplication produto)
        {
            _appProduto = produto;
            _pathProduto = "Imagens/Produtos";
        }

        #region Telas
        [AdminFilterResult]
        public ActionResult ListaProdutos()
        {
            return View();
        }

        [AdminFilterResult]
        public ActionResult CadastrarProduto()
        {
            return View();
        }

        [AdminFilterResult]
        public ActionResult DetalheProduto(int idProduto, string telaAnterior)
        {
            var response = _appProduto.DetalharProduto(idProduto);
            if (response.Status != HttpStatusCode.OK)
                return Content("Erro. " + response.ContentAsString);
            TempData["caminhoImagensProdutos"] = _pathProduto;
            ViewBag.telaAnterior = telaAnterior;
            return View(response.Content);
        }

        [AdminFilterResult]
        public ActionResult EditarProduto(int idProduto, string telaAnterior)
        {
            var response = _appProduto.DetalharProduto(idProduto);
            if (response.Status != HttpStatusCode.OK)
                return Content("Erro. " + response.ContentAsString);
            ViewBag.telaAnterior = telaAnterior;
            ViewBag.Tela = response.Content.Ativo;
            TempData["caminhoImagensProdutos"] = _pathProduto;
            return View(response.Content);
        }

        [AdminFilterResult]
        public ActionResult DesativarProduto(int idProduto, string telaAnterior)
        {
            var response = _appProduto.DetalharProduto(idProduto);
            if (response.Status != HttpStatusCode.OK)
                return Content("Erro. " + response.ContentAsString);
            ViewBag.telaAnterior = telaAnterior;
            TempData["caminhoImagensProdutos"] = _pathProduto;
            return View(response.Content);
        }
        #endregion

        #region Listas
        [AdminFilterResult]
        public ActionResult Listar()
        {
            var response = _appProduto.ListarProdutos();
            if (response.Status != HttpStatusCode.OK)
                return Content("Erro. " + response.ContentAsString);

            TempData["caminhoImagensProdutos"] = _pathProduto;
            TempData["nomeLista"] = "Produtos Ativos";
            return View("ListaProdutos", response.Content);

        }

        [AdminFilterResult]
        public ActionResult ListarInativos()
        {
            var response = _appProduto.ListarInativos();
            if (response.Status != HttpStatusCode.OK)
                return Content($"Erro. {response.ContentAsString}");

            TempData["nomeLista"] = "Produtos Inativos";

            return View("ListaProdutos", response.Content);
        }

        [AdminFilterResult]
        public ActionResult ProcurarProduto(string nome)
        {
            var response = _appProduto.ProcurarProduto(nome);
            if (response.Status != HttpStatusCode.OK)
                return Content($"Erro: {response.Status}");

            TempData["caminhoImagensProdutos"] = _pathProduto;
            TempData["nomeLista"] = "Produtos relacionados";
            return View("ListaProdutos", response.Content);
        }
        #endregion

        #region Execucoes
        [AdminFilterResult]
        [HttpPost]
        public ActionResult CadastrarProduto(ProdutoViewModel produto)
        {
            var response = _appProduto.InserirProduto(produto);
            if (response.Status != HttpStatusCode.OK)
                return Content($"Erro. {response.ContentAsString}");

            //salvando todas as imagens que o usuário inseriu
            var cont = 0;
            if (produto.ImagemA != null)
            {
                string[] prefixos = { "data:image/jpeg;base64,", "data:image/png;base64,", "data:image/jpg;base64," };
                foreach (var prefixo in prefixos)
                {
                    if (!produto.ImagemA.StartsWith(prefixo)) continue;
                    produto.ImagemA = produto.ImagemA.Substring(prefixo.Length);

                    var bytes = Convert.FromBase64String(produto.ImagemA);

                    Image imagem = (Bitmap)((new ImageConverter()).ConvertFrom(bytes));

                    if (!Directory.Exists(_pathProduto))
                        Directory.CreateDirectory(_pathProduto);


                    var caminho = $"{_pathProduto}/{response.Content}_A.jpg";

                    imagem.Save(Server.MapPath(caminho), ImageFormat.Jpeg);
                    cont++;
                }
            }

            if (produto.ImagemB != null)
            {
                string[] prefixos = { "data:image/jpeg;base64,", "data:image/png;base64,", "data:image/jpg;base64," };
                foreach (var prefixo in prefixos)
                {
                    if (!produto.ImagemB.StartsWith(prefixo)) continue;
                    produto.ImagemB = produto.ImagemB.Substring(prefixo.Length);

                    var bytes = Convert.FromBase64String(produto.ImagemB);

                    Image imagem = (Bitmap)((new ImageConverter()).ConvertFrom(bytes));


                    var caminho = $"{_pathProduto}/{response.Content}_B.jpg";

                    imagem.Save(Server.MapPath(caminho), ImageFormat.Jpeg);
                    cont++;
                }
            }

            if (produto.ImagemC != null)
            {
                string[] prefixos = { "data:image/jpeg;base64,", "data:image/png;base64,", "data:image/jpg;base64," };
                foreach (var prefixo in prefixos)
                {
                    if (!produto.ImagemC.StartsWith(prefixo)) continue;
                    produto.ImagemC = produto.ImagemC.Substring(prefixo.Length);

                    var bytes = Convert.FromBase64String(produto.ImagemC);

                    Image imagem = (Bitmap)((new ImageConverter()).ConvertFrom(bytes));

                    var caminho = $"{_pathProduto}/{response.Content}_C.jpg";

                    imagem.Save(Server.MapPath(caminho), ImageFormat.Jpeg);
                    cont++;
                }
            }

            if (cont != 0 && produto.ImagemA == null) return Content("Produto cadastrado com sucesso!!");
            {
                //pegando a imagem na aplicação e transformando em base 64
                var imagem = ConvertTo64();
                //transformando em array de bytes e salvando com o cpf do usuário
                var bytes = Convert.FromBase64String(imagem);

                Image imagem2 = (Bitmap)((new ImageConverter()).ConvertFrom(bytes));

                var caminho = $"{_pathProduto}/{response.Content}_A.jpg";

                imagem2.Save(Server.MapPath(caminho), ImageFormat.Jpeg);
            }
            return Content("Produto cadastrado com sucesso!!");
        }

        [AdminFilterResult]
        [HttpPut]
        public ActionResult EditarProduto(ProdutoViewModel produto)
        {
            var response = _appProduto.EditarProduto(produto);
            if (response.Status != HttpStatusCode.OK)
                return Content($"Erro. {response.ContentAsString}");
            try
            {


                if (produto.ImagemA != null)
                {
                    string[] prefixos = {"data:image/jpeg;base64,", "data:image/png;base64,", "data:image/jpg;base64,"};
                    foreach (var prefixo in prefixos)
                    {
                        if (!produto.ImagemA.StartsWith(prefixo)) continue;
                        produto.ImagemA = produto.ImagemA.Substring(prefixo.Length);

                        var bytes = Convert.FromBase64String(produto.ImagemA);

                        Image imagem = (Bitmap) new ImageConverter().ConvertFrom(bytes);

                        var caminho = $"{_pathProduto}/{produto.IdProduto}_A.jpg";

                        imagem.Save(Server.MapPath(caminho), ImageFormat.Jpeg);
                    }
                }

                if (produto.ImagemB != null)
                {
                    string[] prefixos = {"data:image/jpeg;base64,", "data:image/png;base64,", "data:image/jpg;base64,"};
                    foreach (var prefixo in prefixos)
                        if (produto.ImagemB.StartsWith(prefixo))
                        {
                            produto.ImagemB = produto.ImagemB.Substring(prefixo.Length);

                            var bytes = Convert.FromBase64String(produto.ImagemB);

                            Image imagem = (Bitmap) new ImageConverter().ConvertFrom(bytes);

                            var caminho = $"{_pathProduto}/{produto.IdProduto}_B.jpg";

                            imagem.Save(Server.MapPath(caminho), ImageFormat.Jpeg);
                        }
                }

                if (produto.ImagemC != null)
                {
                    string[] prefixos = {"data:image/jpeg;base64,", "data:image/png;base64,", "data:image/jpg;base64,"};
                    foreach (var prefixo in prefixos)
                        if (produto.ImagemC.StartsWith(prefixo))
                        {
                            produto.ImagemC = produto.ImagemC.Substring(prefixo.Length);

                            var bytes = Convert.FromBase64String(produto.ImagemC);

                            Image imagem = (Bitmap) new ImageConverter().ConvertFrom(bytes);

                            var caminho = $"{_pathProduto}/{produto.IdProduto}_C.jpg";

                            imagem.Save(Server.MapPath(caminho), ImageFormat.Jpeg);
                        }
                }
            }
            catch (Exception exception)
            {
                return Content("Erro ao salvar imagem");
            }
            if (produto.RemoverImagemA)
            {
                var filePath = Server.MapPath($"{_pathProduto}/{produto.IdProduto}_A.jpg");
                if (System.IO.File.Exists(filePath))
                    System.IO.File.Delete(filePath);
            }

            if (produto.RemoverImagemB)
            {
                var filePath = Server.MapPath($"{_pathProduto}/{produto.IdProduto}_B.jpg");
                if (System.IO.File.Exists(filePath))
                    System.IO.File.Delete(filePath);
            }

            if (produto.RemoverImagemC) return Content("Produto editado com sucesso!");
            {
                var filePath = Server.MapPath($"{_pathProduto}/{produto.IdProduto}_C.jpg");
                if (System.IO.File.Exists(filePath))
                    System.IO.File.Delete(filePath);
            }

            return Content("Produto editado com sucesso!");
        }

        [AdminFilterResult]
        [HttpPut]
        public ActionResult DesativarProdutoConfirmado(ProdutoViewModel produto)
        {
            var response = _appProduto.DesativarProduto(produto);
            return Content(response.Status != HttpStatusCode.OK ? $"Erro: {response.Status}" : "Produto desativado com sucesso!");
        }
        #endregion

        private string ConvertTo64()
        {
            using (var image = Image.FromFile(Server.MapPath($"{_pathProduto}/sem-foto.png")))
            {
                using (var m = new MemoryStream())
                {
                    image.Save(m, image.RawFormat);
                    var imageBytes = m.ToArray();

                    // Convert byte[] to Base64 String
                    var base64String = Convert.ToBase64String(imageBytes);
                    return base64String;
                }
            }
        }
    }
}

