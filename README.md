[Ondrej Sika (sika.io)](https://sika.io) | <ondrej@sika.io> | [go to course ->](#course) | [join slack](https://sika.link/slack-sikapublic), [open slack](https://sikapublic.slack.com) | [join.sika.io](https://join.sika.io)

# ArgoCD Training

## Course

## Setup

acd alias

```
alias acd="argocd "
```

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
slu argocd initial-password
```

Copy to pasteboard (Mac)

```
slu argocd initial-password | pbcopy
```

See

<https://argocd.k8s.sikademo.com>


### Login to argocd CLI

Login

```bash
acd login <argocd_domain_port>
```

Login "without" password

```bash
acd login $(slu acd domain) --username admin --password $(slu acd initial-password)
```

## Create basic ArgoCD App

Using CLI

```
argocd app create example-1 --repo https://github.com/argocd-training/example-1.git --path . --dest-server https://kubernetes.default.svc --dest-namespace default
```

Declarative

```
kubectl apply -f argocd-app-example-1.yml
```

## Create ArgoCD App from own repository

Fork [argocd-training/example-1](https://github.com/argocd-training/example-1) to Gitlab.

Create ArgoCD App using CLI

```
argocd app create example-1-own --repo https://gitlab.sikademo.com/ondrejsika/example-1.git --path . --dest-server https://kubernetes.default.svc --dest-namespace example-1-own --sync-option CreateNamespace=true
```

See YAML:

```
kubectl -n argocd get app example-1-own -o yaml
```

## Manual Sync

Make changes to your repository ([gitlab.sikademo.com/ondrejsika/example-1](https://gitlab.sikademo.com/ondrejsika/example-1)) and see if ArgoCD propagate those changes to cluster.

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

## ArgoCD App with Helm

```
kubectl apply -f argocd-app-example-2.yml
```

or another way

```
kubectl apply -f argocd-app-helm.yml
```

## Sync Hooks

Example with pre & post sync hooks

```
kubectl apply -f argocd-app-sync-hooks.yml
```

## Own SSH known hosts

Get keys using `ssh-keyscan`

```
ssh-keyscan gitlab.sikademo.com
```

Add to `configmap` `argocd-ssh-known-hosts-cm` in `argocd` namespace.

```
kubectl patch -n argocd configmap argocd-ssh-known-hosts-cm --patch-file argocd-ssh-known-hosts-cm-patch.yml
```

## Private Repositories

HTTPS

```
kubectl apply -f repo-https.yml
```
SSH

```
kubectl apply -f repo-https.yml
```

## ArgoCD App Projects

```
kubectl apply -f approj-foo.yml
kubectl apply -f approj-bar.yml
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
kubectl apply -f argocd-app-bar.yml
```

## App of Apps

App of Apps is global ArgoCD app which is created manually in the cluster and manages all others ArgoCD Apps using ArgoCD

```
kubectl apply -f https://raw.githubusercontent.com/argocd-training/examples/master/app-of-apps.yml
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
