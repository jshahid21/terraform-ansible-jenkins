pipeline {

  agent any

  environment {
    SVC_ACCOUNT_KEY = credentials('terraform-auth-js')
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
        sh 'echo $SVC_ACCOUNT_KEY | base64 -d > terraform.tfvars'
      }
    }

    stage('TF Plan') {
      steps {

          sh 'terraform init'
          sh 'terraform plan'
      }
    }

    stage('Approval') {
      steps {
        script {
          def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
        }
      }
    }

    stage('TF Apply') {
      steps {
          sh 'terraform apply -auto-approve'
      }
    }

    stage('Ansible Playbook') {
      steps {
        ansiColor('xterm') {
            ansiblePlaybook(
                playbook: '/var/lib/jenkins/workspace/tajJS/ansible-playbook/main.yml',
                inventory: '/var/lib/jenkins/workspace/tajJS/ansible-playbook/hosts',
                credentialsId('-----BEGIN RSA PRIVATE KEY-----MIIEpAIBAAKCAQEAtuWMtnX6dTDMKxeBP169mol51sPX4uqgPdavpUhb/AbvT68d14sDB6HuSXdRnI6yMgqrdwq89TAlxWgsXp/q/wclCD2hjSq+/BTwEai+kehzuMkCV72vUJ/zwXWpLou+X01DLOrsit71knfXBAxJ9Nug0W4u1mxZl3GPE23mbm6ErKbO42Ni67OiPvzfcdw6QxJuvD/EylcgDxrUABCG9W4XnMHyCRc0l6THaU0zA+USSpboCnKlVETeRMBS59FwYEagzMt4zZmtYeZb1b0qkLU/NKPCpfyTM6+IVcjQFI7Grdgoax9HpkNBnn9240DCNBheoaQN3teZesrrqV1SqwIDAQABAoIBAAqssR7BGgIW/AOT1p5NOEG5vluziHkc+odBbXT3GS9HdFYxQUugOGgMomy1QxUhGvNivgkvnkGtMrcn0lcffEawMxAdEL29ffIWgsB1GdJIP+DMEo/uaToKa96hsGMgEtdbGg2YFIAybSDET89TrElXPDac+KzZHA2DujcHFgjh3xc2LcrVCW9q3zHaD3A06OoD5b9jiqUz3wER3RR3KyhzEDWHplNrXGWUFWixwmvJCwmlTvFo/lHw47KTCzfoTDZkyyk1i5hsI5VjcI/o2YMqfoZ8a5GyXIcz5YoWniCcep9GQ213aVyNvgVHmJQZtj7NI7p0s8SjgGfIU47aBxkCgYEA6LecbaR0AnTEkn9Sa5IKO+LLEK5iyYDuXgG953gCaM5+kSiLeTxP4v8pFjtRzOpO++GhcKyDylmUShCJJUznYjket6ZYqJHA9Yb2c93MHOseARjyL2xhE2J/KJbdJ0WWPC+3Q4zSuPti/6E77siKYRqm8D9huKm+5ih0ssqRzPUCgYEAyTHtVTKy2x0HYeNSSfWdlLOd69sLoNEr+TR1NXYI7C6vOutasIvhGS3mxyWa0FhmlJcd
t7QkA60KBOE986YOhehxoN4ebh6MwR94TxTTtecuDWLGYtQD5F9Q2fUfLfrm7FurDbZrsLx4nVg+p8gajCqvTeJDhcY+2LcmAtju3R8CgYBP3EKoNZlCBoQ2qc7E73bnmiqJbO6lq8MhK4PZ3QsmoEY61ikWz6WyhlG5OV4W7glw0rsuCWWomRkUWZxW2o9E28k4yLMAFhSbrVcB6AlVmzHOuprRv2WI23I7oZn/Ehg+SzmeysK9jDcq9k+038jtDdJf+8AzOL00CooRmQZzyQKBgQCs+E55O8AGnptVLdD2IsJaMF2pgsUpegsbEV1fG94p5yzhM6vhMjDQq+TG+25whj+SqaRz5dw8iMyfS2IukWnU9/SQf8WbmIocEkkle9tTfK/b9Dpohqvd75AcAh/PMPDM7TZO8LD+3dm4NECRkHg6XwwdolO4s6oeOL7mHcilswKBgQC3Ua/w/Jy18XzfuLIa5waCA1hg5cQKq6whO3F2zIuezTX8NM904A+BwzjF04sd/UoY181eWKLwdtP3WfB29d6wOdcZHm+6ADab8TE30fHkQ/ZquApeT7WWQRkbKGY+aMl1aM909rgvLOXKW5NxmflPSUurr5jLKtlvT1JM64XXpg==-----END RSA PRIVATE KEY-----')
                colorized: true)
        }
      }
    }
  }
}
