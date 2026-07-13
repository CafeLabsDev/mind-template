# Mind — template

Base de conhecimento pessoal organizada como uma árvore de Markdown, feita pra ser editada visualmente num editor tipo [Obsidian](https://obsidian.md) e consultada sob demanda pelo [Claude Code](https://claude.com/claude-code).

Este repositório é a **versão crua/template**: só a engenharia (Skill, gatilho de captura, script de symlink, docs de arquitetura), sem nenhum conteúdo pessoal. Clone, personalize e comece a preencher com seus próprios nós.

Funciona sozinho, só com Claude Code + um editor de Markdown. Acesso por voz é um extra opcional — ver [Integração por voz](#integração-por-voz-opcional) mais abaixo.

A arquitetura completa (por que cada decisão foi tomada, o que ainda falta) está em [docs/ARQUITETURA.md](docs/ARQUITETURA.md). Este README é só o "como usar".

## O que tem aqui

- **`MIND.md`**: índice raiz, começa vazio. Não existe uma árvore de pastas fixa pré-criada — os nós (e as pastas que fizerem sentido pra organizá-los) vão nascendo aos poucos, conforme as conversas.
- **`.claude/`**: Skill e permissões que só valem quando este projeto está ativo.
- **`claude-user/`**: o "armazém" da Skill, Subagentes e instrução de **nível usuário** — funcionam em qualquer projeto ativo, não só neste. Ficam aqui (versionados neste repo) e são espelhados em `~/.claude/` via symlink (ver abaixo).
- **`scripts/setup-symlinks.sh`**: recria os symlinks de `claude-user/` em `~/.claude/`.

## Setup numa máquina nova

```bash
git clone <url-deste-repo> mind
cd mind
./scripts/setup-symlinks.sh
```

Pode clonar com o nome que quiser e em qualquer caminho — não há exigência de local fixo, a menos que você use uma integração por voz (ver seção abaixo).

Rodar o script de novo é seguro a qualquer momento (idempotente) — necessário só quando uma Skill/Subagente novo for adicionado em `claude-user/`.

## Como a captura de conhecimento funciona

Durante qualquer conversa com o Claude Code, em qualquer projeto, se algo parecer um fato/decisão/preferência pessoal que valha a pena guardar, o Claude pergunta antes de salvar. Se confirmado, ele mesmo edita o nó certo (ou cria um novo) e atualiza o índice em `MIND.md`. A lógica completa está em `claude-user/CLAUDE.md` (gatilho) e `claude-user/skills/mind/SKILL.md` (procedimento).

Nada é salvo sem confirmação — e nada impede edição manual direta a qualquer momento; o Claude só lê o estado atual dos arquivos quando consultado.

## Integração por voz (opcional)

É possível plugar um assistente de voz externo que resolve "projeto ativo" por voz e roda o Claude Code apontado pra ele. É totalmente opcional — sem isso, o Mind funciona normalmente só com Claude Code no teclado. Detalhes do padrão geral estão em `docs/ARQUITETURA.md`, seção 8.

## Repositório privado depois de preenchido

Assim que você começar a adicionar nós de conhecimento com informação pessoal, mantenha o repositório privado. Toda a "engenharia" deste template (Skill, script de symlink, estrutura, este README, `docs/ARQUITETURA.md`) é genérica e pode continuar pública/compartilhável — o que precisa ficar privado é só o conteúdo que você for criando.
