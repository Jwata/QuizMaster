[![CircleCI](https://circleci.com/gh/Jwata/QuizMaster.svg?style=svg)](https://circleci.com/gh/Jwata/QuizMaster)
[![Coverage Status](https://coveralls.io/repos/github/Jwata/QuizMaster/badge.svg?branch=master)](https://coveralls.io/github/Jwata/QuizMaster?branch=master)

# QuizMaster
This is a simple quiz web app built with Ruby on Rails.  
You can also see the demo app [here](https://quiz-master-jw.herokuapp.com/).

![](./docs/screenshot-quiz.png)


## Local environment
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