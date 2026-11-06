namespace AplicacaoBackAula.DTO
{
    public class ItemDTO
    {
        public int IdItem { get; set; }
        public int IdCategoria { get; set; }
        public string? Categoria { get; set; }
        public string? Item { get; set; }
        public string? DescricaoItem { get; set; }
        public decimal? Preco { get; set; }
        public string? TipoItem { get; set; }
        public string? AtivoProdutoServico { get; set; }
        public int? CodigoPreco { get; set; }
        public decimal? PrecoVenda { get; set; }
        public string? Unidade { get; set; }
        public int QuantidadeEstoque { get; set; }
    }
}
