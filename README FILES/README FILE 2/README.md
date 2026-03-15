graph TD
    %% Define Nodes
    User[💻 Local Machine]
    TF[🏗️ Terraform]
    AWS((☁️ AWS Cloud ap-south-1))
    EC2[🖥️ EC2 Instance t3.micro]
    SG[🛡️ Security Group]
    UD[[⚙️ UserData.sh Execution]]
    
    %% Internal steps of UserData
    Setup[📦 Install Java 17, Maven, Git]
    DB[(🐬 MySQL Database)]
    Code[🐙 Clone GitHub Repo]
    App[🚀 Spring Boot Application]
    
    %% Define Connections
    User -->|terraform apply| TF
    TF --> AWS
    AWS --> SG
    SG -->|Allows SSH 22 & TCP 8085| EC2
    EC2 --> UD
    
    UD --> Setup
    UD --> DB
    UD --> Code
    Setup --> App
    DB --> App
    Code --> App
    
    App -->|Exposes Port 8085| Web((🌐 Accessible via Browser))
    
    %% Styling
    style AWS fill:#ff9900,stroke:#232f3e,stroke-width:2px,color:white
    style EC2 fill:#ff9900,stroke:#232f3e,stroke-width:2px,color:white
    style App fill:#6db33f,stroke:#333,stroke-width:2px,color:white
    style DB fill:#00758f,stroke:#333,stroke-width:2px,color:white