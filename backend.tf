access_key = ${{ secrets.ACCESS_KEY }}
secret_key = ${{ secrets.SECRET }}
#bucket = "aws-tf-state-bucket-tx"  
#key    = "remotedemo.tfstate"  
#region = "us-east-1"
hostname = "gurpreet1.jfrog.io"
organization = "tf2"
token = ${{ secrets.TOKEN }}
workspaces {
  prefix = "my-prefix-"
}
