---
title: "Kubernetes"
date: 2026-07-27
tags:
# Work or personal?
- work
categories: blog
toc: true
toc_sticky: true
header:
    teaser: "/../assets/2026-07-27-kubernetes/default-thumbnail.png"
---

# Kubernetes

![k8s](/../assets/2026-07-27-kubernetes/default-thumbnail.png)

## Basics
If you like cars, before diving into engine specs and horsepower, you first need to know how to drive. In this blog is no different—so before we get under the hood with intermediate concepts, let's briefly touch on the basics to make sure we're all on the same page. Promise we’ll keep it quick!
### Setup
- [Minikube](https://github.com/kubernetes/minikube/releases/latest)
- [Docker Desktop](https://docs.docker.com/desktop/use-desktop/kubernetes/)

### Verify
```sh
kubectl config view  # tells which cluster it talks to
kubectl config view --raw # 
kubectl config get-contexts $(kubectl config current-context)  # details
kubectl config use-context # 

kubectl api-resources --api-group=apps --namespaced=false
```

```yml
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJkekNDQVIyZ0F3SUJBZ0lCQURBS0JnZ3Foa2pPUFFRREFqQWpNU0V3SHdZRFZRUUREQmhyTTNNdGMyVnkKZG1WeUxXTmhRREUzT0RRNE16Y3dNalV3SGhjTk1qWXdOekl6TWpBd016UTFXaGNOTXpZd056SXdNakF3TXpRMQpXakFqTVNFd0h3WURWUVFEREJock0zTXRjMlZ5ZG1WeUxXTmhRREUzT0RRNE16Y3dNalV3V1RBVEJnY3Foa2pPClBRSUJCZ2dxaGtqT1BRTUJCd05DQUFRZGxhNnpjaFljbklkVHN3M2U2NmNocG1kL2dEdWdJMkx5UEY3L1BTOXcKWDNsUVRyWnNmaCtsNDZ0eHdiekxyQmVyR3pLL3lDak5tS05PWXFQMlhHK1FvMEl3UURBT0JnTlZIUThCQWY4RQpCQU1DQXFRd0R3WURWUjBUQVFIL0JBVXdBd0VCL3pBZEJnTlZIUTRFRmdRVUo3LzlwZmE1NStkS1ZxZXZTdjRaCm9GaURyZmt3Q2dZSUtvWkl6ajBFQXdJRFNBQXdSUUloQUpjWkRzUzJuUzdOcG9XWHNPUkN0RGdUSER6YS9FdkEKVm1vTG5HSlA0MjhkQWlBcVlNajUyNXhiUFlNVE90WmlsVnZrd1U4bUI4OUtJVkF2VSthZUhBSERlUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
    server: https://127.0.0.1:6443
  name: default
contexts:
- context:
    cluster: default
    user: default
  name: default
current-context: default
kind: Config
users:
- name: default
  user:
    client-certificate-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJrVENDQVRlZ0F3SUJBZ0lJSGs0NGVNd2lGU013Q2dZSUtvWkl6ajBFQXdJd0l6RWhNQjhHQTFVRUF3d1kKYXpOekxXTnNhV1Z1ZEMxallVQXhOemcwT0RNM01ESTFNQjRYRFRJMk1EY3lNekl3TURNME5Wb1hEVEkzTURjeQpNekl3TURNME5Wb3dNREVYTUJVR0ExVUVDaE1PYzNsemRHVnRPbTFoYzNSbGNuTXhGVEFUQmdOVkJBTVRESE41CmMzUmxiVHBoWkcxcGJqQlpNQk1HQnlxR1NNNDlBZ0VHQ0NxR1NNNDlBd0VIQTBJQUJFRHZzNVFOL0cwTHRVVGIKc3p4WW43aXYyeTZSY1drakdmc3lVSjdzaVYrYlVBcXpLNXNKa3RIWWNpcUJDMGRndU5UekwxeDYvNjNsTWVUWQpwYk5pclB1alNEQkdNQTRHQTFVZER3RUIvd1FFQXdJRm9EQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBakFmCkJnTlZIU01FR0RBV2dCU2NhOTk3MWVkMmhBUHJNOUlTMnRsbmtkc1dxVEFLQmdncWhrak9QUVFEQWdOSUFEQkYKQWlCZXBXT2hHSmtvdWk1RVdvbzMxZWFpSDF1MGROYzlrQkdIZmI1ejQ3czlId0loQUtLUTZsM3JWVFhLK1hTdQpuWkUzbUJ6U2Vvd1R1bENQdDBUd0lvY1lmODJnCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0KLS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJlRENDQVIyZ0F3SUJBZ0lCQURBS0JnZ3Foa2pPUFFRREFqQWpNU0V3SHdZRFZRUUREQmhyTTNNdFkyeHAKWlc1MExXTmhRREUzT0RRNE16Y3dNalV3SGhjTk1qWXdOekl6TWpBd016UTFXaGNOTXpZd056SXdNakF3TXpRMQpXakFqTVNFd0h3WURWUVFEREJock0zTXRZMnhwWlc1MExXTmhRREUzT0RRNE16Y3dNalV3V1RBVEJnY3Foa2pPClBRSUJCZ2dxaGtqT1BRTUJCd05DQUFUQnlFd2pKVDF6bVN0OVBuR1MranZGNkN0NklTVkdnTTg0bkNVWGxRZUIKNHVGT3FlZUxheDA4eENRTGozZXpBKzJCNloxaWp2dXpGSkl3QXpoeEJVTm5vMEl3UURBT0JnTlZIUThCQWY4RQpCQU1DQXFRd0R3WURWUjBUQVFIL0JBVXdBd0VCL3pBZEJnTlZIUTRFRmdRVW5HdmZlOVhuZG9RRDZ6UFNFdHJaClo1SGJGcWt3Q2dZSUtvWkl6ajBFQXdJRFNRQXdSZ0loQUxvbnhMeWVpWVYzbXd4M2JoY25mVFZnd0RQbkhxOXkKY2pHaU9PVEpTQ3JpQWlFQTduZ0NGNC9CZ3JJQzhTaDJGaEgvd0V2ZHFSTXZ5czdRd3RWQjFCWWdOUFU9Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
    client-key-data: LS0tLS1CRUdJTiBFQyBQUklWQVRFIEtFWS0tLS0tCk1IY0NBUUVFSUlJcWJXd2FiemFwWGxYRVBwMGswa21RditqWjNpYkxVOGNvd09jaTBHUVJvQW9HQ0NxR1NNNDkKQXdFSG9VUURRZ0FFUU8remxBMzhiUXUxUk51elBGaWZ1Sy9iTHBGeGFTTVorekpRbnV5Slg1dFFDck1ybXdtUwowZGh5S29FTFIyQzQxUE12WEhyL3JlVXg1TmlsczJLcyt3PT0KLS0tLS1FTkQgRUMgUFJJVkFURSBLRVktLS0tLQo=
```
```md
NAME                                SHORTNAMES   APIVERSION                          NAMESPACED   KIND
bindings                                         v1                                  true         Binding
componentstatuses                   cs           v1                                  false        ComponentStatus
configmaps                          cm           v1                                  true         ConfigMap
endpoints                           ep           v1                                  true         Endpoints
events                              ev           v1                                  true         Event
limitranges                         limits       v1                                  true         LimitRange
namespaces                          ns           v1                                  false        Namespace
nodes                               no           v1                                  false        Node
persistentvolumeclaims              pvc          v1                                  true         PersistentVolumeClaim
persistentvolumes                   pv           v1                                  false        PersistentVolume
pods                                po           v1                                  true         Pod
podtemplates                                     v1                                  true         PodTemplate
replicationcontrollers              rc           v1                                  true         ReplicationController
resourcequotas                      quota        v1                                  true         ResourceQuota
secrets                                          v1                                  true         Secret
serviceaccounts                     sa           v1                                  true         ServiceAccount
services                            svc          v1                                  true         Service
mutatingwebhookconfigurations                    admissionregistration.k8s.io/v1     false        MutatingWebhookConfiguration
validatingadmissionpolicies                      admissionregistration.k8s.io/v1     false        ValidatingAdmissionPolicy
validatingadmissionpolicybindings                admissionregistration.k8s.io/v1     false        ValidatingAdmissionPolicyBinding
validatingwebhookconfigurations                  admissionregistration.k8s.io/v1     false        ValidatingWebhookConfiguration
customresourcedefinitions           crd,crds     apiextensions.k8s.io/v1             false        CustomResourceDefinition
apiservices                                      apiregistration.k8s.io/v1           false        APIService
controllerrevisions                              apps/v1                             true         ControllerRevision
daemonsets                          ds           apps/v1                             true         DaemonSet
deployments                         deploy       apps/v1                             true         Deployment
replicasets                         rs           apps/v1                             true         ReplicaSet
statefulsets                        sts          apps/v1                             true         StatefulSet
selfsubjectreviews                               authentication.k8s.io/v1            false        SelfSubjectReview
tokenreviews                                     authentication.k8s.io/v1            false        TokenReview
localsubjectaccessreviews                        authorization.k8s.io/v1             true         LocalSubjectAccessReview
selfsubjectaccessreviews                         authorization.k8s.io/v1             false        SelfSubjectAccessReview
selfsubjectrulesreviews                          authorization.k8s.io/v1             false        SelfSubjectRulesReview
subjectaccessreviews                             authorization.k8s.io/v1             false        SubjectAccessReview
horizontalpodautoscalers            hpa          autoscaling/v2                      true         HorizontalPodAutoscaler
cronjobs                            cj           batch/v1                            true         CronJob
jobs                                             batch/v1                            true         Job
certificatesigningrequests          csr          certificates.k8s.io/v1              false        CertificateSigningRequest
leases                                           coordination.k8s.io/v1              true         Lease
endpointslices                                   discovery.k8s.io/v1                 true         EndpointSlice
events                              ev           events.k8s.io/v1                    true         Event
flowschemas                                      flowcontrol.apiserver.k8s.io/v1     false        FlowSchema
prioritylevelconfigurations                      flowcontrol.apiserver.k8s.io/v1     false        PriorityLevelConfiguration
gatewayclasses                      gc           gateway.networking.k8s.io/v1        false        GatewayClass
gateways                            gtw          gateway.networking.k8s.io/v1        true         Gateway
grpcroutes                                       gateway.networking.k8s.io/v1        true         GRPCRoute
httproutes                                       gateway.networking.k8s.io/v1        true         HTTPRoute
referencegrants                     refgrant     gateway.networking.k8s.io/v1beta1   true         ReferenceGrant
helmchartconfigs                                 helm.cattle.io/v1                   true         HelmChartConfig
helmcharts                                       helm.cattle.io/v1                   true         HelmChart
accesscontrolpolicies                            hub.traefik.io/v1alpha1             false        AccessControlPolicy
aiservices                                       hub.traefik.io/v1alpha1             true         AIService
apiaccesses                                      hub.traefik.io/v1alpha1             true         APIAccess
apibundles                                       hub.traefik.io/v1alpha1             true         APIBundle
apicatalogitems                                  hub.traefik.io/v1alpha1             true         APICatalogItem
apiplans                                         hub.traefik.io/v1alpha1             true         APIPlan
apiportals                                       hub.traefik.io/v1alpha1             true         APIPortal
apiratelimits                                    hub.traefik.io/v1alpha1             true         APIRateLimit
apis                                             hub.traefik.io/v1alpha1             true         API
apiversions                                      hub.traefik.io/v1alpha1             true         APIVersion
managedsubscriptions                             hub.traefik.io/v1alpha1             true         ManagedSubscription
addons                                           k3s.cattle.io/v1                    true         Addon
etcdsnapshotfiles                                k3s.cattle.io/v1                    false        ETCDSnapshotFile
nodes                                            metrics.k8s.io/v1beta1              false        NodeMetrics
pods                                             metrics.k8s.io/v1beta1              true         PodMetrics
ingressclasses                                   networking.k8s.io/v1                false        IngressClass
ingresses                           ing          networking.k8s.io/v1                true         Ingress
ipaddresses                         ip           networking.k8s.io/v1                false        IPAddress
networkpolicies                     netpol       networking.k8s.io/v1                true         NetworkPolicy
servicecidrs                                     networking.k8s.io/v1                false        ServiceCIDR
runtimeclasses                                   node.k8s.io/v1                      false        RuntimeClass
poddisruptionbudgets                pdb          policy/v1                           true         PodDisruptionBudget
clusterrolebindings                              rbac.authorization.k8s.io/v1        false        ClusterRoleBinding
clusterroles                                     rbac.authorization.k8s.io/v1        false        ClusterRole
rolebindings                                     rbac.authorization.k8s.io/v1        true         RoleBinding
roles                                            rbac.authorization.k8s.io/v1        true         Role
deviceclasses                                    resource.k8s.io/v1                  false        DeviceClass
resourceclaims                                   resource.k8s.io/v1                  true         ResourceClaim
resourceclaimtemplates                           resource.k8s.io/v1                  true         ResourceClaimTemplate
resourceslices                                   resource.k8s.io/v1                  false        ResourceSlice
priorityclasses                     pc           scheduling.k8s.io/v1                false        PriorityClass
csidrivers                                       storage.k8s.io/v1                   false        CSIDriver
csinodes                                         storage.k8s.io/v1                   false        CSINode
csistoragecapacities                             storage.k8s.io/v1                   true         CSIStorageCapacity
storageclasses                      sc           storage.k8s.io/v1                   false        StorageClass
volumeattachments                                storage.k8s.io/v1                   false        VolumeAttachment
volumeattributesclasses             vac          storage.k8s.io/v1                   false        VolumeAttributesClass
ingressroutes                                    traefik.io/v1alpha1                 true         IngressRoute
ingressroutetcps                                 traefik.io/v1alpha1                 true         IngressRouteTCP
ingressrouteudps                                 traefik.io/v1alpha1                 true         IngressRouteUDP
middlewares                                      traefik.io/v1alpha1                 true         Middleware
middlewaretcps                                   traefik.io/v1alpha1                 true         MiddlewareTCP
serverstransports                                traefik.io/v1alpha1                 true         ServersTransport
serverstransporttcps                             traefik.io/v1alpha1                 true         ServersTransportTCP
tlsoptions                                       traefik.io/v1alpha1                 true         TLSOption
tlsstores                                        traefik.io/v1alpha1                 true         TLSStore
traefikservices                                  traefik.io/v1alpha1                 true         TraefikService

```
### Excerise
- **Pod**
The smallest and simplest Kubernetes object. It represents a single instance of a running process in your cluster.
```sh
kubectl run web-pod --image=gcr.io/google-samples/kubernetes-bootcamp:v1 --dry-run=client -o yml > pod.yml
```

- **Replica Set**
- **Deployment**
- **Rollout**
- **Service**
    - **ClusterIP**
    - **NodePort**
    - **LoadBalancer**
- **ConfigMap**
- **Secrets**
- **Namespace**
- ****