import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { Menu } from '../../menu/menu';

@Component({
  selector: 'app-loja-layout',
  imports: [RouterOutlet, Menu],
  templateUrl: './loja-layout.html',
  styleUrl: './loja-layout.css',
})
export class LojaLayout {}
