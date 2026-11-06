using System.ComponentModel.DataAnnotations;

namespace AplicacaoBackAula.DTO
{
    public class LoginDTO
    {
        [Required(ErrorMessage = "Informe o CPF.")]
        [RegularExpression(@"^\d{11}$", ErrorMessage = "O CPF deve ter 11 numeros.")]
        public string Cpf { get; set; } = string.Empty;
    }
}
