provider "aws" {
    region = "eu-west-2"   #"${var.AWS_REGION}"
    access_key = "AKIAZMC2XWDGPNMSLDH7"
    secret_key = "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"
    	default_tags  {
		tags = {
		name =  "${var.OWNERTAG}"
	    owner = "${var.OWNERTAG}"
	    bootcamp = "int"
		expiration_date = "30-02-23"	   
	   }
	}
}

terraform {
 backend "s3" {
   bucket         = "olgag-bucket-1"
   key            = "state/terraform.tfstate"
   region = "eu-west-2"   #"${var.AWS_REGION}"
   access_key = "AKIAZMC2XWDGPNMSLDH7"
   secret_key = "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"  
 }
}