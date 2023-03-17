resource "argocd_application" "helm" {
  metadata {
    name      = "prometheus-cdrs"
    namespace = "argocd"
    labels = {
      test = "true"
    }
  }

  wait = true

  spec {
    source {
      repo_url        = "https://prometheus-community.github.io/helm-charts"
      chart           = "prometheus-operator-cdrs"
      target_revision = "2.0.0"
      helm {
        # parameter {
        #   name  = "image.tag"
        #   value = "1.2.3"
        # }
        # parameter {
        #   name  = "someotherparameter"
        #   value = "true"
        # }
        value_files = ["values.yml"]
#         values      = <<EOT     <------ עם שניתי משהו!!!
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