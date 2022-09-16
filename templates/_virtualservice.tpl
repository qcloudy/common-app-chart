{{/* vim: set filetype=mustache: */}}

{{/*
Generate route entry that is compatible with all Kubernetes API versions.
*/}}

{{- define "virtualService.destination" -}}
{{- $apiVersion := (include "capabilities.virtualservice.apiVersion" .context) -}}
{{- if or (eq $apiVersion "networking.istio.io/v1alpha3") (eq $apiVersion "networking.istio.io/v1beta1") -}}
destination:
  host: {{ .serviceName }}
  port: {{ .servicePort }}
  subset: {{ .subsetName }}
  {{- end }}
{{- end -}}c
