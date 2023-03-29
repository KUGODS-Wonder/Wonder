# Wonder
<p align="center"><img src="https://res.cloudinary.com/startup-grind/image/upload/c_fill,dpr_2,f_auto,g_center,q_auto:good/v1/gcs/platform-data-dsc/contentbuilder/GDG-Bevy-ChapterThumbnail.png" height="200px" width="200px"></p>

Project to participate in 2023 google solution challenge

# Member
 Chanho Park                     | Keo Kim    | Boyoung Kim | SeoKyung Baek |
|------------------------|------------|-------------|---------------|
| - Lead <br/> - Backend | - Frontend | - Frontend  | - AI          |

# UN-SDGs that our solution solving for
## Goal 3. Good Health and Well-Being
<img src="https://user-images.githubusercontent.com/83508073/228183331-9a51e851-0ae2-474e-8511-6ae086b67a1d.png">


# About our solution
Our service is designed to solve the problem of the lack of physical activity of modern people. We tried to solve this problem through walking exercises that anyone can start easily and lightly. 
 
So we added several gamification techniques to help users enjoy walking in their daily lives. The user can make a habit of doing walking exercises and be motivated by watching his or her tier rise.

In addition, there is a function that connects volunteer organizations and users so that they can participate in various volunteer activities that can be done while walking. For example, there are volunteer activities to take a walk with dogs at an abandoned dog shelter or lunch box delivery services for the elderly living alone.


# App Demo

<figure class="third">

![myprofile](https://user-images.githubusercontent.com/83508073/228186679-5a72397b-2b11-4fcc-a433-f4f09133d66c.gif)
![map](https://user-images.githubusercontent.com/83508073/228186705-e6b85ba2-8c21-4ecf-a0da-2df0906322e5.gif)
![voluntary_work](https://user-images.githubusercontent.com/83508073/228186724-2b547cff-32a2-4dd2-bb73-bb65661ea250.gif)
<figure>

# About Implementation
## Backend
### 1. Tech Stack
- Java 11
- Spring, Spring boot
- Spring Web MVC, Spring Security
- Spring Data JPA, QueryDsl
- MySQL
- Docker, Docker-compose
- GCP

### 2. Architecture
![wonder server architecture](https://user-images.githubusercontent.com/83508073/223980536-cc1bd254-3910-43e4-a545-abeb4459b5b5.png)
- I deploy my Spring server application with Docker and Docker Compose.
- First, I create a Dockerfile to build an image of my application.
- Then, I build an image of my application and push to the DockerHub.
- I also create a docker-compose.yml file with information about my spring application from the hub and Nginx and certbot.
  [related issue](https://github.com/KUGODS-Wonder/Wonder-Backend/issues/8)
- Nginx was used to implement the reverse proxy, and certbot was used to use the https protocol.
- Finally, I can start my app with Docker compose by running a command like "docker-compose up". This starts containers for my app.


### 3. Api Docs
[Gitbook](https://cksgh1735.gitbook.io/wonder/)

### 4. ERD
![image](https://user-images.githubusercontent.com/83508073/226541680-70d95739-e328-4c81-8edf-c94f08548b5f.png)


## Frontend
### 1. Tech Stack
- Dart 2.19.2
- Flutter 3.7.5
- Flutter ScreenUtil 5.7.0
- Get 4.6.5
- Dio 5.0.3
- Google Maps Flutter 2.2.5
- Google Login 5.5.3


### 2. Architecture
```aidl
app
    ├── common
    │   ├── util
    │   └── values
    │       └── styles
    ├── data
    │   ├── enums
    │   ├── errors
    │   ├── models
    │   └── providers
    ├── modules
    │   ├── event
    │   │   ├── bindings
    │   │   ├── controllers
    │   │   └── views
    │   ├── home
    │   │   ├── bindings
    │   │   ├── controllers
    │   │   └── views
    │   ├── login
    │   │   ├── bindings
    │   │   ├── controllers
    │   │   └── views
    │   ├── map
    │   │   ├── bindings
    │   │   ├── controllers
    │   │   └── views
    │   ├── map_detail
    │   │   ├── bindings
    │   │   ├── controllers
    │   │   └── views
    │   ├── register
    │   │   ├── bindings
    │   │   ├── controllers
    │   │   └── views
    │   ├── reservation_list
    │   │   ├── bindings
    │   │   ├── controllers
    │   │   └── views
    │   ├── splash
    │   │   ├── bindings
    │   │   ├── controllers
    │   │   └── views
    │   ├── walk_track
    │   │   ├── bindings
    │   │   ├── controllers
    │   │   └── views
    │   └── widgets
    └── routes
```
- We chose MVC pattern as an architecture.
  - Every feature is divided into modules, and each module has its own controller, view, and binding.
- The data layer is divided into models and providers. 
  - The models are used to store data, and the providers are used to communicate with the backend.
- GetX is used as a state management and navigation tool. 
  - In exchange for less flexible page transitions, GetX allowed us to quickly implement the app's core features.
- We used the Google Maps Flutter plugin to implement the map feature. We also used the Google Login plugin to implement the login feature.