resource "argocd_application" "helm" {
  metadata {
    name      = "prometheus-stack"
    namespace = "argocd"
    labels = {
      test = "true"
    }
  }

  wait = true

  spec {
    source {
      repo_url        = "https://prometheus-community.github.io/helm-charts"
      chart           = "kube-prometheus-stack"
      target_revision = "45.7.1"
      helm {        
        value_files = ["values.yml"]
#         values      = <<EOT
# someparameter:
#   enabled: true
#   someArray:
#   - foo
#   - bar    
# EOT
      #  release_name = "testing"
      }
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "monitoring"
    }
  }
}