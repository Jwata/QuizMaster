[![CircleCI](https://circleci.com/gh/Jwata/QuizMaster.svg?style=svg)](https://circleci.com/gh/Jwata/QuizMaster)
[![Coverage Status](https://coveralls.io/repos/github/Jwata/QuizMaster/badge.svg?branch=master)](https://coveralls.io/github/Jwata/QuizMaster?branch=master)

# QuizMaster
This is a simple quiz web app with a simple spaced repetition system.  
You can also see the demo app [here](https://quiz-master-jw.herokuapp.com/).

## Tech Stack
* Rails 5.2.0.beta2
* 2.4.1 or above
* PostgreSQL 9.6.5 or above

## Features
### CRUD questions
You can do CRUD operations for questions management.

![](./docs/crud.png)

### Markdown support
Markdown is supported to describe the contents of questions.

![](./docs/markdown-editor.png)

### Quiz mode
You also can try quiz mode. when the answer is/contains number, you also can answer it in words.

![](./docs/quiz-mode.png)

### (Beta) Learning Session
You can start a learning session by clicking the button on the questions page.
You will repeat quizes until you manage to answer all of them.  
You can stop the learning session by clicking the link in the flash message.

![](./docs/learning-session.png)

### (Beta) Spaced Repetition
In the learning session mode, the spaced repetition system schedules next repetition depending on your response.  
Check the [supermemo2 algorithm](https://www.supermemo.com/english/ol/sm2.htm) for more details.



## Development
### Setup
Install dependencies 

```
bundle install
yarn install
```

Prepare DB

```
rails db:create db:migrate db:seed
```

### Test

```
rails spec
```

### Run
```
rails s
```

### Tasks
Get auth token 

```
rails user:auth_token[1]
=> eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1MTI2NjMzNzUsInN1YiI6MX0.OUqNvFezsW94ovzOzmoOBINZ3dj-jCnWt0f0Vz0MSF0
```

### Open
```
open http://localhost:3000/?token=your_token
```

## Deployment
```
git push heroku master
```

