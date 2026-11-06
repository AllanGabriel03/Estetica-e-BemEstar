namespace AplicacaoBackAula.DTO
{
    public class FuncionarioDTO
    {
        public int IdPessoa { get; set; }
        public string Nome { get; set; } = string.Empty;
        public string Cpf { get; set; } = string.Empty;
        public DateOnly DataNascimento { get; set; }
        public string Sexo { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public long Telefone { get; set; }
        public string Cargo { get; set; } = string.Empty;
        public DateOnly DataAdmissao { get; set; }
        public string AtivoPessoa { get; set; } = string.Empty;
    }
}
