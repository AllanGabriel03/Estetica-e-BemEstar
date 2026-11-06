using System.ComponentModel.DataAnnotations;

namespace AplicacaoBackAula.DTO
{
    public class EntradaProdutoAddDTO
    {
        [Required(ErrorMessage = "Selecione o produto.")]
        [Range(1, int.MaxValue, ErrorMessage = "Selecione o produto.")]
        public int IdItem { get; set; }

        [Required(ErrorMessage = "Informe a quantidade.")]
        [Range(1, int.MaxValue, ErrorMessage = "A quantidade deve ser maior que zero.")]
        public int Quantidade { get; set; }

        [Required(ErrorMessage = "Informe o valor unitario.")]
        [Range(0.01, 999999.99, ErrorMessage = "Informe um valor unitario valido.")]
        public decimal ValorUnitario { get; set; }

        public DateOnly? DataEntrada { get; set; }

        [StringLength(10, ErrorMessage = "A unidade deve ter no maximo 10 caracteres.")]
        public string? Unidade { get; set; }
    }

    public class EntradaProdutoDTO
    {
        public int IdEntrada { get; set; }
        public int IdItem { get; set; }
        public string Item { get; set; } = string.Empty;
        public DateOnly DataEntrada { get; set; }
        public int Quantidade { get; set; }
        public string Unidade { get; set; } = string.Empty;
        public decimal ValorUnitario { get; set; }
    }
}
