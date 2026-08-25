---
title: "Kubernetes"
date: 2024-07-27
tags:
- kubernetes
categories: blog
toc: true
toc_sticky: true
header:
    teaser: "/../assets/2025-07-27-kubernetes/default-thumbnail.png"
excerpt: "Kubernetes has a reputation for being terrifyingly complex, but it doesn't have to be."
---

# Kubernetes

It's orchestration engine and gives basic primitives to orchestrate application deployments on a low level -such as `pods`, `jobs`, `deployments`, `services`, `ingress`, `persisten volumes`, `volume claims`, `secrets`, `configmaps`, `daemon`, and `statefulsets` etc..

![k8s](/../assets/2025-07-27-kubernetes/pesudo-thumbnail.png){: .align-center}

## Basics
If you like cars, before diving into engine specs and horsepower, you first need to know how to drive. In this blog is no different—so before we get under the hood with intermediate concepts, let's briefly touch on the basics to make sure we're all on the same page. Promise we’ll keep it quick!
### Setup
- [Minikube](https://github.com/kubernetes/minikube/releases/latest)
- [Docker Desktop](https://docs.docker.com/desktop/use-desktop/kubernetes/)

### Verify
```sh
kubectl config view  # tells which cluster it talks to
kubectl config view --raw # 
kubectl config view --minify | grep namespace # 
kubectl config get-contexts $(kubectl config current-context)  # details, list every cluster your kubeconfig knows, * is active
kubectl config use-context # switch clusters
kubectl config set-context --current --namespace= # set kubectl context

kubectl api-resources --api-group=apps --namespaced=false
```

```yml
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: XXXX
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
    client-certificate-data: XXXX
    client-key-data: XXXX
```


##### Kubectl CMD

| group-verb | action |
|------------|--------|
| READ       | get    |
| READ       | describe|
| READ       | explain|
| CHANGE     | apply  |
| CHANGE     | edit   |
| CHANGE     | diff   |
| RUN &DEBUG | logs   |
| RUN &DEBUG | exec   |
| RUN &DEBUG | port-forward |


```sh
kubectl apply -f pod.yaml --dry-run=client # does local checks; never contact API server; Good for generate yaml `-o yaml`
kubectl apply -f pod.yaml --dry-run=server # send the object and does what client can't: quota, webhooks, missing references, 
kubectl apply -f pod.yaml # validates and writes to etcd
```



<details>
<summary>kubectl api-resources</summary>
<pre>
<code class="language-markdown">
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
</code>
</pre>
</details>

### K8S 101

![alt text](/../assets/2025-07-27-kubernetes/overview-primitives.png){: .align-center}

##### - **Container**
A sealed application package (Docker)

##### - **Pod**
The smallest and simplest Kubernetes object. It represents a single instance of a running process in your cluster. pods are one or more containers
```sh
kubectl run web-pod --image=gcr.io/google-samples/kubernetes-bootcamp:v1 --dry-run=client -o yml > pod.yml
```
  - *Qos*: Settings `requests` and `limits` influence the `kubelet` to make decision as to which pod to evicit first in the event of resource starvation
  `requests`:: min amount of resource that pod needs.
  `limits`:: define the max amount of resources that you need to supply for a given pod.
    - **Guaranteed**:: Every container must have both CPU and memory limits and requests defined. `requests == limits`
    - **Burstable**:: At least one container has a CPU or memory request that does not equal its limit. `requests defined `
    - **Best Effort**::  No containers have any CPU or memory requests or limits defined. `1st one get killed if resource starvation`
  - *Pod Priority* and *preemption*: Now, what happens if high priority comes when there are no nodes with respective pods? The scheduler will remove low-priority pods



```yaml
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: high-priority-apps
value: 1000000
# preemptionPolicy: Never  # Non-preempting PriorityClass
globalDefault: false
description: "This priority class is reserved for mission-critical core applications."
---
apiVersion: v1
kind: Pod
metadata:
  name: critical-api-pod
  labels:
    app: api-service
spec:
  priorityClassName: high-priority-apps # Linking the pod-priority
  containers:
  - name: web-app
    image: nginx:latest
    # defining resource and limits
    resources:
      requests:
        memory: "256Mi"
        cpu: "500m"
      limits:
        memory: "512Mi"
        cpu: "1000m"
```


  ![sharabled-non-sharable-resources](https://www.cncf.io/wp-content/uploads/2020/08/Kubernetes-Patterns-Capacity-7.jpg)

  - *Sharable Resources* that can be shared among different consumers limited when required. CPU is sharable resources, it pod wants more than limit, it will not get terminated. Kubelet throttles the container, leads to negative performance.
  - *Non sharable resources* that cannot be shared by nature, Memory. when container exceeds it will get killed **OOMKilled**


  - *Health Checks*: `Liveness Probe`,  `Readiness Probe` and `Startup Probe` 


<table>
  <tr>
    <td valign="top">
        <pre>
        Application Running
                │
                ▼
        Liveness Probe
                │
          Healthy?
            /    \
        Yes      No
        │         │
        │     Restart Container
        ▼
        Continue Running
        </pre>
    </td>
    <td valign="top">
          <pre>
          Application Starting
                  │
                  ▼
          Readiness Probe
                  │
            Ready?
            /    \
          Yes     No
          │        │
          │     Don't send traffic
          ▼
          Receive traffic
          </pre>
    </td>
  </tr>
</table>




##### - **Labels** 
Identify metadata attached to objects.  use to determin which objects to apply an operation to primitive objects


```yaml
apiVersion: v1
kind: Pod
metadata:
  name: dev-fe
  labels:
    app: nify
    phase: dev
    role: fe
spec:
  containers:
  - name: nginx
    image: nginx:alpine
---
apiVersion: v1
kind: Pod
metadata:
  name: dev-be
  labels:
    app: nify
    phase: dev
    role: be
spec:
  containers:
  - name: python
    image: python:3.12-alpine
    command: ["python", "-m", "http.server", "8000"]
---
apiVersion: v1
kind: Pod
metadata:
  name: test-fe
  labels:
    app: nify
    phase: test
    role: fe
spec:
  containers:
  - name: httpd
    image: httpd:alpine
---
apiVersion: v1
kind: Pod
metadata:
  name: test-be
  labels:
    app: nify
    phase: test
    role: be
spec:
  containers:
  - name: golang
    image: golang:1.24-alpine
    command:
      - sh
      - -c
      - |
        cat <<'EOF' > /tmp/server.go
        package main

        import (
          "fmt"
          "net/http"
        )

        func main() {
          http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
            fmt.Fprintln(w, "Hello from Go!")
          })
          http.ListenAndServe(":8080", nil)
        }
        EOF
        go run /tmp/server.go
```

![alt text](/../assets/2025-07-27-kubernetes/labels.png){: .align-center}

##### - **Selector**
Query against labels, producing a set result
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nify-service
spec:
  selector:
    app: nify
  ports:
  - port: 80
    targetPort: 80
  type: ClusterIP
```
- Query `App=Nifty`
```sh
kubectl get pods -l App=Nifty
kubectl get pods -l 'App in (Nifty)'
```
![alt text](/../assets/2025-07-27-kubernetes/selector-2.png){: .align-center}


```yml
apiVersion: v1
kind: Service
metadata:
  name: nify-fe-service
spec:
  selector:
    app: nify
    role: fe
  ports:
  - port: 80
    targetPort: 80
  type: ClusterIP
```
- Query `App=Nifty` and `Role=FE`
![alt text](/../assets/2025-07-27-kubernetes/selector-3.png){: .align-center}

```yml
apiVersion: v1
kind: Service
metadata:
  name: nify-dev-service
spec:
  selector:
    app: nify
    phase: dev
  ports:
  - port: 80
    targetPort: 80
  type: ClusterIP
```
- Query `App=Nifty` and `Phase=Dev`
![alt text](/../assets/2025-07-27-kubernetes/selector-4.png){: .align-center}


To test the connection
```yml
kubectl port-forward service/SERVICE_NAME 8080:80
```


##### - **Controller**
A reconcilation loop that drives current state towards desired state

```go
while(true) {
    desired = API Server
    actual  = Cluster

    if desired != actual {
        reconcile()
    }
}
```

##### - **Replica Set**

##### - **Deployment**
Grp of pods of the same type together to achieve load balancing. Greate for stateless workload, where exact copies of app runs and destory, maintain  desired number of apps.


```yaml
apiVersion: apps/v1        # workloads live in apps/v1, not core v1
kind: Deployment           # Pod → Deployment
metadata:
  name: web
  labels:
    app: web
spec:
  replicas: 3              # NEW — how many Pods you want
  selector:
    matchLabels:
      app: web             # NEW — which Pods this Deployment owns; # must match template.metadata.labels below
  template:                # everything below is the Pod, indented one level
    metadata:
      labels:
        app: web           # the Pod's own labels — must satisfy the selector; # the pod Label
    spec:
      containers:
        - name: web
          image: ghcr.io/platformrelay/workshop-web:v1
          ports:
            - containerPort: 8080
          resources:
            requests:
              cpu: 50m
              memory: 64Mi
            limits:
              cpu: 250m
              memory: 128Mi
```

If you plans to go for new Image
```sh
kubectl set image deployment/web web=ghcr.io/platformrelay/workshop-web:v2 # edit the pod with new template image
```


##### - **Rollout**
![rollouts](/../assets/2025-07-27-kubernetes/rollouts.gif)

```sh
kubectl rollout status deployment/web
kubectl rollout history deployment/web
kubectl rollout undo deployment/web
```


##### - **Service**
A set of pods that work together in deployment and Service helps expose your deployment. This exposure can be to other deployments `and/or` to the outside world.
![alt text](/../assets/2025-07-27-kubernetes/service-overview.png){: .align-center}

  - Types of Services ![types](/../assets/2025-07-27-kubernetes/k8s_services.png){: .align-center}
    - **ClusterIP**; Reachable only from within the cluster
    - **NodePort**; ClusterIP + fixed port on the every Node
    - **LoadBalancer**; NodePort+ external IP cloud/provider
    - **Headless** = **ClusterIP:None**; DNS returns Pod IPs directly. This is how `StatefulSets` give each Pod a stable name
    - **ExternalName**; Maps Service to DNS name, returns CNAME record

```yaml
apiVersion: v1
kind: Service
metadata:
  name: string
  namespace: string
  labels: {}
  annotations: {}
spec:
  selector: {}                        # Label selector to target Pods;  map[string]string
  ports:                             # Required: Port configuration;   []ServicePort  name,protocol, port, targetPort
  - name: string                     # Port name (optional)
    protocol: string                 # TCP, UDP, or SCTP (default: TCP)
    port: integer                    # Service port (required)
    targetPort: string/integer       # Pod port (default: same as port)
    nodePort: integer               # Node port (NodePort/LoadBalancer only)
  type: string                       # ClusterIP, NodePort, LoadBalancer, ExternalName
  clusterIP: string                  # Cluster-internal IP address
  clusterIPs: []                     # For dual-stack configurations
  externalIPs: []                    # External IP addresses
  sessionAffinity: string            # None or ClientIP; Distribute requests randomly across Pods ClientIP: Route requests from same client IP to same Pod
  sessionAffinityConfig: {}          # Session affinity configuration
    # clientIP:
    #   timeoutSeconds: 3600           # 1 hr
  externalName: string               # External DNS name (ExternalName only)
  externalTrafficPolicy: string      # Cluster or Local; `LoadBalancer`, `NodePort`
  internalTrafficPolicy: string      # Cluster or Local
  ipFamilies: []                     # IPv4, IPv6 (dual-stack)
  ipFamilyPolicy: string             # SingleStack, PreferDualStack, RequireDualStack
status:
  loadBalancer:                      # LoadBalancer status
    ingress: []                      # External load balancer ingress points
```

###### NodePort

![alt text](/../assets/2025-07-27-kubernetes/nodeport.png)
```yaml
apiVersion: v1
kind: Service
metadata:
  name: web
  labels:
    app: web
spec:
  selector:
    app: web            # the SAME label the Deployment stamps on its Pods;            # picks every Pod carrying this label
  ports:
    - name: http
      port: 80          # the Service port — what clients hit
      targetPort: 8080  # the container port (containerPort in the Pod)
```
![alt text](/../assets/2025-07-27-kubernetes/node-port-on-every-node.png)

Your servie can reach within the Cluster `ClusterIP`. 
Giving `LoadBalancer` every app its own burns on Cloud IP

One L7 entry point in front of many services `Ingress`

if your image is locally build and deploy, if requirement.txt changes it'll be locally cached
###### ClusterIP
![alt text](/../assets/2025-07-27-kubernetes/clusterIP-service.png)
```yaml
# POD
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: Nifty
    role: fe
spec:
  containers:
  - name: nginx-container
    image: nginx
---
# SVC
apiVersion: v1
kind: Service
metadata:
  name: front-end
spec:
  selector:
    app: Nifty
    role: fe
  type: ClusterIP
  ports:
  - targetPort: 80
    port: 80
```
###### HEADLESS <ClusterIP:None>
###### LoadBalancer

##### - **ConfigMap**

##### - **Secrets**

##### - **Namespace**
It provide a mechanism for isolating groups of resources within a single cluster.
![ns](/../assets/2025-07-27-kubernetes/namespace.png)
```sh
kubectl create ns NAMESPACE
kubectl config set-context --current --namespace=NAMESPACE
```

##### - **StatefulSets**
Similar to deployments but used for applications where copies of same application must coordianate with each other to maintain state. It manage the lifecycle of unique copies of pods. make sure networking & storage are reused if unhealthy pod need to be replaced. 

##### - **Volumes**
![alt text](/../assets/2025-07-27-kubernetes/pv-pvc-claim.png){: .align-center}
- ****
https://github.com/hvalfangst/kubernetes-encyclopedia/blob/main/service/REFERENCE.md

##### **Cronjob**
```yml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: devops
spec:
  jobTemplate:
    metadata:
      name: devops
    spec:
      template:
        metadata: {}
        spec:
          containers:
          - image: nginx:latest
            name: cron-devops
            resources: {}
            command:
            - /bin/sh
            - -c
            - echo Welcome to xfusioncorp!
          restartPolicy: OnFailure
  schedule: '*/10 * * * *'                      # schedules
status: {}
```
```sh
kubectl create cronjob devops --image=nginx:latest --schedule='*/10 * * * *' --dry-run=client -o yml # modify it later as above
kubectl get cronjobs devops
kubectl describe cronjobs devops
kubectl get jobs --watch
pods=$(kubectl get pods --selector=job-name=devops-29764270 --output=jsonpath={.items[*].metadata.name})  # replace `devops-29764270` with actual pod which runs job
kubectl logs $pods #  Welcome to xfusioncorp!
```
```log
NAME     SCHEDULE       TIMEZONE   SUSPEND   ACTIVE   LAST SCHEDULE   AGE
devops   */10 * * * *   <none>     False     0        4m6s            5m50s
------------------------------------------------
Name:                          devops
Namespace:                     default
Labels:                        <none>
Annotations:                   <none>
Schedule:                      */10 * * * *
Concurrency Policy:            Allow
Suspend:                       False
Successful Job History Limit:  3
Failed Job History Limit:      1
Starting Deadline Seconds:     <unset>
Selector:                      <unset>
Parallelism:                   <unset>
Completions:                   <unset>
Pod Template:
  Labels:  <none>
  Containers:
   cron-devops:
    Image:      nginx:latest
    Port:       <none>
    Host Port:  <none>
    Command:
      /bin/sh
      -c
      echo Welcome to xfusioncorp!
    Environment:     <none>
    Mounts:          <none>
  Volumes:           <none>
  Node-Selectors:    <none>
  Tolerations:       <none>
Last Schedule Time:  Tue, 04 Aug 2026 15:10:00 +0000
Active Jobs:         <none>
Events:
  Type    Reason            Age    From                Message
  ----    ------            ----   ----                -------
  Normal  SuccessfulCreate  4m48s  cronjob-controller  Created job devops-29764270
  Normal  SawCompletedJob   4m41s  cronjob-controller  Saw completed job: devops-29764270, condition: Complete
------------------------------------------------
NAME              STATUS     COMPLETIONS   DURATION   AGE
devops-29764270   Complete   1/1           7s         5m41s
```



##### Job
A Kubernetes Job is a workload controller that runs finite, short-lived tasks to completion and then stops.
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: countdown-devops
spec:
  template:
    metadata:
      name: countdown-devops
    spec:
      containers:
      - image: ubuntu:latest
        name: container-countdown-devops
        command:
        - /bin/sh 
        - sleep 5
        resources: {}
      restartPolicy: Never
status: {}
```
```sh
kubectl get jobs
```


### Kubernetes Components


https://www.xiaoyeshiyu.com/post/ff15.html


![k8s](https://www.cncf.io/wp-content/uploads/2022/07/1_EoNdB23tkScc846qfovnog.jpg){: .align-center}

- **API Server**: responsible for communication with kubelet on the worker nodes. `Authentication` , `Authorization` of the requestor. It is the one who communicate with *Etcd*

The access process for APIServer is `HTTP Router` very similar to that of other services,
- `AuthN` Authentication
- `Rate Limiter` 
- `Auditing` Audit logs record operations
- `Authz` Authentication, which `RBAC` determines whether the permissions are satisfied
- `Aggregator` are used when you need to add/modify attributes to a reqest, or when you want to bypass Kubernetes native logic and use your own custom logic `APIServer`. Examples include `kubectl top node` these plugins.
- `validation` Validators, syntax validators, etc.


![alt text](/../assets/2025-07-27-kubernetes/api-server.png)


- **Etcd**: key-value store of the critical state of system. Distributed Core Logic snapsotting the status of the k8s cluster developed *CoreOS* used for service discovery, shared configuration, and consistency assurance (such as database leader election, distributed locks ( CAS, CAD ), etc.)
  - CAS Compare And Swap
  - CAD Compare And Delete

Store every object's spec and status. Lose etcd, lose the cluster's memory
{: .notice--danger}



![alt text](/../assets/2025-07-27-kubernetes/etcd.png)
 Microservices write their IP addresses and ports into etcd.
b
- **Kube Controller Manager**: responsible for monitoring the shared state of cluster through apiserver and making it to desired state **Reconcillation Loops**

![alt text](/../assets/2025-07-27-kubernetes/controller-workflow.png)


- **Kube Scheduler**: responsbile for select the worker node for a POD, and provision on target node according to resource specification (affinity, taints,resources) . **Kubelet** does the running


- **Kubelet** The node's Agent watches the API server for pods assign to the ndoe reports their status back.

- **Kube-proxy** Programs the node's networking as a `Service IP` reaches the right pod

- **Container Runtime** **Kubelet** calls over the CRI to pull image and start containers

#### API Server
#### Etcd
#### Kube Controller Manager
#### Kube Scheduler:



```yaml
# desired state
apiVersion:
kind:
metadata:
spec:
  ...

# observed state
status:
  phase: 
  conditions: [...]
```



### Helm

It's a kubernets **package manager**
similar,
- *pip* to python3
- *apt* to debian

```sh
sudo apt-get install curl gpg apt-transport-https --yes  
curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null  
echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list  
sudo apt-get update  
sudo apt-get install helm
```

#### chart packagin
```
my-chart/
.
├── templates         # k8s yaml tempaltes manifests
│__ ├── deployment.yaml
│__ ├── ingress.yaml
│__ └── service.yaml
├── chart.yaml           # metadata like, name, version, deps
└── values.yaml          # default config 
```
#### Templating
#### Versioning & Rollbacks

### Kustomize


### Operator