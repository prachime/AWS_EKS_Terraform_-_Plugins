kubectl patch deployment argocd-server -n argocd \
  --type='json' \
  -p='[{
    "op": "replace",
    "path": "/spec/template/spec/containers/0/resources",
    "value": {
      "requests": {
        "cpu": "50m",
        "memory": "100Mi"
      },
      "limits": {
        "cpu": "200m",
        "memory": "500Mi"
      }
    }
  }]'