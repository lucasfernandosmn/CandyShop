﻿using CandyShop.Core;
using CandyShop.Core.Infra;
using CandyShop.Core.Services._Interfaces;
using CandyShop.Core.Services.Produto;
using CandyShop.Core.Services.Usuario;
using CandyShop.Repository;
using SimpleInjector;
using SimpleInjector.Lifestyles;

namespace CandyShop.WebAPI
{
    public class SimpleInjectorContainer
    {
        public static Container Build()
        {
            var container = new Container();
            container.Options.DefaultScopedLifestyle = new AsyncScopedLifestyle();
            container.Register<INotification, Notification>(Lifestyle.Scoped);
            container.Register<IUsuarioRepository, UsuarioRepository>();
            container.Register<IUsuarioService, UsuarioService>();
            container.Register<IProdutoService, ProdutoService>();
            container.Register<IPagamentoRepository, PagamentoRepository>();
            container.Register<IProdutoRepository, ProdutoRepository>();
            container.Register<ICompraRepository, CompraRepository>();
           
            container.Verify();
            return container;
        }
    }
}