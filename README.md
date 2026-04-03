# Azure Infrastructure & Cloud Engineering Lab

Production-ready Azure infrastructure modules, CI/CD pipelines, and cloud security patterns built following Microsoft's [Well-Architected Framework](https://learn.microsoft.com/en-us/azure/well-architected/). Deployed with Bicep, automated with YAML pipelines in Azure DevOps.

## Security Approach

Every module in this repository follows Microsoft's recommended security best practices:

- **Managed Identity authentication** — no hardcoded credentials anywhere
- **Azure RBAC** for all access control (no legacy Key Vault access policies)
- **Key Vault** for all secrets, connection strings, and certificates
- **Network segmentation** with NSGs, private endpoints, and default-deny rules
- **TLS 1.2 minimum**, HTTPS enforced on all endpoints
- **Diagnostic logging** enabled on every resource

## Featured Projects

| Project | Description | Status |
|---------|-------------|--------|
| Reusable Bicep Modules | Modular IaC for networking, compute, storage, security, and monitoring | Planned |
| CI/CD Pipeline Templates | YAML pipelines with security scanning, approval gates, and multi-stage deployment | Planned |
| App Configuration Patterns | Secure connection strings, managed identity auth, Key Vault references | Planned |
| Multi-Environment Deployments | Dev/staging/prod with environment-specific configs and security tiers | Planned |
| AI Services Deployment | Bicep modules for Azure Cognitive Services and Azure OpenAI | Planned |
| Complete Application Stack | Full app with secure service-to-service communication and zero-trust networking | Planned |

## Repository Structure
├── modules/                  # Reusable Bicep modules
│   ├── networking/           # VNets, NSGs, private endpoints
│   ├── compute/              # VMs, App Services with managed identity
│   ├── storage/              # Storage accounts with security defaults
│   ├── security/             # Key Vault (RBAC), role assignments, Azure Policy
│   ├── monitoring/           # Log Analytics, diagnostic settings, alerts
│   └── ai-services/          # Azure AI resource deployments
├── pipelines/                # YAML pipeline templates
│   └── templates/            # Reusable pipeline steps
├── environments/             # Dev/staging/prod parameter files
├── docs/                     # Technical documentation
│   ├── architecture/         # Architecture decisions and diagrams
│   ├── security/             # Security patterns and decisions
│   ├── app-management/       # Connection strings, config, identity patterns
│   └── learning-journal/     # Daily learning notes
└── foundations/              # Phase 1: Environment setup & Git workflow

## Documentation

Technical documentation is organized by topic in the `/docs` directory. Key documents include:

- **Security patterns:** Key Vault integration, managed identity usage, RBAC assignments, environment security tiers
- **App management:** Connection string patterns, Key Vault references in app settings, API fundamentals
- **Architecture:** Design decisions, deployment diagrams, Well-Architected Framework alignment
- **Learning journal:** Daily technical notes documenting the hands-on learning process

## About

This repository documents my progression from Azure administration into enterprise-grade Infrastructure as Code, DevOps automation, and cloud security engineering. Each module is designed to be reusable, secure by default, and production-ready.