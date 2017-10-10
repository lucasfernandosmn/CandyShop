﻿using CandyShop.Core.Services.CompraProduto;
using CandyShop.Core.Services.Produto;
using System;

namespace CandyShop.Core.Services.Compra
{
    /* Classes de serviços servem para fazer as verificações necessárias antes de enviar
       o objeto que é recebido aqui ao repositório. */
    public class CompraService
    {
        private readonly ICompraRepository _compraRepository;
        private readonly ICompraProdutoRepository _compraProdutoRepository;
        private readonly INotification _notification;
        private readonly IProdutoRepository _produtoRepository;

        public CompraService(ICompraRepository compraRepositorio, ICompraProdutoRepository compraProdutoRepository, INotification notification, IProdutoRepository produtoRepository)
        {
            _compraRepository = compraRepositorio;
            _compraProdutoRepository = compraProdutoRepository;
            _notification = notification;
            _produtoRepository = produtoRepository;
        }

        public int InserirCompra(Compra compra)
        {
            /* Inicia uma transação no banco, se qualquer coisa der errado
               durante a inserção da compra, um rollback será realizado e 
               o processo será inteiro "desconsiderado", caso dê certo o 
               método commit será chamado e a transação será finalizada. */
            _compraRepository.BeginTransaction();
            try
            {
                int valor;
                var result = _compraRepository.InserirCompra(compra, out valor);
                if (result == -1)
                {
                    _compraRepository.RollBackTransaction();
                    _notification.Add("Falha ao inserir compra");
                    return 0;
                }

                /* Após inserir os dados da compra, item a item dessa mesma compra
                   é inserido no banco, se algum deles exceder o estoque, o rollback
                   é realizado. */
                foreach (var item in compra.Itens)
                {
                    if (item.QtdeCompra <= 0)
                    {
                        _notification.Add("Quantidade do produto nao pode ser zero ou menor");
                        return 0;
                    }

                    VerificaEstoque(item);
                    if (_notification.HasNotification())
                    {
                        _compraRepository.RollBackTransaction();
                        return 0;
                    }

                    item.IdCompra = valor;
                    _compraProdutoRepository.InserirCompraProduto(item);
                }

                _compraRepository.CommitTransaction();
                return valor;
            }
            catch (Exception e)
            {
                // Em caso de exception(erro) o roolback é realizado
                _compraRepository.RollBackTransaction();
                _notification.Add("Erro ao inserir compra " + e.Message);
                return 0;
            }
        }

        // Método que verifica a quantidade disponível do item no banco 
        private void VerificaEstoque(CompraProduto.CompraProduto item)
        {
            var consulta = _produtoRepository.SelecionarDadosProduto(item.Produto.IdProduto);
            var estoque = consulta.QtdeProduto;
            if (item.QtdeCompra > estoque)
                _notification.Add($"Quantidade de {consulta.NomeProduto} indisponível no estoque!");
        }
    }
}
