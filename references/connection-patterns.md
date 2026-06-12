# Padrões de Conexão — Método Triwer

> As Âncoras reais do vault e seus temas estão registrados em `memoria.md` (seção
> **Âncoras**). Esta referência define a *lógica* de roteamento — aplicá-la sempre
> usando as Âncoras, produtos e notas-índice do próprio usuário.

## Como escolher a Âncora

1. Identificar o tema central da nota (1 frase)
2. Comparar com os temas listados ao lado de cada Âncora em `memoria.md`
3. Linkar a Âncora com maior sobreposição semântica — em caso de empate, linkar as duas
4. Se nenhuma Âncora cobrir o tema → oferecer criar uma nova (template `moc`) e
   registrá-la em `memoria.md`

### Exemplos de gravitação temática

| Se o vault tiver uma Âncora de... | Temas que gravitam em torno |
|---|---|
| Marketing/Conteúdo | Instagram, carrossel, stories, headlines, audiência |
| Vendas | oferta, CTA, copy, página de vendas, conversão |
| Lançamento | CPL, webinário, checklist, aquecimento, perpétuo |
| Narrativas/Histórias | storytelling, resultados de clientes, prova social |
| Estratégia | frameworks, método, sistemas, posicionamento |
| IA/Tecnologia | agentes, automação, MCP, prompts |
| Gestão | operação, time, processos, empresa |
| Produtividade | Zettelkasten, second brain, sistemas pessoais |
| Estudos | aprendizado, livros, referências, pesquisa |

---

## Roteamento por tipo de conteúdo

### Frameworks e métodos (próprios ou aprendidos)
- Âncora: a de estratégia/método + a do tema de aplicação
- Pasta: Permanentes ou Estratégias
- Linkar para: produto onde o framework é aplicado + literatura que o originou

### Produtos e ofertas (os registrados em `memoria.md`)
- Âncora: a do tema principal do produto
- Pasta: Projetos/[produto]
- Linkar para: frameworks usados + histórias de resultados + iscas relacionadas

### Lançamentos e campanhas
- Âncora: a de lançamento/vendas
- Pasta: Projetos (subpasta de lançamentos, se existir)
- Linkar para: produto + checklist + debriefing anterior se existir

### Insights de mentoria, consultoria ou atendimento
- Âncora: tema do insight
- Pasta: Permanentes (se insight atômico) ou Projetos/[produto relacionado]
- Linkar para: princípio geral extraído + produto relacionado

### Conteúdo de lives, aulas e eventos
- Âncora: a de marketing/conteúdo + âncora do tema
- Pasta: Projetos (subpasta de conteúdo gerado, se existir) ou Permanentes
- Linkar para: frameworks usados + produto promovido

### Histórias e resultados de alunos/clientes
- Âncora: a de narrativas/histórias (ou a temática mais próxima)
- Pasta: Permanentes
- Linkar para: índice de histórias (se registrado em `memoria.md`) + produto + âncora temática

### Iscas e CTAs
- Âncora: a de marketing + a de vendas
- Pasta: Permanentes
- Linkar para: índice de iscas e CTAs (se registrado em `memoria.md`) + produto específico

### Referências externas (livros, artigos, estudos)
- Âncora: a de estudos (ou a temática mais próxima)
- Pasta: Referência (subpasta por tipo, se existir)
- Linkar para: notas permanentes geradas a partir dessa referência

---

## Sinais de nota mal conectada

- `related:` vazio ou com apenas 1 item em nota `permanent`
- Nenhuma Âncora linkada
- Nota de produto sem link para a pasta/nota do produto
- Nota de história sem link para o índice de histórias (quando registrado na memória)
- Nota de isca sem link para o índice de iscas e CTAs (quando registrado na memória)
