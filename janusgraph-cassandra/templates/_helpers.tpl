{{- /*
Copyright 2021 Google LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/}}
{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "janusgraph.name" }}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "janusgraph.fullname" }}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- /*
Create chart name and version as used by the chart label.
*/}}
{{- define "janusgraph.chart" }}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- /*
Retrieve the value of a secret to use in a ConfigMap
Usage: include "janusgraph.secretValue" (dict "Namespace" ns "Name" secretName "Key" secretProperty ) | default "orElse"
*/}}
{{- define "janusgraph.secretValue" }}
{{- (get (coalesce (get (coalesce (lookup "v1" "Secret" .Namespace .Name) dict) "data") dict) .Key) | b64dec }}
{{- end }}

{{- /*
Retrieve the value of a property provided in a ConfigMap
Usage: include "syndeia.configmapValue" (dict "Namespace" ns "Name" configmapName "Key" property ) | default "orElse"
*/}}
{{- define "janusgraph.configmapValue" }}
{{- (get (coalesce (get (coalesce (lookup "v1" "ConfigMap" .Namespace .Name) dict) "data") dict) .Key) }}
{{- end }}