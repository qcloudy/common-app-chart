{{/* vim: set filetype=mustache: */}}

{{/*
Generate route entry that is compatible with all Kubernetes API versions.
*/}}

{{- define "virtualService.destination" -}}
{{- $apiVersion := (include "capabilities.virtualservice.apiVersion" .context) -}}
{{- if or (eq $apiVersion "networking.istio.io/v1alpha3") (eq $apiVersion "networking.istio.io/v1beta1") -}}
{{- range $subsetStable := .Values.subsets.stable }}
- destination:
    subset: {{ $subsetStable.name }}
    host: {{ include "service.fullname" $ }}
  weight: {{ $subsetStable.weight | int }}
{{- end }}
{{- range $subsetCanary := .Values.subsets.canary }}
- destination:
    subset: {{ $subsetCanary.name }}
    host: {{ include "service.fullname" $ }}
  weight: {{ $subsetCanary.weight | int }}
{{- end }}
{{- end -}}
{{- end }}