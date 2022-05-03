[Ondrej Sika (sika.io)](https://sika.io) | <ondrej@sika.io> | [go to course ->](#course) | [join slack](https://sika.link/slack-sikapublic), [open slack](https://sikapublic.slack.com) | [join.sika.io](https://join.sika.io)

# ArgoCD Training

## Course

## Core Concepts

<https://argo-cd.readthedocs.io/en/stable/core_concepts/>

- **Application** A group of Kubernetes resources as defined by a manifest. This is a Custom Resource Definition (CRD).
- **Application source type** Which **Tool** is used to build the application.
- **Target state** The desired state of an application, as represented by files in a Git repository.
- **Live state** The live state of that application. What pods etc are deployed.
- **Sync status** Whether or not the live state matches the target state. Is the deployed application the same as Git says it should be?
- **Sync** The process of making an application move to its target state. E.g. by applying changes to a Kubernetes cluster.
- **Sync operation status** Whether or not a sync succeeded.
- **Refresh** Compare the latest code in Git with the live state. Figure out what is different.
- **Health** The health of the application, is it running correctly? Can it serve requests?
- **Tool** A tool to create manifests from a directory of files. E.g. Kustomize or Ksonnet. See **Application Source Type**.
- **Configuration management tool** See **Tool**.
- **Configuration management plugin** A custom tool.

## CLI

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

Reset `admin` password

```
slu argocd password-reset
```

```
slu acd pr
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
