# Golburger game

O projeto se divide em 2 partes: Software e Hardware

## Software

### Framework

O jogo é desenvolvido em uma framework chamada LÖVE2D (que eu vou me referir somente como löve). Löve é uma framework para a linguagem LUA com foco na criação de jogos 2D com extensa documentação e comunidade. LUA é uma linguagem simples e multiplataforma, fazendo com que löve funcione em vários sistemas operacionais (Linux, Windows, OSX) e arquiteturas (x86, amd64, arm, etc). Além disso é possível exportar o jogo para a maioria dos formatos de distribuição: Aplicativos para Android e iOS, executáveis para Windows, OSX e Linux.

Para mais informação sobre a framework visite o site https://love2d.org/
O código fonte da framework pode ser encontrado no link https://bitbucket.org/rude/love
Para completa documentação visite a wiki https://love2d.org/wiki/Main_Page

### O jogo

O código do jogo está hospedado em https://github.com/murilopolese/golburguer
A estrutura do código é simples e tão minimalista quanto possível:

- `main.lua`:
Arquivo principal do jogo. Inicializa variáveis, define propriedades da janela do jogo, inclui arquivos e define os loops principais de `update` e `draw`.

- `_gfx.lua`:
Carrega todos os elementos gráficos do jogo (imagens e tipografia) e armazena em variáveis.

- `_events.lua`:
Administra todos os eventos que vem do hardware (teclado, joystick e gamepad) e executa os métodos apropriados de acordo com o estado do jogo.

- `/gfx`:
Pasta com todos os gráficos a serem carregados pelo jogo

- `/lib`:
Pasta com bibliotecas e ferramentas

- `/game_states`:
Cada estado do jogo possui um arquivo separado que define um objeto com nome do estado (por exemplo game, menu ou gameover) e implementa os métodos `load`, `update`, `events` e demais métodos específicos de cada estado.

### Como rodar o jogo?

Baixe a última versão do jogo em https://github.com/murilopolese/golburguer/archive/master.zip e descompacte o arquivo em seu computador. Cada sistema operacional possui uma forma de executar o jogo para desenvolvimento.
A documentação de como executar o jogo está em https://love2d.org/wiki/Getting_Started

### Como criar um executável do jogo?

https://love2d.org/wiki/Game_Distribution


## Hardware

O hardware escolhido para hospedar e rodar o jogo foi o Raspberry Pi 2.
Mais informação sobre este hardware pode ser encontrado em https://www.raspberrypi.org/products/raspberry-pi-2-model-b/

O sistema operacional instalado no Raspberry Pi é o PiLove, uma distribuição linux baseada em Raspian (que é baseada no Debian) e otimizada para rodar jogos feitos em löve.
Mais informações sobre PiLove em http://pilove.mitako.eu/

O jogo está esperando encontrar um controle USB conectado ao hardware.
Para mais informações sobre essa implementação, confira o arquivo `_events.lua` no código fonte do jogo: https://github.com/murilopolese/golburguer/blob/master/_events.lua

### Como eu faço para configurar o Raspberry Pi do zero?

Se algo terrível acontecer com o Raspberry Pi ou houver a necessidade de replicar a instalação, siga os passos:

1. Baixe a imagem do PiLove no site http://pilove.mitako.eu/
2. Instale o PiLove em um cartão SD compatível com o Raspberry Pi escolhido: https://www.raspberrypi.org/documentation/installation/installing-images/
3. Tranfira o código fonte do jogo ou executável para o PiLove através de rede ou pelo cartão SD (leia o FAQ do http://pilove.mitako.eu/ e lembre-se: google é seu amigo)
4. Modifique o arquivo `/etc/rc.local` para executar o código fonte ou executável que foi transferido para o PiLove. Isso vai fazer com que o jogo seja iniciado ao ligar o Raspberry Pi.
