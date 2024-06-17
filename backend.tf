access_key = ${{ secrets.ACCESS_KEY }}
secret_key = ${{ secrets.SECRET }}
#bucket = "aws-tf-state-bucket-tx"  
#key    = "remotedemo.tfstate"  
#region = "us-east-1"
terraform {
    backend "remote" {
        hostname = "gurpreet1.jfrog.io"
        organization = "tf2"
        token = ${{ secrets.TOKEN }}
        workspaces {
          # name = "dev"
          prefix = "my-prefix-"
        }
    }
}
