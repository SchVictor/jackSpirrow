# ⚓ Jack Espirrow

> Jogo de plataforma 2D com temática pirata, desenvolvido em **Godot 4.6** com GDScript.

---

## 📖 Sobre o Jogo

Jack Espirrow é um jogo de plataforma 2D em que você controla um pirata corajoso que precisa atravessar uma fase repleta de inimigos, espinhos e armadilhas. Colete moedas, destrua baús, elimine inimigos e chegue ao final da fase sem perder toda a sua vida.

**Gênero:** Plataforma 2D  
**Engine:** Godot 4.6  
**Linguagem:** GDScript  
**Status:** Em desenvolvimento

---

## 🎮 Como Jogar

### Controles

| Ação | Teclado |
|------|---------|
| Mover para a esquerda | `A` ou `←` |
| Mover para a direita | `D` ou `→` |
| Pular | `Espaço` ou `↑` ou `W` |
| Atacar | `Botão esquerdo do mouse` |

### Objetivo

- Chegue ao **fim da fase** sem morrer.
- **Colete moedas** pelo caminho — elas também saem dos baús quando você os destrói.
- Evite **espinhos**, **buracos** e os **inimigos** que patrulham a fase.
- Se cair no vazio, você morre instantaneamente.

### HUD (interface durante o jogo)

- **Canto superior esquerdo:** seus pontos de vida em corações (❤). Cada coração representa 1 ponto de vida. Quando todos ficarem pretos (🖤), você morre.
- **Canto superior direito:** contador de moedas (🪙) coletadas até o momento.

---

## 🚀 Como Executar o Jogo (passo a passo para iniciantes)

### O que você precisa instalar

**1. Baixe o Godot 4.6**

- Acesse: [https://godotengine.org/download](https://godotengine.org/download)
- Escolha a versão **Godot Engine 4.x** (não a versão .NET)
- Baixe o arquivo para o seu sistema operacional (Windows, macOS ou Linux)
- **Windows:** baixe o `.exe`, salve em uma pasta e execute — não precisa instalar
- **macOS:** baixe o `.dmg`, arraste para Aplicativos e abra normalmente
- **Linux:** baixe o arquivo, dê permissão de execução (`chmod +x Godot_*`) e execute

**2. Baixe o projeto**

- Faça o download do arquivo `.zip` do projeto
- Extraia o conteúdo em uma pasta de sua escolha (ex: `Documentos/jack-espirrow`)

### Abrindo o projeto no Godot

1. Abra o Godot Engine
2. Na tela inicial (Project Manager), clique em **Import**
3. Clique em **Browse** e navegue até a pasta onde você extraiu o projeto
4. Selecione o arquivo `project.godot` dentro da pasta `jack-espirrow`
5. Clique em **Import & Edit**
6. O projeto vai abrir no editor do Godot

### Rodando o jogo

- Com o projeto aberto, pressione **F5** no teclado, ou clique no botão ▶ (triângulo de play) no canto superior direito do editor
- O jogo vai abrir em uma janela separada
- Para fechar o jogo, feche a janela ou pressione **Alt + F4** (Windows) / **Cmd + Q** (macOS)

---

## 📁 Estrutura do Projeto

```
jack-espirrow/
├── project.godot          ← arquivo principal do projeto (abra este no Godot)
├── Scripts/               ← todos os scripts GDScript do jogo
│   ├── game_manager.gd    ← singleton global: controla vida, moedas e transições
│   ├── player.gd          ← lógica do personagem jogável
│   ├── inimigo.gd         ← inteligência artificial dos inimigos
│   ├── moeda.gd           ← comportamento das moedas coletáveis
│   ├── bau.gd             ← baú destrutível que solta moedas
│   ├── spike.gd           ← espinhos que matam ao tocar
│   ├── void_killer.gd     ← zona invisível no fundo que mata ao cair
│   ├── hud.gd             ← interface de vida e moedas durante o jogo
│   ├── menu.gd            ← menu principal
│   ├── game_over.gd       ← tela de game over
│   └── vitoria.gd         ← tela de vitória
├── Cenas/                 ← todas as cenas (.tscn) do jogo
│   ├── fase.tscn          ← cena principal de gameplay
│   ├── menu.tscn          ← tela inicial
│   ├── game_over.tscn     ← tela de derrota
│   ├── vitoria.tscn       ← tela de vitória
│   ├── hud.tscn           ← HUD instanciada dentro da fase
│   ├── player.tscn        ← personagem jogável
│   ├── inimigo.tscn       ← inimigo pirata/mercador
│   ├── moeda.tscn         ← moeda coletável
│   ├── bau.tscn           ← baú destrutível
│   ├── spike.tscn         ← espinho
│   ├── void_killer.tscn   ← área de morte por queda
│   └── Decoração/         ← cenas decorativas (palmeiras, bandeiras, parallax)
└── Assets/                ← imagens, sprites e recursos visuais
    ├── Palm Tree Island/  ← backgrounds de céu, mar e água
    ├── Wood and Paper UI/ ← texturas de interface (madeira, papel, botões)
    └── ...                ← sprites do personagem, inimigos, tiles, etc.
```

---

## ⚙️ Configuração do Autoload (necessária uma única vez)

O `GameManager` é um singleton que precisa estar registrado no Godot para funcionar. Se o jogo apresentar erros relacionados a `GameManager`, faça:

1. No Godot, vá em **Project → Project Settings**
2. Clique na aba **Autoload** (no topo)
3. No campo **Path**, clique em **Browse** e selecione `res://Scripts/game_manager.gd`
4. No campo **Name**, escreva exatamente: `GameManager`
5. Clique em **Add**
6. Confirme que aparece na lista e feche as configurações

---

## 🗺️ Fluxo de Cenas

```
menu.tscn
    │
    └── [Botão JOGAR] ──→ fase.tscn
                              │
                    ┌─────────┴──────────┐
                    │                    │
              [player morre]    [chega ao fim da fase]
                    │                    │
             game_over.tscn       vitoria.tscn
                    │                    │
          [Reiniciar / Menu]   [Jogar Novamente / Menu]
                    │                    │
                    └────────┬───────────┘
                             │
                         menu.tscn
```

---

## 🧩 Mecânicas do Jogo

### Personagem (Player)
- **Vida:** 10 pontos de vida. Cada dano recebido reduz a barra. Ao chegar a zero, a animação de morte toca e o jogo reinicia automaticamente após ~1 segundo.
- **Ataque:** clique com o mouse para atacar. Acerta inimigos e baús no raio de alcance.
- **Movimentação:** corre e pula normalmente. Cair no vazio é morte instantânea.

### Inimigos
- Patrulham a fase automaticamente, virando ao chegar na borda da plataforma.
- Ao detectar o player por contato, param e atacam repetidamente.
- Podem ser eliminados com ataques do player. Ao morrer, as colisões são desativadas para não causar dano pós-morte.

### Moedas e Baús
- Moedas estão espalhadas pela fase e são coletadas ao tocar.
- Baús podem ser destruídos com ataque, soltando moedas no cenário.
- O total de moedas coletadas aparece na tela de vitória.

### Espinhos e Void
- **Espinhos:** causam dano ao tocar.
- **Void (fundo do mapa):** uma área invisível abaixo do mapa mata o player instantaneamente ao cair.

---

## 🐛 Problemas Conhecidos e Soluções

| Problema | Solução |
|----------|---------|
| Erro `GameManager not found` | Verifique se o Autoload está configurado conforme a seção acima |
| Erro `Node not found: CoracaoContainer` | Certifique-se que `hud.tscn` está instanciado dentro de `fase.tscn` |
| Tela preta ao iniciar | Verifique em *Project → Project Settings → Application → Run → Main Scene* se aponta para `res://Cenas/menu.tscn` |
| UID duplicado ao importar cenas | Clique com botão direito no arquivo no FileSystem → *Reimport* |
| Inimigo causando dano após morrer | Atualize `inimigo.gd` para a versão mais recente que desativa colisões em `die()` |

---

## 👨‍💻 Informações Técnicas

| Item | Detalhe |
|------|---------|
| Engine | Godot 4.6 |
| Linguagem | GDScript |
| Tipo de jogo | Plataforma 2D |
| Física | CharacterBody2D com `move_and_slide()` |
| Gerenciamento de estado | Singleton (Autoload) via `GameManager` |
| Comunicação entre cenas | Sinais (`signal`) do GameManager |
| Cena inicial | `res://Cenas/menu.tscn` |

---

## 📜 Licença

Projeto desenvolvido para fins educacionais. Os assets visuais utilizados (Palm Tree Island, Wood and Paper UI, sprites de personagens) são de terceiros e possuem suas próprias licenças — verifique os termos antes de redistribuir.

---

*Feito com ❤️ e Godot 4.6*
