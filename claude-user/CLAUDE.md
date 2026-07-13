# Instruções globais (nível usuário)

## Princípio: o Mind é a única fonte, não um sistema de memória interno paralelo

O Mind é literalmente a mente do usuário: tudo que é durável — conhecimento, contexto de projetos, e também **regras de como ele quer que o Claude trabalhe** (convenções de git, formato de resposta, o que evitar, o que repetir) — mora aqui, versionado e editável por ele. Nunca guarde esse tipo de informação só num sistema de memória interno do Claude Code (não versionado, não visível/editável pelo usuário) quando ela deveria estar no Mind — isso recria em paralelo o mesmo problema que o Mind existe pra resolver: o usuário ter que reexplicar as coisas porque ficaram presas num lugar que ele não enxerga. Se alguma informação já vive só na memória interna e devia estar aqui, mova pra cá.

## Captura para o Mind

Em qualquer conversa, em qualquer projeto ativo, preste atenção a informações do usuário que pareçam duráveis e que não sejam específicas do código do projeto atual: fatos sobre vida pessoal, decisões/contexto de outros projetos ("preciso lembrar de mudar X no projeto Y"), conhecimento que ele explicou, preferências, planos, e **regras de como ele quer que o Claude trabalhe** (ex.: convenções de commit, forma de responder).

Quando identificar algo assim que pareça valer a pena guardar:

1. Pergunte ao usuário se ele quer salvar isso no Mind — nunca salve sem confirmar antes.
2. Se ele confirmar, use a Skill `mind` para decidir onde e como escrever (edita um nó existente ou cria um novo, e atualiza o índice).

Não interromper a conversa por qualquer detalhe pequeno — só ofereça quando parecer que realmente vale a pena persistir. Isso vale mesmo estando em outro projeto ativo: o Mind não depende de estar como projeto ativo pra receber uma atualização.

## Regras de trabalho

_Conforme forem surgindo preferências de como você quer que o Claude trabalhe (convenções de commit, formato de resposta, o que evitar/repetir), registre-as aqui, uma por bullet, no formato "regra + motivo" — sem narrar a conversa em que surgiram, só o que ficou decidido e por quê._
