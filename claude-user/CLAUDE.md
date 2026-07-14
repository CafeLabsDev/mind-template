# Instruções globais (nível usuário)

## Princípio: o Mind é a única fonte, não um sistema de memória interno paralelo

O Mind é literalmente a mente do usuário: tudo que é durável — conhecimento, contexto de projetos, e também **regras de como ele quer que o Claude trabalhe** (convenções de git, formato de resposta, o que evitar, o que repetir) — mora aqui, versionado e editável por ele. Nunca guarde esse tipo de informação só num sistema de memória interno do Claude Code (não versionado, não visível/editável pelo usuário) quando ela deveria estar no Mind — isso recria em paralelo o mesmo problema que o Mind existe pra resolver: o usuário ter que reexplicar as coisas porque ficaram presas num lugar que ele não enxerga. Se alguma informação já vive só na memória interna e devia estar aqui, mova pra cá.

## Captura para o Mind

Em qualquer conversa, em qualquer projeto ativo, preste atenção a informações do usuário que pareçam duráveis e que não sejam específicas do código do projeto atual: fatos sobre vida pessoal, decisões/contexto de outros projetos ("preciso lembrar de mudar X no projeto Y"), conhecimento que ele explicou, preferências, planos, e **regras de como ele quer que o Claude trabalhe** (ex.: convenções de commit, forma de responder).

Quando identificar algo assim que pareça valer a pena guardar:

1. Pergunte ao usuário se ele quer salvar isso no Mind — nunca salve sem confirmar antes.
2. Se ele confirmar, use a Skill `mind` para decidir onde e como escrever (edita um nó existente ou cria um novo, e atualiza o índice).

Não interromper a conversa por qualquer detalhe pequeno — só ofereça quando parecer que realmente vale a pena persistir. Isso vale mesmo estando em outro projeto ativo: o Mind não depende de estar como projeto ativo pra receber uma atualização.

## Time de agentes de desenvolvimento (opcional, fora do Mind)

O Mind organiza conhecimento pessoal — não é uma ferramenta de desenvolvimento de software. Se em qualquer conversa o usuário indicar que quer começar a desenvolver algo (uma ideia de produto, um MVP, um app novo) e o time de agentes do [Café Labs Forge](https://github.com/CafeLabsDev/forge) (padrão orquestrador + especialistas) ainda não estiver configurado nesta máquina (checar `~/.claude/agents/`), pode mencionar essa opção — sem insistir, só como algo disponível caso ajude. Não é pré-requisito de nada aqui, e a maioria de quem só quer organizar conhecimento pessoal nunca vai precisar dele. Detalhes em `docs/ARQUITETURA.md`, seção 9.

## Regras de trabalho

_Conforme forem surgindo preferências de como você quer que o Claude trabalhe (convenções de commit, formato de resposta, o que evitar/repetir), registre-as aqui, uma por bullet, no formato "regra + motivo" — sem narrar a conversa em que surgiram, só o que ficou decidido e por quê. As regras abaixo são um ponto de partida sensato, não fixo — edite ou apague o que não fizer sentido pro seu jeito de trabalhar._

- **Commits do git**: ao commitar um conjunto de mudanças a pedido do usuário, prefira vários commits menores por mudança lógica/coesa, em vez de um único commit que engloba tudo — mas sem fragmentar a ponto de um commit por edição trivial. Critério: "isso representa uma decisão/propósito coeso", não "um arquivo por commit".
- **Grafo de dependências entre projetos**: ao terminar uma mudança de feature/produto num projeto que tem nó em `projetos/` (ou pasta equivalente do seu vault), checar se esse nó tem uma seção "Consumido por" e, se tiver, avisar proativamente o usuário quais outros lugares (landing, portfólio, etc.) provavelmente precisam de atualização por causa da mudança. Nunca editar esses lugares dependentes sozinho sem confirmação — costumam ser conteúdo público-facing, então o usuário decide se e quando propagar. Motivo: manter um "sistema de teias conectadas" entre projetos, mas via aviso proativo + confirmação, nunca via automação silenciosa.
- **Listar tarefas pendentes inclui repos com commits/pushes pendentes**: sempre que o usuário pedir a lista de tarefas/pendências, além do checklist do Mind (`tarefas/pessoal.md`, `tarefas/empresa.md`), rodar `scripts/status-all.sh` (varre todos os repos conhecidos de uma vez — preencha o array `REPOS` do script com os que você acompanha) e informar quais têm mudanças não commitadas ou commits locais ainda não enviados ao remoto. Se um repo novo for criado, adicionar ele no array. Motivo: "pendente" inclui não só o que falta fazer, mas também trabalho já feito localmente que ainda não está persistido/compartilhado.
