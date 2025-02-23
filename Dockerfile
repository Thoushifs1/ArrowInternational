FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y curl unzip

# Download and install SnowSQL
RUN curl -L -o /tmp/snowsql-linux_x86_64.bash https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/latest/linux_x86_64/snowsql-linux_x86_64.bash && \
    chmod +x /tmp/snowsql-linux_x86_64.bash && \
    /tmp/snowsql-linux_x86_64.bash -- -y && \
    rm /tmp/snowsql-linux_x86_64.bash

ENV PATH="/usr/local/bin:$PATH"

# Verify installation
RUN snowsql --version

WORKDIR /workspace
COPY . .

# Run the SQL script
CMD ["snowsql", "-a", "${SNOWFLAKE_ACCOUNT}", "-u", "${SNOWFLAKE_USER}", "-p", "${SNOWFLAKE_PASSWORD}", "-d", "${SNOWFLAKE_DATABASE}", "-s", "${SNOWFLAKE_SCHEMA}", "-w", "${SNOWFLAKE_WAREHOUSE}", "-f", "code.sql"]
