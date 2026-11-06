using System.ComponentModel.DataAnnotations;

namespace AplicacaoBackAula.DTO
{
    public class AtualizarStatusDTO
    {
        [Required(ErrorMessage = "Informe a situacao do pedido.")]
        [RegularExpression(@"^(A|P|F|C|Aberto|Em processamento|Concluido|Concluído|Cancelado)$",
            ErrorMessage = "Situacao invalida.")]
        public string Status { get; set; } = string.Empty;
    }
}
