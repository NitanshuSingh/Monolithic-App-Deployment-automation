# Monolithic-App-Deployment-automation

# Azure DevOps Artifacts – Universal Packages

## Publish and Consume Build Artifacts

### 1. Overview
This document describes the complete process of publishing and consuming build artifacts using Azure DevOps Artifacts (Universal Packages). Universal Packages provide a centralized, versioned, and secure mechanism to store deployable outputs and reuse them across multiple pipelines and environments.

### 2. Prerequisites

#### 2.1 Azure DevOps
- Azure DevOps organization and project
- Artifacts feature enabled
- CI/CD pipeline configured

#### 2.2 Agent Requirements
- Self-hosted agent (Windows or Linux)
- Network access to Azure DevOps
- UniversalPackages@0 task available
- Azure CLI with azure-devops extension (optional)

> Note: UniversalPackages task does not require Azure CLI. Azure CLI is only required for CLI-based artifact management.

### 3. Artifact Feed Setup

#### 3.1 Create a Feed
1. Navigate to Azure DevOps → Artifacts
2. Click Create Feed
3. Provide a feed name (e.g. todo-artifacts)
4. Select Project-scoped feed (recommended)

#### 3.2 Configure Feed Permissions
Pipelines run using a service identity, not a human user.

Required identities:
- <Project Name> Build Service (<Organization>)
- Optional individual users

Steps:
1. Artifacts → Feed → Settings
2. Open Permissions
3. Add <Project Name> Build Service (<Organization>)
4. Grant Contributor or minimum AddPackage permission

### 4. Optional Azure CLI Setup
Required only for script-based artifact operations.

```bash
az extension add --name azure-devops
az devops configure --defaults organization=https://dev.azure.com/<org> project=<project>
```

### 5. Publish Universal Package

```yaml
- task: UniversalPackages@0
  displayName: Publish Universal Package
  inputs:
    command: publish
    publishDirectory: '$(Build.ArtifactStagingDirectory)'
    feedsToUsePublish: internal
    vstsFeedPublish: todo-artifacts
    vstsFeedPackagePublish: todo-web
    versionOption: custom
    versionPublish: 1.0.$(Build.BuildId)
    description: Todo web application build
```

### 6. Download Universal Package

```yaml
- task: UniversalPackages@0
  displayName: Download Universal Package
  inputs:
    command: download
    feedsToUse: internal
    vstsFeed: todo-artifacts
    vstsFeedPackage: todo-web
    vstsPackageVersion: latest
    downloadDirectory: '$(Pipeline.Workspace)/artifacts'
```

### 7. Versioning and Rollback
Use semantic or build-based versioning such as 1.0.<BuildId> or 1.1.<ReleaseId>. Rollback can be done by specifying a previous package version in the download task. No rebuild is required.

### 8. Advantages
- Centralized artifact storage
- All versions available at one place
- Tagging support for rollback and release identification
- Secure access using role-based permissions
- Supports build once deploy many strategy

### 9. Best Practices
- Use Universal Packages for deployable outputs
- Grant permissions to Build Service, not only users
- Keep feeds project-scoped unless cross-project sharing is required
- Avoid rebuilding artifacts for higher environments
- Periodically clean up old package versions

### 10. Common Issues
| Issue | Cause | Fix |
|------|------|-----|
| AddPackage permission error | Build Service missing permission | Grant Contributor or AddPackage |
| Upload completes then fails | Permission validated at final step | Same fix |
| Download fails | Feed permission missing | Add Build Service |

### 11. Summary
Azure DevOps Artifacts Universal Packages provide a secure, versioned, and scalable artifact solution. Combined with environments and deployment jobs, they enable a production-ready CI/CD pipeline.

Build once, store centrally, deploy everywhere.

<img width="1532" height="335" alt="image" src="https://github.com/user-attachments/assets/493efa6a-aa4e-4662-836b-6ef6d5e9e594" />

