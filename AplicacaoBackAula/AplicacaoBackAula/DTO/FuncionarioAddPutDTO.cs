using System.ComponentModel.DataAnnotations;

namespace AplicacaoBackAula.DTO
{
    public class FuncionarioAddPutDTO
    {
        [Required(ErrorMessage = "Informe o nome.")]
        [StringLength(100, MinimumLength = 3, ErrorMessage = "O nome deve ter entre 3 e 100 caracteres.")]
        public string? Nome { get; set; }

        [Required(ErrorMessage = "Informe o CPF.")]
        [RegularExpression(@"^\d{11}$", ErrorMessage = "O CPF deve ter 11 numeros.")]
        public string? Cpf { get; set; }

        [Required(ErrorMessage = "Informe a data de nascimento.")]
        public DateOnly DataNascimento { get; set; }

        [Required(ErrorMessage = "Informe o sexo.")]
        [RegularExpression("^[MFmf]$", ErrorMessage = "Sexo deve ser M ou F.")]
        public string? Sexo { get; set; }

        [Required(ErrorMessage = "Informe o e-mail.")]
        [EmailAddress(ErrorMessage = "Informe um e-mail valido.")]
        [StringLength(100)]
        public string? Email { get; set; }

        [Required(ErrorMessage = "Informe o telefone.")]
        [Range(1000000000, 99999999999, ErrorMessage = "Telefone deve ter DDD + numero.")]
        public long Telefone { get; set; }

        [Required(ErrorMessage = "Informe o cargo.")]
        [StringLength(20, ErrorMessage = "O cargo deve ter no maximo 20 caracteres.")]
        public string? Cargo { get; set; }

        [Required(ErrorMessage = "Informe a data de admissao.")]
        public DateOnly DataAdmissao { get; set; }

        [RegularExpression("^[SN]$", ErrorMessage = "Situacao deve ser S ou N.")]
        public string AtivoPessoa { get; set; } = "S";
    }
}
