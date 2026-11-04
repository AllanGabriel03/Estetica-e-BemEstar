import { Routes } from '@angular/router';
import { Catalogo } from './loja/catalogo/catalogo';
import { Carrinho } from './loja/carrinho/carrinho';
import { CadastroCliente } from './loja/cadastro-cliente/cadastro-cliente';
import { MeusPedidos } from './loja/meus-pedidos/meus-pedidos';

export const routes: Routes = [
    {
        path:'',
        redirectTo: 'catalogo',
        pathMatch: 'full'
    },
    {
        path:'catalogo',
        component: Catalogo
    },
    {
        path:'carrinho',
        component: Carrinho
    },
    {
        path:'cadastro',
        component: CadastroCliente
    },
    {
        path:'pedidos',
        component: MeusPedidos
    }
];
