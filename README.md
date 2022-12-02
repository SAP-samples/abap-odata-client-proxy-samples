# SAP-samples/repository-template
This default template for SAP Samples repositories includes files for README, LICENSE, and .reuse/dep5. All repositories on github.com/SAP-samples will be created based on this template.

# Containing Files

1. The LICENSE file:
In most cases, the license for SAP sample projects is `Apache 2.0`.

2. The .reuse/dep5 file: 
The [Reuse Tool](https://reuse.software/) must be used for your samples project. You can find the .reuse/dep5 in the project initial. Please replace the parts inside the single angle quotation marks < > by the specific information for your repository.

3. The README.md file (this file):
Please edit this file as it is the primary description file for your project. You can find some placeholder titles for sections below.

# CP REST SAMPLES
<!-- Please include descriptive title -->

<!--- Register repository https://api.reuse.software/register, then add REUSE badge:
[![REUSE status](https://api.reuse.software/badge/github.com/SAP-samples/REPO-NAME)](https://api.reuse.software/info/github.com/SAP-samples/REPO-NAME)
-->

## Description

This sample code uses the well-known [Swagger Petstore Sample](https://github.com/swagger-api/swagger-petstore) which can also be found on GitHub.

It shows how the OData proxy client can be used to also consume pure REST services that are no OData service.  

In the ABAP sample code you will have to replace the constant **petstore_url**.  
<pre>CONST: petstore_url type string value ‘<Swagger Petstore Sample URL>’ .</pre>
with the URL that points to the hosted version that is described in the above mentioned GitHub repository or an instance that you are running on your own.

## Requirements

The ABAP code can be used on:
- SAP BTP, ABAP Environment
- SAP S4HANA Cloud, ABAP Environment
- SAP ABAP Platform 2021 and later

## Download and Installation

1. Create a package (e.g.) `TEST_CP_REST_SAMPLE`      
2. Start the report `ZABAPGIT` or `ZABAPGIT_STANDALONE` depending on what you have installed in your system  
3. Create an offline repository or an online repository with the package and with the URL of this GitHub repository  
4. Pull changes  
5. Use mass activation to activate the objects that have been imported in step 3   

## Known Issues
<!-- You may simply state "No known issues. -->

## How to obtain support
[Create an issue](https://github.com/SAP-samples/<repository-name>/issues) in this repository if you find a bug or have questions about the content.
 
For additional support, [ask a question in SAP Community](https://answers.sap.com/questions/ask.html).

## Contributing
If you wish to contribute code, offer fixes or improvements, please send a pull request. Due to legal reasons, contributors will be asked to accept a DCO when they create the first pull request to this project. This happens in an automated fashion during the submission process. SAP uses [the standard DCO text of the Linux Foundation](https://developercertificate.org/).

## License
Copyright (c) 2022 SAP SE or an SAP affiliate company. All rights reserved. This project is licensed under the Apache Software License, version 2.0 except as noted otherwise in the [LICENSE](LICENSE) file.
