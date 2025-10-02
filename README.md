# Sleep Tracker

"Sleep Tracker" is app for tracking when sleep and wake up.

## Features

- Sleep Tracking: track duration of each sleep sessions
- Analytics: show sleep statistic based on sleep histories
- Follow other users
- Friend feeds: show all following users's sleep sessions

## Onboarding and Development Guide

### Prerequisite

1. [Visual Studio Code](https://code.visualstudio.com/) with [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension
2. [Docker](https://www.docker.com/get-started/) or [Podman](https://podman.io/docs/installation)

### Setup Local Development

1. clone repository

```shell
git clone git@github.com:bickyeric/sleep-tracker.git
```

2. open with vscode

```shell
code sleep-tracker
```

3. run the `Dev Containers: Reopen in Container` command from the vscode Command Palette (`F1`). just wait while dev container setting up container for you
4. run the `Terminal: Create New Terminal in Editor Area` command from the vscode Command Palette (`F1`)

6. run rails server
```shell
rails server
```

## API

### Authentication

To simplify the app, authentication can be done by adding `Authorization` header with user id

### Endpoint
- `POST   /api/v1/sleeps` - start sleep session
- `POST   /api/v1/sleeps/:sleep_id/end` - end sleep session or wake up
- `GET    /api/v1/sleeps/stats` - get statistics of you sleeps
- `GET    /api/v1/sleeps/friend_feeds` - get list of sleep feeds from you friends
- `POST   /api/v1/users/:user_id/follow` - Follow user by their id
- `DELETE /api/v1/users/:user_id/follow` - Unfollow user by their id

## Handling high data volumes and concurrent requests

1. **Cursor Based Pagination** is used in list sleeps and friend sleeps API as it known to be more performant with large datasets
2. **Background Task** is used to do heavy logic like updating sleep summary without blocking main thread
3. **Database Index** is created for each frequent query patterns
4. **Caching** is used on business logic which is rarely changed like periodic sleep statistic
