# Monolithic-App-Deployment-automation

### Java Capability Issue in Azure DevOps Agent

**Error**
No agent found in pool Default which satisfies the following demand: java

**Root Cause**
JAVA_HOME was either pointing to the bin directory instead of the JDK root, or it was updated after the Azure DevOps agent service had already started. The agent reads environment variables only at startup, so changes were not reflected in agent capabilities.

**Solution**
1. Set JAVA_HOME to the JDK root directory:
```bash
C:\Program Files\Microsoft\jdk-17.0.15.6-hotspot
```
2. Ensure the JDK bin directory is present in the PATH variable.
3. Restart or reconfigure the Azure DevOps agent service so that new environment variables are picked up.
4. As a workaround, explicitly define JAVA_HOME in the pipeline variables.
```bash
variables:
  JAVA_HOME: 'C:\Program Files\Microsoft\jdk-17.0.15.6-hotspot'
```
___

### Azure DevOps Environments and Deployment Jobs

**Environment**
An Environment in Azure DevOps represents a deployment target such as a Virtual Machine, Kubernetes cluster, or App Service. Environments provide visibility, traceability, and access control for deployments.

Key points:
- Environments are created at project level
- Resources (VMs, AKS, etc.) are added to an environment
- Each resource runs its own deployment job
- Environment-level approvals and checks can be applied

**Deployment Jobs**
Deployment jobs are special jobs designed to deploy applications to environment resources.

Key points:
- Defined using the `deployment:` keyword
- Must be linked to an Environment
- Execute directly on the environment resource (for example, a VM)
- Support deployment strategies like runOnce and rolling

Behavior:
- If multiple VMs are added to the same environment, the deployment runs on all VMs
- Artifacts are downloaded directly on the target machine
- No manual copying from build agent to VM is required

**Example Flow**
1. Build pipeline creates an artifact
2. Artifact is stored in Azure Artifacts
3. Deployment job targets an Environment
4. Job runs on each VM resource in that Environment
5. Application is deployed consistently across all machines

**Summary**
Environments define *where* to deploy, and deployment jobs define *how* to deploy. Together, they enable controlled, repeatable, and multi-machine deployments.

___

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

