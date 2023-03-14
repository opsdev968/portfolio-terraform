resource "helm_release" "argo-cd" {
  name  = "argocd"
  repository       = var.helm_repository
  chart            = "argo-cd"
  namespace        = var.kubernetes_argocd_namespace
  version          = var.argocd_helm_chart_version
  create_namespace = true
  # values = [
  #   "${file("/home/adiv/Documents/finalproject/infrastructure/values.yaml")}"
  # ]
  #  set {
  #   name  = "server.insecure"
  #   value = "true"
  # }
  # set {
  #   name  = "server.ingress.enabled"
  #   value = "true"
  # }
  # set {
  #   name  = "ingress.ingressClassName"
  #   value = "nginx"
  # }
  #  set {
  #   name  = "ingress.enabled"
  #   value = "true"
  # }

  set {
    name  = "argocdServerAdminPassword"
    value = "$2y$10$pZMBbXHhWbf/iK3wKJxsfef5mYSTCllXP3XOr8JyfLuUneQyvfGlu"
  }      

  # set {
  #   name  = "server.service.type"
  #   value = "ClusterIP"
  # }
  # set {
  #   name  = "server.ingress.ingressClassName"
  #   value = "nginx"
  # }
  # set {
  #   name  = "server.ingress.hosts"
  #   value = "argoadi.duckdns.org"
  # }
}









