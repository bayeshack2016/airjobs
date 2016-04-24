# airjobs
BayesHack2016 Project

### AirJobs Career Explorer

Are you thinking about making a career change, but you're not sure what kind of job is right for you? The AirJobs Career Explorer can help. It takes in information from job-seekers and uses a custom matching algorithm to recommend jobs that best suit each person's situation.

The tool can take in the following information about a job-seeker:
* Skills
* Interests
* Knowledge Areas
* Level of Educational Attainment
* Minimum Acceptible Job Wage
* Preferred States

The user can also input weights to express how important each piece of information is to them in their job search.

#### Images of App in Action

The first image shows the tool in action, with some skills input into the tool.
<img src=airjobs_01.png>

The second image shows the tool shows the tool's top recommendations given a set of input preferences.
<img src=airjobs_02.png>

#### Past Context

[MyNextMove](https://www.mynextmove.org/) is a helpful site that leverages the Department of Labor's data about jobs. It allows you to search for careers
with keywords, within individual industries, or along certain interests. However, in the past, job seekers could only search for jobs along one dimension at a time, and they could not weight different preferences differently. Our tool allows a more nuanced and targeted job recommendation approach than is currently available with BLS data.



### Viz network

To launch the viz : 

- cd to `network-viz` 
- run the command : `python -m SimpleHTTPServer 8888`
- open a new page and load to `localhost:8888`
