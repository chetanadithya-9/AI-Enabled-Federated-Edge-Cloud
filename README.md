# An AI-Enabled Federated Edge-Cloud Communication Framework for Dynamic Task Offloading and Network Anomaly Detection in IoT Systems

A Java-based web application that demonstrates IoT file communication
across sender, edge-node, cloud, and receiver roles, with network
anomaly detection and file-protection features.

**Academic project:** B.Tech (Computer Science & Engineering), SR
International Institute of Technology (SRIIT), Hyderabad\
**Academic period:** 2023--2027\
**Affiliation:** Jawaharlal Nehru Technological University Hyderabad
(JNTUH)

------------------------------------------------------------------------

## Table of Contents

-   [Overview](#overview)
-   [Key Features](#key-features)
-   [System Architecture](#system-architecture)
-   [Technology Stack](#technology-stack)
-   [Machine Learning and Anomaly
    Detection](#machine-learning-and-anomaly-detection)
-   [Security Features](#security-features)
-   [Repository Structure](#repository-structure)
-   [Prerequisites](#prerequisites)
-   [Setup and Execution](#setup-and-execution)
-   [Application Workflow](#application-workflow)
-   [Reported Results](#reported-results)
-   [Documentation](#documentation)
-   [Team](#team)
-   [Limitations and Notes](#limitations-and-notes)
-   [License](#license)

## Overview

IoT environments generate network traffic and data that may need to be
transferred between devices, edge nodes, and cloud services. Fixed
task-allocation strategies can be less responsive to changing node
loads, while network anomaly detection is often treated as a separate
concern.

This project brings together **edge-cloud task offloading** and
**network anomaly detection** in a Java web application. An IoT sender
uploads a file, the application encrypts and routes data through
available edge nodes and the cloud, and the cloud-side application
evaluates network attributes to identify traffic patterns associated
with attacks. An authorized IoT receiver can request access to a file
and decrypt it using the corresponding key.

The repository contains the Java web application, MySQL database script,
network-anomaly dataset, and supporting project documentation.

## Key Features

-   **Role-based application flow:** Separate interfaces for the IoT
    Sender, Edge Node, Cloud Server, and IoT Receiver.
-   **File upload and transfer:** Sender-side file upload and
    packet/offloading workflow through the application.
-   **Edge-node offloading:** Uses registered nodes (`node1` to `node4`)
    and node load values when assigning data.
-   **Network anomaly detection:** Combines a rule-based predictor with
    a K-Nearest Neighbors (KNN) classifier.
-   **AES-128 file encryption:** Encrypts uploaded file content before
    it is stored and transferred.
-   **Receiver key-request workflow:** Receivers request access to a
    file; the cloud-side workflow handles authorization and key
    delivery.
-   **Email-based key delivery:** The project documentation describes
    SMTP-based delivery of generated secret keys.
-   **SHA-256 block-hash demonstration:** Includes a block-hashing
    component documented as a lightweight integrity-verification
    demonstration.

## System Architecture

The application is organized around four roles:

  -----------------------------------------------------------------------
  Component                           Main responsibilities
  ----------------------------------- -----------------------------------
  **IoT Sender**                      Registers/logs in, uploads files,
                                      and initiates file transfer.

  **Edge Nodes**                      Receive data assigned by the cloud
                                      workflow, maintain node/load
                                      information, and forward data.

  **Cloud Server**                    Manages uploaded-file records and
                                      nodes, evaluates network records,
                                      and handles receiver key requests.

  **IoT Receiver**                    Registers/logs in, requests access
                                      to files, and downloads/decrypts
                                      authorized files.
  -----------------------------------------------------------------------

### High-level workflow

1.  The IoT Sender uploads a file through the web application.
2.  The application encrypts the file content using AES-128 and records
    the upload details.
3.  The cloud/offloading workflow assigns data to an available edge node
    based on the node information maintained in the database.
4.  Network attributes associated with the transfer are evaluated by the
    rule-based predictor and KNN classifier.
5.  The IoT Receiver requests access to a file.
6.  After the request is handled by the cloud workflow, the receiver
    obtains the key through the configured delivery process and decrypts
    the downloaded file.

## Technology Stack

  -----------------------------------------------------------------------
  Area                                Technology
  ----------------------------------- -----------------------------------
  Programming language                Java

  Web application                     JavaServer Pages (JSP) and Servlets

  Database                            MySQL

  Database connectivity               JDBC

  Build system                        Apache Ant (`build.xml`)

  IDE used in project documentation   Apache NetBeans

  Application server                  Apache Tomcat

  File upload support                 Apache Commons FileUpload / Commons
                                      IO (as required by the project
                                      setup)

  Machine learning                    K-Nearest Neighbors (KNN) and Java
                                      rule-based classification

  Cryptography                        AES-128 and SHA-256 hashing

  Email                               JavaMail / SMTP
  -----------------------------------------------------------------------

## Machine Learning and Anomaly Detection

The repository documents two complementary detection components.

### 1. Rule-based anomaly prediction

`NetworkAttackPredictor.java` evaluates network attributes such as:

-   `duration_sec`
-   `packet_count`
-   `bytes_transferred`
-   `flow_rate`
-   `failed_logins`
-   `syn_packets`
-   `udp_packets`
-   `tcp_retransmissions`
-   `avg_packet_size`
-   `connection_hour`

The documented rule-based labels include:

-   **DDoS**
-   **Botnet**
-   **PortScan**
-   **Normal**

The predictor applies configured threshold conditions to the traffic
attributes to assign a label.

### 2. K-Nearest Neighbors (KNN)

`KNNClassifier.java` uses Euclidean distance to compare a network record
with training records from the repository's CSV dataset. It selects the
*K* nearest records and assigns a class based on majority voting.

**Dataset:**
[`network_anomaly_dataset_records_rule_based).csv`](./network_anomaly_dataset_records_rule_based%29.csv)

The dataset filename includes a closing parenthesis. The link above
URL-encodes that character.

## Security Features

-   **AES-128:** The project documentation describes 128-bit AES keys
    for file encryption and decryption.
-   **Base64 encoding:** Used to represent encrypted bytes and key data
    in text-compatible form.
-   **SHA-256 hashing:** `bcdemo.java` demonstrates SHA-256-based block
    hashing. The project documentation describes this as a lightweight
    blockchain/integrity demonstration; it should not be interpreted as
    a production blockchain implementation.
-   **Key-request and delivery flow:** The receiver requests access to a
    file, and the application documentation describes SMTP email
    delivery of the generated key.

> **Security note:** This is an academic project, not a production-ready
> security system. Review the cryptographic implementation, key storage,
> authentication, authorization, transport security, and
> secret-management practices before using it with sensitive data.

## Repository Structure

The following is a high-level view of the repository layout. Some
application files are grouped to keep the tree readable.

``` text
AI-Enabled-Federated-Edge-Cloud/
├── nbproject/                         # NetBeans project configuration
├── src/
│   └── java/
│       ├── databaseconnection/
│       │   └── databasecon.java       # JDBC database connection
│       └── Efficient/
│           ├── KNNClassifier.java     # KNN classifier
│           ├── NetworkAttackPredictor.java
│           ├── NetworkRecord.java
│           ├── Upload.java            # Upload servlet
│           ├── encryption.java        # Encryption helper
│           ├── decryption.java        # Decryption helper
│           ├── encryptimg.java
│           ├── bcdemo.java            # SHA-256 block-hash demo
│           ├── mail.java              # SMTP mail helper
│           ├── Ftpcon.java
│           ├── Ftpcon1.java
│           └── Main.java
├── web/                               # JSP, HTML, CSS, JavaScript and web resources
│   ├── WEB-INF/
│   └── assets/
├── build.xml                          # Apache Ant build file
├── db.sql                             # MySQL schema and sample records
├── network_anomaly_dataset_records_rule_based).csv
├── project.md                         # Project architecture and setup notes
├── projsrc.md                         # Source-code reference documentation
└── project new final (sept 20).pdf    # Academic project report
```

## Prerequisites

Install and configure the following before running the application:

-   Java Development Kit (JDK) compatible with the project and its
    dependencies
-   Apache NetBeans IDE (or another IDE that supports Ant-based Java web
    projects)
-   Apache Tomcat (the project guide refers to Tomcat 8.5 or 9.0+)
-   MySQL Server
-   MySQL JDBC driver
-   Apache Commons FileUpload and Commons IO libraries, if they are not
    already included in the project
-   JavaMail dependencies and SMTP settings if email-based key delivery
    is to be used

The exact dependency versions should be taken from the project
configuration and the libraries used by your local setup.

## Setup and Execution

### 1. Clone the repository

``` bash
git clone https://github.com/chetanadithya-9/AI-Enabled-Federated-Edge-Cloud.git
cd AI-Enabled-Federated-Edge-Cloud
```

### 2. Create and import the database

The supplied `db.sql` script creates and uses a database named
**`alb`**.

You can import it from a terminal with:

``` bash
mysql -u YOUR_MYSQL_USERNAME -p < db.sql
```

Alternatively, open `db.sql` in MySQL Workbench or another MySQL client
and execute the script.

> **Important:** Review `db.sql` before importing it. It contains
> `DROP TABLE IF EXISTS` statements and sample `INSERT` records.
> Importing it into an existing database with the same table names can
> replace those tables. The current sample records also contain demo
> login details and personal-looking contact data; replace them with
> fictional test data before sharing or using the database.

### 3. Configure the database connection

Open:

``` text
src/java/databaseconnection/databasecon.java
```

Update the JDBC URL, database name, username, and password to match your
local MySQL configuration. The database name used by the supplied SQL
script is `alb`.

Do not commit real database passwords, SMTP credentials, app passwords,
or other secrets to the public repository. Use local configuration or
environment-based secrets where possible.

### 4. Open the project in NetBeans

1.  Launch NetBeans.
2.  Open the cloned project directory.
3.  Confirm that NetBeans recognizes the Ant-based Java web project.
4.  Check that the required JDBC, FileUpload, Commons IO, and JavaMail
    libraries are available to the project.
5.  Configure the Tomcat server in NetBeans.

### 5. Configure email settings (if using email delivery)

The project documentation describes SMTP-based key delivery through
JavaMail. Configure the mail settings in the relevant mail helper using
your own SMTP account settings. Do not place real credentials in source
files or commit them to GitHub.

### 6. Build and run

1.  Use **Clean and Build** in NetBeans.
2.  Resolve any missing-library or server-configuration errors.
3.  Run/deploy the web application to Tomcat.
4.  Open the local URL shown by NetBeans/Tomcat after deployment.

The project guide documents a context path resembling:

``` text
http://localhost:8080/An_Al-Enabled_Federated/
```

The actual URL may differ depending on the project name and Tomcat
deployment configuration.

## Application Workflow

1.  **Sender:** Register or log in and upload a file.
2.  **Cloud:** Review uploaded-file information and coordinate the
    offloading workflow.
3.  **Edge Node:** View and process data assigned to the node, then
    forward it through the application workflow.
4.  **Anomaly detection:** Evaluate network attributes using the
    rule-based predictor and KNN classifier.
5.  **Receiver:** Register or log in and request access to an available
    file.
6.  **Key delivery and download:** Complete the
    authorization/key-delivery workflow, then decrypt and download the
    file.

## Reported Results

The original project README draft lists the following results as
reported project outcomes:

  -----------------------------------------------------------------------
  Metric                                                  Reported result
  ------------------------------ ----------------------------------------
  Latency reduction                                               38--42%

  Throughput improvement                                          22--27%

  Federated-learning                                    Approximately 30%
  communication-overhead         
  reduction                      

  Anomaly-detection accuracy                                       99.61%
  -----------------------------------------------------------------------

These figures are reproduced from the project's existing summary and
should be read alongside the evaluation methodology, datasets,
baselines, and test conditions in the [project
report](./project%20new%20final%20%28sept%2020%29.pdf). They have not
been independently reproduced as part of this README revision. Do not
treat them as guaranteed performance in other environments.

## Documentation

Additional project material is available in this repository:

-   [Project architecture and implementation guide](./project.md)
-   [Source-code reference documentation](./projsrc.md)
-   [Database schema and sample data](./db.sql)
-   [Network anomaly
    dataset](./network_anomaly_dataset_records_rule_based%29.csv)
-   [Full academic project report
    (PDF)](./project%20new%20final%20%28sept%2020%29.pdf)

## Team

  Name                     Roll Number
  ------------------------ -------------
  Vishal Vanam             23VF1M33B5
  Rongali Chetan Adithya   23VF1M3389
  Gelli Naga Sai Srikar    22VF1M3336

**Project Guide / HOD:** Dr. Pulagam Hari Krishna, Professor & Head of
Department, Department of Computer Science and Engineering, SRIIT,
Hyderabad.

## Limitations and Notes

-   The repository documents an edge-cloud offloading workflow and
    KNN/rule-based anomaly detection. The available implementation
    documentation does not describe a complete federated model-training
    or model-aggregation pipeline. The project title is retained, but
    federated learning should not be represented as verified
    functionality unless that workflow is implemented and demonstrated
    in the code.
-   The reported performance figures are project-reported values;
    consult the report for experimental details.
-   The SQL dump includes sample records and destructive table-drop
    statements. Review and sanitize it before importing into a
    non-disposable database.
-   The application requires local configuration of database access,
    server settings, dependencies, and SMTP credentials.
-   This repository is an academic project and should be reviewed and
    hardened before any production deployment.

## License

No license file is currently included in the repository. Unless a
license is added, the project should be treated as having no explicit
open-source reuse permissions. Add a `LICENSE` file if you intend to
grant others permission to use, modify, or distribute the code.
