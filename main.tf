provider "kubernetes" {
  config_path = "/home/donmeza/.kube/kube-test2/config"
}

locals {
  name = "mon_premier_pod"
}


variable "definition" {
  type = list (object({
    pod_name = string
    namespace = string
    image = string
    isdefault = bool 
  }))


  default = [ {
     pod_name = "carolepod"
     namespace = "rashid"
     image = "marwaney/ssh-server"
     isdefault = false
  },
  {
     pod_name = "carolepod2"
     namespace = "rashid"
     image = "marwaney/ssh-server"
     isdefault = true
  },
  {
     pod_name = "carolepod3"
     namespace = "rashid"
     image = "marwaney/ssh-server"
     isdefault = true
  }
  ]
}
  resource "kubernetes_pod" "mon-premier-pod" {
    count = length(var.definition)
    metadata {
      name = var.definition[count.index].pod_name
      namespace = var.definition[count.index].namespace
      labels = {
        "prenom" = "carole"
      }
    }
  spec{
    container {
      name = local.name 
      image = var.definition[count.index].image
    }
  }  
    
  }
  