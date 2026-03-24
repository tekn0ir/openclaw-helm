---
apply: always
---

* Zero configuration
    * All configurations have defaults that correspond to my preferences
    * Everything else is hardcoded in the Helm chart
    * Values/valuesContent during chart installation should be empty in most use cases
* README.md should be updated
  * It should be kept very short without icons and simple formatting, basically mostly adjusting things to align with changes made or fixing direct errors
* Teknoir platform requirements
  * Web UI service resource needs a fixed NodePort based on the OpenClaw kustomize resources, with the port derived from the default port, no Ingress
  * Persistence volumes should use hostPath under /opt/teknoir/openclaw
