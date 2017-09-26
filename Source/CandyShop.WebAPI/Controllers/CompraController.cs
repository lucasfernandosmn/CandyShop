﻿using CandyShop.Core.Services.Compra;
using CandyShop.Core.Services.Compra.Dto;
using System.Web.Http;

namespace CandyShop.WebAPI.Controllers
{
    public class CompraController : ApiController
    {
        private readonly ICompraRepository _compraRepository;

        public CompraController(ICompraRepository compraRepository)
        {
            _compraRepository = compraRepository;
        }

        // Método Post que ira inserir uma compra e retornar um 200 (Ok)
        public IHttpActionResult PostCompra(CompraDto compra)
        {
            _compraRepository.InserirCompra(compra);
            return Ok();
        }        

        public IHttpActionResult PutCompra(CompraDto compra)
        {
            _compraRepository.EditarCompra(compra);
            return Ok();
        }
        
        #region Gets
        public IHttpActionResult GetCompra()
        {
            return Ok(_compraRepository.ListarCompra());
        }

        [Route("api/compra/listaCompracpf/{cpf}")]
        public IHttpActionResult GetCpf(string cpf)
        {
            return Ok(_compraRepository.ListarCompraPorCpf(cpf));
        }

        [Route("api/compra/semana")]
        public IHttpActionResult GetSemana()
        {
            return Ok(_compraRepository.ListarCompraSemana());
        }

        [Route("api/compra/mes/{mes}")]
        public IHttpActionResult GetMes(int mes)
        {
            return Ok(_compraRepository.ListarCompraMes(mes));
        }

        [Route("api/compra/dia")]
        public IHttpActionResult GetDia()
        {
            return Ok(_compraRepository.ListarCompraDia());
        }
        [Route("api/compra/{nomeUsuario}")]
        public IHttpActionResult GetNome(string nomeUsuario)
        {
            return Ok(_compraRepository.ListarCompraPorNome(nomeUsuario));
        }

        #endregion
    }
}