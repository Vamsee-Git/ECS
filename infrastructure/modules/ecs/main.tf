resource "aws_ecs_cluster" "main" {
  name = "${var.environment}-ecs-cluster"
  tags = {
    Environment = var.environment
  }
}

resource "aws_ecs_task_definition" "patientservice" {
  family                   = "${var.environment}-patientservice-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = jsonencode([
    {
      name      = "${var.environment}-patientservice-container"
      image     = "${outputs.ecr_repository_url}/patientservice:latest"
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}

resource "aws_ecs_task_definition" "appointmentservice" {
  family                   = "${var.environment}-appointmentservice-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = jsonencode([
    {
      name      = "${var.environment}-appointmentservice-container"
      image     = "${outputs.ecr_repository_url}/appointmentservice:latest"
      essential = true
      portMappings = [
        {
          containerPort = 3001
          hostPort      = 3001
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "patientservice" {
  name            = "${var.environment}-patientservice"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.patientservice.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = var.private_subnets
    security_groups = [aws_security_group.ecs.id]
  }

  load_balancer {
    target_group_arn = var.patientservice_target_group_arn
    container_name   = "${var.environment}-patientservice-container"
    container_port   = 3000
  }
}

resource "aws_ecs_service" "appointmentservice" {
  name            = "${var.environment}-appointmentservice"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.appointmentservice.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = var.private_subnets
    security_groups = [aws_security_group.ecs.id]
  }
  load_balancer {
    target_group_arn = var.appointmentservice_target_group_arn
    container_name   = "${var.environment}-appointmentservice-container"
    container_port   = 3001
  }
}


resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.environment}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_security_group" "ecs" {
  vpc_id = var.vpc_id  # Use the variable instead of module reference

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
