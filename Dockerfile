# Build stage for compiling the React app
FROM public.ecr.aws/bitnami/node:14.18.3 as build
COPY . /app
WORKDIR /app
RUN ls -l
RUN npm install \
    && npm run-script build \
    && ls -l

# Final stage for creating the final Docker image
FROM public.ecr.aws/nginx/nginx:1.21-alpine as final
COPY --from=build /app/build/ /var/www/html