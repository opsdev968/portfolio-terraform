resource "helm_release" "ngnix-ingress-controller" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  # version    = "5.26.0"
  namespace  = "ingress-nginx"
  create_namespace = true
}