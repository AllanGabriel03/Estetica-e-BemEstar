using System.ComponentModel.DataAnnotations;

namespace AplicacaoBackAula.DTO
{
    public class PessoaDTO
    {
        public int IdPessoa { get; set; }

        [Required(ErrorMessage = "Informe o nome.")]
        [StringLength(100, MinimumLength = 3, ErrorMessage = "O nome deve ter entre 3 e 100 caracteres.")]
        public string? Nome { get; set; }

        [Required(ErrorMessage = "Informe o CPF.")]
        [RegularExpression(@"^\d{11}$", ErrorMessage = "O CPF deve ter 11 numeros.")]
        public string? CPF { get; set; }

        [Required(ErrorMessage = "Informe a data de nascimento.")]
        public DateOnly DataNascimento { get; set; }

        [Required(ErrorMessage = "Informe o sexo.")]
        [RegularExpression("^[MFmf]$", ErrorMessage = "Sexo deve ser M ou F.")]
        public string? sexo { get; set; }

        [Required(ErrorMessage = "Informe o e-mail.")]
        [EmailAddress(ErrorMessage = "Informe um e-mail valido.")]
        [StringLength(100)]
        public string? email { get; set; }

        [Required(ErrorMessage = "Informe o telefone.")]
        [Range(1000000000, 99999999999, ErrorMessage = "Telefone deve ter DDD + numero.")]
        public long telefone { get; set; }

        [Required(ErrorMessage = "Informe a situacao.")]
        [RegularExpression("^[SN]$", ErrorMessage = "Situacao deve ser S ou N.")]
        public string? AtivoPessoa { get; set; }

        public List<EnderecoDTO> Enderecos { get; set; } = new();
    }
}
