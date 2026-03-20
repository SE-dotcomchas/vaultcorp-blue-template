# VaultCorp — Operation Lockdown

> **SEV-1 INCIDENT** — This app has been deployed to production with critical vulnerabilities.
> Your mission: harden it through GitOps before the Red team finds every hole.

## Quick Start

1. **Fork this repo** (one person per Blue team)
2. Add your teammates as collaborators
3. Create your ArgoCD Application (see below)
4. Start fixing vulnerabilities — every push to `main` triggers ArgoCD auto-sync

## GitOps Workflow

```
Edit manifests/ or app code
        |
   git push main
        |
   ArgoCD detects change (~30s)
        |
   Auto-sync to your namespace
        |
   New pod deploys with your fix
```

**All changes MUST go through Git.** Manual `kubectl edit` will be reverted by ArgoCD self-heal.

## ArgoCD Application

Create this file and apply it to connect your fork to your namespace:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: vaultcorp-blue-X        # your team number
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/YOUR-FORK/vaultcorp-blue-template
    targetRevision: main
    path: manifests
  destination:
    server: https://kubernetes.default.svc
    namespace: blue-X             # your namespace
  syncPolicy:
    automated:
      selfHeal: true
      prune: true
```

```bash
kubectl apply -f argocd-app.yaml
```

## Structure

```
manifests/
  deployment.yaml    # Kubernetes Deployment (FIX THIS)
  service.yaml       # Kubernetes Service (FIX THIS)
Dockerfile           # Container image build (FIX THIS)
app.py               # Application code (FIX THIS)
requirements.txt     # Python dependencies
```

## Rules

- App must stay online — downtime > 2 min = -10 points
- All fixes through Git (ArgoCD reverts manual changes)
- Submit patches via the scoreboard for points
