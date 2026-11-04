import { Component } from '@angular/core';
import { CurrencyPipe, DatePipe } from '@angular/common';
import { Atendimento } from '../../models/atendimento'; // ajuste o caminho para onde estão seus models

@Component({
  selector: 'app-meus-pedidos',
  standalone: true,
  imports: [CurrencyPipe, DatePipe],
  templateUrl: './meus-pedidos.html',
  styleUrl: './meus-pedidos.css'
})
export class MeusPedidos {

  // Dados de exemplo, só para ilustrar. Depois vêm da API.
  pedidos: Atendimento[] = [
    {
      idAtendimento: 1,
      idPessoa: 1,
      nomePessoa: 'Ashley Vitoria',
      dataAtendimento: '2026-10-29',
      statusAtendimento: 'Concluído',
      itens: [
        { idAtendimento: 1, idItem: 10, item: 'Limpeza de pele', idFuncionario: 3, nomeFuncionario: 'Carla Souza', cargo: 'Esteticista', quantidade: 1, valorUnitario: 120 },
        { idAtendimento: 1, idItem: 11, item: 'Hidratante facial', idFuncionario: 3, nomeFuncionario: 'Carla Souza', cargo: 'Esteticista', quantidade: 2, valorUnitario: 45.9 }
      ]
    },
    {
      idAtendimento: 2,
      idPessoa: 1,
      nomePessoa: 'Ashley Vitoria',
      dataAtendimento: '2026-11-05',
      statusAtendimento: 'Agendado',
      itens: [
        { idAtendimento: 2, idItem: 12, item: 'Massagem relaxante', idFuncionario: 4, nomeFuncionario: 'Paulo Lima', cargo: 'Massoterapeuta', quantidade: 1, valorUnitario: 150 }
      ]
    }
  ];

  total(pedido: Atendimento): number {
    return pedido.itens.reduce((soma, i) => soma + i.quantidade * i.valorUnitario, 0);
  }

  statusClasse(status: string): string {
    return status.toLowerCase().replace(/[^a-z]/g, '');
  }
}