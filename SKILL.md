---
name: obsidian-zettelkasten
description: >
  Comportamento padrão obrigatório para TODA operação de escrita, criação ou atualização
  de notas no Obsidian (vault organizado no método Zettelkasten Triwer). Acionar SEMPRE
  que qualquer ferramenta do Obsidian for usada — create_or_update_note, append_to_note,
  ou qualquer operação que crie ou modifique conteúdo no vault. Nunca criar uma nota no
  Obsidian sem seguir este fluxo. Inclui onboarding automático no primeiro uso que mapeia
  o vault do usuário. Triggers incluem: "salva no Obsidian", "cria uma nota", "adiciona
  ao vault", "registra no Obsidian", "documenta no Obsidian", "atualiza no Obsidian",
  qualquer uso das ferramentas obsidian:create_or_update_note ou obsidian:append_to_note.
---

# Skill: Obsidian Zettelkasten — Comportamento Padrão Triwer

Toda nota no vault é um **nó em uma rede**. Criar sem conectar = criar lixo.

---

## BOOT — EXECUTAR SEMPRE AO INICIAR

### Passo 1 — Verificar memória

Tente ler `~/.claude/skills/obsidian-zettelkasten/memoria.md`.

- **Se existir:** carregue em memória de trabalho a estrutura do vault, as Âncoras, os
  produtos/projetos e as convenções registradas. Siga direto para o fluxo normal.
- **Se não existir:** é o primeiro uso. Execute o **ONBOARDING** antes de continuar.

### Passo 2 — Verificar conexão Obsidian

Confirme que as ferramentas do Obsidian estão disponíveis (`obsidian:create_or_update_note`,
`obsidian:append_to_note`, `obsidian:search_notes`).

- **Se disponíveis:** confirme internamente. Não avise o usuário a menos que haja erro.
- **Se não disponíveis:** exiba:

> ⚠️ **Obsidian não conectado**
>
> Esta skill precisa do MCP do Obsidian ativo no Claude para criar notas no seu vault.
> Verifique se o servidor MCP do Obsidian está configurado e se o Obsidian está aberto,
> e reinicie esta conversa depois de conectar.

---

## Princípio de economia de tokens

**Nunca chamar `get_vault_structure` ou `get_linkable_notes` fora do onboarding** — a
estrutura do vault foi mapeada uma única vez no onboarding e está registrada em
`memoria.md`. A única ferramenta de leitura permitida antes de criar é
`obsidian:search_notes` com termos-chave específicos do conteúdo — e só quando o tema é
ambíguo ou pode haver duplicata.

Se o usuário reorganizar o vault (mudar pastas, criar novas Âncoras), atualize
`memoria.md` — não volte a consultar a estrutura a cada operação.

---

## ONBOARDING — APENAS NO PRIMEIRO USO

Execute quando `memoria.md` não existir. **Esta é a única situação em que
`get_vault_structure` pode ser chamada.**

### O1 — Apresentação

```
Oi! Sou a skill de Zettelkasten da Triwer. A partir de agora, toda nota
que eu criar no seu Obsidian vai nascer classificada, com frontmatter
completo e conectada ao resto do seu vault — nada de notas soltas.

Antes de começar, preciso mapear o seu vault. Isso leva uns 3 minutos
e só precisa ser feito uma vez.
```

### O2 — Verificar conexão Obsidian

Igual ao Passo 2 do BOOT. **Não avance sem o Obsidian conectado.**

### O3 — Mapear a estrutura do vault

Chame `get_vault_structure` **uma única vez** e analise as pastas existentes.
Classifique o que encontrar nos papéis do método:

| Papel | O que procurar |
|---|---|
| Efêmeras / inbox | pastas tipo "Inbox", "Efêmeras", "Processamento", "Capturas" |
| Referência | pastas de artigos, citações, livros, estudos externos |
| Literatura | pastas de síntese de fontes (livros, cursos, vídeos) |
| Permanentes | corpo principal de notas atômicas próprias |
| Estratégias | estratégias concretas destiladas (pode não existir) |
| Âncoras / MOCs | pastas de MOCs, mapas, índices temáticos |
| Projetos | projetos ativos, produtos, lançamentos |
| Daily notes | diário, notas diárias |
| Templates | modelos de nota |

Apresente o mapeamento ao usuário para confirmação, no formato:

```
Mapeei seu vault assim:

- Efêmeras/inbox → [pasta encontrada]
- Permanentes → [pasta encontrada]
- ...
- Não encontrei: [papéis sem pasta correspondente]

Está correto? Quer ajustar alguma coisa?
```

**Cenários:**

- **Vault já organizado:** confirme o mapeamento e siga para O4.
- **Vault parcial** (faltam papéis): ofereça criar as pastas que faltam. Só os papéis
  Efêmeras, Permanentes e Âncoras são obrigatórios — os demais podem ficar como
  "não usado" na memória, e as notas desses tipos vão para Permanentes.
- **Vault novo ou desorganizado:** ofereça a estrutura recomendada Triwer. Leia
  `references/estrutura-recomendada.md` e proponha criá-la. Se o usuário recusar,
  trabalhe com o que existir.

### O4 — Mapear as Âncoras (MOCs)

Âncoras são os MOCs temáticos do vault — todo conteúdo novo se conecta a pelo menos uma.

- **Se a pasta de Âncoras tiver notas:** liste os nomes encontrados e pergunte ao usuário
  quais temas cada uma cobre (uma linha por Âncora). Registre na memória.
- **Se não houver nenhuma Âncora:** pergunte:

```
Seu vault ainda não tem Âncoras (mapas temáticos que conectam as notas).
Me diz os 3 a 6 grandes temas do seu trabalho — por exemplo: marketing,
vendas, lançamentos, IA, gestão, produtividade...

Vou criar uma Âncora para cada um.
```

Crie cada Âncora na pasta mapeada usando o template `moc` de `references/templates.md`.

### O5 — Produtos e projetos

Pergunte:

```
Você tem produtos, serviços ou projetos recorrentes que vão aparecer
nas notas? (cursos, mentorias, lançamentos, ofertas...)

Para cada um, me diz o nome — vou usar como tag e destino de notas
de projeto.
```

Para cada produto: registre nome, tag em kebab-case (ex: "Mentoria Alfa" → `mentoria-alfa`)
e a pasta de projeto correspondente (se existir ou se o usuário quiser criar).
Se o usuário não tiver nenhum, registre a seção como vazia — pode preencher depois.

### O6 — Notas-índice especiais (opcional)

Pergunte se o vault tem (ou se o usuário quer criar) notas-índice que centralizam
conteúdos recorrentes do método Triwer:

- **Índice de histórias** — histórias e resultados de alunos/clientes (prova social)
- **Índice de iscas e CTAs** — iscas, keywords e chamadas usadas nos conteúdos

Para cada uma que existir ou for criada, registre o nome exato da nota na memória.
Se não quiser nenhuma, registre como "não usado" — sem insistir.

### O7 — Convenções do vault

Verifique e registre:

- **Frontmatter legado:** se as notas existentes usam convenções diferentes
  (ex: `Data:` e `Tipo:` em maiúsculo), registre a regra: *ao atualizar notas antigas,
  não alterar o frontmatter — só acrescentar conteúdo*.
- **Pasta de logs de sessão** (opcional): se o usuário usa uma pasta para registros de
  sessões com o Claude (ex: dentro de Daily Notes), registre o caminho — notas ali
  seguem a regra exclusiva nº 6 (ver Regras invioláveis).

### O8 — Salvar memória

Crie `~/.claude/skills/obsidian-zettelkasten/memoria.md`:

```markdown
# Memória — Obsidian Zettelkasten
_Última atualização: [data]_

## Estrutura do vault
- Efêmeras/inbox: [pasta]
- Referência: [pasta | não usado]
- Literatura: [pasta | não usado]
- Permanentes: [pasta]
- Estratégias: [pasta | não usado]
- Âncoras/MOCs: [pasta]
- Projetos: [pasta | não usado]
- Daily notes: [pasta | não usado]
- Templates: [pasta | não usado]

## Âncoras (MOCs do vault)
- [[Nome]] — temas: [temas que gravitam em torno]

## Produtos / projetos
- [Nome] | tag: [tag-kebab] | pasta: [pasta | —]

## Notas-índice especiais
- Índice de histórias: [[nome exato]] | não usado
- Índice de iscas e CTAs: [[nome exato]] | não usado

## Convenções
- Frontmatter legado: [regra | nenhuma]
- Pasta de logs de sessão: [caminho | não usado]

## Preferências
- [preferências expressas pelo usuário durante o uso]

## Pendências
- [itens pendentes do onboarding]
```

Confirme:

```
Pronto! Seu vault está mapeado. A partir de agora, toda nota que eu
criar segue o método: classificada, com frontmatter e conectada.
```

---

## Passo 1 — Classificar o tipo e a pasta de destino

As pastas vêm da seção **Estrutura do vault** de `memoria.md`.

| Tipo | Quando usar | Pasta (da memória) |
|---|---|---|
| `fleeting` | Captura bruta, ideia não processada | Efêmeras/inbox |
| `literature` | Síntese de fonte externa (livro, curso, vídeo, transcrição) | Literatura |
| `permanent` | Insight próprio, ideia atômica desenvolvida | Permanentes |
| `reference` | Artigo, citação, teoria, estudo externo | Referência |
| `strategy` | Estratégia concreta aplicável | Estratégias |
| `project` | Nota de projeto ativo | Projetos/[produto ou contexto] |
| `anchor` | MOC temático | Âncoras/MOCs |

Se o tipo mapear para uma pasta marcada como "não usado", use Permanentes.

**Regra:** Uma nota `permanent` captura UMA ideia. Se tem 2+ ideias → dividir.

---

## Passo 2 — Frontmatter obrigatório

**Padrão base** (permanent, strategy, literature, reference, project):
```yaml
---
title: "Título como afirmação ou pergunta, nunca só substantivo"
type: permanent
date: YYYY-MM-DD
tags:
  - [tema]
  - [tag do produto, se aplicável — usar as tags registradas em memoria.md]
status: seedling        # seedling | growing | evergreen
related: "[[Nota A]], [[Nota B]]"
source: ""              # só preencher se vier de fonte externa
---
```

**Variante: live / aula / evento** (quando o conteúdo é output de uma live, aula ou evento
do usuário):
```yaml
---
tags: [live, [tema], [tag do produto se aplicável]]
date: YYYY-MM-DD
tema: [título completo da live/aula]
isca: [código/nome da isca, se houver]
keyword: [keyword de automação, se houver]
related: "[[Âncora]], [[Nota de produto]]"
---
```

**Notas antigas:** se a memória registrar uma convenção de frontmatter legado, respeitá-la —
não alterar o frontmatter existente ao atualizar, só acrescentar conteúdo.

**Status:** `seedling` = ideia bruta · `growing` = em desenvolvimento · `evergreen` = madura

---

## Passo 3 — Estrutura interna

### `permanent` e `strategy`:
```markdown
# [Título]

[1–3 parágrafos. Mais que isso → dividir a nota.]

## Conexões
- [[Nota A]] — [motivo]
- [[Nota B]] — [motivo]
```

### `literature` e `reference`:
Ver `references/templates.md`

---

## Passo 4 — Conexões (o passo mais importante)

**Regra mínima: toda nota permanent precisa de 2 links de saída e 1 link de entrada.**

### 4a. Links de saída — usar o contexto já disponível
Antes de chamar qualquer ferramenta, verificar se o conteúdo da conversa atual já menciona
notas do vault. Linkar primeiro o que já se sabe. Só usar `search_notes` se o tema for
ambíguo ou suspeitar de duplicata.

### 4b. Âncora obrigatória
Toda nota deve linkar para ao menos 1 Âncora registrada em `memoria.md`. Escolher pela
semântica: comparar o tema da nota com os temas listados ao lado de cada Âncora na memória.
A lógica detalhada de roteamento está em `references/connection-patterns.md`.

Se nenhuma Âncora existente cobrir o tema da nota, oferecer ao usuário criar uma nova
Âncora (template `moc`) — e registrá-la em `memoria.md`.

### 4c. Atualizar notas existentes (links de entrada)
Identificar 1–2 notas do vault que deveriam apontar para a nova nota e atualizá-las.
Prioridade: Âncoras relevantes > Permanentes do mesmo tema > Projetos relacionados.

**Regra extra para Âncoras:** ao linkar para qualquer Âncora, verificar se ela tem lista
de notas no corpo. Se não tiver, adicionar a nova nota na Âncora via `append_to_note`.
Isso popula as Âncoras progressivamente sem custo extra — cada operação de criação
melhora o vault um pouco.

### 4d. Notas satélite
Se surgir um conceito que merece nota própria mas não existe → criar como `seedling` e
linkar de volta. Não deixar `[[link quebrado]]` no vault.

---

## Passo 5 — Relatório (sempre ao final)

```
✅ [[Nome da Nota]] · type: permanent · status: seedling
📎 Saída: [[Nota A]], [[Nota B]]
🔗 Entrada adicionada em: [[Âncora X]], [[Nota Y]]
⚠️ Pendências: [se houver]
```

---

## Manutenção da memória

Atualize `memoria.md` (e a data de última atualização) sempre que:

- Uma nova Âncora for criada → adicionar à seção **Âncoras** com seus temas
- O usuário mencionar um produto/projeto novo → oferecer registrar em **Produtos/projetos**
- O usuário criar ou citar uma nota-índice (histórias, iscas) → registrar em **Notas-índice**
- O usuário reorganizar pastas do vault → atualizar **Estrutura do vault**
- O usuário expressar uma preferência de formato ou fluxo → registrar em **Preferências**

---

## Regras invioláveis

1. Nunca criar nota sem frontmatter
2. Nunca criar nota `permanent` sem ao menos 1 Âncora linkada
3. Nunca duplicar — se o tema já tem nota, atualizar
4. Nunca usar título genérico — afirmação ou pergunta sempre
5. Nunca chamar `get_vault_structure` ou `get_linkable_notes` fora do onboarding
6. Notas na pasta de logs de sessão (se registrada em `memoria.md`) seguem regra exclusiva:
   - Usar o template `prd` de `references/templates.md`
   - Única leitura permitida antes de criar: `list_notes` na pasta do dia para checar se já existe nota com mesmo nome
   - Passo 4 inteiro (4a, 4b, 4c, 4d) NÃO se aplica — sem busca de links de saída, sem âncora obrigatória, sem atualizar notas existentes, sem criar satélites
7. Nunca sobrescrever `memoria.md` com dados genéricos — só atualizar campos específicos

---

## Referências

- `references/templates.md` → templates completos para cada tipo de nota
- `references/connection-patterns.md` → lógica de conexão e roteamento por tipo de conteúdo
- `references/estrutura-recomendada.md` → estrutura de vault recomendada (para onboarding)
