﻿namespace CandyShop.Core.Services.Usuario.Dto
{
    public class UsuarioDto
    {
        public string Cpf { get; set; }
        public string NomeUsuario { get; set; }
        public string SenhaUsuario { get; set; }
        public decimal SaldoUsuario { get; set; }
        public string Ativo { get; set; }

        public bool IsValid(INotification notification)
        {
            if (!ValidaCpf(Cpf))
                notification.Add("Cpf Invalido");
            if (string.IsNullOrEmpty(NomeUsuario.Trim()) || NomeUsuario.Length > 50)
                notification.Add("Nome do Usuario invalido ");
            if (string.IsNullOrEmpty(SenhaUsuario.Trim()) || SenhaUsuario.Length > 12)
                notification.Add("Senha invalida");
            if (string.IsNullOrEmpty(Ativo))
                notification.Add("Status do usuario nao pode ser nulo");                

            return !notification.HasNotification();
        }

        private bool ValidaCpf(string cpf)
        {
            var mt1 = new[] { 10, 9, 8, 7, 6, 5, 4, 3, 2 };
            var mt2 = new[] { 11, 10, 9, 8, 7, 6, 5, 4, 3, 2 };

            cpf = cpf.Trim();
            cpf = cpf.Replace(".", "").Replace("-", "");

            if (cpf.Length != 11)
                return false;

            var tempCpf = cpf.Substring(0, 9);
            var soma = 0;
            for (var i = 0; i < 9; i++)
                soma += int.Parse(tempCpf[i].ToString()) * mt1[i];

            var resto = soma % 11;
            if (resto < 2)
                resto = 0;
            else
                resto = 11 - resto;

            var digito = resto.ToString();
            tempCpf = tempCpf + digito;
            soma = 0;

            for (var i = 0; i < 10; i++)
                soma += int.Parse(tempCpf[i].ToString()) * mt2[i];

            resto = soma % 11;
            if (resto < 2)
                resto = 0;
            else
                resto = 11 - resto;

            digito = digito + resto;

            return cpf.EndsWith(digito);
        }
    }
}
