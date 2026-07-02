# OpenClaw Helm Chart

This chart deploys OpenClaw, a local llama.cpp model server and Open Notebook (a NotebookLM alternative) to a K3s cluster using the HelmChart CRD and controller. Persistence uses hostPath under `/opt/teknoir/openclaw`.

Open Notebook runs from the single-container `lfnovo/open_notebook` image (bundled SurrealDB) and uses the local llama.cpp server through its OpenAI-compatible API, so no external API keys are required. Its web UI is exposed on a fixed NodePort (`30502`). Configuration lives under `openNotebook` in `values.yaml`.

The model backend runs the massive GLM-4.6 (357B MoE) as a quantized GGUF via `llama-server`, split across CPU and both GPUs: dense/attention layers are offloaded to the two 16GB GPUs while the routed MoE experts stay in 128GB system RAM, with a 256K context window. Configuration lives under `llamacpp` in `values.yaml`. There is no public "GLM-5.2" GGUF; GLM-4.6 is the current flagship GLM model for llama.cpp.

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
