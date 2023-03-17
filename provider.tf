provider "aws" {
    region = "eu-west-2"   #"${var.AWS_REGION}"
    ##access_key = + secret_key from aws access key (other type)  in env variables
    	default_tags  {
		tags = {
		name =  "${var.OWNERTAG}"
	    owner = "${var.OWNERTAG}"
	    bootcamp = "int"
		expiration_date = "30-02-23"	   
	   }
	}
}

provider "kubectl" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  load_config_file       = false

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
}

terraform {
  required_providers {
    ## https://github.com/rallyware/terraform-argocd-apps/blob/main/examples/basic/versions.tf
     argocd = {
      source  = "oboukili/argocd"
      version = ">= 1.2"
     
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.6.0"
    }
  }
  required_version = "~> 1.0"
}

# provider "argocd" {
#   #source  = "oboukili/argocd"
#   #version = ">= 1.2"
#   server_addr = "argocd-server.argocd.svc:80" #"argoolga.duckdns.org" #"${helm_release.argocd.status.ingress[0].host}"
#   username    = "admin"
#   password    = "mustbehere"
#   grpc_web    = true
# }

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name ]
      command     = "aws"
    }
  }
}


#provider "argocd" {
  
  # api_version = "client.authentication.k8s.io/v1beta1"
  #server      =  "argocd.local:443" //"argoolga.duckdns.org"//"https://${helm_release.argocd.status.ingress[0].host}"
  #token       = var.argocd_token  ## auth_token  = "1234..."

#  kubernetes {
#     host                   = module.eks.cluster_endpoint
#     cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name ]
#       command     = "aws"
#     }
#   }
#}

terraform {
 backend "s3" {
   bucket         = "olgag-bucket-1"
   key            = "state/terraform.tfstate"
   region = "eu-west-2"   #"${var.AWS_REGION}"
 }
}