# Templates por Tipo de Nota

## Template: `permanent`
```markdown
---
title: "[Afirmação ou pergunta que captura a ideia]"
type: permanent
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - [tema-principal]
  - [produto-ou-área]
status: seedling
related:
  - "[[]]"
source: ""
---

# [Título]

## Ideia Central
[1–3 parágrafos. Se ultrapassar → dividir a nota.]

## Evidências / Exemplos
- 

## Conexões
- [[Nota relacionada]] — [motivo da conexão]

## Fonte
```

---

## Template: `literature`
```markdown
---
title: "Literatura: [Nome da fonte]"
type: literature
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - literatura
  - [tema]
status: growing
related:
  - "[[]]"
source: "[URL ou título do material]"
---

# Literatura: [Nome da fonte]

## Resumo em 3 frases
[O que é. Por que importa. O que muda com isso.]

## Insights extraíveis
- **[Insight 1]** → [[Nota Permanente relacionada]]
- **[Insight 2]** → a processar

## Citações relevantes
> "[trecho]" — p. X

## Notas a criar a partir daqui
- [ ] [[Ideia A]] — seedling
- [ ] [[Ideia B]] — seedling
```

---

## Template: `meeting` / `mentoria`
```markdown
---
title: "Meeting: [Contexto] — YYYY-MM-DD"
type: meeting
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - reunião
  - [projeto-ou-produto]
status: growing
related:
  - "[[]]"
participants: []
---

# Meeting: [Contexto] — YYYY-MM-DD

## Contexto
[Qual era o objetivo da reunião/sessão]

## Decisões tomadas
- 

## Tarefas geradas
- [ ] [Tarefa] — responsável: [pessoa]

## Insights para vault
[Ideias que merecem virar nota permanente]
→ [[Nota a criar]]

## Próximos passos
```

---

## Template: `moc` (Map of Content)
```markdown
---
title: "MOC — [Tema]"
type: moc
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - moc
  - [tema]
status: growing
related: []
---

# MOC — [Tema]

> Mapa de todas as notas relacionadas a [tema].

## Fundamentos
- [[Nota fundacional 1]]
- [[Nota fundacional 2]]

## Aplicações práticas
- [[Nota aplicada 1]]

## Em desenvolvimento
- [[Nota seedling 1]] 🌱

## Fontes de literatura
- [[Literatura: Fonte 1]]
```

---

## Template: `project`
```markdown
---
title: "Projeto: [Nome]"
type: project
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - projeto
  - [produto]
status: growing
related:
  - "[[MOC - Tema relevante]]"
deadline: YYYY-MM-DD
---

# Projeto: [Nome]

## Objetivo
[O que precisa estar feito e qual o critério de sucesso]

## Contexto
[[Nota de background relevante]]

## Tarefas
- [ ] 

## Notas relacionadas
- [[]]

## Histórico
```

---

## Template: `prd` / Claude Log

```markdown
---
tags:
  - claude-log
  - prd
  - [tema]
date: YYYY-MM-DD
related: "[[]]"
status: seedling
---

# PRD — [Nome da Tarefa]

> Sessão iniciada em DD/MM/YYYY. [Status: pendente | em andamento | retomada]

---

## Contexto

[O que existe hoje e o que está faltando. 1–3 frases.]

**Fonte(s) consultada(s):** [arquivos, notas ou dados lidos nessa sessão]

---

## Estado atual *(preencher só se tarefa em andamento)*

[O que já foi feito. Decisões tomadas.]

| Item | Status |
|---|---|
| [tarefa] | ✅ Concluído / ⏳ Pendente |

---

## O que implementar

[Mudanças exatas. Conteúdo literal a ser inserido/substituído — não resumo.]

---

## Como executar

[Passos na ordem. Caminhos, arquivos e ferramentas necessárias.]

---

## Próximos passos *(preencher só se tarefa em andamento)*

- [ ] [tarefa pendente]

---

## Links

- [[Nota ou arquivo relacionado]] — [motivo]
```
