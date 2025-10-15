terraform {
  cloud {

    organization = "4social"

    workspaces {
      name = "devops-cli"
    }
  }
}
