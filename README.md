# Service Orchestration Take-Home Project
Welcome to the Pocket Worlds Service Orchestration Take-Home Project! In this repository, we'd like you to demonstrate your
skills by creating the infrastructure as code to run the simple web app container included here.

This project will serve as the primary jumping off point for our technical interviews. We expect you to spend a 
couple of hours building an MVP that meets the requirements in the Product Description. You are free to implement 
your solution and modify the provided template in the way that makes the most sense to you, but make sure to 
update the README accordingly so that it's clear how to run and test your project. During the interviews, you will 
be asked to demo your solution and discuss the reasoning behind your implementation decisions and their trade-offs. 
Be prepared to share your screen for live coding and problem solving with your interviewers based on this discussion.

## Project Description



Using the provided Python project template, your task is to implement a URL Shortener web service that exposes
the following API endpoints:

* POST `/url/shorten`: accepts a URL to shorten (e.g. https://www.google.com) and returns a short URL that 
  can be resolved at a later time (e.g. http://localhost:8000/r/abc)
* GET `r/<short_url>`: resolve the given short URL (e.g. http://localhost:8000/r/abc) to its original URL
  (e.g. https://www.google.com). If the short URL is unknown, an HTTP 404 response is returned.

Your solution must support running the URL shortener service with multiple workers.

For example, it should be possible to start two instances of the service, make a request to shorten a URL
to one instance, and be able to resolve that shortened URL by sending subsequent requests to the second instance. 

## Getting Started

To begin the project, fork this repository:

```commandline
git clone https://github.com/pocketzworld/service-orchestration-tech-test.git
```

Then clone your fork to your local machine.

### Building the Service Container

This repository contains a simple web service and container, described here:
[a link](https://github.com/pocketzworld/service-orchestration-tech-test/blob/main/service/src/pw/service/README.md)

The service container can be built using `make build` from the root directory of the test. Feel free to customize existing commands or add new ones as you see fit. You are not required to use the Makefile. The included Dockerfile is sufficient to run this service for the purposes of the test. You are welcome to make changes to support tools you want to use or demonstrate other patterns, but do not add config files or configuration related environment variables to the Dockerfile.

### Testing

Swagger UI is available as part of the FastAPI framework that can be used to inspect and test
the API endpoints of the URL shortener. To access it, start run the web service and go to http://localhost:8000/docs

## Submission Guidelines
When you have completed the project, please follow these guidelines for submission:

1. Commit and push your code to your GitHub repository.
2. Update this README with any additional instructions, notes, or explanations regarding your implementation, if necessary.
3. Provide clear instructions on how to run and test your project.
4. Share the repository URL with the hiring team or interviewer.

## Additional Information
Feel free to be creative in how you approach this project. Your solution will be evaluated based on code quality,
efficiency, and how well it meets the specified requirements. Be prepared to discuss the reasoning behind your
implementation decisions and their trade-offs.

Remember that this project is the basis for the technical interviews, which do include live coding. We will not
ask you to solve an algorithm, but you will be expected to demo your solution and explain your thought process.

Good luck, and we look forward to seeing your URL Shortener project! If you have any questions or need
clarifications, please reach out to us.
