# Generate an Access Token for OAC Deployment
If Oracle Analytics Cloud (OAC) is one of the resources that you wish to deploy, you will need to generate an access token to use for the `OAC IDCS Access Token` field. To walk through this process, please follow these instructions.

## Sign into the IDCS UI
1. If you are not already signed into the OCI UI, open a new browser tab and navigate to `cloud.oracle.com` and sign in with your OCI user credentials.
2. Click the Hamburger icon at the top-left of the OCI UI.
3. Type `federation`, and click `Federation` on the right-hand side of the OCI UI once it auto-populates.
4. Click the hyperlinked name of your identity provider of type IDCS (Oracle Identity Cloud Service).
5. Click the hyperlinked text next to `Oracle Identity Cloud Service Console`. This link will open the IDCS UI.
6. To create an IDCS Application that can be used to generate access tokens, please proceed to [the next section](#generate-an-idcs-application).

## Generate an IDCS Application
1. Click the `+` icon on the tile labeled `Applications and Services` to add an IDCS Application.
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
12. Click `Activate` near the top-right corner of the IDCS UI, and then click `OK` to confirm the activation of your application, so that your IDCS Application can be used to generate tokens.

## Generate the Access Token from the IDCS Application
1. Click `Generate Access Token` near the top-right corner of the IDCS UI. Note that for subsequent deployments of OAC, you may return to this IDCS Application to generate a new access token. The IDCS Application can be accessed from the IDCS UI as follows:
```

Hamburger menu > Applications > (Search for your IDCS Application) > (Click your IDCS Application listing)

```
2. Choose the option for `Customized Scopes`, and then click `Download Token`. This will initiate the download of a token file to your local machine called `tokens.tok`.
3. Open `tokens.tok` from your download location, using a text editor, and from its contents, copy to your clipboard the string of characters represented as `<VALUE>` in: `{"app_access_token":"<VALUE>"}`
4. On your browser tab with the `Configure Variables` section of Resource Manager, paste the contents of your clipboard into the `OAC IDCS Access Token` field.