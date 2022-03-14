
# Prometheus Alerting Rules Integrator - K8s

Add prometheus alerts for applications on K8s.

## How we do this?

Just add prometheus rules to the respective directories and run the helm apply command

### Prerequisites

Alerting rules should be validated before onboarding via pull requests.

Each team should at least have a slack and opsgenie/pagerduty or whatever routing route setup on Prometheus. Teams should have an idea of what kind of alerts should be sent to the respective channels.
You can design this as per the org standards. Easy org has diff policies. 

### How to onboard my Application alerts to the rules engine?

Follow the steps below:

1. Fork the repo
2. Add alerts to the directory structure mentioned below.
3. Run the helm apply command.

### Alert query creation steps:

1. Write the PromQL and validate the metrics
https://$PROMETHEUS-ENDPOINT/prometheus/
2. Goto rules directory and create the application folder [We made it like this for better visibility and managebility]
```
Directory Structure of Alerts:

|____rules
| |____platforms
| | |____$ServiceNAME
| | | |____uptimetrack.yaml
| |____devops
| | |____k8s
| | | |____resources.yaml
| | | |____worker-node.yaml
| | |____state-metrics
| | | |____kube-state.yaml
| | |____coredns
| | | |____latency-coredns.yaml
...
...


prometheus-alerts-k8s/removeold.sh
This will help in removing old rules and apply only the latest commits. This helps in reducing the helm apply time to 10 seconds and bulds will be fast.
```
3. Paste the alert yaml file in the application dir rules/$TEAM/$APP_NAME/$Name.yaml. 
4. Run helm apply
## What happens in the backend when Jenkins job is triggered?

* We have templated the Alert rule generation using Helm templating. This makes rules directory human-readable!
* When a new file is added a new PrometheusRule CRD is generated. 
* We push this template to Helm repo and once applied we are done.

## Resources
* [Prometheus Alert Manager](https://prometheus.io/docs/alerting/alertmanager/) - Alert Manager
* [PromQL examples](https://prometheus.io/docs/prometheus/latest/querying/examples/) - Getting started with PromQL

## Future tasks 

## FAQs:

* #### Why not make it part of application repo?

1. Reduces complexity of the values.yaml file.
2. Can be centrally managed and good visibilty. 
3. We have a single source of truth GitHub for all alerts.

* #### Why do we need an alert manager repo?
1. It's a centralized repo for managing alerts thus simplifying updates and tracking changes.
2. Configuring alerts on Grafana directly is bad practice and does not scale as well. Less visibility and auditing.

