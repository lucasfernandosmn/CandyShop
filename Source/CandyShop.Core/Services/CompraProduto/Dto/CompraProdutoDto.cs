﻿using CandyShop.Core.Services.Produto.Dto;

namespace CandyShop.Core.CompraProduto.Dto
{
    public class CompraProdutoDto
    {
        public int IdCompra { get; set; }
        public ProdutoDto Produto { get; set; }
        public int QtdeCompra { get; set; }
    }
}
