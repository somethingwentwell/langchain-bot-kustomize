# langchain-bot-kustomize

## Set up local environment using kind

```
## https://kind.sigs.k8s.io/docs/user/ingress/#using-ingress

cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
EOF

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```

## Use script to create overlay

1. hostPath
```
sudo bash ./create_overlay.sh --template-type hostPath \
 --overlay-folder-name test001 \
 --postgres-pv-name postgres-pv-001 \
 --postgres-data-path postgres-data-001 \
 --insource-pv-name insource-pv-001 \
 --insource-data-path insource-data-001 \
 --insource-namespace insource001 \
 --insource-ingress-host insource.local \
 --insource-ingress-root-path test001
```

2. AzureFiles
```
sudo bash ./create_overlay.sh --template-type AzureFiles \
 --overlay-folder-name test003 \
 --postgres-pv-name postgres-pv-003 \
 --postgres-data-path postgres-data-003 \
 --insource-pv-name insource-pv-003 \
 --insource-data-path insource-data-003 \
 --insource-namespace insource003 \
 --insource-ingress-host insource.southeastasia.cloudapp.azure.com \
 --insource-ingress-root-path test003
```

## Apply overlay

```
kubectl apply -k ./kustomize/overlay/test001
```
