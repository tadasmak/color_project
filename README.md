# Color Combinations API

## Overview
The Color Combinations API Project provides a variety of color combination endpoints, allowing users to generate color combinations in complementary, triadic, tetradic, analogous, and split-complementary. The API supports both RGB and HEX color formats and includes JWT authentication for "secure" access.

## URL
[https://color-project-889dc471a78a.herokuapp.com/](https://color-project-889dc471a78a.herokuapp.com/)

## Documentation
See the [Color Combinations API docs](https://color-project-889dc471a78a.herokuapp.com/api-docs/index.html).

## Features
- **Color Combinations**: Generate color combinations including complementary, triadic, tetradic, analogous, and split-complementary.
- **Color Formats**: Supports RGB and HEX color formats.
- **Swagger API Documentation**: Easily explore and test available endpoints through Swagger.
- **JWT Authentication**: Access with JSON Web Token (JWT).
- **24-hour JWT Token**: Generated tokens are valid for 24 hours.

## API Endpoints
### `/api/complementary`
Generates complementary color combinations for the provided color in RGB or HEX format.
- **Parameters**:
    - `color` (required): The base color in RGB or HEX format.
- **Response**: An array of complementary colors in the same format.

### `/api/triadic`
Generates triadic color combinations for the provided color in RGB or HEX format.
- **Parameters**:
    - `color` (required): The base color in RGB or HEX format.
- **Response**: An array of triadic colors in the same format.

### `/api/tetradic`
Generates tetradic color combinations for the provided color in RGB or HEX format.
- **Parameters**:
    - `color` (required): The base color in RGB or HEX format.
- **Response**: An array of tetradic colors in the same format.

### `/api/analogous`
Generates analogous color combinations for the provided color in RGB or HEX format.
- **Parameters**:
    - `color` (required): The base color in RGB or HEX format.
- **Response**: An array of analogous colors in the same format.

### `/api/split_complementary`
Generates split-complementary color combinations for the provided color in RGB or HEX format.
- **Parameters**:
    - `color` (required): The base color in RGB or HEX format.
- **Response**: An array of split-complementary colors in the same format.

## JWT Authentication
To access protected endpoints, a valid JWT token is required. You can generate a JWT token using the `/api/login` endpoint. The token is valid for 24 hours and should be included in the Authorization header (`Bearer <token>`).

### `/api/login`
Generates a JWT token for authentication.
- **Parameters**:  
  - `email` (required): User’s email address (use `example@gmail.com` for successful call).
  - `password` (required): User’s password (use `secure_password` for successful call).
- **Response**:  
  - `token`: A JWT token valid for 24 hours.  