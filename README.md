# Obsidian Zettelkasten — Triwer

Skill para Claude Code e Claude Desktop que define o comportamento padrão para **toda** criação e atualização de notas no Obsidian, seguindo o método Zettelkasten no padrão Triwer.

Com ela instalada, o Claude nunca cria uma nota solta no seu vault: toda nota nasce classificada (fleeting, literature, permanent, reference, strategy...), com frontmatter completo, conectada a outras notas e ancorada em um MOC temático.

---

## O que a skill faz

- **Classifica** cada nota no tipo e pasta corretos do vault
- **Frontmatter obrigatório** — título como afirmação/pergunta, tags, status (`seedling` → `growing` → `evergreen`), notas relacionadas
- **Conexões mínimas garantidas** — toda nota permanente sai com 2 links de saída, 1 link de entrada e ao menos 1 Âncora (MOC)
- **Atualiza as Âncoras progressivamente** — cada nota criada melhora o vault
- **Economia de tokens** — estrutura do vault hardcoded, sem chamadas desnecessárias de leitura
- **Relatório final** — mostra o que foi criado, linkado e o que ficou pendente

---

## Instalação

### Opção 1 — Pelo próprio Claude (recomendado)

Copie e cole esta mensagem numa conversa do **Claude Code**:

```
Instale a skill obsidian-zettelkasten pra mim. Rode o instalador correspondente ao meu sistema operacional:

- Windows (PowerShell): irm https://raw.githubusercontent.com/paulovyn1/obsidian-zettelkasten/main/scripts/instalar-windows.ps1 | iex
- Mac/Linux (bash): curl -fsSL https://raw.githubusercontent.com/paulovyn1/obsidian-zettelkasten/main/scripts/instalar-mac.sh | bash

Depois confirme que a pasta ~/.claude/skills/obsidian-zettelkasten foi criada com SKILL.md, VERSION e references/.
```

O Claude detecta seu sistema, roda o instalador e confirma a instalação.

### Opção 2 — Direto no terminal

**Mac / Linux**
```bash
curl -fsSL https://raw.githubusercontent.com/paulovyn1/obsidian-zettelkasten/main/scripts/instalar-mac.sh | bash
```

**Windows (PowerShell)**
```powershell
irm https://raw.githubusercontent.com/paulovyn1/obsidian-zettelkasten/main/scripts/instalar-windows.ps1 | iex
```

O instalador:
- Verifica se já há uma versão instalada
- Só baixa se houver versão mais nova
- Instala em `~/.claude/skills/obsidian-zettelkasten/`

---

## Atualizar

Rode o mesmo comando de instalação — o script detecta a versão instalada e só baixa se houver uma versão mais nova.

---

## Requisitos

- **Claude Code** ou **Claude Desktop** instalado ([baixar aqui](https://claude.ai/download))
- **Plano pago do Claude** (Pro ou superior)
- **Obsidian** conectado ao Claude via MCP (ferramentas `obsidian:create_or_update_note`, `obsidian:append_to_note`, `obsidian:search_notes`)
- Vault organizado no **padrão Triwer** (estrutura de pastas descrita no SKILL.md)

---

## Como usar

Não tem comando — a skill é **automática**. Depois de instalada, sempre que você pedir algo como:

- "salva essa ideia no Obsidian"
- "cria uma nota com isso"
- "registra esse insight no vault"
- "documenta no Obsidian"

...o Claude segue o fluxo completo: classifica, escreve o frontmatter, conecta e entrega o relatório.

---

## Estrutura instalada

```
~/.claude/skills/obsidian-zettelkasten/
├── SKILL.md
├── VERSION
└── references/
    ├── templates.md              ← templates completos por tipo de nota
    └── connection-patterns.md    ← lógica de conexão por tema
```

---

Feito com 🧡 pelo [Triwer](https://triwer.com.br)
