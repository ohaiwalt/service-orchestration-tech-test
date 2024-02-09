terraform {}

provider "aws" {}

resource "aws_ecr_repository" "pw" {
  name                 = "mwalter-test-pw"
  image_tag_mutability = "MUTABLE"
}
