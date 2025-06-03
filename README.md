# postgis_pgvector

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

🤖 This `README` was written by GPT-4. 🤖

## Introduction
This project focuses on creating a Docker image that combines the functionalities of `PostGIS` and `pgvector`, offering an easy-to-use solution for working with spatial data and vector similarity in PostgreSQL. It is designed to be as simple as integrating any other PostgreSQL Docker image into your workflow.

## Components
- `PostGIS`: An extension to PostgreSQL that allows it to store spatial data and perform spatial operations.
- `pgvector`: An extension for PostgreSQL designed for efficient similarity search in high dimensional vector spaces.

### Dockerfile
The `Dockerfile` starts with the `postgis/postgis` image specified via the build argument `POSTGIS_IMAGE` and installs essential packages including build tools, PostgreSQL server development tools, and `git`. It then clones and installs pgvector. The Dockerfile is optimized to reduce the layer size by cleaning up after installations.

## Customization
- **Environment Variables**: Set `POSTGIS_IMAGE`, `POSTGRES_PASSWORD`, `POSTGRES_DB`, `PGADMIN_DEFAULT_EMAIL`, and `PGADMIN_DEFAULT_PASSWORD` in your environment or directly in the `docker-compose.yml`.

## Notes
- Ensure Docker is installed on your system.
- The image can be customized further by modifying the Dockerfile as needed.
- This image is currently intended for development and testing purposes.
- For production use, consider securing your database with stronger passwords and appropriate network settings.

## Contributing
Your contributions are welcome! To contribute, please follow the standard fork and pull request workflow.

## License
This project is licensed under the MIT License.
