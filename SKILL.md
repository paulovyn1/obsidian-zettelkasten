---
name: obsidian-zettelkasten
description: >
  Comportamento padrão obrigatório para TODA operação de escrita, criação ou atualização
  de notas no Obsidian (vault no padrão Triwer). Acionar SEMPRE que qualquer ferramenta
  do Obsidian for usada — create_or_update_note, append_to_note, ou qualquer operação
  que crie ou modifique conteúdo no vault. Nunca criar uma nota no Obsidian sem seguir
  este fluxo. Triggers incluem: "salva no Obsidian", "cria uma nota", "adiciona ao vault",
  "registra no Obsidian", "documenta no Obsidian", "atualiza no Obsidian", qualquer uso
  das ferramentas obsidian:create_or_update_note ou obsidian:append_to_note.
---

# Skill: Obsidian Zettelkasten — Comportamento Padrão Triwer

## Princípio de economia de tokens

**Nunca chamar `get_vault_structure` ou `get_linkable_notes`** — a estrutura do vault é
estável e está hardcoded abaixo. A única ferramenta de leitura permitida antes de criar é
`obsidian:search_notes` com termos-chave específicos do conteúdo — e só quando o tema é
ambíguo ou pode haver duplicata.

Toda nota no vault é um **nó em uma rede**. Criar sem conectar = criar lixo.

---

## Estrutura do vault (hardcoded — não consultar)

```
00. 🎲 Processamento/          → efêmeras brutas, inbox de ideias
01. ⚓ Âncoras/                → MOCs temáticos (ver lista abaixo)
02. 📆 Daily Notes/            → diário
03. 📽️ Projetos/               → projetos ativos e produtos
  └── Conteúdo Gerado/         → output de lives, Estrateclasses
  └── Diary/Ideias/            → ideias soltas de projetos
  └── Lançamentos/             → histórico e planejamento de lançamentos
  └── Produtos Triwer/         → uma pasta por produto
  └── Triwer/Dados/            → análises e dados históricos
  └── Youtube/                 → estratégia YouTube
04. 🧩 Recursos/Notas/         → corpo principal do Zettelkasten
  └── 1. Efêmeras/             → captura rápida (fleeting)
  └── 2. Referência/           → artigos, citações, livros, estudos, teorias, YouTube
  └── 3. Literatura/           → síntese de fontes externas
  └── 4. Permanentes/          → insights próprios, evergreen
  └── 6. Estratégias/          → estratégias concretas destiladas
  └── 7. Autores/              → notas por autor
Modelos/                       → templates
```

### Âncoras existentes (MOCs do vault)
`AI` | `Antecipação` | `Desejo` | `Estratégia` | `estudos` | `Gestão` |
`Lançamento` | `Marketing` | `Narrativas` | `perpétuo` | `Produtividade` | `vendas`

---

## Passo 1 — Classificar o tipo e a pasta de destino

| Tipo | Quando usar | Pasta |
|---|---|---|
| `fleeting` | Captura bruta, ideia não processada | `04. 🧩 Recursos/Notas/1. Efêmeras/` |
| `literature` | Síntese de fonte externa (livro, curso, vídeo, transcrição) | `04. 🧩 Recursos/Notas/3. Literatura/` |
| `permanent` | Insight próprio, ideia atômica desenvolvida | `04. 🧩 Recursos/Notas/4. Permanentes/` |
| `reference` | Artigo, citação, teoria, estudo externo | `04. 🧩 Recursos/Notas/2. Referência/[subtipo]/` |
| `strategy` | Estratégia concreta aplicável | `04. 🧩 Recursos/Notas/6. Estratégias/` |
| `project` | Nota de projeto ativo | `03. 📽️ Projetos/[produto ou contexto]/` |
| `anchor` | MOC temático | `01. ⚓ Âncoras/` |

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
  - [produto se aplicável: sds | sim-inevitavel | malha-de-ouro | mentoria-arco]
status: seedling        # seedling | growing | evergreen
related: "[[Nota A]], [[Nota B]]"
source: ""              # só preencher se vier de fonte externa
---
```

**Variante: Estrateclass / live** (quando o conteúdo é output de live ou Estrateclass):
```yaml
---
tags: [triwer, estrateclass, live, [tema]]
date: YYYY-MM-DD
tema: [título completo da live]
isca: [CÓDIGO] — [nome da isca]
keyword-manychat: [CÓDIGO]
related: "[[Âncora]], [[Nota de produto]]"
---
```

**Notas antigas** usam `Data:` e `Tipo:` em maiúsculo — não alterar ao atualizar, só acrescentar conteúdo.

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
Toda nota deve linkar para ao menos 1 Âncora da lista acima. Escolher pela semântica:
- Conteúdo, desejo, carrossel, stories → `[[Marketing]]` ou `[[Desejo]]`
- Frameworks, método, sistema → `[[Estratégia]]`
- Lançamento, oferta, vendas → `[[Lançamento]]` ou `[[vendas]]`
- IA, automação, agente → `[[AI]]`
- Resultado, história de aluno → `[[Narrativas]]`

### 4c. Atualizar notas existentes (links de entrada)
Identificar 1–2 notas do vault que deveriam apontar para a nova nota e atualizá-las.
Prioridade: Âncoras relevantes > Permanentes do mesmo tema > Projetos relacionados.

**Regra extra para Âncoras:** as Âncoras do vault estão parcialmente vazias (sem lista de notas).
Ao linkar para qualquer Âncora, verificar se ela tem lista de notas no corpo. Se não tiver,
adicionar a nova nota na Âncora via `append_to_note`. Isso popula as Âncoras progressivamente
sem custo extra — cada operação de criação melhora o vault um pouco.

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

## Regras invioláveis

1. Nunca criar nota sem frontmatter
2. Nunca criar nota `permanent` sem ao menos 1 Âncora linkada
3. Nunca duplicar — se o tema já tem nota, atualizar
4. Nunca usar título genérico — afirmação ou pergunta sempre
5. Nunca chamar `get_vault_structure` ou `get_linkable_notes`
6. Notas em `02. 📆 Daily Notes/Claude Logs/` seguem regra exclusiva:
   - Usar o template `prd` de `references/templates.md`
   - Única leitura permitida antes de criar: `list_notes` na pasta do dia para checar se já existe nota com mesmo nome
   - Passo 4 inteiro (4a, 4b, 4c, 4d) NÃO se aplica — sem busca de links de saída, sem âncora obrigatória, sem atualizar notas existentes, sem criar satélites

---

## Referências
- `references/templates.md` → templates completos para cada tipo de nota
- `references/connection-patterns.md` → lógica de conexão por tema Triwer
