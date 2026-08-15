variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "allowed_ssh_cidr" {
  description = "Public IPv4 CIDR allowed to SSH to the bastion host (use a single-address /32 CIDR)"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.allowed_ssh_cidr)) && endswith(var.allowed_ssh_cidr, "/32")
    error_message = "allowed_ssh_cidr must be a valid single-address IPv4 /32 CIDR, for example 203.0.113.10/32."
  }
}

variable "temporary_open_ssh" {
  description = "Temporarily allow SSH to the bastion from 0.0.0.0/0 when the client uses rotating public NAT; keep false except while establishing a lab session"
  type        = bool
  default     = false
}

variable "hf_token" {
  description = "Hugging Face Token for gated models (like Gemma)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "model_id" {
  description = "Hugging Face Model ID to serve"
  type        = string
  default     = "google/gemma-4-E2B-it"
}

variable "enable_gpu" {
  description = "Set to true to deploy the optional GPU + vLLM LLM inference node instead of the default CPU + LightGBM node"
  type        = bool
  default     = false
}

variable "cpu_instance_type" {
  description = "Instance type for the default CPU (LightGBM) compute node; t3.small is used because AWS Free Plan blocks t3.medium"
  type        = string
  default     = "t3.small"
}

variable "gpu_instance_type" {
  description = "Instance type for the optional GPU (vLLM) compute node"
  type        = string
  default     = "g4dn.xlarge"
}
