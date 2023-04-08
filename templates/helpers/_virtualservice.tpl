{{/* vim: set filetype=mustache: */}}

{{/*
Generate route entry that is compatible with all Kubernetes API versions.
*/}}

{{- define "virtualService.destination" -}}
{{- range $subsetStable := .Values.istio.subsets.stable }}
- destination:
    subset: {{ $subsetStable.name }}
    host: {{ include "service.fullname" $ }}
  weight: {{ $subsetStable.weight | int }}
{{- end }}
{{- range $subsetCanary := .Values.istio.subsets.canary }}
- destination:
    subset: {{ $subsetCanary.name }}
    host: {{ include "service.fullname" $ }}
  weight: {{ $subsetCanary.weight | int }}
{{- end }}
{{- end -}}
