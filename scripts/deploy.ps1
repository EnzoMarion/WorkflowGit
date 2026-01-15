Param(
  [string]$Sha
)

$envFile = "active_color.env"

if (Test-Path $envFile) {
  $line = Get-Content $envFile | Where-Object { $_ -match "^ACTIVE_COLOR=" }
  if ($line) {
    $current = $line.Split("=")[1].Trim()
  } else {
    $current = "blue"
  }
} else {
  $current = "blue"
}

if ($current -eq "blue") {
  $next = "green"
} else {
  $next = "blue"
}

Write-Host "Current color: $current"
Write-Host "Next color (deploy target): $next"

Write-Host "Pulling images for SHA $Sha..."
docker pull ghcr.io/enzomarion/cloudnative-backend:$Sha
docker pull ghcr.io/enzomarion/cloudnative-frontend:$Sha

Write-Host "Starting stack for color $next..."
docker compose -f docker-compose.base.yml -f "docker-compose.$next.yml" up -d --build

"ACTIVE_COLOR=$next" | Out-File -FilePath $envFile -Encoding UTF8

Write-Host "Reloading Nginx..."
docker exec reverse-proxy nginx -s reload

Write-Host "Blue/Green deployment done. Active color is now: $next"
