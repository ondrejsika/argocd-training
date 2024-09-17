[Ondrej Sika (sika.io)](https://sika.io) | <ondrej@sika.io> | [go to course ->](#course) | [join slack](https://sika.link/slack-sikapublic), [open slack](https://sikapublic.slack.com) | [join.sika.io](https://join.sika.io)

# ArgoCD Training

## Course

## Install ArgoCD

Install cluster essentials (ingress-nginx, cert-manager, letsencrypt issuer)

```
make install-essentials
```

Install ArgoCD

```
make install-argocd
make install-essentials
```

Get `admin` initial password

```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo
```

Using [slu](https://github.com/sikalabs/slu)

```
slu argocd initial-password
```

Copy to pasteboard (Mac)

```
slu argocd initial-password | pbcopy
```

See

<https://argocd.k8s.sikademo.com>

## Install ArgoCD with SSO

Create `argocd.sso.values.yml`

```
cp argocd.sso.values.EXAMPLE.yml argocd.sso.values.yml
```

Install

```
make install-argocd-with-sso
```

## Create basic ArgoCD App

Declarative

```
kubectl apply -f examples/apps/manifests_v1.yml
```

## Create ArgoCD App from own repository

Fork [ondrejsika/argocd-training](https://github.com/ondrjsika/argocd-training) to Gitlab.

## Manual Sync

Make changes to your repository ([gitlab.sikademo.com/ondrejsika/argocd-training](https://gitlab.sikademo.com/ondrejsika/argocd-training)) and see if ArgoCD propagate those changes to cluster.

Update repo path

```
kubectl apply -f examples/apps/manifests_gitlab_v1.yml
```

You can click **refresh** to fetch new repo version.

Nothing is updated, you can see diff of current state and desired state.

If you want to apply those new changes, you have to click **sync**.

## Create Namespace

ArgoCD don't create namespace for application by default. You have to specify syncOptions `CreateNamespace=true`:

```yaml
spec:
  # ...
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
```

## Automatic Sync and Prune

You have to enable automatic sync and prunning by:

```yaml
spec:
  # ...
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

## Delete resources after delete App

Add finalizer:

```yaml
metadata:
  # ...
  finalizers:
    - resources-finalizer.argocd.argoproj.io
```

Try it

```
kubectl apply -f examples/apps/manifests_v2.yml
```

or

```
kubectl apply -f examples/apps/manifests_gitlab_v2.yml
```

## ArgoCD App with Helm

Helm package from Git repo

```
kubectl apply -f examples/helm_from_git.yml
```

Helm package from Helm repo

```
kubectl apply -f examples/helm_from_package.yml
```

You can also install Helm without any specific helm configuration

```
kubectl apply -f examples/helm_with_dependencies.yml
```

## Private Repositories

HTTPS

```
kubectl apply -f examples/repos/repo-https.yml
```
SSH

```
kubectl apply -f examples/repos/repo-https.yml
```

## Own SSH known hosts

Get keys using `ssh-keyscan`

```
ssh-keyscan gitlab.sikademo.com
```

Add to `configmap` `argocd-ssh-known-hosts-cm` in `argocd` namespace.

```
kubectl patch -n argocd configmap argocd-ssh-known-hosts-cm --patch-file examples/argocd-ssh-known-hosts-cm-patch.yml
```

## App of Apps

App of Apps is global ArgoCD app which is created manually in the cluster and manages all others ArgoCD Apps using ArgoCD

```
kubectl apply -f examples/app_of_apps/app_of_apps.yml
```

or

```
kubectl apply -f https://raw.githubusercontent.com/ondrejsika/argocd-training/master/examples/app_of_apps/app_of_apps.yml
```

## Sync Hooks

[Resource Hooks Docs](https://argo-cd.readthedocs.io/en/stable/user-guide/resource_hooks/)

Example with pre & post sync hooks.

```
kubectl apply -f examples/sync-hooks/app-of-apps.yml
```

## Sync Waves

Example of sync waves

```
kubectl apply -f examples/sync-waves/app-of-apps.yml
```

## ArgoCD App Projects

```
kubectl apply -f examples/appproj/appproj_foo.yml
kubectl apply -f examples/appproj/appproj_bar.yml
```

## Sync Window

We can specify SyncWindow at AppProject by:

```yaml
spec:
  syncWindows:
  - applications:
    - '*'
    duration: 10m
    kind: allow
    schedule: 0 * * * *
    timeZone: UTC
```

Try:

```
kubectl apply -f examples/appproj/app_bar.yml
```

## Application Set

Application Set is a way how to create multiple ArgoCD Apps from one template.

```
kubectl apply -f examples/appset.yml
```

## ArgoCD Image Updater

- Docs - https://argocd-image-updater.readthedocs.io/en/stable/
- Github - https://github.com/argoproj-labs/argocd-image-updater

### Install

```
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/manifests/install.yaml
```

### Public Example

```
kubectl apply -f examples/image_updater/helm_public.yml
```

### Private Example

Allow Image Updater to access secrets in all namespaces

```
kubectl apply -f examples/argocd_image_updater_read_secrets_in_all_namespaces.yml
```

Apply the example

```
kubectl apply -f examples/image_updater/helm_private.yml
```


### slu CLI

Get Initial `admin` password

```
slu argocd initial-password
```

```
slu acd ip
```

```
slu acd ip | pbcopy
```

Get / Open ArgoCD URL

```
slu argocd get
```

```
slu argocd open
```

Reset `admin` password

```
slu argocd password-reset
```

```
slu acd pr
```

Port forward to ArgoCD without Ingress

```
slu argocd port-forward
```

```
slu acd pf
```

## Thank you! & Questions?

That's it. Do you have any questions? **Let's go for a beer!**

### Ondrej Sika

- email: <ondrej@sika.io>
- web: <https://sika.io>
- twitter: [@ondrejsika](https://twitter.com/ondrejsika)
- linkedin: [/in/ondrejsika/](https://linkedin.com/in/ondrejsika/)
- Newsletter, Slack, Facebook & Linkedin Groups: <https://join.sika.io>

_Do you like the course? Write me recommendation on Twitter (with handle `@ondrejsika`) and LinkedIn (add me [/in/ondrejsika](https://www.linkedin.com/in/ondrejsika/) and I'll send you request for recommendation). **Thanks**._

Wanna to go for a beer or do some work together? Just [book me](https://book-me.sika.io) :)

## Past Training Sessions

### 2024-09-17

- My changes in this repo - https://github.com/sika-training-examples/2024-09-17_ondrej-argocd-training
- ArgoCD Apps Monorepo - https://github.com/sika-training-examples/2024-09-17_argocd_apps_example

### 2023-12-01

- Repositories
  - My changes in this repo - https://github.com/sika-training-examples/2024-04-22-argocd-training-ondrejsika
  - ArgoCD Apps - https://github.com/sika-training-examples/2024-02-22-argocd-apps
  - Example project with Gitlab CI pipeline - https://github.com/sika-training-examples/2024-04-22-argocd-example-pipeline

- Repositories from gitlab.sikademo.com
  - example/os - https://github.com/sika-training-examples/2023-12-01_argocd_training_ondrejsika
  - example/1 - https://github.com/sika-training-examples/2023-12-01_argocd_training_1
  - example/2 - https://github.com/sika-training-examples/2023-12-01_argocd_training_2
  - example/3 - https://github.com/sika-training-examples/2023-12-01_argocd_training_3

## My Notes

Replace README of training repo with link to this repo

```
echo '# !!! This is not an original ArgoCD Training repo. This repo has many changes from past training session. If you want to see an original ArgoCD training repo, please go to [ondrejsika/argocd-training](https://github.com/ondrejsika/argocd-training)' > README.md
```
