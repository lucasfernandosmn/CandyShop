﻿using CandyShop.Application.Interfaces;
using CandyShop.Application.ViewModels;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Net.Http.Formatting;

namespace CandyShop.Application
{
    public class CompraApplication : ICompraApplication
    {
        private readonly string _enderecoApi = $"{ApiConfig.enderecoApi}/compra";

        public Response<int> InserirCompra(CompraViewModel compra)
        {
            using (var client = new HttpClient())
            {
                /* Aqui é definido o endereço da API, o verbo HTTP que será utilizado
                   (nesse caso POST) e o tipo de retorno(nesse caso JSON), a linha de baixo
                   define o tipo da resposta(nesse caso INT) e recebe o status dessa resposta
                   (ok, bad request, internal server error, etc) */
                var response = client.PostAsync(_enderecoApi, compra, new JsonMediaTypeFormatter()).Result;
                return new Response<int>(response.Content.ReadAsStringAsync().Result, response.StatusCode);
            }
        }

        public Response<string> EditarCompra(CompraViewModel compra)
        {
            using (var client = new HttpClient())
            {
                var response = client.PutAsync(_enderecoApi, compra, new JsonMediaTypeFormatter()).Result;
                /* Nessa código abaixo dizemos que se o status da resposta vier ok, queremos
                   o conteúdo dessa resposta, se não, queremos o status que veio com ela
                   (404 not fount, 500 internal server error, etc) */
                return response.StatusCode != HttpStatusCode.OK
                    ? new Response<string>(response.Content.ReadAsStringAsync().Result, response.StatusCode)
                    : new Response<string>(response.StatusCode);
            }
        }

        public Response<CompraViewModel> SelecionarCompra(int idCompra)
        {
            using (var client = new HttpClient())
            {
                var response = client.GetAsync($"{_enderecoApi}/selecionarcompra/{idCompra}").Result;
                return new Response<CompraViewModel>(response.Content.ReadAsStringAsync().Result, response.StatusCode);
            }
        }

        public Response<string> EditaItens(CompraProdutoViewModel compraProduto)
        {
            using (var client = new HttpClient())
            {
                var response = client.PutAsync(_enderecoApi, compraProduto, new JsonMediaTypeFormatter()).Result;
                return response.StatusCode != HttpStatusCode.OK
                    ? new Response<string>(response.Content.ReadAsStringAsync().Result, response.StatusCode)
                    : new Response<string>(response.StatusCode);
            }
        }

        #region Listas
        public Response<IEnumerable<CompraViewModel>> ListaCompra()
        {
            using (var client = new HttpClient())
            {
                var response = client.GetAsync($"{_enderecoApi}").Result;
                return new Response<IEnumerable<CompraViewModel>>(response.Content.ReadAsStringAsync().Result, response.StatusCode);
            }
        }

        public Response<IEnumerable<CompraViewModel>> ListaCompraPorCpf(string cpf)
        {
            using (var client = new HttpClient())
            {
                var response = client.GetAsync($"{_enderecoApi}/listaCompracpf/{cpf}").Result;
                return new Response<IEnumerable<CompraViewModel>>(response.Content.ReadAsStringAsync().Result, response.StatusCode);
            }
        }

        public Response<IEnumerable<CompraViewModel>> ListarComprasSemana()
        {
            using (var client = new HttpClient())
            {
                var response = client.GetAsync($"{_enderecoApi}/semana").Result;
                return new Response<IEnumerable<CompraViewModel>>(response.Content.ReadAsStringAsync().Result, response.StatusCode);
            }
        }

        public Response<IEnumerable<CompraViewModel>> ListarComprasMes(int mes)
        {
            using (var client = new HttpClient())
            {
                var response = client.GetAsync($"{_enderecoApi}/mes/{mes}").Result;
                return new Response<IEnumerable<CompraViewModel>>(response.Content.ReadAsStringAsync().Result, response.StatusCode);
            }
        }

        public Response<IEnumerable<CompraViewModel>> ListarComprasDia()
        {
            using (var client = new HttpClient())
            {
                var response = client.GetAsync($"{_enderecoApi}/dia").Result;
                return new Response<IEnumerable<CompraViewModel>>(response.Content.ReadAsStringAsync().Result, response.StatusCode);
            }
        }

        public Response<IEnumerable<CompraViewModel>> ListaCompraPorNome(string nomeUsuario)
        {
            using (var client = new HttpClient())
            {
                var response = client.GetAsync($"{_enderecoApi}/{nomeUsuario}").Result;
                return new Response<IEnumerable<CompraViewModel>>(response.Content.ReadAsStringAsync().Result, response.StatusCode);
            }
        }

        public Response<int> VerificarUltimaCompra()
        {
            using (var client = new HttpClient())
            {
                var response = client.GetAsync($"{_enderecoApi}/ultima").Result;
                return new Response<int>(response.Content.ReadAsStringAsync().Result, response.StatusCode);
            }
        }
        #endregion
    }
}