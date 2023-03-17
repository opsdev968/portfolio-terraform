resource "null_resource" "argocdcli" {
  provisioner "local-exec" {
    command = "sudo curl --silent --location -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v2.4.7/argocd-linux-amd64 && sudo chmod +x /usr/local/bin/argocd && argocd login argoolga.duckdns.org --insecure --username admin --password $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath=\"{.data.password}\" | base64 -d)"
  }
}

resource "null_resource" "argocdcli-deploy-app" {
  provisioner "local-exec" {
    command = "argocd app delete -y todoapp && argocd app create todoapp     --repo https://github.com/opsdev968/portfolio-gitops.git     --path todoapp     --dest-server https://kubernetes.default.svc     --dest-namespace default     --project default     --revision HEAD     --grpc-web &&  argocd app sync todoapp"
  }
}

resource "null_resource" "argocdcli-deploy-crds" {
  provisioner "local-exec" {
    command = "argocd app delete -y prometheus-cdrs && argocd app create prometheus-cdrs  --repo https://prometheus-community.github.io/helm-charts  --chart  prometheus-operator-cdrs --target_revision = 2.0.0     --dest-server https://kubernetes.default.svc     --dest-namespace monitoring     --project default  --grpc-web &&  argocd app sync prometheus-cdrs"
  }
}

resource "null_resource" "argocdcli-deploy-stack" {
  provisioner "local-exec" {
    command = "argocd app delete -y prometheus-stack && argocd app create prometheus-stack  --repo https://prometheus-community.github.io/helm-charts  --chart  kube-prometheus-stack --target_revision = 45.7.1     --dest-server https://kubernetes.default.svc     --dest-namespace monitoring     --project default  --grpc-web &&  argocd app syncprometheus-stack"
  }
}