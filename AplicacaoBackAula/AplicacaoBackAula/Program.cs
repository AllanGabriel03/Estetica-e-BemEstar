using System.Text.Json.Serialization;
using AplicacaoBackAula.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services
    .AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles;
    })
    .ConfigureApiBehaviorOptions(options =>
    {
        options.InvalidModelStateResponseFactory = context =>
        {
            var erros = context.ModelState
                .Where(item => item.Value?.Errors.Count > 0)
                .SelectMany(item => item.Value!.Errors)
                .Select(erro => erro.ErrorMessage)
                .Where(mensagem => !string.IsNullOrWhiteSpace(mensagem))
                .ToList();

            return new BadRequestObjectResult(new
            {
                mensagem = erros.FirstOrDefault() ?? "Dados invalidos.",
                erros
            });
        };
    });

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddDbContext<BdAulaBackendContext>(options =>
    options.UseMySql(
        builder.Configuration.GetConnectionString("connection"),
        ServerVersion.AutoDetect(builder.Configuration.GetConnectionString("connection"))
    )
);

var app = builder.Build();

app.UseCors(o => o.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());

app.UseSwagger();
app.UseSwaggerUI();

app.UseAuthorization();

app.MapControllers();

app.Run();
