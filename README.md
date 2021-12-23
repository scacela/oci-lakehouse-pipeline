# oci-streaming-pipeline
Deploy a pipeline for streaming, warehousing, processing and analyzing data.

### What can the stack provision?
<details>
<summary>Compartment</summary>
<p></p>
<pre>
Logical container for resources, used to manage access to resources as part of Identity and Access Management (IAM).
</pre>
</details>
<details>
<summary>Virtual Cloud Network</summary>
<p></p>
<pre>
Customizable and private cloud network.
</pre>
</details>
<details>
<summary>Data Science Platform</summary>
<p></p>
<pre>
Build, train, deploy, and manage machine learning models with a data science cloud platform built for teams.
</pre>
</details>
<details>
<summary>Data Integration Platform</summary>
<p></p>
<pre>
Extract, transform and load (ETL) data for data science and analytics. Design code-free data flows into data lakes and data marts.
</pre>
</details>
<details>
<summary>Autonomous Data Warehouse</summary>
<p></p>
<pre>
Managed data warehouse service that automates provisioning, configuring, securing, tuning, scaling, and backing up of the data warehouse. It includes tools for self-service data loading, data transformations, business models, automatic insights, and built-in converged database capabilities that enable simpler queries across multiple data types and machine learning analysis.
</pre>
</details>
<details>
<summary>Analytics Cloud Platform</summary>
<p></p>
<pre>
Provides the capabilities required to address the entire analytics process from data ingestion and modeling, through data preparation and enrichment, to visualization and collaboration without compromising security and governance.
</pre>
</details>
<details>
<summary>Object Storage Bucket</summary>
<p></p>
<pre>
Securely store any type of data in its native format, with built-in redundancy.
</pre>
</details>
<details>
<summary>Data Catalog</summary>
<p></p>
<pre>
Metadata management service that helps data professionals discover data and support data governance. Designed specifically to work well with the Oracle ecosystem, it provides an inventory of assets, a business glossary, and a common metastore for data lakes.
</pre>
</details>
<details>
<summary>Streaming</summary>
<p></p>
<pre>
Real-time, serverless, Apache Kafka-compatible event streaming platform for developers and data scientists.
</pre>
</details>

### Prerequisites
- Fully-privileged access to an OCI Tenancy (account).
- (CLI Terraform deployment only) Terraform set up on your local machine. You can access the steps [here](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformgetstarted.htm).
- Sufficient availability of resources. You can check resource availability [here](https://cloud.oracle.com/limits?region=home).


### Deployment via Resource Manager


1. Click [![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?region=home&zipUrl=https://github.com/scacela/oci-streaming-pipeline/archive/refs/tags/v1.0.0.zip)
2. Follow the steps outlined in [this documentation](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Tasks/deploybutton.htm#ariaid-title4), starting from Step 2.

### Deployment via CLI Terraform


1. [Download this project](https://github.com/scacela/oci-streaming-pipeline/archive/refs/tags/v1.0.0.zip) to your local machine.
2. [Set up CLI Terraform on your local machine.](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformgetstarted.htm) 
3. Navigate to project folder on your local machine via CLI.
<pre>
cd &ltYOUR_PATH_TO_THIS_PROJECT&gt
</pre>
4. Open your local copy of [vars.tf](./vars.tf) and edit the values that are assigned to the objects of type variable, which will influence the stack topology according to your preferences.
5. Initialize your Terraform project, downloading necessary packages for the deployment.
<pre>
terraform init
</pre>
6. View the plan of the Terraform deployment, and confirm that the changes described in the plan reflect the changes you wish to make in your OCI environment.
<pre>
terraform plan
</pre>
7. Apply the changes described in the plan, and answer <b>yes</b> when prompted for confirmation.
<pre>
terraform apply
</pre>
8. You can track the logs associated with the job by monitoring the output on the CLI. After the deployment has finished, review the output information at the bottom of the logs for instructions on how to access the nodes in the topology.