---
name: mind
description: Use isto para (1) consultar a base de conhecimento pessoal do usuário — vida pessoal, hobbies, conhecimentos, contexto de projetos — ou (2) quando o usuário confirmar que quer salvar algo novo no Mind: decidir se edita um nó existente ou cria um nó novo, e manter o índice atualizado.
---

# Mind — base de conhecimento pessoal do usuário

O vault vive na raiz deste repositório. Índice raiz: `MIND.md` (só links + 1 linha de descrição cada, sem conteúdo pesado). Estrutura completa e decisões de arquitetura: `docs/ARQUITETURA.md`.

## Modo leitura (consulta sob demanda)

1. Leia `MIND.md`.
2. Identifique o(s) nó(s) relevante(s) pra pergunta feita.
3. Leia só esses arquivos — nunca a árvore inteira.
4. Ao ler qualquer índice (o `MIND.md` raiz ou o índice de uma subpasta), aplique também a **regra de reagrupamento** abaixo — é uma checagem barata, o índice já foi lido de qualquer forma pra achar o nó certo.

## Modo captura (escrita — só depois de confirmação do usuário)

Acionado pelo gatilho em `~/.claude/CLAUDE.md` quando o usuário já confirmou que quer salvar algo.

1. Leia `MIND.md` pra ver os nós existentes.
2. **Checar duplicação antes de criar novo**: `MIND.md` pode estar desatualizado, ou a informação pode já estar mencionada de passagem em outro nó. Faça um `Grep` por palavras-chave relacionadas no vault inteiro antes de concluir que "não cabe em nada" — evita criar dois nós cobrindo a mesma coisa.
3. Decida: a informação cabe em um nó existente, ou merece um nó novo?
   - **Cabe em existente** → abra o arquivo e edite a seção relevante (ou adicione uma seção/linha nova). Atualize o campo `atualizado` do frontmatter (ver abaixo).
   - **Não cabe** → crie o arquivo na pasta certa, ou uma pasta nova se nenhuma categoria existente couber, e adicione a entrada em `MIND.md` apontando pra ele.
4. Contexto sobre outro projeto (ex: "lembrar de atualizar X no projeto Y") vai num nó de projeto próprio — só a decisão/contexto de alto nível, sem duplicar documentação que já existe no repo daquele projeto (ver seção 3 do `ARQUITETURA.md`).
5. **Tasks/pendências só em `tarefas/`**: qualquer item acionável — algo que falta fazer, uma decisão pendente, um "falta X" — vai exclusivamente em `tarefas/pessoal.md` ou `tarefas/empresa.md`, nunca como lista solta dentro de outro nó (ex.: uma seção `## Pendências` dentro de um nó de projeto). Nós de projeto/conhecimento descrevem fatos (ex.: "Estado atual"), não mantêm sua própria lista de tarefas; se o estado atual menciona algo pendente, aponte pra `tarefas/` em vez de duplicar o item ali. Evita ter a mesma pendência desatualizada em dois lugares.
6. **Frontmatter mínimo em todo nó novo** (padrão Obsidian):
   ```yaml
   ---
   tags: [tag1, tag2]
   criado: AAAA-MM-DD
   atualizado: AAAA-MM-DD
   ---
   ```
   Tags livres, mas reaproveite as que já existirem em nós parecidos (checar via Grep) em vez de inventar sinônimo novo.
7. **Regra de tamanho/split (de cima pra baixo)**: se um nó passar de ~120-150 linhas ou claramente virar dois assuntos distintos, converta-o numa pasta com um índice próprio no mesmo padrão do `MIND.md` (ex.: `tema/tema.md` vira o índice, e os subtópicos viram `tema/subtopico-a.md`, `tema/subtopico-b.md`). Isso mantém os nós curtos o bastante pra funcionar bem também por voz, se houver essa integração (ver princípio orientador, seção 1 do `ARQUITETURA.md`).
8. **Regra de reagrupamento (de baixo pra cima)**: ao ler o índice de um nível (raiz ou subpasta), se dois ou mais nós/pastas daquele mesmo nível claramente compartilharem um tema mais amplo, ou se aquele nível já acumulou muitas entradas soltas sem estrutura (regra de bolso: ~6-8+), isso é sinal de que o "cérebro" está desorganizado e precisa de uma pasta intermediária nova.
   - **Nunca mova ou reorganize arquivos sozinho.** Pare e proponha ao usuário: quais nós agrupar, sob que nome de pasta nova, e por quê — antes ou depois de responder a pergunta original, mas sempre como proposta, não como ação já feita.
   - Se o usuário confirmar: crie a pasta nova com um índice próprio (mesmo padrão do `MIND.md`, um md explicando o que a pasta reúne), mova os nós existentes pra dentro dela, atualize o índice do nível acima pra apontar pro índice da pasta nova em vez dos nós individuais, e corrija todo link relativo afetado (links "Ver também" cruzados e qualquer referência que você tenha visto de fora apontando pro caminho antigo).
   - Essa checagem é sobre a estrutura (nomes/organização do índice), não sobre reler o conteúdo de cada nó — não vira desculpa pra carregar a árvore inteira.
9. **Links "Ver também"**: ao criar ou editar um nó, cheque se ele se relaciona com outro nó existente. Se sim, adicione um link cruzado nos dois arquivos (seção `## Ver também` no final, com link relativo). É isso que faz o vault funcionar como grafo, não como uma pilha de arquivos soltos. Dois critérios de higiene, pra manter os links úteis em vez de virarem ruído:
   - **Só linka relação real, não trivia genérica.** Compartilhar característica superficial ("mesmo padrão de stack", "mesma tecnologia", "mesmo tipo de projeto") não é motivo suficiente pra criar uma aresta entre dois nós — isso não ajuda quem está navegando a decidir se vale a pena abrir o outro arquivo. Se o fato for relevante, registre como prosa no nó mais geral que já cobre os dois, não como link entre os dois nós-irmãos.
   - **Não duplique o que já está em "Depende de"/"Consumido por".** Essas seções já são a aresta do grafo entre dois nós (uma metade em cada lado — quem depende linka em "Depende de", quem é consumido aparece em "Consumido por" no outro). Repetir o mesmo link de novo em "Ver também" é redundante; só adicione ali uma relação **diferente** da já coberta.
10. Escreva pensando nas duas pontas de uso (ver princípio orientador na seção 1 do `ARQUITETURA.md`): nós concisos, bem fatiados, que funcionem tanto pra leitura num editor de Markdown quanto pra consulta sob demanda por voz, se houver essa integração. Evite parágrafos longos.
11. **Nunca dar `git add`/`commit`** como parte da captura, nem mesmo ao reagrupar pastas — a skill só edita arquivos no working tree; commitar é sempre decisão manual do usuário, que vai querer revisar o diff antes.
12. Depois de escrever (ou reorganizar), confirme numa frase o que foi salvo/movido, em qual arquivo, e se algum link cruzado foi adicionado ou corrigido.

## Modo "time de agentes" (ainda não implementado)

Quando os subagentes especializados (`claude-user/agents/`) existirem, este skill também deve indicar quando delegar a eles em vez de responder diretamente. Ver seção 10 do `ARQUITETURA.md` para o estado desta decisão.
