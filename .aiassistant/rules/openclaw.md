---
apply: always
---

* Only local installation: running OpenClaw and models on a local machine with K3s using the Teknoir platform
  * Including always deploying Ollama and one default model
  * No API keys to models, only using models running locally
  * Always deploy Ollama and one default model
    * Pick a 4bit quantized general-purpose model that fit on 12GB GPU
    * Selection prioritize larger context window and quality/accuracy, and down-prioritize speed
* The OpenClaw kustomize setup can be referenced in this project in directory ./k8s/manifests, as a starting point. No changes in this dir is needed
