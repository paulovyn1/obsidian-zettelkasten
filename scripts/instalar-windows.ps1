# =============================================================
# Triwer Skills — Instalador do obsidian-zettelkasten (Windows/PowerShell)
# =============================================================

$ErrorActionPreference = "Stop"

$REPO = "https://raw.githubusercontent.com/paulovyn1/obsidian-zettelkasten/main"
$SKILLS_DIR = "$env:USERPROFILE\.claude\skills"
$SKILL_DIR = "$SKILLS_DIR\obsidian-zettelkasten"
$VERSION_FILE = "$SKILL_DIR\VERSION"

function Write-Color($text, $color = "White") {
    Write-Host $text -ForegroundColor $color
}

function Download-File($remotePath, $localPath) {
    $dir = Split-Path $localPath
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    try {
        Invoke-WebRequest -Uri "$REPO/$remotePath" -OutFile $localPath -UseBasicParsing
    } catch {
        Write-Color "  ERRO ao baixar: $remotePath" "Red"
        throw
    }
}

Write-Host ""
Write-Color "╔══════════════════════════════════════════════╗" "Blue"
Write-Color "║   Triwer Skills — obsidian-zettelkasten      ║" "Blue"
Write-Color "╚══════════════════════════════════════════════╝" "Blue"
Write-Host ""

# Buscar versão disponível
Write-Color "→ Verificando versão disponível..." "Yellow"
try {
    $REMOTE_VERSION = (Invoke-WebRequest -Uri "$REPO/VERSION" -UseBasicParsing).Content.Trim()
} catch {
    Write-Color "✗ Não foi possível conectar ao repositório. Verifique sua conexão." "Red"
    exit 1
}

Write-Color "   Versão disponível: $REMOTE_VERSION" "Green"

# Verificar versão instalada
$INSTALLED_VERSION = ""
if (Test-Path $VERSION_FILE) {
    $INSTALLED_VERSION = (Get-Content $VERSION_FILE).Trim()
}

if ($INSTALLED_VERSION -eq $REMOTE_VERSION) {
    Write-Host ""
    Write-Color "✓ Você já tem a versão mais recente instalada ($INSTALLED_VERSION)." "Green"
    Write-Host ""
    exit 0
}

if ($INSTALLED_VERSION -ne "") {
    Write-Color "   Versão instalada:  $INSTALLED_VERSION" "Yellow"
    Write-Color "→ Atualizando para $REMOTE_VERSION..." "Yellow"
    $UPDATE = $true
} else {
    Write-Color "   Nenhuma versão instalada." "White"
    Write-Color "→ Instalando versão $REMOTE_VERSION..." "Yellow"
    $UPDATE = $false
}

Write-Host ""

# Criar estrutura de pastas
Write-Color "→ Criando pastas..." "Yellow"
if (-not (Test-Path "$SKILL_DIR\references")) {
    New-Item -ItemType Directory -Force -Path "$SKILL_DIR\references" | Out-Null
}

# Baixar arquivos
Write-Color "→ Baixando obsidian-zettelkasten..." "Yellow"
Download-File "SKILL.md" "$SKILL_DIR\SKILL.md"
Download-File "references/templates.md" "$SKILL_DIR\references\templates.md"
Download-File "references/connection-patterns.md" "$SKILL_DIR\references\connection-patterns.md"
Download-File "references/estrutura-recomendada.md" "$SKILL_DIR\references\estrutura-recomendada.md"

# memoria.md: nunca sobrescrever (dados pessoais do usuário)
if (Test-Path "$SKILL_DIR\memoria.md") {
    Write-Color "   ↳ memoria.md mantido (seus dados pessoais)" "White"
} else {
    Write-Color "   ↳ memoria.md será criado no primeiro uso (onboarding)" "White"
}

# Salvar versão instalada
Set-Content -Path $VERSION_FILE -Value $REMOTE_VERSION

Write-Host ""
Write-Color "╔══════════════════════════════════════════════╗" "Green"
if ($UPDATE) {
    Write-Color "║   ✓ Atualização concluída!                   ║" "Green"
} else {
    Write-Color "║   ✓ Instalação concluída!                    ║" "Green"
}
Write-Color "║   Versão: $REMOTE_VERSION" "Green"
Write-Color "╚══════════════════════════════════════════════╝" "Green"
Write-Host ""
Write-Color "  Próximos passos:" "Blue"
Write-Host "  1. Conecte o Obsidian ao Claude (MCP do Obsidian ativo)"
Write-Host ""
Write-Host "  2. Abra uma nova conversa e peça, por exemplo:"
Write-Color "     `"salva essa ideia no Obsidian`"" "Yellow"
Write-Host ""
Write-Host "  3. No primeiro uso, o onboarding mapeia o seu vault"
Write-Host "     automaticamente (leva uns 3 minutos, só uma vez)."
Write-Host ""
