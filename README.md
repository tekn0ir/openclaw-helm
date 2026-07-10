# OpenClaw Helm Chart

This chart deploys OpenClaw, a local vLLM model server and Open Notebook (a NotebookLM alternative) to a K3s cluster using the HelmChart CRD and controller. Persistence uses hostPath under `/opt/teknoir/openclaw`.

Open Notebook runs from the single-container `lfnovo/open_notebook` image (bundled SurrealDB) and uses the local vLLM server through its OpenAI-compatible API, so no external API keys are required. Its web UI is exposed on a fixed NodePort (`30502`). Configuration lives under `openNotebook` in `values.yaml`, including the public `API_URL`/CORS origin used when the service is accessed through Istio and Keycloak.

The model backend runs DeepSeek-V4-Flash (285B MoE, ~13B active) via `vllm serve`, sharded across both GPUs with tensor and expert parallelism. The model ships in a native FP4/FP8 format that the two 16GB RTX 2000 Pro Blackwell GPUs accelerate in hardware; weights that exceed the 32GB VRAM budget are offloaded to the 128GB system RAM, with a 128K context window and an FP8 KV cache. Configuration lives under `vllm` in `values.yaml`.

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

## Linting

```bash
./scripts/lint.sh
```
