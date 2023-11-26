# Atty
Atty - Organizer for Ukrainian lawyers and attorney

### Description:

Atty is a specialized organizer tailored for lawyers and attorneys, streamlining the process of accessing pertinent information concerning their clients' legal proceedings, decisions, scheduled court hearings, latest legal updates, and the ability to monitor diverse legal cases.

### Key Features:

Efficient Work Management:
* Capability to add clients, projects, and tasks with defined deadlines.
* Notifying users about impending tasks for better organization.

Robust Information Handling:
* Attachment of documents to clients' profiles and their respective projects, including image-based documentation.
* Structured management of expenses and income streams.
* Integrated court fee and penalty calculator for precise calculations.
  
# Utilized Technologies:
* UI Design: Figma
* UI Framework: UiKit, SnapKit.
* Auth: Firebase.
* Data Storage: Realm + RxRealm, Firebase.
* API Integration: Alamofire.
* Architectural Pattern: MVVM.

# Project Structure:
* Models: Defined data models (User, Client, Project, Cost, Task, CourtCase) representing core information.
* Services: Dedicated classes for database operations (Realm), auth (Firebase), network (Alamofire).
* Views: Comprehensive range of ViewControllers, TableViews, and other visual components offering data representation and interaction.
* ViewModels: Specific ViewModels engineered to process and provide data for respective visual components.

# Design Inspiration:
The design was meticulously crafted using Figma, drawing inspiration from various design samples showcased on Dribbble to ensure an aesthetically appealing and user-centric interface.
![1](https://github.com/MelnykovMykyta/Atty/assets/127539076/462eb3c8-0e62-4ba1-a534-252a4dfe7e5d)


![2](https://github.com/MelnykovMykyta/Atty/assets/127539076/eaefd14e-6ce4-4b5c-89f6-eda523f9d5dc)

# Project Status:
This is my first pet project. It's still a work in progress and hasn't been fully implemented yet. Ongoing efforts are being made to further develop and enhance its functionalities.
Currently, the API data is obtained from the Beeceptor test server, and in the future there is a prospect of communication with the public owner of the court database to gain access and connect the real database to the project.

# Contribution:
Should you wish to contribute or report issues/improvements, please consider opening Issues or initiating Pull Requests within this repository.
