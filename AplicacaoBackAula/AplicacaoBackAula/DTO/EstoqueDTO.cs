namespace AplicacaoBackAula.DTO
{
    public class EstoqueDTO
    {
        public int IdItem { get; set; }
        public string Item { get; set; } = string.Empty;
        public string DescricaoItem { get; set; } = string.Empty;
        public string Categoria { get; set; } = string.Empty;
        public string Unidade { get; set; } = string.Empty;
        public decimal Preco { get; set; }
        public decimal PrecoVenda { get; set; }
        public int QuantidadeEstoque { get; set; }
        public string Ativo { get; set; } = string.Empty;
    }
}
