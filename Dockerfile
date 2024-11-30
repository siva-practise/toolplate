# Use the latest Ubuntu base image for building
FROM ubuntu:latest as BUILD-IMAGE

# Install necessary dependencies
RUN apt-get update -y && apt-get install -y unzip && apt-get install -y wget

# Set working directory to /dev
WORKDIR /app

# Download the zip file using curl and save it to the expected filename
RUN wget https://www.tooplate.com/zip-templates/2084_zipper.zip
# Verify that the file has been downloaded (optional debugging)
RUN ls -l /app

# Unzip the contents of the zip file
RUN unzip 2136_kool_form_pack.zip

# Clean up the zip file
RUN rm 2136_kool_form_pack.zip

# Use the latest Nginx image for the final image
FROM nginx:latest

# Set the working directory to Nginx's default directory
WORKDIR /usr/share/nginx/html

# Copy the files from the build stage to the Nginx HTML directory
COPY --from=BUILD-IMAGE /app/* /usr/share/nginx/html/

# Expose port 80 for HTTP
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]

