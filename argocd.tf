resource "helm_release" "argocd" {
  name  = "argocd"
  repository       = var.helm_repository
  chart            = "argo-cd"
  namespace        = var.kubernetes_argocd_namespace
  version          = var.argocd_helm_chart_version
  create_namespace = true
  # values = [
  #   "${file("/home/adiv/Documents/finalproject/infrastructure/values.yaml")}"
  # ]

  set {
    name  = "configs.params.server\\.insecure"
    value = "true"
  }
  set {
    name  = "server.ingress.enabled"
    value = "true"
  }
   set {
    name  = "server.ingress.ingressClassName"
    value = "nginx"
  }


  #  set {
  #   name  = "ingress.enabled"
  #   value = "true"
  # }

  set {
    name  = "argocdServerAdminPassword"
    value = "123456"
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
