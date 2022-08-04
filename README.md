# common-app-chart

common-app-chart is a unified chart template for deploy services with CI/CD.

## TL;DR

```console
$ helm repo add qcloudy https://qcloudy.github.io/common-app-chart/charts
$ helm repo update
$ helm install my-release qcloudy/common-app-chart \
  --set image.repository=<Hostname of your container registry> \
  --set image.tag=<tag of your container image>
```

## Prerequisites

- Kubernetes 1.12+
- Helm 3.1.0

## Installing the Chart

 To install the chart with the release name `my-release`:

```console
$ helm install my-release qcloudy/common-app-chart \
  --set image.repository=<Hostname of your container registry> \
  --set image.tag=<Tag of your container image>
```

These commands deploy service on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Parameters

### Global parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`  |
| `global.storageClass`     | Global StorageClass for Persistent Volume(s)    | `nil` |

### Common parameters

| Name               | Description                                                                                               | Value |
| ------------------ | --------------------------------------------------------------------------------------------------------- | ----- |
| `kubeVersion`      | Force target Kubernetes version (using Helm capabilities if not set)                                      | `nil` |
| `nameOverride`     | String to partially override service.fullname template with a string (will prepend the release name)      | `nil` |
| `fullnameOverride` | String to fully override service.fullname template with a string                                          | `nil` |
| `commonLabels` | Add labels to all the deployed resources                                          | `nil` |
| `commonAnnotations` | Add annotations to all the deployed resources                                          | `nil` |

### Secrets Management parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `secretsManager.bankVault.enabled` | Enable Banzaicloud Vault Secrets Mutating Webhook | `false`  |
| `secretsManager.bankVault.annotations` | Banzaicloud Vault Secrets Mutating Webhook configure annotations. [Documentation](https://banzaicloud.com/docs/bank-vaults/mutating-webhook/annotations/) | `nil`  |

### Autoscaling parameters (HPA)

| Name                      | Description                                     | Value  |
| ------------------------- | ----------------------------------------------- | -----  |
| `autoscaling.enabled`     | Enable HPA                                      | `false`|
| `autoscaling.minReplicas` | HPA Min replicas                                | `nil`  |
| `autoscaling.maxReplicas` | HPA Max replicas                                | `nil`  |
| `autoscaling.targetCPU`   | Target CPU utilization percentage               | `nil`  |
| `autoscaling.targetMemory`| Target Memory utilization percentage            | `nil`  |

### Metrics parameters

| Name                                       | Description                                                                           | Value       |
| ------------------------------------------ | ------------------------------------------------------------------------------------- | ----------- |
| `metrics.enabled`                          | Enable Prometheus to access metrics endpoint                                          | `false`     |
| `metrics.containerPort`                    | Prometheus Exporter container port                                                    | `8081`      |
| `metrics.service.type`                     | Prometheus Exporter service type                                                      | `ClusterIP` |
| `metrics.service.port`                     | Prometheus Exporter service port                                                      | `8081`      |
| `metrics.service.annotations`              | Annotations for Prometheus to auto-discover the metrics endpoint                      | `{}`        |
| `metrics.serviceMonitor.enabled`           | Create ServiceMonitor Resource for scraping metrics using Prometheus Operator         | `false`     |
| `metrics.serviceMonitor.path`              | Scrape path for the ServiceMonitor Resource                                           | `/metrics`  |
| `metrics.serviceMonitor.namespace`         | Namespace for the ServiceMonitor Resource (defaults to the Release Namespace)         | `""`        |
| `metrics.serviceMonitor.interval`          | Interval at which metrics should be scraped.                                          | `""`        |
| `metrics.serviceMonitor.scrapeTimeout`     | Timeout after which the scrape is ended                                               | `""`        |
| `metrics.serviceMonitor.additionalLabels`  | Additional labels that can be used so ServiceMonitor will be discovered by Prometheus | `{}`        |
| `metrics.serviceMonitor.selector`          | Prometheus instance selector labels                                                   | `{}`        |
| `metrics.serviceMonitor.relabelings`       | RelabelConfigs to apply to samples before scraping                                    | `[]`        |
| `metrics.serviceMonitor.metricRelabelings` | MetricRelabelConfigs to apply to samples before ingestion                             | `[]`        |
| `metrics.serviceMonitor.honorLabels`       | Specify honorLabels parameter to add the scrape endpoint                              | `false`     |
| `metrics.serviceMonitor.jobLabel`          | The name of the label on the target service to use as the job name in prometheus.     | `""`        |

### App parameters

| Name                                   | Description                                                                                                                                               | Value                    |
| -------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| `image.registry`                       | App image registry                                                                                                                                        | `nil`                    |
| `image.repository`                     | App image repository                                                                                                                                      | `nil`                    |
| `image.tag`                            | App image tag (immutable tags are recommended)                                                                                                            | `nil`                    |
| `image.pullPolicy`                     | App image pull policy                                                                                                                                     | `Always`                 |
| `replicaCount`                         | Number of replicas of the app Pod                                                                                                                         | `1`                      |
| `serviceAccount.create`                   | Create Service Account Name                                                                                                                                      | `false`                    |
| `serviceAccount.name`                   | Use already existing Service Account Name                                                                                                                                      | `nil`                    |
| `serviceAccount.annotations`                   | Add annotations to Service Account Name                                                                                                                                      | `{}`                    |
| `serviceAccount.automountServiceAccountToken`                   | Automount Service Account token Name                                                                                                                                      | `true`                    |
| `updateStrategy.type`                  | Set up update strategy for app installation.                                                                                                              | `RollingUpdate`          |
| `hostAliases`                          | Add deployment host aliases                                                                                                                               | `[]`                     |
| `env`                                  | env vars to configure app                                                                                                                                 | `nil`                    |
| `configMapFile` | config file name or wildcard pattern in chart/config directory | `nil` |
| `envSecret`                            | Enable/Disabke ingest from secret containing extra env vars to configure app (in case of sensitive data)                                                  | `false`                  |
| `extraVolumes`                         | Array to add extra volumes. Requires setting `extraVolumeMounts`                                                                                          | `nil`                    |
| `extraVolumeMounts`                    | Array to add extra mounts. Normally used with `extraVolumes`                                                                                              | `nil`                    |
| `livenessProbe`                        | Liveness probe                                                                                                                                            | `nil`                    |
| `readinessProbe`                       | Readiness probe                                                                                                                                           | `nil`                    |
| `service.port`                         | Kubernetes Service port                                                                                                                                   | `8080`                   |
| `service.type`                         | Kubernetes Service type                                                                                                                                   | `ClusterIP`              |
| `service.nodePort`                     | Specify the nodePort value for the LoadBalancer and NodePort service types                                                                                | `nil`                    |
| `service.externalTrafficPolicy`        | Enable client source IP preservation                                                                                                                      | `Cluster`                |
| `service.loadBalancerIP`               | loadBalancerIP if app service type is `LoadBalancer`                                                                                                      | `nil`                    |
| `service.extraPorts`                   | Extra ports to expose in the service (normally used with the `sidecar` value)                                                                             | `nil`                    |
| `ingress.enabled`                      | Enable ingress controller resource                                                                                                                        | `false`                  |
| `ingress.certManager`                  | Add annotations for cert-manager                                                                                                                          | `false`                  |
| `ingress.pathType`                     | Ingress Path type                                                                                                                                         | `ImplementationSpecific` |
| `ingress.path`                         | The Path to app. You may need to set this to '/*' in order to use this with ALB ingress controllers.                                                      | `ImplementationSpecific` |
| `ingress.annotations`                  | Ingress annotations                                                                                                                                       | `{}`                     |
| `ingress.tls.secretName`               | TLS secret                                                                                                                                                | `false`                  |
| `ingress.tls.hosts`                    | TLS host                                                                                                                                                  | `false`                  |
| `ingress.extraHosts`                   | The list of additional hostnames to be covered with this ingress record.                                                                                  | `[]`                     |
| `ingress.extraPaths`                   | Additional arbitrary path/backend objects                                                                                                                 | `[]`                     |
| `ingress.extraTls`                     | The tls configuration for additional hostnames to be covered with this ingress record.                                                                    | `[]`                     |
| `containerPort`                        | Port to expose at container level                                                                                                                         | `8080`                   |
| `extraContainerPorts`                  | Extra Container Ports to expose at container level                                                                                                        | `nil`                    |
| `resources.limits`                     | The resources limits for the container                                                                                                                    | `{}`                     |
| `resources.requests`                   | The requested resources for the container                                                                                                                 | `{}`                     |
| `affinity`                             | Affinity for pod assignment                                                                                                                               | `{}`                     |
| `nodeSelector`                         | Node labels for pod assignment                                                                                                                            | `{}`                     |
| `tolerations`                          | Tolerations for pod assignment                                                                                                                            | `[]`                     |
| `sidecars`                             | Additional containers to run within the same pod                                                                                                          | `nil`                    |
| `initContainers`                       | Temporary init containers to run before main container up                                                                                                 | `nil`                    |


Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml common-app-chart/
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Configuration and installation details

It is strongly recommended to use immutable tags in a production environment. This ensures your deployment does not change automatically if the same tag is updated with a different image.

### How to use environment variables

In case you want to add environment variables, you can use the `env` property.

```yaml
env:
  - name: ELASTICSEARCH_VERSION
    value: "6"
  - name: LOG_LEVEL
    value: debug
```

### How to use secret environment variables with Banzaicloud Vault Secrets Webhook

Alternatively, you can use a a Secret with the environment variables.

```yaml
secretsManagement:
  bankVault:
    enabled: true
    annotations:
      vault.security.banzaicloud.io/vault-addr: "https://vault:8200"

env:
  - name: DB_PASSWORD
    value: "vault:secrets/data/database#DB_PASSWORD"
  - name: AUTH_TOKEN
    value: "vault:secrets/data/example#AUTH_TOKEN"
```

### Sidecars and Init Containers

If you have a need for additional containers to run within the same pod as app (e.g. an additional metrics or logging exporter), you can do so via the `sidecars` config parameter. Simply define your container according to the Kubernetes container spec.

```yaml
sidecars:
- name: your-image-name
  image: your-image
  imagePullPolicy: Always
  ports:
  - name: portname
    containerPort: 1234
```

Similarly, you can add extra init containers using the `initContainers` parameter.

```yaml
initContainers:
- name: your-image-name
  image: your-image
  imagePullPolicy: Always
  ports:
  - name: portname
    containerPort: 1234
```

### Adding extra volumes

The common-app-chart chart supports mounting extra volumes (either PVCs, secrets or configmaps) by using the `extraVolumes` and `extraVolumeMounts` property. This can be combined with advanced operations like adding extra init containers and sidecars.

### Adding config files to configMap

> **Tip**: Before using this feature, you need to copy your files in chart/config directory!!!

```sh
cp src/main/resources/application.yml chart/config/application.yml
```

```yaml
configMapFile: "application.yml"
```

## Authors

Okassov Marat <marat@qcloudy.io>
