# OpenClaw Helm Chart

This chart deploys OpenClaw and Ollama to a K3s cluster using the HelmChart CRD and controller. Services include Prometheus scrape annotations for `/metrics`. Persistence uses hostPath under `/opt/teknoir/openclaw`.

> The implementation of the Helm chart is the bare minimum to get it to work by design.


## Usage in Teknoir platform
Use the HelmChart to deploy OpenClaw and Ollama to a Device.

```yaml
---
apiVersion: helm.cattle.io/v1
kind: HelmChart
metadata:
  name: openclaw
  namespace: default
spec:
  repo: https://tekn0ir.github.io/openclaw-helm
  chart: openclaw
  targetNamespace: default
  valuesContent: |-
    # Example for minimal configuration (typically empty)
    
```

## Adding the repository

```bash
helm repo add tekn0ir-openclaw https://tekn0ir.github.io/openclaw-helm/
```

## Installing the chart

```bash
helm install openclaw tekn0ir-openclaw/openclaw -f values.yaml
```

## MCP

The chart hardcodes one MCP server in `~/.openclaw/workspace/.mcp.json`:

- `swedish-law` -> `https://swedish-law-mcp.vercel.app/mcp`

## Linting

```bash
./scripts/lint.sh
```
