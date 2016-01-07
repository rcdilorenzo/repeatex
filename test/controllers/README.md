# Repeatex API

Assuming you've forwarded requests to `/repeatex` you can call that endpoint for the following JSON bodies:

## Parse

Request:

    GET /repeatex HTTP/1.1

    {"repeats": "every day"}

Response:

    HTTP/1.1 200 OK
    connection: close
    server: Cowboy

    {"type": "daily", "days": [], "frequency": 1}


## Format (after parsing as Repeatex struct)

Request:

    GET /repeatex HTTP/1.1

    {"repeats": {"type": "monthly", "days": [15, 25], "frequency": 1}}

Response:

    HTTP/1.1 200 OK
    connection: close
    server: Cowboy

    {"description": "15th and 25th every month"}
