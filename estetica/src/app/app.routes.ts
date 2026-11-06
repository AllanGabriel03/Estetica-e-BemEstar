import { Routes } from '@angular/router';
import { Catalogo } from './loja/catalogo/catalogo';
import { Carrinho } from './loja/carrinho/carrinho';
import { CadastroCliente } from './loja/cadastro-cliente/cadastro-cliente';
import { MeusPedidos } from './loja/meus-pedidos/meus-pedidos';
import { Login } from './login/login';
import { LojaLayout } from './layout/loja-layout/loja-layout';
import { AdminLayout } from './administrativo/layout/admin-layout/admin-layout';
import { Dashboard } from './administrativo/dashboard/dashboard';
import { Clientes } from './administrativo/clientes/clientes';
import { ClienteEdicao } from './administrativo/clientes/cliente-edicao';
import { Funcionarios } from './administrativo/funcionarios/funcionarios';
import { Produtos } from './administrativo/produtos/produtos';
import { Servicos } from './administrativo/servicos/servicos';
import { Categorias } from './administrativo/categorias/categorias';
import { Pedidos } from './administrativo/pedidos/pedidos';
import { PedidoDetalhe } from './administrativo/pedidos/pedido-detalhe';
import { Estoque } from './administrativo/estoque/estoque';
import { clienteGuard } from './guards/cliente-guard';

export const routes: Routes = [
  {
    path: '',
    component: LojaLayout,
    children: [
      { path: '', redirectTo: 'catalogo', pathMatch: 'full' },
      {
        path: 'catalogo',
        component: Catalogo,
        data: { tipo: 'P', titulo: 'Produtos' }
      },
      {
        path: 'servicos',
        component: Catalogo,
        data: { tipo: 'S', titulo: 'Serviços' }
      },
      { path: 'carrinho', component: Carrinho },
      { path: 'cadastro', component: CadastroCliente },
      { path: 'login', component: Login },
      { path: 'pedidos', component: MeusPedidos, canActivate: [clienteGuard] }
    ]
  },
  {
    path: 'admin',
    component: AdminLayout,
    children: [
      { path: '', component: Dashboard },
      { path: 'clientes', component: Clientes },
      { path: 'clientes/:id', component: ClienteEdicao },
      { path: 'funcionarios', component: Funcionarios },
      { path: 'produtos', component: Produtos },
      { path: 'servicos', component: Servicos },
      { path: 'categorias', component: Categorias },
      { path: 'pedidos', component: Pedidos },
      { path: 'pedidos/:id', component: PedidoDetalhe },
      { path: 'estoque', component: Estoque }
    ]
  },
  { path: 'clientes', redirectTo: 'admin/clientes' },
  { path: 'funcionarios', redirectTo: 'admin/funcionarios' },
  { path: 'estoque', redirectTo: 'admin/estoque' },
  { path: '**', redirectTo: 'catalogo' }
];
