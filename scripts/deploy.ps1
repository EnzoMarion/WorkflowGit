Param(
  [string]$Sha
)

Write-Host "Stopping current stack..."
docker compose down

Write-Host "Removing old containers (postgres, backend, frontend)..."
$names = @("postgres", "backend", "frontend")
foreach ($name in $names) {
  $container = docker ps -a --format "{{.Names}}" | Select-String -SimpleMatch $name
  if ($container) {
    docker rm -f $name
  }
}

Write-Host "Freeing port 3000 if used..."
$containers = docker ps --format "{{.ID}} {{.Names}} {{.Ports}}" | Select-String -SimpleMatch "0.0.0.0:3000->"
if ($containers) {
  $containers -split "`n" | ForEach-Object {
    $id = ($_ -split " ")[0]
    docker rm -f $id
  }
}

Write-Host "Pulling images for SHA $Sha..."
docker pull ghcr.io/enzomarion/cloudnative-backend:$Sha
docker pull ghcr.io/enzomarion/cloudnative-frontend:$Sha

Write-Host "Starting stack..."
docker compose up -d
