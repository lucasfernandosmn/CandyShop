﻿using CandyShop.Application.Interfaces;
using CandyShop.Application.ViewModels;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Net.Http.Formatting;

namespace CandyShop.Application
{
    public class ProdutoApplication : IProdutoApplication
    {
        private readonly string _enderecoApi = $"{ApiConfig.enderecoApi}/produto";        

        public Response<string> InserirProduto(ProdutoViewModel produto)
        {
            using (var client = new HttpClient())
            {
                var response = client.PostAsync(_enderecoApi, produto, new JsonMediaTypeFormatter()).Result;
                return new Response<string>(response.Content.ReadAsStringAsync().Result, response.StatusCode);
            }
        }

        public Response<ProdutoViewModel> DetalharProduto(int idProduto)
        {
            using (var cliente = new HttpClient())
            {
                var response = cliente.GetAsync($"{_enderecoApi}/selecionar/{idProduto}").Result;
                return new Response<ProdutoViewModel>(response.Content.ReadAsStringAsync().Result, response.StatusCode);
            }
        }

        public Response<string> EditarProduto(ProdutoViewModel produto)
        {
            using (var client = new HttpClient())
            {
                var response = client.PutAsync(_enderecoApi, produto, new JsonMediaTypeFormatter()).Result;
                return response.StatusCode != HttpStatusCode.OK
                      ? new Response<string>(response.Content.ReadAsStringAsync().Result, response.StatusCode)
                      : new Response<string>(response.StatusCode);
            }
        }

        public Response<string> DesativarProduto(ProdutoViewModel produto)
        {
            using (var cliente = new HttpClient())
            {
                var response = cliente.PutAsync($"{_enderecoApi}/desativar/{produto.IdProduto}", produto, new JsonMediaTypeFormatter()).Result;
                return response.StatusCode != HttpStatusCode.OK
                     ? new Response<string>(response.Content.ReadAsStringAsync().Result, response.StatusCode)
                     : new Response<string>(response.StatusCode);
            }
        }        

        #region GETS

        public Response<IEnumerable<ProdutoViewModel>> ListarProdutos()
        {
            using (var client = new HttpClient())
            {
                var response = client.GetAsync(_enderecoApi).Result;
                return new Response<IEnumerable<ProdutoViewModel>>(response.Content.ReadAsStringAsync().Result, response.StatusCode);
            }
        }

        public Response<IEnumerable<ProdutoViewModel>> ListarInativos()
        {
            using (var cliente = new HttpClient())
            {
                var response = cliente.GetAsync($"{_enderecoApi}/inativos").Result;
                return new Response<IEnumerable<ProdutoViewModel>>(response.Content.ReadAsStringAsync().Result, response.StatusCode);
            }
        }

        public Response<IEnumerable<ProdutoViewModel>> ProcurarProduto(string nome)
        {
            using (var cliente = new HttpClient())
            {
                var response = cliente.GetAsync($"{_enderecoApi}/procurar/{nome}").Result;
                return new Response<IEnumerable<ProdutoViewModel>>(response.Content.ReadAsStringAsync().Result, response.StatusCode);
            }
        }

        public Response<IEnumerable<ProdutoViewModel>> ListarCategoria(string categoria)
        {
            using (var cliente = new HttpClient())
            {
                var response = cliente.GetAsync($"{_enderecoApi}/categoria/{categoria}").Result;
                return new Response<IEnumerable<ProdutoViewModel>>(response.Content.ReadAsStringAsync().Result, response.StatusCode);
            }
        }

        #endregion
    }
}