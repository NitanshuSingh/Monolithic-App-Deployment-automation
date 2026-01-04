# Monolithic-App-Deployment-automation

# Azure DevOps Artifacts – Universal Packages  
## Publish & Consume Artifacts Using Feeds

---

## 1. Purpose

This document explains how to **publish and download build artifacts** using **Azure DevOps Artifacts (Universal Packages)**.  
Universal Packages provide a **centralized, versioned, and secure** way to store deployable artifacts and reuse them across pipelines and environments.

---

## 2. Prerequisites

### 2.1 Azure DevOps Requirements
- Azure DevOps **Project**
- **Artifacts** feature enabled
- Pipeline with access to the project

---

### 2.2 Agent Requirements

#### Self-hosted Agent
- Windows or Linux
- Network access to Azure DevOps
- One of the following:
  - **UniversalPackages@0 task** (recommended)
  - OR **Azure CLI + azure-devops extension** (optional)

> ⚠️ **Note**  
> The UniversalPackages task **does not require Azure CLI**.  
> Azure CLI is required only if packages are managed via scripts.

---

## 3. Setup Steps

---

### 3.1 Create an Artifact Feed

1. Azure DevOps → **Artifacts**
2. Click **Create Feed**
3. Configure:
   - Feed name (example: `todo-artifacts`)
   - Scope:
     - **Project-scoped** (recommended)
     - Organization-scoped (for cross-project sharing)

**Best Practice:**  
Use **one feed per project** and separate packages by name and version.

---

### 3.2 Configure
