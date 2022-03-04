# oci-lakehouse-pipeline
Deploy a pipeline for streaming, warehousing, processing and analyzing data.

## Table of Contents

- [What can the stack provision?](#what-can-the-stack-provision)
- [Prerequisites](#prerequisites)
- [Deployment via Resource Manager](#deployment-via-resource-manager)
- [Deployment via CLI Terraform](#deployment-via-cli-terraform)

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
- Sufficient availability of resources in your OCI Tenancy. You can check resource availability [here](https://cloud.oracle.com/limits?region=home).


### Deployment via Resource Manager
For general Resource Manager deployment steps, you can refer to [this documentation](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Tasks/deploybutton.htm#ariaid-title4). For steps that are specific to this stack, proceed to Step 1.


1. Click the button, opening the link into a new browser tab:
\
\
[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?region=home&zipUrl=https://github.com/scacela/oci-streaming-pipeline/archive/refs/tags/v1.0.1.zip)
2. Log into your Oracle Cloud Infrastructure (OCI) tenancy with your user credentials. You will then be redirected to the `Stack Information` section of Resource Manager.
3. In the `Stack Information` section, select the checkbox to confirm that you accept the [Oracle Terms of Use](https://cloudmarketplace.oracle.com/marketplace/content?contentId=50511634&render=inline).
4. Click `Next` to proceed to the `Configure Variables` section.
5. For each resource that you wish to deploy, verify that the corresponding checkbox is selected in the `Select Resources` tile.
\
\
Optionally, you can customize the attributes of each selected resource once its respective "details" tile appears below.
\
\
If Oracle Analytics Cloud (OAC) is one of the resources that you wish to deploy, you will need to generate an access token to use for the `OAC IDCS Access Token` field. To walk through this process, please follow this sub-steps series:
\
\
	<b>Generate an Access Token for OAC Deployment:</b>
	1. Duplicate your browser tab where you are signed into the OCI UI, and switch to that tab, or if you are not already signed into the OCI UI, open a new browser tab and navigate to `cloud.oracle.com` and sign in with your OCI user credentials.
	2. Click the Hamburger icon at the top-left of the OCI UI.
	3. Type `federation`, and click `Federation` on the right-hand side of the page once it auto-populates.
	4. Click the hyperlinked name of your identity provider of type IDCS (Oracle Identity Cloud Service).
	5. Click the link next to `Oracle Identity Cloud Service Console:`
	6. To create an IDCS Application that can be used to generate access tokens, follow this sub-steps series:
\
\
		<b>(One-Time Only) Generate an IDCS Application:</b>
		1. Click the `+` icon on the tile labeled, `Applications and Services` to add an IDCS Application.
		2. Click `Confidential Application`
		3. In the `Details` section, enter a name, e.g. `Analytics_Token_App`, then click `Next`.
		4. In the `Client` section, choose the option to `Configure this application as a client now`.
		5. Select the following options for `Allowed Grant Types`:
			- `Resource Owner`
			- `Client Credentials`
			- `JWT Assertion`
		6. For `Allowed Operations`, select `On behalf Of`.
		7. For `Grant the client access to Identity Cloud Service Admin APIs`, click `Add` and select `Me` from the popup window, and click `Add`.
		8. Click `Next` to proceed to the `Resources` section. Choose the option to `Skip for later` to skip configuring this application as a resource server.
		9. Click `Next` to proceed to the `Web Tier Policy` section. Choose the option to `Skip for later` to skip configuring the Web Tier Policy for this application.
		10. Click `Next` to proceed to the `Authorization` section. Choose the option to `Skip for later` to skip enforcing grants as authorization.
		11. Click `Finish`, and then click `Close` to exit the `Application Added` popup window.
		12. Click `Activate` near the top-right corner of the IDCS UI, and then click `OK` to confirm the activation of your application, so that your IDCS Application be used to generate tokens.

	7. Click `Generate Access Token` near the top-right corner of the IDCS UI. For subsequent deployments of OAC, you may return to this IDCS Application to generate a new access token. The IDCS Application can be accessed as follows:
	```

	Hamburger menu > Applications > (Search for your application) > (Click your IDCS Application listing)
	
	```
	8. Choose the option for `Customized Scopes`, and then click `Download Token`. This will initiate the download of a token file to your local machine called `tokens.tok`.
	9. Open `tokens.tok` from your download location, using a text editor, and from its contents, copy to your clipboard the string of characters represented as `<VALUE>` in: `{"app_access_token":"<VALUE>"}`
	10. On your browser tab with the `Configure Variables` section of Resource Manager, paste the contents of your clipboard into the `OAC IDCS Access Token` field.

6. When you are finished editing your variables in the `Configure Variables` section, click `Next` to proceed to the `Review` section.
7. Select the checkbox for `Run Apply`, and click `Create`.
8. You can monitor the deployment by monitoring the `Logs` window. Once the resources in the stack have been provisioned, you can access your resources by following this sub-steps series:
\
\
	<b>Access Your Resources:</b>
	1. Click `Outputs` to open a page that shows the identifiers of the resources that were provisioned.
	2. For each resource that you wish to access, do the following:
		1. Copy to your clipboard its identifier from under the `Value` column.
		2. Duplicate your browser tab, and switch to that tab.
		3. Paste the identifier from your clipboard into the search field at the top of the OCI UI.
		4. Click the listing that appears in the search results.

### Deployment via CLI Terraform


1. [Download this project](https://github.com/scacela/oci-streaming-pipeline/archive/refs/tags/v1.0.1.zip) to your local machine.
2. [Set up CLI Terraform on your local machine.](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformgetstarted.htm) 
3. Navigate to project folder on your local machine via CLI.
<pre>
cd &ltYOUR_PATH_TO_THIS_PROJECT&gt
</pre>
4. Open your local copy of [vars.tf](./vars.tf) and edit the values that are assigned to the objects of type variable, which will influence the stack topology according to your preferences.
\
\
If Oracle Analytics Cloud (OAC) is one of the resources that you wish to deploy, you will need to generate an access token to use for the `OAC IDCS Access Token` field. To walk through this process, please follow the sub-steps series in Step 5. of the [Resource Manager deployment steps](#deployment-via-resource-manager).
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