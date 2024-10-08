install-all:
	@make install-essentials
	@make install-argocd

install-argocd:
	@make _install-argocd

install-argocd-with-sso:
	@make _install-argocd EXTRA_ARGS="--values ./argocd.sso.values.yml"

_install-argocd:
	helm upgrade --install \
		argocd argo-cd \
		--repo https://argoproj.github.io/argo-helm \
		--create-namespace \
		--namespace argocd \
		--wait \
		--values ./argocd.values.yml ${EXTRA_ARGS}

install-essentials:
	make install-ingress
	make install-cert-manager
	make install-clusterissuer-letsencrypt

install-ingress:
	helm upgrade --install \
		ingress-nginx ingress-nginx \
		--repo https://kubernetes.github.io/ingress-nginx \
		--create-namespace \
		--namespace ingress-nginx \
		--wait \
		--values ./cluster/ingress-nginx.values.yml

install-ingress-with-proxy-protocol:
	slu scripts kubernetes install-ingress --use-proxy-protocol

install-cert-manager:
	helm upgrade --install \
		cert-manager cert-manager \
		--repo https://charts.jetstack.io \
		--create-namespace \
		--namespace cert-manager \
		--wait \
		--values ./cluster/cert-manager.values.yml

install-clusterissuer-letsencrypt:
	kubectl apply -f cluster/clusterissuer-letsencrypt.yml
