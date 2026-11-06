import { Endereco } from './endereco';

export interface Pessoa {
  idPessoa: number;
  nome: string;
  cpf: string;
  dataNascimento: string;
  sexo: string;
  email: string;
  telefone: number;
  ativoPessoa: string;
  enderecos?: Endereco[];
}
